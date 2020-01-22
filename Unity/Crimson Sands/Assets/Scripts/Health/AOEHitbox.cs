using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AOEHitbox : Hitbox
{
    public float disableTime = .1f;
    public GameObjectPool explosionPool;
    public float explosiveForce = 10f;
    public float explosionRadius = 2f;

    public bool damageFalloff = true;
    public AnimationCurve falloffCurve = AnimationCurve.Linear(0, 1, 1, 0);
    
    
    private int startDamage;

    private void Start()
    {
        startDamage = weapon.damage;
        
        //Debug.Log($"Enabled, {transform.position}", this);
        explosionPool.GetPooledObject(transform.position, Quaternion.identity);

        //sphere overlap to see what colliders to hit
        Collider[] cols = Physics.OverlapSphere(transform.position, explosionRadius);

        //list to contained already activated weaponhits
        List<IWeaponHit> hits = new List<IWeaponHit>();
        List<Health> hitHealths = new List<Health>();

        //for each collider hit
        foreach (var col in cols)
        {
            //get its weapon hit. if its null, return. if its already in the activated list, return
            IWeaponHit wh = col.GetComponent<IWeaponHit>();
            if (wh == null) continue;

            Hurtbox hb = col.GetComponent<Hurtbox>();
            if (hb)
            {
                Health health = hb.health;
                if (health != null)
                {
                    Debug.Log($"health {health}");
                    if (hitHealths.Contains(health))
                    {
                        Debug.Log($"hitHealths already contains  {health}, returning");
                        continue;
                    }
                    Debug.Log($"adding {health} to hitHealths");
                    hitHealths.Add(health);
                }
            }
            
            SendDamage(col);
            
            //add to the activated list
            hits.Add(wh);
        }
        
        Invoke(nameof(Disable), disableTime);
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
        //startDamage = weapon.damage;
        
       
    }

    private void SendDamage(Collider other)
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

        //knockback
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

    private void Disable()
    {
        gameObject.SetActive(false);
    }

    private float DamageFalloff(Vector3 position)
    {   
        //get distance from obj
        float distance = Vector3.Distance(position, transform.position);

        //normalize distance with sizeof sphere collider
        distance = distance / explosionRadius;
        
        //get damage multiplier from curve
        float damageMultiplier = falloffCurve.Evaluate(distance);

        float newDamage = startDamage * damageMultiplier;
        
        //Debug.Log($"Grenade Damage = {newDamage}. Weapon Damage = {weapon.damage}");
        
        weapon.damage = (int)newDamage;

        return damageMultiplier;

    }
}
