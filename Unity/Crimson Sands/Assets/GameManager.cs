using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    [SerializeField] private int levelIndex;
    public void StartGame()
    {
        SceneManager.LoadScene(levelIndex);
    }
}
