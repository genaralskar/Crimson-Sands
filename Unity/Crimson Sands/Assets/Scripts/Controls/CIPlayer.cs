using UnityEngine;

[CreateAssetMenu(menuName = "ControlInputs/Player")]
public class CIPlayer : ControlInputs
{
    [SerializeField] private string horizontalName = "Horizontal";
    [SerializeField] private string verticalName = "Vertical";
    [SerializeField] private string brakeName = "Brake";
    public override CarInputs GetInputs(CarController cc)
    {
//        cc.horizontalInput = Input.GetAxis("Horizontal");
//        cc.verticalInput = Input.GetAxis("Vertical");
//        cc.breaking = Input.GetButton("Brake");

        return new CarInputs
        {
            horizontal = Input.GetAxis(horizontalName),
            vertical = Input.GetAxis(verticalName),
            braking = Input.GetButton(brakeName)
        };
    }
}
