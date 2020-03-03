using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MusicPlayer : MonoBehaviour
{
    [Tooltip("Audio source for the game music")]
    public AudioSource gmSource;
    [Tooltip("Auido source for the pause music")]
    public AudioSource pmSource;

    public List<AudioClip> songs;
    public AudioClip pauseMusic;
    private int currentSongIndex = 0;

    private float currentSongLength;
    private float songStartTime;

    private float pausedTime = 0;
    private float unpausedTime = 0;

    private float pauseBuffer = 0;

    private void Awake()
    {
        PauseMenu.GamePaused += OnPausedHandler;
        PauseMenu.GameUnpaused += OnUnpausedHandler;
        pmSource.clip = pauseMusic;
        pmSource.Play();
        pmSource.Pause();
    }

    private void Update()
    {
        if (gmSource.clip == null) return;
        
        if(gmSource.time >= gmSource.clip.length)
        //if (Time.time - pauseBuffer - songStartTime >= currentSongLength)
        {
            //song has ended
            NextSong();
        }
    }

    public void StartSongs()
    {
        NextSong(false);
    }

    private void NextSong(bool increment = true)
    {
        gmSource.Stop();
        if (increment)
        {
            //songs increment up to amount of songs in list, then loop
            currentSongIndex = (currentSongIndex + 1) % songs.Count;
        }
        gmSource.clip = songs[currentSongIndex];
        songStartTime = Time.time;
        currentSongLength = gmSource.clip.length;
        gmSource.Play();
    }

    private void OnPausedHandler()
    {
        //pause game audio
        gmSource.Pause();
        //play pause audio
        pmSource.UnPause();
        pausedTime = Time.time;
    }

    private void OnUnpausedHandler()
    {
        //pause pause audio
        pmSource.Pause();
        //play game audio
        gmSource.UnPause();
        unpausedTime = Time.time;

        float pauseDif = unpausedTime - pausedTime;
        pauseBuffer += pauseDif;
    }

    private void OnDestroy()
    {
        PauseMenu.GamePaused -= OnPausedHandler;
        PauseMenu.GameUnpaused -= OnUnpausedHandler;
    }
}
