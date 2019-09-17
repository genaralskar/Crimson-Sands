using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CarHealth : Health
{
    public bool isPlayer = false;
    
    protected override void Death()
    {
        //blow up car

        if (isPlayer)
        {
            //end game/respawn
        }
    }
}
