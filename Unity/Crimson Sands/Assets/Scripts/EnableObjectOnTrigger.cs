using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This is used to spawn vehicles and other objects when something passes through a boxcollider
/// </summary>
[RequireComponent(typeof(BoxCollider))]
public class EnableObjectOnTrigger : MonoBehaviour
{

    public List<GameObject> objsToEnable;

    public bool disableOnStart = true;
    public bool resetIfAlreadyEnabled = false;
    public bool resetTransformsOnEnable = true;

    public float launchForce;

    public string tagCheck = "";
    
    private List<Vector3> objsPos = new List<Vector3>();
    private List<Quaternion> objsRot =  new List<Quaternion>();
    
    private BoxCollider col;

    private void OnValidate()
    {
        if (!col)
        {
            col = GetComponent<BoxCollider>();
        }
    }

    private void Awake()
    {
        for (int i = 0; i < objsToEnable.Count; i++)
        {
            objsPos.Add(objsToEnable[i].transform.position);
            objsRot.Add(objsToEnable[i].transform.rotation);
        }

        if (disableOnStart)
        {
            StartCoroutine(DisableTimer());
        }
    }

    private IEnumerator DisableTimer()
    {
        yield return new WaitForSeconds(1f);

        foreach (var obj in objsToEnable)
        {
            obj.SetActive(false);
        }
    }

    private void OnTriggerEnter(Collider other)
    {
        //Debug.Log(other.gameObject);

        if (tagCheck != "")
        {
            //if the tags dont match, dont do anything
            if (!other.gameObject.CompareTag(tagCheck)) return;
        }
        
        for(int i = 0; i < objsToEnable.Count; i++)
        {
            GameObject obj = objsToEnable[i];
            
            
            //if not reset always, and the object is enabled, dont do anything
            if (!resetIfAlreadyEnabled && obj.activeInHierarchy)
            {
                return;
            }
            
            //otherwise, reset the object
            
            //if gameobject is active disable it to move it
            if (obj.activeInHierarchy)
            {
                obj.SetActive(false);
            }
            
            //reset its position if needed
            if (resetTransformsOnEnable)
            {
                obj.transform.position = objsPos[i];
                obj.transform.rotation = objsRot[i];
            }
            
            //enable object
            obj.SetActive(true);
            
            //do launch forces
            if (launchForce > 0)
            {
                Rigidbody rb = obj.GetComponent<Rigidbody>();
                if (rb)
                {
                    rb.AddForce(rb.transform.forward * launchForce, ForceMode.VelocityChange);
                }
            }
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.matrix = transform.localToWorldMatrix;
        Gizmos.color = new Color(0f, 1f, 0f, .25f);
        Vector3 colliderBounds = col.size;

        Gizmos.DrawCube(Vector3.zero, colliderBounds);
    }
}
