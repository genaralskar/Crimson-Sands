using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CinemachineToNormalCam : MonoBehaviour
{
    public GameObject cinemachineCam;
    public GameObject normalCam;

    public float lerpTime = 2f;

    private void SwapCamera()
    {
        normalCam.SetActive(true);
        cinemachineCam.SetActive(false);
        normalCam.GetComponent<Camera>().enabled = true;
    }

    public void StartSwap()
    {
        Debug.Log("Stargin swap");
        StartCoroutine(MatchGameGame());
    }
    
    private IEnumerator MatchGameGame()
    {
        float timer = 0;
        
        //lerp cinemachine cam
        while (timer < lerpTime)
        {
            timer += Time.deltaTime;
            cinemachineCam.transform.position = Vector3.Lerp(cinemachineCam.transform.position, normalCam.transform.position, timer/lerpTime);
            yield return new WaitForEndOfFrame();
        }
        Debug.Log("Stopin Swap");
        SwapCamera();
    }
}
