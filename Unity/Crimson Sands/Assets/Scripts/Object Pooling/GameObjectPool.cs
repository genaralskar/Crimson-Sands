using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

/// <summary>
/// Used to create pools of GameObjects, and to get a GameObject from the pool, like for projectile prefabs
/// </summary>

[CreateAssetMenu(menuName = "Pools/GameObject Pool")]
public class GameObjectPool : ScriptableObject
{
    
    [Tooltip("Object to add to pool")]
    public GameObject poolObject;
    
    [Tooltip("How many of that object to pool")]
    public int amount = 100;

    private Queue<GameObject> pooledObjects;

    private void PoolObjectsHandler()
    {
        SpawnPooledObject();
    }

    public void SpawnPooledObject()
    {
        //check if pooled objects already exist
        if (pooledObjects == null || pooledObjects.Count == 0)
        {
            //create new queue to hold objects
            pooledObjects = new Queue<GameObject>();
        }
        
        if (pooledObjects.Count >= amount)
            return;
        
        for (var i = pooledObjects.Count; i < amount; i++)
        {
            //spawn new objects, set them inactive, and add them to the queue
            GameObject obj = Instantiate(poolObject);
            obj.SetActive(false);
            pooledObjects.Enqueue(obj);
        }
    }

    public GameObject GetPooledObject()
    {
        //if the pool hasnt been made yet, make it
        if (pooledObjects == null || pooledObjects.Count < amount)
        {
            SpawnPooledObject();
            Debug.LogWarning(name + " spawned mid-game. Consider adding it to the object spawner to spawn these at runtime.");
        }
        
        //get reference to the first item in the queue
        GameObject obj = pooledObjects.Dequeue();
        
        //place it at the end of the queue
        pooledObjects.Enqueue(obj);

        obj.SetActive(true);
        
        return obj;
    }

    public GameObject GetPooledObject(Vector3 newPos, Quaternion newRot)
    {
        GameObject proj = GetPooledObject();
        proj.transform.position = newPos;
        proj.transform.rotation = newRot;
        return proj;
    }

    public GameObject GetPooledObject(Transform newParent)
    {
        GameObject proj = GetPooledObject();
        proj.transform.SetParent(newParent);
        return proj;
    }
}
