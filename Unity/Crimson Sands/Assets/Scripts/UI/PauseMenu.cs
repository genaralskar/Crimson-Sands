using UnityEngine;
using UnityEngine.Events;

public class PauseMenu : MonoBehaviour
{
    public static UnityAction GamePaused;
    public static UnityAction GameUnpaused;

    public static bool paused = false;

    public GameObject pauseMenu;
    
    private void Update()
    {
        if (Input.GetButtonDown("Cancel"))
        {
            TogglePause();
        }
    }
    
    public void TogglePause()
    {
        if (!paused)
        {
            Pause();
        }
        else
        {
            Unpause();
        }
    }

    private void Pause()
    {
        //set timescale to 0
        paused = true;
        Time.timeScale = 0;
        GamePaused?.Invoke();
        pauseMenu.SetActive(true);
    }

    private void Unpause()
    {
        //set timescale to 1
        paused = false;
        Time.timeScale = 1;
        GameUnpaused?.Invoke();
        pauseMenu.SetActive(false);
    }
}
