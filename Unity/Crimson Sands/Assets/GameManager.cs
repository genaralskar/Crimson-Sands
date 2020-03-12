using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public class GameManager : MonoBehaviour
{
    public GameObject hide;
    public GameObject show;
    
    public Slider loadingBar;
    
    [SerializeField] private int levelIndex;
    public void StartGame()
    {
        StartCoroutine(LoadBar(levelIndex));
    }

    private IEnumerator LoadBar(int levelIndex)
    {
        show.SetActive(true);
        hide.SetActive(false);
        AsyncOperation operation = SceneManager.LoadSceneAsync(levelIndex);
        
        while (!operation.isDone)
        {
            float progress = Mathf.Clamp01(operation.progress / .9f);
            loadingBar.value = progress;
            //Debug.Log(progress);
            yield return null;
        }
    }

    public void Quit()
    {
        Application.Quit();
    }
}
