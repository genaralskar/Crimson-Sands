using System.Collections;
using System.Collections.Generic;
using genaralskar;
using UnityEngine;

namespace genaralskar.Cars
{
    [RequireComponent(typeof(CarUpdater))]
    public class CarSelector : MonoBehaviour
    {

        private CarUpdater updater;
        private CarDatabase database;

        private void Awake()
        {
            updater = GetComponent<CarUpdater>();
            database = updater.carDatabase;
        }

        private void Start()
        {
            updater.ResetAllCarValues();
            updater.UpdateCar(database.CARS[0]);
        }

        // Update is called once per frame
        void Update()
        {
        
        }
    }
}

