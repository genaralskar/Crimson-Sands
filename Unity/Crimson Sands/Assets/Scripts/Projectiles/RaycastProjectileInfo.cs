using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "Weapons/Raycast Projectile Info")]
public class RaycastProjectileInfo : ScriptableObject
{
    public int damage = 10;
    public GameObjectPool hitSparks;
}
