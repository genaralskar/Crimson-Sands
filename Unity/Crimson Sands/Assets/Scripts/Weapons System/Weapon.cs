using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

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
    [SerializeField]
    private Transform firePoint;

    [Tooltip("Whether or not the weapon will use raycasts or gameObjects for its projectiles")]
    [SerializeField]
    private bool useRaycast = false;

    [Tooltip("All the layers the raycast projectile can hit. This should include all physics layers, not just hurtbox layers")]
    [SerializeField]
    private LayerMask raycastProjectileLayerMask;

    public float spread = 0;

    [SerializeField] private RaycastProjectileInfo raycastProjectileInfo;
    
    [Tooltip("The projectile particle system. This should be attached to the firePoint transform")]
    public GameObjectPool projectile;

    [Tooltip("Whether or not this weapon is being fired by a player")]
    [SerializeField]
    public bool isPlayer = true;

    [Tooltip("This is used to set the proper layer when spawning projectiles. This shouldn't need to be changed as long" +
             " as the layers don't change")]
    [SerializeField] private int playerHitboxLayer = 10;
    [Tooltip("This is used to set the proper layer when spawning projectiles. This shouldn't need to be changed as long" +
             " as the layers don't change")]
    [SerializeField] private int enemyHitboxLayer = 12;

    [SerializeField] private LayerInfo layerInfo;
    
    [Tooltip("The animator of the weapon. Will automatically find an Animator component if none is assigned.")]
    public Animator anims;

    public AudioManager fireSoundSource;

    public GameObject muzzleFlash;

    public bool tracer = false;
    public LineRenderer tracerTemplate;
    
    private WeaponFireHandler fireHandler;
    
    private bool isFiring;

    private LineRenderer lineRend;
    private LineRendererFadeOverTime lineRendFade;

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
        
        muzzleFlash.SetActive(false);
    }

    private void Start()
    {
        SetupLineRenderer();
    }

