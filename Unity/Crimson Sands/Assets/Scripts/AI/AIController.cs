using System;
using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using UnityEngine;
using UnityEngine.AI;
using UnityEngine.UIElements;
using Vector3 = UnityEngine.Vector3;

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

    [Header("Navigation Stuff")]
    [SerializeField]
    private RCC_AICarController RCCController;
    
    [SerializeField] private List<WeaponMount> weapons;

    private void Awake()
    {
        carController = GetComponent<RCC_AICarController>();
        maxSpeed = carController.maximumSpeed;
        armorHolder = GetComponent<ArmorHolder>();
        RCCController = GetComponent<RCC_AICarController>();
        FindWeaponMounts();
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
                CarHealth carHealth = hit.collider.transform.root.GetComponent<CarHealth>();
                //if player, fire
                if (carHealth && (carHealth.isPlayer || carHealth.playerTeam))
                {
                    return true;
                }
            }
        }

        return false;
    }

    private IEnumerator TargetSwitchTimer()
    {
        yield return new WaitForSeconds(5f);
    }

    private IEnumerator SetDestination()
    {
        NavMeshAgent agent = RCCController.navigator;
        WaitForSeconds wait = new WaitForSeconds(0.2f);
        
        while (true)
        {
            yield return wait;
            if (!RCCController.targetChase || !agent)
            {
                agent = RCCController.navigator;
                //Debug.Log("Attempting to get navigator");
                continue;
            }


            float distance = Vector3.Distance(transform.position, RCCController.targetChase.position);
        
            if (agent.isOnNavMesh && distance < RCCController.detectorRadius)
            {
                agent.SetDestination(RCCController.targetChase.position);
            }
        }
        
        
    }

    private void SwitchTarget(string newTarget)
    {
        currentTargetTag = newTarget;
        carController.targetTag = currentTargetTag;
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
}
