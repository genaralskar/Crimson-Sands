using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on the base weapon mount
/// It handles swapping weapons
/// </summary>
public class WeaponMount : MonoBehaviour
{
    public WeaponInfo currentWeapon;
    private WeaponInfo nextWeapon;

    public Transform mountPoint;
    
    public bool deployOnStart = true;

    private bool deployed = true;

    private Animator mountAnims;
    
    private GameObject weaponPrefab;
    private Animator weaponAnims;

    private bool swapping = false;
    private bool retracted = false;

    private void Awake()
    {
        mountAnims = GetComponent<Animator>();
        SpawnNewWeapon();
    }

    private void Start()
    {
        if (deployOnStart)
        {
            DeployWeapon();
        }
    }

    public void SwapWeapon(WeaponInfo newWeapon)
    {
        Debug.Log("Swapping!");
        swapping = true;
        nextWeapon = newWeapon;
        RetractWeapon();
    }
    
    //called from animation event at end of retract animation
    public void WeaponRetractedHandler()
    {
        if (swapping)
        {
            //retracted = true;
            SpawnNewWeapon();
            DeployWeapon();
        }
    }
    
    private void SpawnNewWeapon()
    {
        //delete old weapon
        if (weaponPrefab != null)
        {
            Destroy(weaponPrefab);
        }
        
        //spawn new weapon
        if(nextWeapon != null)
            currentWeapon = nextWeapon;
        
        weaponPrefab = Instantiate(currentWeapon.weaponPrefab, mountPoint);
        weaponPrefab.transform.localPosition = Vector3.zero;
        weaponPrefab.transform.localRotation = Quaternion.identity;
        weaponAnims = weaponPrefab.GetComponent<Weapon>().anims;

    }
    
    private void DeployWeapon()
    {
        mountAnims.SetBool("Deployed", true);
        //deployed = true;
    }
    
    private void RetractWeapon()
    {
        mountAnims.SetBool("Deployed", false);
        //tell animator on the weapon to play its retract animation
        //probably want to do this when we start the retract animation, so called from another event
        weaponAnims.SetTrigger("Retract");
        //deployed = false;
    }

    public void WeaponRetractStartHandler()
    {
        
    }



}
