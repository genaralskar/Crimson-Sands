using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// Handles creating/destroying joints for armor/attatching and deatatching armor pieces
/// <para>Children of this object will be considered for armor, or which armor can be manually set up</para>
/// </summary>
public class ArmorSet : MonoBehaviour
{
    public List<ArmorHealth> armorParts;

    public bool autoCreateArmorInChildren = false;
    public bool populateArmorFromChildren = false;

    public Vector3 armorOffset;

    public ArmorHolder vehicle;
    [Tooltip("The object for the armor to reset its transformation to so it can be placed properly")]
    public Transform snapPoint;

    private Rigidbody vehicleRb;

    private bool armorSetup = false;

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
        
        if(!armorSetup)
            SetupArmor();
    }

    public void SetupArmor()
    {
        Debug.Log("Running armor setup");
        Vector3 offsetP = Vector3.zero;
        Quaternion offsetR = Quaternion.identity;
        if (snapPoint != null)
        {
            offsetP = snapPoint.localPosition;
            offsetR = snapPoint.localRotation;
        }
        transform.position = vehicle.transform.position + offsetP + armorOffset;
        transform.rotation = vehicle.transform.rotation * offsetR;

        SetupOffsets();
        
        SetupJoints();

        vehicle.currentArmor = this;

        armorSetup = true;
        Debug.Log("armor setup");
    }

    private void SetupOffsets()
    {
        foreach (var armor in armorParts)
        {
            Vector3 positionOffset = armor.transform.localPosition;

            Quaternion rotationOffset = armor.transform.localRotation;

            armor.positionOffset = positionOffset;
            armor.rotationOffset = rotationOffset;
        }
    }

    private void SetupJoints()
    {
        foreach (var armor in armorParts)
        {
            armor.vehicleRb = vehicleRb;
            armor.joint.connectedBody = vehicleRb;
        }
    }

    public void DetachAllArmor()
    {
        foreach (var armor in armorParts)
        {
            DetachArmor(armor);
        }
    }

    public void DetachArmor(ArmorHealth armor)
    {
        armor.SetHealth(0);
    }

    public void AttachAllArmor()
    {
        
        foreach (var armor in armorParts)
        {
            
            AttachArmor(armor);
        }
    }

    public void AttachArmor(ArmorHealth armor)
    {
        Debug.Log("Reatching Armor");
        if (armor.joint != null) Debug.Log("no joint?");
        if (armor.joint != null) return;
        
        //line up armor
        //set proper position based on offset
        Vector3 newPos = vehicle.transform.TransformPoint(armor.positionOffset);
        Debug.Log(armor.gameObject + " " + this);
        armor.transform.position = newPos;
        
        //set proper rotation based on offset
        Quaternion startRotation = armor.rotationOffset;/*some rotation to redact*/
        Quaternion someRotationToSetTo = vehicle.transform.rotation;/* the target rotation from which we want to redact */
        Quaternion newRotation = Quaternion.Inverse(startRotation) * someRotationToSetTo;
        armor.transform.rotation = newRotation;

        //match velocity of rigidbodies
        armor.rb.velocity = vehicleRb.velocity;
        
        //maybe gradualy change its mass from 1 to what its supposed to be to stop the car from jittering when
        //it gets reattatched


        //create joint
        Joint newJoint = armor.gameObject.AddComponent<FixedJoint>();
        armor.joint = newJoint;
        armor.joint.connectedBody = vehicleRb;
        
        
        
        //reset health
        armor.ResetHealth();
    }
}
