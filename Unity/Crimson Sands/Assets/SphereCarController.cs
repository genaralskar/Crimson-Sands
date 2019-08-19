using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(Rigidbody))]
public class SphereCarController : MonoBehaviour
{
    public Transform carModel;
    public Transform cameraRig;

    public float speed = 500;
    public float stickToGroundDistance = .5f;

    private Camera cam;
    private Rigidbody rb;
    
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody>();
        cam = Camera.main;
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 inputVector = Vector3.zero;
        inputVector.x = Input.GetAxis("Horizontal");
        inputVector.z = Input.GetAxis("Vertical");
        
        rb.AddForce(inputVector * speed);
        StickToGround();

        SetModelDirection();

        cameraRig.transform.position = transform.position;
    }

    private void SetModelDirection()
    {
        Vector3 direction = rb.velocity.normalized;
        //direction = AlignModelToNormal();
        print(direction);
        carModel.rotation = Quaternion.LookRotation(direction);
        carModel.position = transform.position;
    }

    private Vector3 AlignModelToNormal()
    {
        
        //raycastdown
        Ray ray = new Ray(transform.position, Vector3.down);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit))
        {
            return hit.normal;
        }
        else
        {
            return Vector3.zero;
        }

        //get normal of ground
    }

    private void StickToGround()
    {
        //raycastdown
        Ray ray = new Ray(transform.position, Vector3.down);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, stickToGroundDistance))
        {
            Vector3 newPos = transform.position;
            newPos.y = hit.point.y + .5f;
            transform.position = newPos;
        }
        
    }
}
