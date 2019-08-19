using System.Collections;
using System.Collections.Generic;
using System.Numerics;
using UnityEngine;
using Vector3 = UnityEngine.Vector3;

[CreateAssetMenu(menuName = "ControlInputs/AI To Point")]
public class CIAIToPoint : ControlInputs
{
    public float speed = 50;
    public bool brake = false;
    
    public override CarInputs GetInputs(CarController cc)
    {
        
        
        //get direction
        Vector3 direction = cc.transform.InverseTransformPoint(cc.carWaypoint.position);

        //do something to find proper steer angle
        float input = Mathf.Clamp(direction.x, -1, 1);

        float speedInput = 0;
        if(!brake)
            speedInput = cc.GetComponent<Rigidbody>().velocity.magnitude > speed ? 0 : 1;

        return  new CarInputs
        {
            horizontal = input,
            vertical = speedInput,
            braking = brake
        };


//        cc.horizontalInput = input;
//        cc.verticalInput = 1;

    }
}
