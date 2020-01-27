using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CinemachineToNormalCam : MonoBehaviour
{
    public GameObject cinemachineCam;
    public GameObject normalCam;

    public void SwapCamera()
    {
        cinemachineCam.SetActive(false);
        normalCam.SetActive(true);
    }
}
