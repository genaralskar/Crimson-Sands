using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This is placed once in the scene and is used to tell all the pooled objects to spawn their objects during Awake
/// </summary>
public class PoolObjects : MonoBehaviour
{
    [SerializeField]
    private List<GameObjectPool> gameObjectPools;
    
    void Awake()
    {
        foreach (var pool in gameObjectPools)
        {
            pool.SpawnPooledObject();
        }
    }

}
