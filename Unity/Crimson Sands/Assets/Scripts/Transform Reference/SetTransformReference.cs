using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetTransformReference : MonoBehaviour
{
    public TransformReference reference;

    private void Awake()
    {
        if (!reference) return;
        reference.transform = transform;
        //Debug.Log($"Transform set to {transform}. Transform reference is {reference}");
    }
}