//    Used for testing purposes
    private void Update()
    {
        if (Input.GetMouseButtonDown(0) && !IsFiring && isPlayer)
        {
            IsFiring = true;
        }

        if (Input.GetMouseButtonUp(0) && IsFiring & isPlayer)
        {
            IsFiring = false;
        }
    }

    private void SetupLineRenderer()
    {
        var lr = new GameObject("Line Rend");
        lineRend = lr.AddComponent<LineRenderer>();
        var rendTemp = tracerTemplate ? tracerTemplate : LineRendererTemplateObject.rend;
        
        lineRend.material = rendTemp.material;
        lineRend.colorGradient = rendTemp.colorGradient;
        lineRend.widthCurve = rendTemp.widthCurve;
        lineRend.endWidth = rendTemp.endWidth;
        lineRend.startWidth = rendTemp.startWidth;
        
        lineRendFade = lr.AddComponent<LineRendererFadeOverTime>();
        lineRendFade.rend = lineRend;
    }

    private void OnDrawGizmosSelected()
    {
        Gizmos.color = Color.red;
        Gizmos.DrawRay(firePoint.transform.position, firePoint.transform.forward * 100);
    }

    private void SetAnimsFiring(bool value)
    {
        anims.SetBool("IsFiring", value);
    }

    //this is called when the weapon event is called from the fire animation
    private void OnWeaponFireHandler()
    {
        if (useRaycast)
        {
            FireRaycast();
        }
        else
        {
            FireProjectile();
        }
        

        if (fireSoundSource != null)
        {
            fireSoundSource.Play();
        }
        
        if (muzzleFlash != null)
        {
            StopAllCoroutines();
            StartCoroutine(MuzzleFlash());
        }
        
    }

    private void FireProjectile()
    {
        GameObject newProj = projectile.GetPooledObject(firePoint.transform.position, firePoint.transform.rotation);
        Projectile proj = newProj.GetComponent<Projectile>();
        if (proj == null)
        {
            Debug.LogError("Object " + newProj + " does not have a projectile componenet. If you want to use this object " +
                           "as a projectile, you need to add the Projectile component");
            return;
        }
            
        
        //set team
        proj.player = isPlayer;
        
        //set the proper layer for the projectile
        if (isPlayer)
        {
            proj.SetLayer(playerHitboxLayer);
        }
        else
        {
            proj.SetLayer(enemyHitboxLayer);
        }
        
        //set damage
        proj.damage = damage;
        
        //set projectile velocity
    }

    private void FireRaycast()
    {
        Ray ray = new Ray(firePoint.position, firePoint.forward);
        RaycastHit hit;

        LayerMask weaponRayCastMask = layerInfo.weaponRaycastLayers;
        
        Vector3 direction = firePoint.forward;

        //do Spread
        float xSpread = Random.Range(-1f, 1f);
        float ySpread = Random.Range(-1f, 1f);
        float zSpread = Random.Range(-1f, 1f);
        
        Vector3 newSpread = new Vector3(xSpread, ySpread, zSpread);
        
        newSpread *= spread;
        
        //Debug.Log(newSpread);
        Debug.DrawRay(firePoint.position, direction, Color.blue);
        
        direction += newSpread;
        Debug.DrawRay(firePoint.position, direction, Color.red);

        if (Physics.SphereCast(firePoint.position, .1f, direction, out hit, Mathf.Infinity, weaponRayCastMask))
        {
            int hitLayer = hit.collider.gameObject.layer;
            //Debug.Log(hitLayer);
            //Debug.Log(hit.collider.gameObject);

            IWeaponHit[] weaponHits = hit.collider.gameObject.GetComponents<IWeaponHit>();
            if (weaponHits != null)
            {
                //if player, hit only enemy
                //if enemy, hit only player
                foreach (var weaponHit in weaponHits)
                {
                    weaponHit.OnWeaponHit(damage, hit.point);
                }
                
            }
            
            //player hit enemy hurtbox or enemy hit player hurtbox
//            if ((isPlayer && hitLayer == layerInfo.enemyHurtbox) || (!isPlayer && hitLayer == layerInfo.playerHurtbox))
//            {
//                Hurtbox hurtbox = hit.collider.gameObject.GetComponent<Hurtbox>();
//                hurtbox.SendDamage(damage);
//            }
            
            //spawn hitsparks
            Vector3 inDir = firePoint.position - hit.point;
            
            Vector3 dir = Vector3.Reflect(inDir, hit.normal);
            dir *= -1;
//            Debug.DrawRay(hit.point, inDir, Color.red, 1f);
//            Debug.DrawRay(hit.point, hit.normal, Color.green, 1f);
//            Debug.DrawRay(hit.point, dir, Color.blue, 1f);
            Quaternion newRot = Quaternion.LookRotation(dir);
            GameObject hitSparks = raycastProjectileInfo.hitSparks.GetPooledObject(hit.point, newRot);

            //==========================================================
            if (lineRend)
            {
                Vector3[] linePos = new[] {firePoint.position, hit.point};
                lineRend.SetPositions(linePos);
                lineRend.colorGradient = LineRendererTemplateObject.rend.colorGradient;
                
                lineRendFade.StartFade();
                
            }
            //============================================================

            if (hit.collider.transform.root == transform.root)
            {
                Debug.LogError("Weapon is hitting its own colliders! WTF!");
            }
            
            //play audio on impact point
        }

        return;
        if (Physics.Raycast(ray, out hit, Mathf.Infinity, weaponRayCastMask))
        {
            int hitLayer = hit.collider.gameObject.layer;
            Debug.Log(hitLayer);
            Debug.Log(hit.collider.gameObject);

            IWeaponHit weaponHit = (IWeaponHit) hit.collider.gameObject.GetComponent(typeof(IWeaponHit));
            if (weaponHit != null)
            {
                //if player, hit only enemy
                //if enemy, hit only player
                weaponHit.OnWeaponHit(damage, hit.point);
            }
            
            //player hit enemy hurtbox or enemy hit player hurtbox
//            if ((isPlayer && hitLayer == layerInfo.enemyHurtbox) || (!isPlayer && hitLayer == layerInfo.playerHurtbox))
//            {
//                Hurtbox hurtbox = hit.collider.gameObject.GetComponent<Hurtbox>();
//                hurtbox.SendDamage(damage);
//            }
            
            //spawn hitsparks
            //Debug.Log(hit.point);
            Vector3 inDir = firePoint.position - hit.point;
            
            Vector3 dir = Vector3.Reflect(inDir, hit.normal);
            dir *= -1;
//            Debug.DrawRay(hit.point, inDir, Color.red, 1f);
//            Debug.DrawRay(hit.point, hit.normal, Color.green, 1f);
//            Debug.DrawRay(hit.point, dir, Color.blue, 1f);
            Quaternion newRot = Quaternion.LookRotation(dir);
            GameObject hitSparks = raycastProjectileInfo.hitSparks.GetPooledObject(hit.point, newRot);

            //==========================================================
            if (lineRend)
            {
                Vector3[] linePos = new[] {firePoint.position, hit.point};
                lineRend.SetPositions(linePos);
                lineRend.colorGradient = LineRendererTemplateObject.rend.colorGradient;
                
                lineRendFade.StartFade();
                
            }
            //============================================================            

//            if (Vector3.Distance(firePoint.position, hit.point) < 5f)
//            {
//                Debug.Log("its close!");
//            }
            
            if (hit.collider.transform.root == transform.root)
            {
                Debug.LogError("Weapon is hitting its own colliders! WTF!");
            }
            
            //play audio on impact point


        }
    }

    private IEnumerator MuzzleFlash()
    {
        muzzleFlash.SetActive(true);
        //random rotation
        Vector3 newRot = Vector3.zero;
        newRot.z = Random.Range(0f, 360f);
        //newRot.z *= 360;
        muzzleFlash.transform.localRotation = Quaternion.Euler(newRot);

        yield return new WaitForFixedUpdate();
        
        muzzleFlash.SetActive(false);
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
