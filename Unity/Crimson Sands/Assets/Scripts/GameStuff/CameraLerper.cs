using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class CameraLerper : MonoBehaviour
{
    public Transform objToMove;
    
    public Transform startPoint;
    public Transform midPoint;
    public Transform endPoint;


    public float time = 5f;

    public UnityAction curveDone;

    public void StartCurving()
    {
        StartCoroutine(Move());
    }
    
    private IEnumerator Move()
    {
        float timer = 0;

        while (timer < time)
        {
            timer += Time.deltaTime;
            objToMove.transform.position = PositionCurve(startPoint.position, midPoint.position, endPoint.position, timer/time);
            objToMove.transform.rotation =
                RotationCurve(startPoint.rotation, midPoint.rotation, endPoint.rotation, timer / time);

            yield return new WaitForEndOfFrame();
        }
        
        curveDone?.Invoke();

    }


    private Vector3 PositionCurve(Vector3 start, Vector3 mid, Vector3 end, float t)
    {
        //lerp between start and mid
        Vector3 Q1 = Vector3.Lerp(start, mid, t);

        //lerp between mid and end
        Vector3 Q3 = Vector3.Lerp(mid, end, t);

        //lerp between Q1 and Q3
        Vector3 curve = Vector3.Lerp(Q1, Q3, t);

        return curve;
    }
    
    private Quaternion RotationCurve(Quaternion start, Quaternion mid, Quaternion end, float t)
    {
        //lerp between start and mid
        Quaternion Q1 = Quaternion.Slerp(start, mid, t);

        //lerp between mid and end
        Quaternion Q3 = Quaternion.Slerp(mid, end, t);

        //lerp between Q1 and Q3
        Quaternion curve = Quaternion.Slerp(Q1, Q3, t);

        return curve;
    }
}
