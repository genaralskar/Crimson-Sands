using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This is placed once in the scene and is used to tell all the pooled objects to spawn their objects during Awake
/// </summary>
public class PoolObjects : MonoBehaviour
{
    void Awake()
    {
        GameObjectPool.PoolObjects();
    }

}
