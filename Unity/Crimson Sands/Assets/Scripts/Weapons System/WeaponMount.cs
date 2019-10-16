using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on the base weapon mount
/// It handles, playing deploy/retract animations for the weapon mount and current weapon and destorying/instantiating weapons to swap them
/// Should probably change it to a pool instead of instatiation
/// SwapWeapon(WeaponInfo newWeapon) can be called to swap out the weapon manually
/// </summary>
public class WeaponMount : MonoBehaviour
{
    public bool isPlayer = false;
    
    public WeaponInfo currentWeapon;
    private WeaponInfo nextWeapon;

    public Transform mountPoint;
    
    public bool deployOnStart = true;

    private bool deployed = true;

    private Animator mountAnims;
    
    private GameObject weaponPrefab;
    private Weapon weapon;
    private Animator weaponAnims;

    private bool swapping = false;
    private bool retracted = false;

    private void OnEnable()
    {
        if(isPlayer)
            SendSwapWeaponEvent.SwapPlayerWeapon += SwapWeaponHandler;
    }

    private void OnDisable()
    {
        if(isPlayer)
            SendSwapWeaponEvent.SwapPlayerWeapon -= SwapWeaponHandler;
    }

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

    public void SwapWeaponHandler(WeaponInfo newWeapon)
    {
        //Debug.Log("Swapping!");
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

        weapon = weaponPrefab.GetComponent<Weapon>();
        weapon.isPlayer = isPlayer;
        weaponAnims = weapon.anims;

    }
    
    private void DeployWeapon()
    {
        mountAnims.SetBool("Deployed", true);
        
        //tell the attached weapon to play its deploy animation
        weaponAnims.SetTrigger("Deploy");
        swapping = false;
    }
    
    private void RetractWeapon()
    {
        mountAnims.SetBool("Deployed", false);
    }

    public void WeaponRetractStartHandler()
    {
        //tell animator on the weapon to play its retract animation
        weaponAnims.SetTrigger("Retract");
    }

    public void SetWeaponFiring(bool isFiring)
    {
        weapon.IsFiring = isFiring;
    }



}
