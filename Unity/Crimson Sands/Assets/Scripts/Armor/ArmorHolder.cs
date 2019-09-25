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

    private void Awake()
    {
        rb = GetComponent<Rigidbody>();
    }
}
