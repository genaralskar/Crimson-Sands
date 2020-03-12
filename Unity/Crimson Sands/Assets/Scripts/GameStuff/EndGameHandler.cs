using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Playables;

public class EndGameHandler : MonoBehaviour
{
    public PlayableDirector endgamePlayable;
    
    public PlayerInput playerInput;

    public string tagCheck = "Semi";
    
    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag(tagCheck))
        {
            //stop player inputs
            playerInput.stopInputs = true;
        
            endgamePlayable.Play();
        }
        
        
        
        //move camera out
        
        
        //play end game music
        
        
        //fade to black
        
        
        //end screen "Crimson Sands... Will Return"
        
        
    }
}
