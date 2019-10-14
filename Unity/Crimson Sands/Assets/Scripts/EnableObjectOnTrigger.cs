using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
public class EnableObjectOnTrigger : MonoBehaviour
{

    public List<GameObject> objsToEnable;

    public bool resetIfAlreadyEnabled = false;
    public bool resetTransformsOnEnable = true;

    public float launchForce;

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
    }

    private void OnTriggerEnter(Collider other)
    {
        Debug.Log(other.gameObject);
        
        for(int i = 0; i < objsToEnable.Count; i++)
        {
            GameObject obj = objsToEnable[i];
            if (!resetIfAlreadyEnabled)
            {
                if (!obj.gameObject.activeInHierarchy)
                {
                    obj.gameObject.SetActive(true);
                    if (resetTransformsOnEnable)
                    {
                        obj.transform.position = objsPos[i];
                        obj.transform.rotation = objsRot[i];

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
            }
            else
            {
                obj.gameObject.SetActive(true);
                if (resetTransformsOnEnable)
                {
                    obj.transform.position = objsPos[i];
                    obj.transform.rotation = objsRot[i];
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
