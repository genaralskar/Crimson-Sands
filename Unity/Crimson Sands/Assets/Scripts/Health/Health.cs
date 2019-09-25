using System.Collections;
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

    public List<Hurtbox> Hurtboxes
    {
        get { return hurtboxes; }
    }
    
    private List<Hurtbox> hurtboxes = new List<Hurtbox>();

    public float NormalizedHealth
    {
        get { return (float)currentHealth / (float)maxHealth; }
    }

    public void ModifyHealth(int amount)
    {
        OnDamage(amount);
        currentHealth += amount;

        HealthCheck();
    }

    public void SetHealth(int amount)
    {
        OnDamage(amount);
        currentHealth = amount;
        
        HealthCheck();
    }

    private void HealthCheck()
    {
        if (currentHealth > maxHealth)
        {
            currentHealth = maxHealth;
        }

        if (currentHealth <= 0)
        {
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
