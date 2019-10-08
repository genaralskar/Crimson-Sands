using System.Collections;
using System.Collections.Generic;
using UnityEngine;
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

    public Transform rayPoint;
    public LayerMask rayLayers;

    [SerializeField] private List<WeaponMount> weapons;

    private void Awake()
    {
        carController = GetComponent<RCC_AICarController>();
        armorHolder = GetComponent<ArmorHolder>();
        FindWeaponMounts();
    }

    private void Update()
    {
        //shoot ray you see if player/semi is infront of ai
        CheckRayHit();
        
        
        
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

    private void CheckRayHit()
    {
        Ray ray = new Ray(rayPoint.position, rayPoint.forward);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, rayLayers))
        {
            
        }
    
        //then fire if it is
        if (Physics.BoxCast(rayPoint.position, (Vector3.one * .2f), rayPoint.forward, out hit, rayPoint.rotation, Mathf.Infinity, rayLayers))
        {
            Debug.Log("Firing at player. " + hit.collider);
            FireWeapon(true);
        }
        else
        {
            Debug.Log("Stopped firing!");
            FireWeapon(false);
        }
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
}
