using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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

    [Tooltip("The time it takes for the projectile to disable itself. Set to -1 to keep enabled forever")]
    [SerializeField]    
    private float lifetime = 5f;
    
    private Vector3 moveVector = Vector3.forward;

    private void Awake()
    {
        UpdateGravity(gravity);
    }

    private void OnDisable()
    {
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
}
