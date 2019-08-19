using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace genaralskar.Cars
{
    /// <summary>
    /// Contains all Car scriptable objects for scripts to reference
    /// </summary>
    [CreateAssetMenu(menuName = "Car/New Database")]
    public class CarDatabase : ScriptableObject
    {
        //getter for CARS so that the database can only be changed in the inspector
        public Car[] CARS => cars;

        [SerializeField] private Car[] cars;
    }
}

