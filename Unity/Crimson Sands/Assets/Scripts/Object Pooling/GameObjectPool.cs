using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

/// <summary>
/// Used to create pools of GameObjects, and to get a GameObject from the pool, like for projectile prefabs
/// </summary>

[CreateAssetMenu(menuName = "Pools/GameObject Pool")]
public class GameObjectPool : ScriptableObject
{
    public static UnityAction PoolObjects;
    
    [Tooltip("Object to add to pool")]
    public GameObject poolObject;
    
    [Tooltip("How many of that object to pool")]
    public int amount = 100;

    private Queue<GameObject> pooledObjects;

    private void OnEnable()
    {
        PoolObjects += PoolObjectsHandler;
    }

    private void OnDisable()
    {
        PoolObjects -= PoolObjectsHandler;
    }

    private void PoolObjectsHandler()
    {
        pooledObjects = new Queue<GameObject>();
        for (var i = 0; i < amount; i++)
        {
            GameObject obj = Instantiate(poolObject);
            obj.SetActive(false);
            pooledObjects.Enqueue(obj);
        }
    }

    public GameObject GetPooledObject()
    {
        //get reference to the first item in the queue
        GameObject obj = pooledObjects.Dequeue();
        
        //place it at the end of the queue
        pooledObjects.Enqueue(obj);

        return obj;
    }
}
