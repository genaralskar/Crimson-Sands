using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class PlayerDeathManager : MonoBehaviour
{
    public static UnityAction PlayerDeath;

    public CarHealth playerHealth;

    private void Awake()
    {
        PlayerDeath += PlayerDeathHandler;
    }

    private void PlayerDeathHandler()
    {
        StopAllCoroutines();
        if (!playerHealth) return;
        StartCoroutine(Dead());
    }
    
    private IEnumerator Dead()
    {
        playerHealth.gameObject.SetActive(false);
        yield return new WaitForSeconds(2f);
        
        playerHealth.gameObject.SetActive(true);
        playerHealth.transform.position = playerHealth.transform.position + Vector3.up;
        playerHealth.SetHealth(100);

    }
}
