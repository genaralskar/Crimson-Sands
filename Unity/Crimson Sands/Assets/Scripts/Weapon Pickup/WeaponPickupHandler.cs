using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on the object on the vehicle that has the collider
/// </summary>
public class WeaponPickupHandler : MonoBehaviour
{
    public List<WeaponMount> weaponMounts;

    public void SwapWeapons(WeaponInfo weapon)
    {
        foreach (var mount in weaponMounts)
        {
            mount.SwapWeaponHandler(weapon);
        }
    }
}
