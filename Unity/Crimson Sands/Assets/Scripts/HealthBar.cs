using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UIElements;

public class HealthBar : MonoBehaviour
{
    public Health playerHealth;
    private UnityEngine.UI.Image healthBarImage;
    private Material healthMaterial;
    
    //float normalize
    
    private void Start()
    {
        healthBarImage = gameObject.GetComponent<UnityEngine.UI.Image>();
    }

    private void Awake()
    {
        playerHealth.HealthChange += HealthUpdatedHandler;
    }

    private void HealthUpdatedHandler(int amount)
    {
        if (healthBarImage != null)
        {
            healthBarImage.fillAmount = playerHealth.NormalizedHealth;
        }
        
    }
}
