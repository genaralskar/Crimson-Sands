using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This gets placed on the same object as an AudioSource, or else it automatically creates one.
/// <para>Used with AudioContainer to play a random audio clip at a random pitch to provide some variation</para>
/// </summary>

[RequireComponent(typeof(AudioSource))]
public class AudioManager : MonoBehaviour
{
    private AudioSource source;
    [Tooltip("The AudioContainer to determine which sounds will play from the attached AudioSource")]
    public AudioContainer container;

    public bool playOnAwake = false;

    private void Awake()
    {
        source = GetComponent<AudioSource>();

        playOnAwake = source.playOnAwake;
        source.playOnAwake = false;
        //Debug.Log("awake!");
    }

    private void OnEnable()
    {
        if (playOnAwake)
        {
            Play();
        }
    }

    public void Play()
    {
        if (container)
        {
            container.PlayAudioClip(source);
        }
        else if (source)
        {
            source.Play();
        }
    }
}
