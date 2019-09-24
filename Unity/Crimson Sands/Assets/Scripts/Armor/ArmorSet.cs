using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// Handles creating/destroying joints for armor
/// Children of this object will be considered for armor, or which armor can be manually set up
/// </summary>
public class ArmorSet : MonoBehaviour
{
    public List<ArmorHealth> armorParts;

    public bool autoCreateArmorInChildren = false;
    public bool populateArmorFromChildren = false;

    public ArmorHolder vehicle;

    private Rigidbody vehicleRb;

    private void Awake()
    {
        vehicleRb = vehicle.GetComponent<Rigidbody>();
    }

    private void Start()
    {
        if (autoCreateArmorInChildren)
        {
            
        }
        
        if(populateArmorFromChildren)
        {
            ArmorHealth[] armors = GetComponentsInChildren<ArmorHealth>();

            foreach (var armor in armors)
            {
                armorParts.Add(armor);
            }
        }
        
        SetupArmor();
    }

    public void SetupArmor()
    {
        transform.position = vehicle.transform.position;
        transform.rotation = vehicle.transform.rotation;
        
        SetupJoints();
    }

    private void SetupJoints()
    {
        foreach (var armor in armorParts)
        {
            armor.rb = vehicleRb;
            armor.joint.connectedBody = vehicleRb;
        }
    }

    public void DetatchAllJoints()
    {
        foreach (var armor in armorParts)
        {
            DetatchJoint(armor);
        }
    }

    public void DetatchJoint(ArmorHealth armor)
    {
        armor.SetHealth(0);
    }
}
