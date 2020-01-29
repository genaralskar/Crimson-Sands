using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class EndGameHandler : MonoBehaviour
{
    public Playable endgamePlayable;
    
    public PlayerInput playerInput;
    
    private void OnTriggerEnter(Collider other)
    {
        //stop player inputs
        playerInput.stopInputs = true;
        
        
        //move camera out
        
        
        //play end game music
        
        
        //fade to black
        
        
        //end screen "Crimson Sands... Will Return"
        
        
    }
}
