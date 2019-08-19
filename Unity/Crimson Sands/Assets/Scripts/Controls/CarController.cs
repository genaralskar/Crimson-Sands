using System.Collections.Generic;
using TMPro;
using UnityEditorInternal;
using UnityEngine;

public class CarController : MonoBehaviour
{
    [HideInInspector]
    public float horizontalInput;
    [HideInInspector]
    public float verticalInput;
    [HideInInspector]
    public float wheelAngle;

    public ControlInputs input;

    public List<Axel> axels;

    public Rigidbody rb;
    public float startForce = 100;

    public float maxWheelAngle = 30f;
    public float forwardTorquePower = 2000f;
    public float reverseTorquePower = 1000f;
    public float breakPower = 1000f;
    public bool braking;

    public Transform carWaypoint;

    public bool AI;

    //start variables
    private Vector3 startPosition;
    private Quaternion startRotation;
    private Vector3 startVelocity;
    private Dictionary<WheelCollider, Vector3> startWheelAngularVels;
    private List<Vector3> startWheelTorque;
    private ControlInputs startBehavior;

    private void Start()
    {
        
    }

    public void FixedUpdate()
    {
        GetInput();
        Steer();
        Accelerate();
        UpdateWheelPoses();
    }

    private void GetInput()
    {
//        horizontalInput = Input.GetAxis("Horizontal");
//        verticalInput = Input.GetAxis("Vertical");
//        breaking = Input.GetButton("Brake");
        if (input != null)
        {
            CarInputs inputs = input.GetInputs(this);
            horizontalInput = inputs.horizontal;
            verticalInput = inputs.vertical;
            braking = inputs.braking;
            
//            input.GetInputs(this);
        }
    }

    private void Steer()
    {
        wheelAngle = maxWheelAngle * horizontalInput;
        foreach(var axel in axels)
        {
            if (axel.steering)
            {
                axel.SetSteering(wheelAngle);
            }
        }
    }

    private void Accelerate()
    {
        //====Breaking Stuff====
 
        //Set braking force on wheels if breaking
        foreach (var axel in axels)
        {
            if (braking && axel.breaks)
            {
                axel.SetBrakeTorque(breakPower);
//                print("Braking!");
            }
            else
            {
                axel.SetBrakeTorque(0);
            }
        }

        //====Takeoff force for faster start, arcadey====
        if (rb.velocity.magnitude < 20 && Input.GetAxis("Vertical") > 0)
        {
//            print("addng force");
            rb.AddForce(transform.forward * startForce);
        }

        //====Motor Force Stuff====
        float torquePower = 0;
        
        //Different torque amount if reversing
        if (verticalInput > 0)
        {
            torquePower = forwardTorquePower;
        }
        else if (verticalInput < 0)
        {
            torquePower = reverseTorquePower;
        }
        
        //multiply input by proper torque amount
        torquePower *= verticalInput;
        
        //set motor force for wheels
        foreach (var axel in axels)
        {
            if (axel.motor)
            {
                axel.SetMotorTorque(torquePower);
            }
        }        
    }

    private void UpdateWheelPoses()
    {
        foreach (var axel in axels)
        {
            axel.UpdateWheelPoses();
        }
    }
}

[System.Serializable]
public class Axel
{
    public WheelCollider RWheelCollider;
    public WheelCollider LWheelCollider;
    public Transform RWheelTransform;
    public Transform LWheelTransform;
    public bool motor = false;
    public bool steering = false;
    public bool breaks = true;

    public void SetSteering(float newSteerAngle)
    {
        RWheelCollider.steerAngle = newSteerAngle;
        LWheelCollider.steerAngle = newSteerAngle;
    }

    public void SetBrakeTorque(float newBrakeTorque)
    {
        RWheelCollider.brakeTorque = newBrakeTorque;
        LWheelCollider.brakeTorque = newBrakeTorque;
    }

    public void SetMotorTorque(float newMotorTorque)
    {
        RWheelCollider.motorTorque = newMotorTorque;
        LWheelCollider.motorTorque = newMotorTorque;
    }

    public void UpdateWheelPoses()
    {
        UpdateWheelPose(RWheelCollider, RWheelTransform);
        UpdateWheelPose(LWheelCollider, LWheelTransform);
    }

    private void UpdateWheelPose(WheelCollider col, Transform trans)
    {
        Vector3 pos;
        Quaternion rot;
        
        col.GetWorldPose(out pos, out rot);

        trans.position = pos;
        trans.rotation = rot;
    }
}

public struct CarInputs
{
    public float horizontal;
    public float vertical;
    public bool braking;
}
