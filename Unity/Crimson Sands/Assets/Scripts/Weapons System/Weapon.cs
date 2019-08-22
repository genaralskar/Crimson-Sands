using UnityEngine;

///<summary>
/// This class handles firing weapons. This should only be on the root object of a weapon prefab.
/// Modify IsFiring variable to start/stop firing.
/// Contains methods for StartFiringHandler, StopFiringHandler, RetractWeaponHandler
/// </summary>

public class Weapon : MonoBehaviour
{
    //damage and particle may be replaced with scriptable object holding this info, allowing easy swaps/upgrades
    //particle system may be replaced with pooled gameobject projectiles or raycasts(?)
    
    public int damage = 10;
    
    [Tooltip("The transform where the projectile with appear from")]
    public Transform firePoint;
    
    [Tooltip("The projectile particle system. This should be attached to the firePoint transform")]
    public ParticleSystem projectile;
    
    [Tooltip("The animator of the weapon. Will automatically find an Animator component if none is assigned.")]
    public Animator anims;
    
    private WeaponFireHandler fireHandler;
    
    private bool isFiring;

    //Turning this on or off starts/stops firing
    public bool IsFiring
    {
        get { return isFiring; }
        set
        {
            isFiring = value;
            SetAnimsFiring(value);
        }
    }

    private void Awake()
    {
        if (anims == null)
        {
            anims = GetComponentInChildren<Animator>();
        }
        
        fireHandler = anims.gameObject.AddComponent<WeaponFireHandler>();
        fireHandler.OnWeaponFire += OnWeaponFireHandler;
    }

//    Used for testing purposes
//    private void Update()
//    {
//        if (Input.GetMouseButtonDown(0) && !IsFiring)
//        {
//            IsFiring = true;
//        }
//
//        if (Input.GetMouseButtonUp(0) && IsFiring)
//        {
//            IsFiring = false;
//        }
//
//        if (Input.GetButtonDown("Brake"))
//        {
//            RetractWeaponHandler();
//        }
//    }
    
    private void SetAnimsFiring(bool value)
    {
        anims.SetBool("IsFiring", value);
    }

    private void OnWeaponFireHandler()
    {
        FireParticle();
    }

    private void FireParticle()
    {
        projectile.Play();
    }

    
    
    public void StartFiringHandler()
    {
        IsFiring = true;
    }

    public void StopFiringHandler()
    {
        IsFiring = false;
    }
    
    public void RetractWeaponHandler()
    {
        anims.SetTrigger("Retract");
    }
}
