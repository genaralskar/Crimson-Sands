using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Audio;
/// <summary>
/// This goes on the root object of each vehicle. This gets all the audio sources under the root and adds them to a mixer
/// </summary>
public class AddChildAudioToMixer : MonoBehaviour
{
    public AudioMixerGroup mixer;

    private void Start()
    {
        GetAudioSources();
    }
    
    
    private void GetAudioSources()
    {
        AudioSource[] sources = GetComponentsInChildren<AudioSource>();

        foreach (var source in sources)
        {
            if (source.outputAudioMixerGroup == null)
            {
                source.outputAudioMixerGroup = mixer;
            }
        }
    }
}
