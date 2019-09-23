using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

/// <summary>
/// This goes on any collider that acts as a way to send damage to a health script, like armor, or the car chassis
/// SendDamage(int amount) can subtract health, SendHealth(int amount) can add health
/// Layers should be set up to only have certain hitboxes collide/interact with this collider
/// </summary>
public class Hurtbox : MonoBehaviour
{
    [SerializeField] private Health health;

    public UnityAction OnHurtboxDamage;
    public UnityAction OnHurtboxHealing;

    private void OnEnable()
    {
        health.AddHurtbox(this);
    }

    private void OnDisable()
    {
        health.RemoveHurtbox(this);
    }

    private void OnTriggerEnter(Collider other)
    {
        Hitbox otherHit = other.GetComponent<Hitbox>();
        SendDamage(otherHit.damage);
        
        //place hitsparks
        //get direction to rotate the sparks in (hopefully)
        Vector3 triggerNormalDirection = other.transform.position - transform.position;

        if (otherHit.projectile.hitSparks != null)
        {
            GameObject hitSparks = otherHit.projectile.hitSparks.GetPooledObject(other.transform.position, Quaternion.Euler(triggerNormalDirection));
        }
        
        //disable projectile that hit this
        otherHit.projectile.gameObject.SetActive(false);
    }

    private void OnCollisionEnter(Collision other)
    {
        Hitbox otherHit = other.collider.GetComponent<Hitbox>();
        SendDamage(otherHit.damage);
        
        //place hitsparks
        //get direction to rotate the sparks in (hopefully)
        Vector3 triggerNormalDirection = other.contacts[0].normal;

        //spawn hitsparks
        if (otherHit.projectile.hitSparks != null)
        {
            GameObject hitSparks = otherHit.projectile.hitSparks.GetPooledObject(other.transform.position, Quaternion.Euler(triggerNormalDirection));
        }
        
        //disable projectile that hit this
        otherHit.projectile.gameObject.SetActive(false);
    }

    public void SendDamage(int amount)
    {
        health.ModifyHealth(-amount);
        OnHurtboxDamage?.Invoke();
    }

    public void SendHealth(int amount)
    {
        health.ModifyHealth(amount);
        OnHurtboxHealing?.Invoke();
    }
}
