using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This object gets attached to the vehicle's colliders on Start from the WeaponPickupVehicle script
/// <para>Used to tell the weapons to swap to a new weapon when driving through a weapon pickup</para>
/// </summary>
public class WeaponPickupHandler : MonoBehaviour
{
    public WeaponPickupVehicle vehicle;

    public void SwapWeapons(WeaponInfo weapon)
    {
        vehicle.SwapWeapons(weapon);
    }
}
