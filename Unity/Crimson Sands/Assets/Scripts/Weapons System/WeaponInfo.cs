using System.Collections;
using System.Collections.Generic;
using UnityEngine;
/// <summary>
/// This ScriptableObject contains all info needed for weapons like the prefab, damage, sound, projectile etc
/// </summary>
[CreateAssetMenu(menuName = "Weapons/Weapon Info")]
public class WeaponInfo : ScriptableObject
{
    public GameObject weaponPrefab;
    public int weaponDamage;
    public AudioClip fireSound;
    public Projectile projectile;
}
