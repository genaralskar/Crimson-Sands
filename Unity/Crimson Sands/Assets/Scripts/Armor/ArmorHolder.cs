using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ArmorHolder : MonoBehaviour
{

    public List<Armor> armor;

    private Rigidbody rb;
    
    // Start is called before the first frame update
    void Start()
    {
        
    }
}

public class Armor : MonoBehaviour
{
    [HideInInspector] public Rigidbody rbPoint;
    public Joint joint;

    public void DeleteJoint()
    {
        Destroy(joint);
    }
}