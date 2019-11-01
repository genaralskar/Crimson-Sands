using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AOEHitbox : Hitbox
{
    public float disableTime = .1f;
    public GameObjectPool explosionPool;
    public float explosiveForce = 10f;

    public bool damageFalloff = false;
    public AnimationCurve falloffCurve;
    private int startDamage;
    private SphereCollider col;

    private void Start()
    {
        startDamage = weapon.damage;
        col = GetComponent<SphereCollider>();
    }

    private void OnTriggerEnter(Collider other)
    {
        IWeaponHit[] hits = other.GetComponents<IWeaponHit>();
        foreach (var hit in hits)
        {
            if (damageFalloff)
            {
                DamageFalloff(other.ClosestPointOnBounds(transform.position));
            }
            
            hit.OnWeaponHit(weapon, transform.position);
            weapon.damage = startDamage;
        }
        other.attachedRigidbody?.AddExplosionForce(explosiveForce, transform.position, 2f, 1);
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

    private void DamageFalloff(Vector3 position)
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

    }
}
