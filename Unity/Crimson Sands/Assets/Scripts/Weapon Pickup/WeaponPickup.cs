using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// this goes on the collider object for a weapon pickup
/// <para>The collider must be set to trigger</para>
/// </summary>
public class WeaponPickup : MonoBehaviour
{
    [SerializeField] private Transform weaponSpawnPoint;
    [SerializeField] private WeaponInfo weapon;

    private void Awake()
    {
        //spawn weapon
        GameObject newWeapon = Instantiate(weapon.weaponPrefab, weaponSpawnPoint);
        newWeapon.transform.localPosition = Vector3.zero;
        newWeapon.transform.localRotation = Quaternion.identity;
        newWeapon.transform.localScale = Vector3.one;
        newWeapon.GetComponent<Weapon>().isPlayer = false;
    }

    private void OnTriggerEnter(Collider other)
    {
        WeaponPickupHandler carWeapons = other.GetComponent<WeaponPickupHandler>();
        if (carWeapons == null)
        {
            Debug.LogError("Change layers to weaponpickup doesn't interact with default colliders");
            return;
        }
        carWeapons.SwapWeapons(weapon);
        
        OnPickedUp();
    }

    private void OnPickedUp()
    {
        gameObject.SetActive(false);
    }
}
