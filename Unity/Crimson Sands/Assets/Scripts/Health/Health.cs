﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

/// <summary>
/// Base abstract class for health.
/// Contains info for maxHealth and currentHealth.
/// Handles adding/subtracting health and handling proper events/methods, like when health drops below 0.
/// ModifyHealth(int amount) will change the current health by amount, SetHealth(int amount) sets current health to amount.
/// Death() can be overridden to change what happens on death by a case by case basis
/// </summary>
public abstract class Health : MonoBehaviour
{
    public UnityAction<int> HealthChange;
    
    public int maxHealth = 100;
    public int currentHealth = 100;

    public bool invincible = false;
    public bool isPlayer = false;

    public bool iFrames = true;
    public float iFrameTime = 0.01f;
    private float lastHitTime = 0;
    
    public List<Hurtbox> Hurtboxes
    {
        get { return hurtboxes; }
    }
    
    private List<Hurtbox> hurtboxes = new List<Hurtbox>();

    public float NormalizedHealth
    {
        get { return (float)currentHealth / (float)maxHealth; }
    }

    public virtual void ModifyHealth(int amount)
    {
        if (invincible) return;

        //I-Frame stuff
        if (Time.time - lastHitTime >= iFrameTime)
        {
            //last hit timer up
            //health not invincible
            lastHitTime = Time.time;
        }
        else
        {
            //Debug.Log("IFrames!");
            //last hit timer not up
            //health is invincible
            return;
        }
        
        OnDamage(amount);
        currentHealth += amount;
        HealthChange?.Invoke(amount);

        HealthCheck();
    }

    public void SetHealth(int amount)
    {
        if (invincible) return;
        
        OnDamage(amount);
        currentHealth = amount;
        
        HealthCheck();
    }

    protected void HealthCheck()
    {
        if (currentHealth > maxHealth)
        {
            currentHealth = maxHealth;
        }

        if (currentHealth <= 0)
        {
            //Debug.Log("Health low!");
            currentHealth = 0;
            Death();
        }
    }

    protected virtual void Death()
    {
        
    }

    protected virtual void OnDamage(int amount)
    {
        
    }

    public virtual void ResetHealth()
    {
        
    }

    public void AddHurtbox(Hurtbox hurtbox)
    {
        if (!hurtboxes.Contains(hurtbox))
        {
            hurtboxes.Add(hurtbox);
        }
    }

    public void RemoveHurtbox(Hurtbox hurtbox)
    {
        if (hurtboxes.Contains(hurtbox))
        {
            hurtboxes.Remove(hurtbox);
        }
    }

    public void RemoveAllHurtboxes()
    {
        foreach (var hurtbox in hurtboxes)
        {
            RemoveHurtbox(hurtbox);
        }
    }

    public void SetHurtboxActive(Hurtbox hurtbox, bool active)
    {
        hurtbox.gameObject.SetActive(active);
    }

    public void SetAllHurtboxesActive(bool active)
    {
        for (int i = hurtboxes.Count - 1; i >= 0; i--)
        {
            SetHurtboxActive(hurtboxes[i], active);
        }
    }

    public void DisableHurtbox(Hurtbox hurtbox)
    {
        hurtbox.gameObject.SetActive(false);
    }

    public void DisableAllHurtboxes()
    {
        for (int i = hurtboxes.Count - 1; i >= 0; i--)
        {
            DisableHurtbox(hurtboxes[i]);
        }
    }
}
