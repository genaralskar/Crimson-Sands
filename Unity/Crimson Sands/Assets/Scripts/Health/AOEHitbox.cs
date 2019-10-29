using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AOEHitbox : Hitbox
{
    public float disableTime = .1f;
    public GameObjectPool explosionPool;
    public float explosiveForce = 10f;
    
    private void OnTriggerEnter(Collider other)
    {
        IWeaponHit[] hits = other.GetComponents<IWeaponHit>();
        foreach (var hit in hits)
        {
            hit.OnWeaponHit(weapon, transform.position);
        }
        other.attachedRigidbody.AddExplosionForce(explosiveForce, transform.position, 2f, 1);
    }

    private void Start()
    {
        
    }

    private void OnEnable()
    {
        Debug.Log($"Enabled, {transform.position}", this);
        explosionPool.GetPooledObject(transform.position, Quaternion.identity);
        Invoke(nameof(Disable), disableTime);
    }

    private void Disable()
    {
        gameObject.SetActive(false);
    }
}
