using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Playables;
using UnityEngine.SceneManagement;

public class GameStartManager : MonoBehaviour
{
    public PlayableDirector startGamePlayable;
    public bool playableOnStart = true;
    public PlayerInput inputs;
    public Camera cineCam;

    public UnityAction cameraLerpDone;

    private void Start()
    {
        if (playableOnStart)
        {
            inputs.stopInputs = true;
            startGamePlayable.Play();
        }
        else
        {
            inputs.stopInputs = false;
            cineCam.gameObject.SetActive(false);
        }
    }

    public void StartGameStuff()
    {
        //Debug.Log("Start the game!");
        inputs.stopInputs = false;
    }

    public void ChangeScenes(int scene)
    {
        Time.timeScale = 1;
        SceneManager.LoadScene(scene);
    }
}
