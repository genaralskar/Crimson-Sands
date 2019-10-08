using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarHealth : Health
{
    public bool isPlayer = false;
    public ParticleSystem deathExplosion;
    
    protected override void Death()
    {
        //blow up car

        if (isPlayer)
        {
            //end game/respawn
        }
        else
        {
            deathExplosion.transform.position = transform.position;
            deathExplosion.gameObject.SetActive(true);
            deathExplosion.Play();
            gameObject.SetActive(false);
        }
    }
}
