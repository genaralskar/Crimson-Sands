using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(WheelCollider))]
public class SpawnWheelParticles : MonoBehaviour
{
    public ParticleSystem part;
    
    private WheelCollider wc;

    private float startEmish;
    // Start is called before the first frame update
    void Start()
    {
        wc = GetComponent<WheelCollider>();
        startEmish = part.emission.rateOverDistance.constant;
    }

    // Update is called once per frame
    void Update()
    {
//        print(wc.isGrounded);
        if (wc.isGrounded)
        {
            //part.Play();
            var emission = part.emission;
            emission.rateOverDistance = startEmish;
        }
        else
        {
            //part.Stop();
            var emission = part.emission;
            emission.rateOverDistance = 0;
        }
    }
}
