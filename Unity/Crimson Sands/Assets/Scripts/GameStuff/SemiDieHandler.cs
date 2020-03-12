using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SemiDieHandler : MonoBehaviour
{
    public CarHealth semiHealth;
    public GameObject youDiedScreen;
    public GameStartManager gm;
    
    private void Awake()
    {
        semiHealth.OnDeath += SemiDeathHandler;
    }

    private void SemiDeathHandler()
    {
        StartCoroutine(DeathSlowdown());
        youDiedScreen.SetActive(true);
    }

    private IEnumerator DeathSlowdown()
    {
        float t = 0;
        while (t < 3)
        {
            t += Time.unscaledDeltaTime;
            float tn = t / 3;
            Mathf.Clamp01(tn);

            Time.timeScale = Mathf.Clamp01(1 - tn);
            //Time.timeScale = Mathf.Clamp01((1 - (tn * tn)));

            yield return null;
        }
        yield return new WaitForSecondsRealtime(5f);
        gm.ChangeScenes(0);
    }
}
