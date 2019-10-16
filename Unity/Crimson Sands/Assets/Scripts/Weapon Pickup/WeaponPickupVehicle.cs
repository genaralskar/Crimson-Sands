using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on the root object for a vehicle, and adds WeaponPickupHandler to all colliders at Start
/// </summary>
public class WeaponPickupVehicle : MonoBehaviour
{
    [Tooltip("Check if you want this to automatically setup all the WeaponPickupHanlders on the vehicle's colliders." +
             "\nUncheck if you want to do it manually, or not have weapons pickups for this vehicle")]
    [SerializeField] private bool setupHandlersOnStart = true;

    [SerializeField] private bool onlySetupOnLayer = false;
    [Tooltip("Should be the layer that interacts with the pickup layer. Probably VehicleBody layer")]
    [SerializeField] private int layer = 15;

    [SerializeField] private bool autoFindWeaponMounts = true;
    
    [Tooltip("All the weapon mounts that are attached to the vehicle")]
    public List<WeaponMount> weaponMounts;

    
    
    void Start()
    {
        if (!setupHandlersOnStart) return;

        if (autoFindWeaponMounts)
        {
            FindWeaponMounts();
        }
        
        StartCoroutine(AttachHandlers());
    }

    private void FindWeaponMounts()
    {
        WeaponMount[] mounts = GetComponentsInChildren<WeaponMount>();

        foreach (var mount in mounts)
        {
            if (!weaponMounts.Contains(mount))
            {
                weaponMounts.Add(mount);
            }
        }
    }

    private IEnumerator AttachHandlers()
    {
        //gotta wait till the next frame cause the car controller i guess makes/moves all the colliders in start,
        //and this need to happen after that so just to be safe it's a frame later
        yield return new WaitForEndOfFrame();
        Collider[] colliderObjects = GetComponentsInChildren<Collider>();

        foreach (var collider in colliderObjects)
        {
            if (onlySetupOnLayer)
            {
                //if collider does not have Pickup layer, skip over it
                if(collider.gameObject.layer != layer) continue;
            }
            
            WeaponPickupHandler newHandler = collider.gameObject.AddComponent<WeaponPickupHandler>();
            newHandler.vehicle = this;
        }
    }

    //called from WeaponPickupHandler when the player drives through a weapon pickup
    public void SwapWeapons(WeaponInfo weapon)
    {
        foreach (var mount in weaponMounts)
        {
            mount.SwapWeaponHandler(weapon);
        }
    }
}
