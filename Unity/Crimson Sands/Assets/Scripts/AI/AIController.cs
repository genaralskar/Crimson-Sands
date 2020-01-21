using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

/// <summary>
/// This goes on the root object for an ai controlled vehicle. This handles switching targets for the RCC AI and
/// when to fire its weapons.
/// </summary>
public class AIController : MonoBehaviour
{
    [SerializeField] private RCC_AICarController carController;
    [SerializeField] private ArmorHolder armorHolder;
    
    public string playerTag = "Player";
    public string semiTag = "AITarget";
    private string currentTargetTag;

    public Transform[] rayPoints;
    //public Transform rayPoint;
    public LayerMask rayLayers;

    public LayerInfo layerInfo;
    
    [Header("Distance Keeping Stuff")]
    public Transform currentTarget;
    public float nearDistance = 5f;
    public float farDistance = 50f;
    public float minSpeed = 50f;
    [Tooltip("The minimum angle difference between the target and the vehicle for the AI to start slowing down")]
    public float minAngle = 20f;

    private float maxSpeed;

    [Header("Navigation Stuff")] [Range(0, 10)]
    public float navFuzz = 1f;

    public bool useStaticFuzz = false;
    private Vector3 staticFuzz;
    public TransformReference playerFollowPoint;
    public TransformReference semiFollowPoint;
    public float chanceToChangeTarget = 0.05f;
    public float chanceToSwerveOnHit = 0.2f;

    private Health health;
    
    [SerializeField] private List<WeaponMount> weapons;

    private void Awake()
    {
        carController = GetComponent<RCC_AICarController>();
        maxSpeed = carController.maximumSpeed;
        armorHolder = GetComponent<ArmorHolder>();
        health = GetComponent<Health>();
        health.HealthChange += HealthChangeHandler;
        FindWeaponMounts();
    }

    private void Start()
    {
        SwitchTarget(semiFollowPoint.transform);
        staticFuzz = GetRandomFuzz(navFuzz);
    }


    private void OnEnable()
    {
        StopAllCoroutines();
        StartCoroutine(SetDestination());
    }

    private void Update()
    {
        //shoot ray you see if player/semi is infront of ai
        CheckRayHits();

        SetVehicleSpeed();

        //if car gets shot by player, then switch target to player
    }
    
    private void FindWeaponMounts()
    {
        WeaponMount[] mounts = GetComponentsInChildren<WeaponMount>();

        foreach (var mount in mounts)
        {
            if (!weapons.Contains(mount))
            {
                weapons.Add(mount);
            }
        }
    }

    private void CheckRayHits()
    {
        bool fire = false;
        foreach (var point in rayPoints)
        {
            fire = CheckRayHit(point);
            if (fire) break;
        }
        FireWeapon(fire);
    }

    private void SetVehicleSpeed()
    {
        if (!carController.targetChase) return;
        
        currentTarget = carController.targetChase;

        float angleDot = Vector3.Dot(transform.forward, currentTarget.forward);

        if (angleDot > minAngle)
        {
            carController.maximumSpeed = maxSpeed;
            return;
        }

        float distance = Vector3.Distance(transform.position, currentTarget.position);
        //Debug.Log("Distance = " + distance);
        
        distance = Mathf.Clamp(distance, nearDistance, farDistance);
        //Debug.Log("Distance Clamped = " + distance);
        
        float distance01 = (distance - nearDistance) / (farDistance - nearDistance);
        //Debug.Log("Distance01 = " + distance01);
        
        float currentSpeed = Mathf.Lerp(minSpeed, maxSpeed, distance01);
        carController.maximumSpeed = currentSpeed;
    }

    private bool CheckRayHit(Transform rayPoint)
    {
        Ray ray = new Ray(rayPoint.position, rayPoint.forward);
        RaycastHit hit;

        if (Physics.BoxCast(rayPoint.position, (Vector3.one * .2f), rayPoint.forward, out hit, rayPoint.rotation,
            Mathf.Infinity, layerInfo.weaponRaycastLayers))
        {
            IWeaponHit weaponHit = hit.collider.gameObject.GetComponent<IWeaponHit>();
            if (weaponHit != null)
            {
                //get carhealth to figure if its a a player
                Health carHealth = hit.collider.transform.root.GetComponent<Health>();
                //if player, fire
                if (carHealth && (carHealth.isPlayer))
                {
                    return true;
                }
            }
        }

        return false;
    }

    private IEnumerator SetDestination()
    {
        NavMeshAgent agent = carController.navigator;
        WaitForSeconds wait = new WaitForSeconds(0.2f);
        
        while (true)
        {
            yield return wait;
            if (!carController.targetChase || !agent)
            {
                agent = carController.navigator;
                //Debug.Log("Attempting to get navigator");
                continue;
            }


            float distance = Vector3.Distance(transform.position, carController.targetChase.position);
        
            if (agent.isOnNavMesh && distance < carController.detectorRadius)
            {
                Vector3 newPos = carController.targetChase.position + GetRandomFuzz(navFuzz);
                
                //if new destination is behind car a certain distance, slow down instead of turning around
                //set destination to in front of car, but apply brakes

                Vector3 newDir = newPos - transform.position;
                newDir = newDir.normalized;
                float newDist = newDir.sqrMagnitude;
                
                if (Vector3.Dot(newDir, transform.forward) < -.5f && newDist < 20)
                {
                    //point is behind car, slow down!
                    carController.overrideBrake = true;
                    carController.brakeInput = 1f;
                    agent.SetDestination(transform.position);
                }
                else
                {
                    carController.overrideBrake = false;
                    agent.SetDestination(newPos);
                }
                
                
            }
        }
    }

    private void HealthChangeHandler(int amount)
    {
        if (amount >= 0) return;
        float amountNormalized = (-amount) / (float)health.currentHealth;
        float randomChance = Random.Range(0f, 1f);
        //Debug.Log($"Normalized Hit = {amountNormalized}, Random Change = {randomChance}");
        if (randomChance < chanceToChangeTarget)
        {
            TargetPlayer();
        }
    }

    private void TargetPlayer()
    {
        SwitchTarget(playerFollowPoint.transform);
        StopCoroutine(TargetSwitchTimer());
        StartCoroutine(TargetSwitchTimer());
    }

    private void TargetSemi()
    {
        SwitchTarget(semiFollowPoint.transform);
    }
    
    private void SwitchTarget(Transform newTarget)
    {
        carController.targetChase = newTarget;
    }
    
    private IEnumerator TargetSwitchTimer()
    {
        yield return new WaitForSeconds(5f);
        TargetSemi();
    }
    
    private void FireWeapon(bool isFiring)
    {
        //Debug.Log("Pew!");
        foreach (var weapon in weapons)
        {
            weapon.SetWeaponFiring(isFiring);
        }
    }

    public void ChangeFollowTarget(Transform newTarget)
    {
        carController.targetChase = newTarget;
        currentTarget = newTarget;
    }

    private Vector3 GetRandomFuzz(float fuzz)
    {
        float xFuzz = Mathf.PerlinNoise(0, Time.time);
        //float yFuxx = Random.Range(0, navFuzz);
        float zFuzz = Mathf.PerlinNoise(Time.time, 0);
        Vector3 newFuzz = new Vector3(xFuzz, 0, zFuzz) * fuzz;
        newFuzz -= Vector3.one * .5f;
        newFuzz *= 2;
        return newFuzz;
    }
}
