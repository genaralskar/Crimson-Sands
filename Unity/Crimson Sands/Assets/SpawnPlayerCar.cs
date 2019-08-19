using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace genaralskar.Cars
{
    [RequireComponent(typeof(CarUpdater))]
    public class SpawnPlayerCar : MonoBehaviour
    {
        public GameObject cameraRig;
        public ControlInputs playerInputs;
        
        private CarUpdater updater;
        private GameObject currentCar;
        

        private void Awake()
        {
            updater = GetComponent<CarUpdater>();
            updater.UpdateCarAction += SetCurrentCar;
        }

        // Start is called before the first frame update
        void Start()
        {
            updater.UpdateCar(updater.playerCar);
            SetUpCamera();
        }

        private void SetUpCamera()
        {
            cameraRig.transform.SetParent(currentCar.transform);
            cameraRig.transform.localPosition = Vector3.zero;
            cameraRig.transform.localRotation = Quaternion.identity;
            
            SetUpCarInputs();
        }

        private void SetUpCarInputs()
        {
            currentCar.GetComponent<CarController>().input = playerInputs;
        }

        private void SetCurrentCar(GameObject newCar)
        {
            currentCar = newCar;
        }
    }
}

