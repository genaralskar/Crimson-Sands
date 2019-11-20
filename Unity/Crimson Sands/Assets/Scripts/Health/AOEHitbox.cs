using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AOEHitbox : Hitbox
{
    public float disableTime = .1f;
    public GameObjectPool explosionPool;
    public float explosiveForce = 10f;

    public bool damageFalloff = true;
    public AnimationCurve falloffCurve = AnimationCurve.Linear(0, 1, 1, 0);
    
    
    private int startDamage;
    private SphereCollider col;

    private void Start()
    {
        startDamage = weapon.damage;
        col = GetComponent<SphereCollider>();
    }

    private void OnTriggerEnter(Collider other)
    {
        float damageMulti = 1;
        IWeaponHit[] hits = other.GetComponents<IWeaponHit>();
        foreach (var hit in hits)
        {
            if (damageFalloff)
            {
                damageMulti = DamageFalloff(other.ClosestPointOnBounds(transform.position));
            }
            
            hit.OnWeaponHit(weapon, transform.position);
            weapon.damage = startDamage;
        }

        Rigidbody otherRb = other.attachedRigidbody;
        if (!otherRb) return;
        ArmorHealth ah = otherRb.GetComponent<ArmorHealth>();
        
        //if the armor health is not detached, or the armor health isPlayer is the same as the weapons isPlayer
        if (ah && (!ah.dead || ah.isPlayer == weapon.isPlayer)) return;

        if (otherRb)
        {
            otherRb.AddExplosionForce(explosiveForce * damageMulti, transform.position, 2f, 1);
        }
        
    }

    private void OnEnable()
    {
        //Debug.Log($"Enabled, {transform.position}", this);
        explosionPool.GetPooledObject(transform.position, Quaternion.identity);
        Invoke(nameof(Disable), disableTime);
    }

    private void Disable()
    {
        gameObject.SetActive(false);
    }

    private float DamageFalloff(Vector3 position)
    {   
        //get distance from obj
        float distance = Vector3.Distance(position, transform.position);

        //normalize distance with sizeof sphere collider
        distance = distance / col.radius;
        
        //get damage multiplier from curve
        float damageMultiplier = falloffCurve.Evaluate(distance);

        float newDamage = startDamage * damageMultiplier;
        
        //Debug.Log($"Grenade Damage = {newDamage}");
        
        weapon.damage = (int)newDamage;

        return damageMultiplier;

    }
}
