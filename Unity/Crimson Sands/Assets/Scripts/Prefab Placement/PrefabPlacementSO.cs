using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "Prefab Placement Settings")]
[System.Serializable]
public class PrefabPlacementSO : ScriptableObject
{
    public List<PrefabGroup> groups;
}

[System.Serializable]
public class PrefabGroup
{
    public string groupName;
    public List<GameObject> prefabs;

    public GameObject GetPrefab()
    {
        int randomPref = Random.Range(0, prefabs.Count);
        return prefabs[randomPref];
    }

    public GameObject[] GetPrefabs(int amount = 1, int seed = -1)
    {
        GameObject[] objs = new GameObject[amount];
        if (seed != -1)
        {
            Random.InitState(seed);
        }

        for (int i = 0; i < amount; i++)
        {
            objs[i] = GetPrefab();
        }

        return objs;
    }
}
