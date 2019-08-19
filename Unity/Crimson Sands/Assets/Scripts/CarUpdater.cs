using System.Collections;
using UnityEngine;
using TMPro;
using UnityEngine.Events;

namespace genaralskar.Cars
{
    /// <summary>
    /// CarSelector is used to update the currently selected car and it's armor. Used when selecting a car in game.
    /// </summary>
    public class CarUpdater : MonoBehaviour
    {
        [Tooltip("CarDatabase containing all cars wanted to spawn")]
        public CarDatabase carDatabase;
        
//        [Tooltip("Array of all cars you want to be selectable")]
//        public Car[] cars;

        [Tooltip("Transform for the car to spawn at\nLeave blank to spawn at origin")]
        public Transform spawnPosition;

        [Tooltip("Object to parent car to\nLeave blank for not parent")]
        public Transform parentObject;

        [Tooltip("The Car SO used to save information about player car selection between scenes")]
        public Car playerCar;

        public UnityAction<GameObject> UpdateCarAction;
        public UnityAction<GameObject> UpdateArmorAction;
        
        private int currentCarIndex = 0;
        private int currentArmorIndex;

        private Car currentCar;
        private Armor currentArmor;

        [Header("Car Selection UI")]
        public TextMeshProUGUI carNameText;
        public TextMeshProUGUI carNameFlavorText;

        [Header("Armor Selection UI")]
        public TextMeshProUGUI armorNameText;
        public TextMeshProUGUI armorNameFlavorText;


        private GameObject currentCarObj;
        private GameObject currentArmorObj;

//        private void Start()
//        {
//            //move this call to another script
//            UpdateCar(cars[0]);
//        }

        //probably move these to the car selector script
        #region Car Selection Functions
        //----====Car Selection Functions====----\\

        public void NextCar()
        {
            //++current car index
            currentCarIndex = (currentCarIndex + 1) % (carDatabase.CARS.Length);
            //Debug.Log(currentCarIndex);

            //update car
            UpdateCar(carDatabase.CARS[currentCarIndex]);
        }

        public void PreviousCar()
        {
            //--current car index
            currentCarIndex = (Mathf.Abs(currentCarIndex - 1)) % (carDatabase.CARS.Length);

            //update car
            UpdateCar(carDatabase.CARS[currentCarIndex]);
        }

        public void NextArmor()
        {
            //++current armor index
            currentArmorIndex = (currentArmorIndex + 1) % (currentCar.armors.Length);
            
            //set current armor on car
            currentCar.currentArmor = currentArmorIndex;

            //update armor
            UpdateArmor(currentCar.armors[currentArmorIndex]);
        }

        public void PreviousArmor()
        {
            //--current armor index
            currentArmorIndex = (Mathf.Abs(currentArmorIndex - 1)) % (currentCar.armors.Length);
            
            //set current armor on car
            currentCar.currentArmor = currentArmorIndex;
            
            //update armor
            UpdateArmor(currentCar.armors[currentArmorIndex]);
        }
        #endregion



        #region Update Car Functions
        //----====Update Car Functions====----\\

        public void UpdateCar(Car newCar)
        {
            //destroy current car
            if(currentCarObj != null)
            {
                Destroy(currentCarObj);
            }

            //destory current armor
            //Destroy(currentArmorObj);

            //set current car
            currentCar = newCar;
            
            //spawn new car at index
            currentCarObj = Instantiate(newCar.carPrefab);
            
            //move to correct position
            if (spawnPosition != null)
            {
                currentCarObj.transform.position = spawnPosition.position;
                currentCarObj.transform.rotation = spawnPosition.rotation;
            }
            
            //parent if wanted
            if (parentObject != null)
            {
                currentCarObj.transform.SetParent(parentObject);
            }
            
            //set inputs

            //if armor index != 0, reset index
            if (currentArmorIndex != 0) currentArmorIndex = 0;
            
            //send out action call
            UpdateCarAction?.Invoke(currentCarObj);

            //update armor
            UpdateArmor(currentCar.armors[currentCar.currentArmor]);

            //update text fields
            if(carNameFlavorText != null)
                UpdateCarTextFields();
        }

        public void UpdateArmor(Armor newArmor)
        {
            //destory previous armor
            if(currentArmorObj != null)
            {
                Destroy(currentArmorObj);
            }

            //set current armor
            currentArmor = newArmor;
            
            //spawn new armor
            currentArmorObj = Instantiate(newArmor.armorPrefab);
            
            //parent armor to car
            currentArmorObj.transform.SetParent(currentCarObj.transform);
            currentArmorObj.transform.localPosition = Vector3.zero;
            currentArmorObj.transform.localRotation = Quaternion.identity;
            
            //send out action call
            UpdateArmorAction?.Invoke(currentArmorObj);

            //update text fields
            if(armorNameFlavorText != null)
                UpdateArmorTextFields();

            //update player car values
            playerCar.SetValues(currentCar);
        }

        public void ResetAllCarValues()
        {
            foreach (var car in carDatabase.CARS)
            {
                car.currentArmor = 0;
            }
        }
        #endregion


        //probably move to car selector script
        #region Update Text Functions
        private void UpdateCarTextFields()
        {
            carNameText.text = currentCar.carName;
            carNameFlavorText.text = currentCar.carFlavor;
        }

        private void UpdateArmorTextFields()
        {
            armorNameText.text = currentArmor.armorName;
            armorNameFlavorText.text = currentArmor.armorFlavor;
        }
        #endregion
    }
}