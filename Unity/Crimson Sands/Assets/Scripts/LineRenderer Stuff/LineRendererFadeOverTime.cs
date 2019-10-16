using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[RequireComponent(typeof(LineRenderer))]
public class LineRendererFadeOverTime : MonoBehaviour
{
    public LineRenderer rend;
    public float fadeTime = 1;

    private float fadeAmount;

    public void StartFade()
    {
        StopAllCoroutines();
        StartCoroutine(Fade());
    }

    private IEnumerator Fade()
    {
        WaitForEndOfFrame wait = new WaitForEndOfFrame();
        fadeAmount = fadeTime/rend.endColor.a;
        while (rend.endColor.a > 0)
        {
            yield return wait;
            rend.endColor = DecrementColor(rend.endColor);
            rend.startColor = DecrementColor(rend.startColor);
        }
    }

    private Color DecrementColor(Color newColor)
    {
        if (newColor.a > 0)
        {
            newColor.a -= fadeAmount * Time.deltaTime;
        }
        else if (newColor.a < 0)
        {
            newColor.a = 0;
        }

        return newColor;
    }
}
