﻿using System.Collections;
using UnityEngine;

namespace genaralskar.Cars
{
    /// <inheritdoc />
    /// <summary>
    /// Contains information about a car, such as it's prefab, name, flavor text, and armors
    /// </summary>
    [CreateAssetMenu(menuName = "Car/New Car")]
    public class Car : ScriptableObject
    {
        public GameObject carPrefab;
        public string carName;
        public string carFlavor;
        public OldArmor[] oldArmors;
        public int currentArmor;

        public void SetValues(Car carValues)
        {
            carPrefab = carValues.carPrefab;
            carName = carValues.carName;
            carFlavor = carValues.carFlavor;
            oldArmors = carValues.oldArmors;
            currentArmor = carValues.currentArmor;
        }
    }
}
