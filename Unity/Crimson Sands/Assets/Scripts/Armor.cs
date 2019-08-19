using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace genaralskar.Cars
{
    /// <summary>
    /// Contains information on armors for cars, such as it's prefab, name, and flavor text
    /// </summary>
    [CreateAssetMenu(menuName = "Car/New Armor")]
    public class Armor : ScriptableObject
    {
        public GameObject armorPrefab;
        public string armorName;
        public string armorFlavor;
    }
}