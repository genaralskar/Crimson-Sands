using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on a single line renderer in the scene to serve as a template for others that get created
/// </summary>
[RequireComponent(typeof(LineRenderer))]
public class LineRendererTemplateObject : MonoBehaviour
{
    [HideInInspector]
    public static LineRenderer rend;

    private void Awake()
    {
        rend = GetComponent<LineRenderer>();
    }
}
