using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HealthBar : MonoBehaviour
{
    public Health playerHealth;

    private void Awake()
    {
        playerHealth.HealthChange += HealthUpdatedHandler;
    }

    private void HealthUpdatedHandler(int amount)
    {
        
    }
}
