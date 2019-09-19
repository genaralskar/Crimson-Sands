using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArmorHealth : Health
{
    [Tooltip("Rigidbody for the armor")]
    [SerializeField]
    private Rigidbody rb;

    [Tooltip("The joint the rigidbody is connected to")]
    [SerializeField]
    private Joint joint;

    [SerializeField]
    private Vector3 lauchDirection = Vector3.forward;

    [SerializeField]
    private float launchForce = 100f;

    private bool dead = false;
    
    protected override void Death()
    {
        if (!dead)
        {
            //detach armor from car
            Destroy(joint);
        
            //lauch armor
            Vector3 dir = transform.TransformDirection(lauchDirection);
            rb.AddForce((dir * launchForce) + (Vector3.up * 50));
        
            //Disable hitbox?
            DisableAllHurtboxes();
            dead = true;
        }
       
    }

    protected override void OnDamage(int amount)
    {
        Debug.Log("Damage: " + amount);
    }

    private void CheckArmorState()
    {
        //checks which state the armor should be in based on health
    }
}
