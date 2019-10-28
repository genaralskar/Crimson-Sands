using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This goes on something that will make a sound when hit by a projectile/weapon raycast
/// </summary>
public class ProjectileImpactAudio : MonoBehaviour, IWeaponHit
{
    public AudioContainer container;
    private AudioManager manager;

    public GameObjectPool sourcePool;
    
    public bool moveSourceOnHit = true;
    private GameObject source;

    [Tooltip("Check this if this is on the vehicle somewhere 'cause the car controller likes to move the colliders around")]
    public bool moveToNewCarCollider = false;

    private void Awake()
    {
        if (moveToNewCarCollider)
            StartCoroutine(MoveThis());
    }

    public void OnWeaponHit(Weapon weapon, Vector3 hitPoint)
    {
        source = sourcePool.GetPooledObject();
        manager = source.GetComponent<AudioManager>();
        manager.container = container;

        if (moveSourceOnHit)
        {
            source.transform.position = hitPoint;
        }
        else
        {
            source.transform.position = transform.position;
        }
        
        manager.Play();
    }
    
    private IEnumerator MoveThis()
    {
        //wait for end of frame so the car controller script can be done moving stuff
        yield return new WaitForEndOfFrame();
        yield return new WaitForEndOfFrame();
        yield return new WaitForEndOfFrame();
        string searchTerm = $"Colliders/{gameObject.name}(Clone)";
        //Debug.Log(searchTerm);
        //Debug.Log(transform.root);
        GameObject newCol = transform.root.Find(searchTerm).gameObject;

        ProjectileImpactAudio newPIA = newCol.AddComponent<ProjectileImpactAudio>();
        newPIA.container = container;
        newPIA.sourcePool = sourcePool;

        //destroy this maybe
        //Destroy(this);
    }
}
