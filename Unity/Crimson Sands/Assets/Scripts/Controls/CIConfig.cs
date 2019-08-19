using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "ControlInputs/Configurable")]
public class CIConfig : ControlInputs
{

    public NameFloat horizontalInput;
    public NameFloat verticalInput;
    public NameFloat breakInput;
    
    public override CarInputs GetInputs(CarController cc)
    {
        CarInputs inputs = new CarInputs
        {
            horizontal = horizontalInput.useCont ? horizontalInput.InputConstant : Input.GetAxis(horizontalInput.InputName),
            
            vertical = verticalInput.useCont ? verticalInput.InputConstant : Input.GetAxis(verticalInput.InputName)
        };

        if (breakInput.useCont)
        {
            inputs.braking = breakInput.InputConstant >= 1;
        }
        else
        {
            inputs.braking = Input.GetButton(breakInput.InputName);
        }

        return inputs;
    }
}

[System.Serializable]
public struct NameFloat
{
    public string InputName;
    public float InputConstant;
    public bool useCont;
}
