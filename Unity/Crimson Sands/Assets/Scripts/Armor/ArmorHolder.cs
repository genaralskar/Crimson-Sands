using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on the same GameObject as the vehicle's rigidbody, and will contains info on what armor set the vehcile
/// currently has
/// </summary>
public class ArmorHolder : MonoBehaviour
{
    private Rigidbody rb;

    public GameObject armorPrefab;

    public Transform snapPoint;
    
    public ArmorSet currentArmor;

    public bool isPlayer = false;

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
        if (!currentArmor)
        {
            GameObject armor = Instantiate(armorPrefab);
            currentArmor = armor.GetComponent<ArmorSet>();
            currentArmor.snapPoint = snapPoint;
            currentArmor.vehicle = this;
        }
    }

    private void OnEnable()
    {
        if (currentArmor)
        {
            currentArmor.gameObject.SetActive(true);
            AttachAllArmor();
        }
    }

    private void OnDisable()
    {
        if(currentArmor)
        {
            currentArmor.DetachAllArmor();
            //currentArmor.gameObject.SetActive(false);
        }
    }

    //should only get called from another ArmorSet
    //need to change order of events for this process
    public void SwapArmor(ArmorSet newArmor)
    {
        currentArmor = newArmor;
    }

    public void DetachAllArmor()
    {
        currentArmor.DetachAllArmor();
    }

    public void AttachAllArmor()
    {
        currentArmor.AttachAllArmor();
    }
}
