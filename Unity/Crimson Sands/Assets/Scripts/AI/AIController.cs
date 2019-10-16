using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using UnityEngine;
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
    
    public Transform currentTarget;
    public float nearDistance = 10f;
    public float farDistance = 50f;
    public float minSpeed = 50f;

    private float maxSpeed;
    
    [SerializeField] private List<WeaponMount> weapons;

    private void Awake()
    {
        carController = GetComponent<RCC_AICarController>();
        maxSpeed = carController.maximumSpeed;
        armorHolder = GetComponent<ArmorHolder>();
        FindWeaponMounts();
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
//        if (Physics.Raycast(ray, out hit, rayLayers))
//        {
//            
//        }
//    
//        //then fire if it is
//        if (Physics.BoxCast(rayPoint.position, (Vector3.one * .2f), rayPoint.forward, out hit, rayPoint.rotation, Mathf.Infinity, rayLayers))
//        {
//            //Debug.Log("Firing at player. " + hit.collider);
//            FireWeapon(true);
//        }
//        else
//        {
//            //Debug.Log("Stopped firing!");
//            FireWeapon(false);
//        }

        if (Physics.BoxCast(rayPoint.position, (Vector3.one * .2f), rayPoint.forward, out hit, rayPoint.rotation,
            Mathf.Infinity, layerInfo.weaponRaycastLayers))
        {
            IWeaponHit weaponHit = (IWeaponHit) hit.collider.gameObject.GetComponent(typeof(IWeaponHit));
            if (weaponHit != null)
            {
                //if player, hit only enemy
                //if enemy, hit only player
                return true;
            }
        }

        return false;
    }

    private IEnumerator TargetSwitchTimer()
    {
        yield return new WaitForSeconds(5f);
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
