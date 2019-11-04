using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ProjectileGrenade : MonoBehaviour
{
    private Rigidbody rb;

    public float launchForce = 5;
    public int damage = 10;
    public Weapon weapon;

    public GameObjectPool grenadeLauncherExplosion;
    public bool isPlayer;
    
    
    [Header("Audio")]
    public GameObjectPool audioSourcePool;
    public AudioContainer grenadeLaunch;
    private GameObject audioSource;
    private AudioManager audioManager;
    
    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
    }

    private void OnEnable()
    {
        
    }

    private void OnCollisionEnter(Collision other)
    {
        Explosion();
    }

    public void Fire(Vector3 velocity, bool player)
    {
        isPlayer = player;
        rb.velocity = (transform.forward * launchForce) + velocity;
        //play sound
        PlaySound(grenadeLaunch);
        
    }

    private void Explosion()
    {
        GameObject boom = grenadeLauncherExplosion.GetPooledObject(transform.position, Quaternion.identity);
        boom.GetComponent<Hitbox>().isPlayer = isPlayer;
        boom.GetComponent<Hitbox>().weapon = weapon;
        gameObject.SetActive(false);
    }

    private void PlaySound(AudioContainer container)
    {
        audioSource = audioSourcePool.GetPooledObject(transform.position, Quaternion.identity);
        audioManager = audioSource.GetComponent<AudioManager>();
        audioManager.container = container;
        
        audioManager.Play();
    }

    
}
