using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(menuName = "Layer Info")]
public class LayerInfo : ScriptableObject
{
    [SerializeField]
    public int playerLayer = 9;
    [SerializeField]
    public int playerHitbox = 10;
    [SerializeField]
    public int playerHurtbox = 11;
    [SerializeField]
    public int enemyHitbox = 12;
    [SerializeField]
    public int enemyHurtbox = 13;

    public int RCCStuff = 17;

    public LayerMask enemyFireLayer;
    public LayerMask weaponRaycastLayers;
}
