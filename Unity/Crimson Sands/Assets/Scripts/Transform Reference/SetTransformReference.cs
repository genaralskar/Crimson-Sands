using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SetTransformReference : MonoBehaviour
{
    public TransformReference reference;

    private void Awake()
    {
        reference.transform = transform;
    }
}
