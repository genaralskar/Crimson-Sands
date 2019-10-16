using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarHealth : Health
{
    public bool isPlayer = false;
    public GameObjectPool deathExplosion;
    public bool resetHealthOnEnable = true;

    private void OnEnable()
    {
        if (resetHealthOnEnable)
        {
            SetHealth(maxHealth);
        }
    }

    protected override void Death()
    {
        //blow up car

        if (isPlayer)
        {
            //end game/respawn
        }
        else
        {
            if (deathExplosion)
            {
                GameObject explosion = deathExplosion.GetPooledObject(transform.position, Quaternion.identity);
                explosion.gameObject.SetActive(true);
            }

            gameObject.SetActive(false);
        }
    }
}
