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
    [SerializeField] private float respawnTime = 10f;

    private List<Transform> children = new List<Transform>();
    private Collider col;
    
    private void Awake()
    {
        //spawn weapon
        GameObject newWeapon = Instantiate(weapon.weaponPrefab, weaponSpawnPoint);
        newWeapon.transform.localPosition = Vector3.zero;
        newWeapon.transform.localRotation = Quaternion.identity;
        newWeapon.transform.localScale = Vector3.one;
        newWeapon.GetComponent<Weapon>().isPlayer = false;

        col = GetComponent<Collider>();
        
        foreach (Transform child in transform)
        {
            children.Add(child);
        }
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
        Deactivate();
        if (respawnTime > 0)
        {
            StartCoroutine(RespawnCountdown());
        }
    }

    private void Activate(bool value = true)
    {
        foreach (var child in children)
        {
            child.gameObject.SetActive(value);
        }

        col.enabled = value;
    }

    private void Deactivate()
    {
        Activate(false);
    }

    private IEnumerator RespawnCountdown()
    {
        yield return new WaitForSeconds(respawnTime);
        Activate();
    }
}
