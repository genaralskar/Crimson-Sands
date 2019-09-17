using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// Base abstract class for health
/// Contains info for maxHealth and currentHealth
/// Handles adding/subtracting health and handling proper events/methods, like when health drops below 0
/// ModifyHealth(int amount) will change the current health by amount, SetHealth(int amount) sets current health to amount
/// Death() can be overridden to change what happens on death by a case by case basis
/// </summary>
public abstract class Health : MonoBehaviour
{
    public int maxHealth = 100;
    public int currentHealth = 100;
    
    public float NormalizedHealth
    {
        get { return (float)currentHealth / (float)maxHealth; }
    }

    public void ModifyHealth(int amount)
    {
        currentHealth += amount;

        HealthCheck();
    }

    public void SetHealth(int amount)
    {
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
}
