using System;
using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;
/// <summary>
/// This goes on an object that is meant to be shot out of a weapon
/// SetLayer(int newLayer) can be used to set the proper layer for this projectile
/// </summary>
public class Projectile : MonoBehaviour
{
    [Tooltip("How fast the projectile moves")]
    [SerializeField]
    private float speed = 20;

    [Tooltip("If gravity affects this projectile or not. DOESN'T WORK")]
    [SerializeField]
    private bool gravity = false;

    [SerializeField]
    private float gravityModifier = 1;

    [Tooltip("If this projectile is being fired by a player or not\n" +
             "This gets changed on the Weapon script when it gets fired")]
    public bool player = true;

    public int damage = 10;

    [Tooltip("The time it takes for the projectile to disable itself. Set to -1 to keep enabled forever")]
    [SerializeField]    
    private float lifetime = 5f;

    [Tooltip("The pooled hit spark projectiles to be placed when this projectile collides with an object")]
    public GameObjectPool hitSparks;

    private Collider col;

    private Hitbox hitbox;

    //when the velocity of the projectile is changed, it updates its move speed/direction with the new velocity
    //velocity is reset back to 0 whenever the object is disabled
    public Vector3 Velocity
    {
        get
        {
            return velocity;
        }
        set
        {
            UpdateGravity(gravity);
            velocity = value;
        }
    }

    private Vector3 velocity = Vector3.zero;
    private Vector3 moveVector = Vector3.forward;

    
    private void Awake()
    {
        UpdateGravity(gravity);
        col = GetComponentInChildren<Collider>();
        hitbox = GetComponentInChildren<Hitbox>();
        hitbox.projectile = this;
    }

    private void OnDisable()
    {
        velocity = Vector3.zero;
        StopAllCoroutines();
    }

    private void OnEnable()
    {
        //check if lifetime is equal to -1
        //this math stuff is what rider told me to do instead of checking != -1 because its a float
        if(Math.Abs(lifetime - (-1)) > .01f)
            //if not, start lifetime countdown
            StartCoroutine(LifetimeCounter());
    }

    private void Update()
    {
        Move();
    }

    private void Move()
    {
        transform.Translate(moveVector * Time.deltaTime);
    }

    //add gravity to the movement vector, doesn't work
    private void UpdateGravity(bool grav)
    {
        moveVector = transform.forward * speed;
        moveVector += velocity;
        if (grav)
        {
            moveVector += transform.InverseTransformDirection(Physics.gravity) * gravityModifier;
        }
    }

    private IEnumerator LifetimeCounter()
    {
        yield return new WaitForSeconds(lifetime);
        gameObject.SetActive(false);
    }

    public void SetLayer(int newLayer)
    {
        col.gameObject.layer = newLayer;
    }

    public void SetProjectileDamage(int newDamage)
    {
        damage = newDamage;
        hitbox.damage = damage;
    }
}
