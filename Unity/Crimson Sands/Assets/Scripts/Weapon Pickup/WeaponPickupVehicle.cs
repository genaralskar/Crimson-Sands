using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on the root object for a vehicle, and adds WeaponPickupHandler to all colliders at Start
/// </summary>
public class WeaponPickupVehicle : MonoBehaviour
{
    [Tooltip("All the weapon mounts that are attached to the vehicle")]
    public List<WeaponMount> weaponMounts;
    
    void Start()
    {
        StartCoroutine(AttachHandlers());
    }

    private IEnumerator AttachHandlers()
    {
        //gotta wait till the next frame cause the car controller i guess makes/moves all the colliders in start,
        //and this need to happen after that so just to be safe it's a frame later
        yield return new WaitForEndOfFrame();
        Collider[] colliderObjects = GetComponentsInChildren<Collider>();

        foreach (var collider in colliderObjects)
        {
            WeaponPickupHandler newHandler = collider.gameObject.AddComponent<WeaponPickupHandler>();
            newHandler.vehicle = this;
        }
    }

    //should be called from WeaponPickupHandler when the player drives through a weapon pickup
    public void SwapWeapons(WeaponInfo weapon)
    {
        foreach (var mount in weaponMounts)
        {
            mount.SwapWeaponHandler(weapon);
        }
    }
}
