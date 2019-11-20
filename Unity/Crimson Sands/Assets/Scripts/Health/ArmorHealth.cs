using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// This goes on all vehicle armor pieces that have/need health
/// <para>Handles armor health and detatching armor when health drops to or below </para>
/// <para>This will also eventually handles changing the model depending on health thresholds to show damage</para>
/// </summary>
public class ArmorHealth : Health
{
    [Tooltip("Rigidbody for the armor")]
    [SerializeField]
    public Rigidbody rb;

    [HideInInspector] public Rigidbody vehicleRb;

    [Tooltip("The joint the rigidbody is connected to")]
    [SerializeField]
    public Joint joint;

    //[HideInInspector]
    public Vector3 positionOffset;
    //[HideInInspector]
    public Quaternion rotationOffset;

    [SerializeField]
    private Vector3 lauchDirection = Vector3.forward;

    [SerializeField]
    private float launchForce = 5;

    public bool dead = false;

    public ArmorSet armorSet;
    

    private void Awake()
    {
        if (joint == null)
        {
            joint = GetComponent<Joint>();
        }

        if (rb == null)
        {
            rb = GetComponent<Rigidbody>();
        }
    }

    protected override void Death()
    {
        if (!dead)
        {
            //detach armor from car
            joint.connectedBody = null;
            Destroy(joint);
            joint = null;
            armorSet.attachedPieces.Remove(gameObject);

            StartCoroutine(LaunchArmor());
        
            //Disable hitbox?
            SetAllHurtboxesActive(false);
            dead = true;
        }
    }

    public override void ResetHealth()
    {
        SetHealth(maxHealth);
        SetAllHurtboxesActive(true);
        dead = false;
    }
    
    private IEnumerator LaunchArmor()
    {
        yield return new WaitForFixedUpdate();
        //lauch armor
        //might have to wait for a fixed update to add force
        Vector3 dir = transform.TransformDirection(lauchDirection);
        //Debug.Log("lauch direction: " + dir, this.gameObject);
        Vector3 lForce = (dir * launchForce);
        //Debug.Log("launch force: " + lForce);
        rb.AddForce(lForce, ForceMode.VelocityChange);
    }

    protected override void OnDamage(int amount)
    {
        //Debug.Log("Damage: " + amount);
    }

    private void CheckArmorState()
    {
        //checks which state the armor should be in based on health
    }
}
