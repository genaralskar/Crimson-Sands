using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlaySoundOnEnable : MonoBehaviour
{
    [SerializeField]
    private AudioSource source;

    private void OnEnable()
    {
        source.Play();
    }
}
