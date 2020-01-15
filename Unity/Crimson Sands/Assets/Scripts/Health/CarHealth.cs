using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarHealth : Health
{
    public bool playerTeam = false;
    public GameObjectPool deathExplosion;
    public bool resetHealthOnEnable = true;

    public ArmorHolder armor;
    //

    private int maxArmorMod = 10;
    private float minDamagePercent = 0.3f;
    
    
    private void OnEnable()
    {
        if (resetHealthOnEnable)
        {
            SetHealth(maxHealth);
        }
    }

    private void Start()
    {
        armor = GetComponent<ArmorHolder>();
    }

    public override void ModifyHealth(int amount)
    {
        if (invincible) return;
        
        OnDamage(amount);
        //Debug.Log($"damage was {amount}");
        //modify amount by number of armor pieces
        if (armor && armor.currentArmor)
        {
            float newAmount = amount * DamageModifier();
            amount = (int)newAmount;
        }
        
        //Debug.Log($"Damage is now {amount}");
        
        currentHealth += amount;
        HealthChange?.Invoke(amount);

        HealthCheck();
    }

    protected override void Death()
    {
        //blow up car
        Debug.Log("Car Death!");
        
        
        Debug.Log("Not Player");
        if (deathExplosion)
        {
            Debug.Log("KABOOOM");
            GameObject explosion = deathExplosion.GetPooledObject(transform.position, transform.rotation);
            explosion.gameObject.SetActive(true);
        }

        gameObject.SetActive(false);

        if (isPlayer)
        {
            PlayerDeathManager.PlayerDeath?.Invoke();
        }
        
    }

    private float DamageModifier()
    {
        int currentArmor = armor.currentArmor.attachedPieces.Count;

        float mod = 1;
        if (currentArmor < maxArmorMod)
        {
            mod = (float)currentArmor / (float)maxArmorMod;
        }

        //if max armor, normal mod would return 1, but we want it to return 0
        //so just 1 minus it to reverse the values
        //i love 0 to 1 space
        mod = 1 - mod;
        
        //from 0 to 1, to .3 to 1
        //multiply by .7 to remap it to 0 to .7
        //add .3 to move it from 0 to .7 to .3 to 1
        mod = mod * 0.7f + 0.3f;
        
        //Debug.Log($"damage mod = {mod}, currentArmor = {currentArmor}, maxArmorMod = {maxArmorMod}");
        return mod;
    }
}
