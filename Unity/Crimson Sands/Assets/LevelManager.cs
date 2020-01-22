using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManager : MonoBehaviour
{
    private bool isPause = false;
    [SerializeField] private GameObject pauseCanvas;
    [SerializeField] private GameObject GameUICanvas;

    [SerializeField] private string menuName;

    // Update is called once per frame
    void Update()
    {
        if (Input.GetButtonDown("Pause"))
        {
            if (!isPause)
            {
                Time.timeScale = 0;
                pauseCanvas.SetActive(true);
                GameUICanvas.SetActive(false);
                isPause = true;
            }
            else
            {
                pauseCanvas.SetActive(false);
                GameUICanvas.SetActive(true);
                Time.timeScale = 1;
                isPause = false;
            }
        }
        
    }

    public void QuitGame()
    {
        Debug.Log("TEST");
        SceneManager.LoadScene(menuName);
    }
}
