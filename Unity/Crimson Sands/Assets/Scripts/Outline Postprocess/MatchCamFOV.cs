using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MatchCamFOV : MonoBehaviour
{
    public Camera cameraToMatch;
    private Camera cam;

    private void Awake()
    {
        cam = GetComponent<Camera>();
    }

    // Update is called once per frame
    void Update()
    {
        cam.fieldOfView = cameraToMatch.fieldOfView;
    }
}
