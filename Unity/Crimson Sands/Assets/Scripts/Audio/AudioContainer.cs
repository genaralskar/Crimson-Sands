using System.Collections.Generic;
using UnityEngine;

/// <summary>
/// This is used to hold all audio clips pertaining to a certain sound. These get plugged into an AudioManager
/// </summary>
[CreateAssetMenu(menuName = "Audio/Audio Container")]
public class AudioContainer : ScriptableObject
{
    [SerializeField]
    [Tooltip("The AudioClips that will be chosen randomly to play")]
    private List<AudioClip> clips;

    [SerializeField]
    [Range(0, 1)]
    private float volume = 1;
    
    [SerializeField]
    [Range(-3, 3)]
    private float pitch = 1;
    
    [SerializeField][UnityEngine.Range(0,1)]
    [Tooltip("The amount of variation in the pitch of the AudioClip when it gets played")]
    private float pitchVariation;

    //This stuff is gonna be for making a random order of clips to be played in, so the same sound doesn't get played
    //back to back over and over again
    private List<AudioClip> soundQueue = new List<AudioClip>();
    private List<AudioClip> firedAudio = new List<AudioClip>();
    
    public void PlayAudioClip(AudioSource source)
    {
        if (clips.Count == 0) return;
        
        source.clip = RandomClip();
        source.pitch = RandomPitch();
        source.volume = volume;
        source.Play();
    }

    private AudioClip RandomClip()
    {
        int rand = Random.Range(0, clips.Count);
        return clips[rand];
    }

    private float RandomPitch()
    {
        return pitch + Random.Range(-pitchVariation, pitchVariation);
    }
    
    
}
