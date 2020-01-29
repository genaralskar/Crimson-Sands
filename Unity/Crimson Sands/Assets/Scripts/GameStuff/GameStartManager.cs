using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Playables;

public class GameStartManager : MonoBehaviour
{
    public Playable startGamePlayable;
    public PlayerInput inputs;


    public UnityAction cameraLerpDone;

    public void StartGameStuff()
    {
        Debug.Log("Start the game!");
        inputs.stopInputs = false;
    }
}
