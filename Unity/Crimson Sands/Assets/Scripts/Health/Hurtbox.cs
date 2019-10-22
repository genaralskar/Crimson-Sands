using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

/// <summary>
/// This goes on any collider that acts as a way to send damage to a health script, like armor, or the car chassis
/// SendDamage(int amount) can subtract health, SendHealth(int amount) can add health
/// Layers should be set up to only have certain hitboxes collide/interact with this collider
/// </summary>
public class Hurtbox : MonoBehaviour, IWeaponHit
{
    [SerializeField] public Health health;

    public UnityAction OnHurtboxDamage;
    public UnityAction OnHurtboxHealing;

    public bool enableCollision = false;

    [Tooltip("Check this when it is used for a car hurtbox, because for some reason the car controller move the collider" +
             " to somewhere else in the hiearchy, but just the collider not the whole game object, so this finds it again")]
    public bool moveHurtboxToCollider = false;

    private void OnEnable()
    {
        //health.AddHurtbox(this);
    }

    private void OnDisable()
    {
        //health.RemoveHurtbox(this);
    }

    private void Start()
    {
        if (moveHurtboxToCollider)
        {
            StartCoroutine(MoveHurtBox());
        }
    }

    private IEnumerator MoveHurtBox()
    {
        //wait for end of frame so the car controller script can be done moving stuff
        yield return new WaitForEndOfFrame();
        yield return new WaitForEndOfFrame();
        yield return new WaitForEndOfFrame();
        string searchTerm = $"Colliders/{gameObject.name}(Clone)";
        //Debug.Log(searchTerm);
        //Debug.Log(transform.root);
        GameObject newCol = transform.root.Find(searchTerm).gameObject;
        Hurtbox newHurt = newCol.AddComponent<Hurtbox>();
        newHurt.moveHurtboxToCollider = false;
        newHurt.health = this.health;
        //destory this maybe
    }

    private void OnTriggerEnter(Collider other)
    {

        Hitbox otherHit = other.GetComponent<Hitbox>();

        if (!otherHit) return;
        
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
        if (!enableCollision) return;
        
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

    public void OnWeaponHit(Weapon weapon, Vector3 hitPoint)
    {
        //Debug.Log("Sending Damage!");
        SendDamage(weapon.damage);
    }

    public void SendDamage(int amount)
    {
        health.ModifyHealth(-amount);
        OnHurtboxDamage?.Invoke();
        //Debug.Log("sending damage");
    }

    public void SendHealth(int amount)
    {
        health.ModifyHealth(amount);
        OnHurtboxHealing?.Invoke();
    }
}
