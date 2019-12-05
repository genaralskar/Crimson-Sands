using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace genaralskar
{
    
    public class PrefabPlacementEditor : EditorWindow
    {
        static PrefabPlacementSO pps;
        public PrefabPlacementSO prePlace;
        
        // Add menu named "My Window" to the Window menu
        [MenuItem("Window/Prefab Placer")]
        static void Init()
        {
            // Get existing open window or if none, make a new one:
            PrefabPlacementEditor window = (PrefabPlacementEditor)EditorWindow.GetWindow(typeof(PrefabPlacementEditor));

            string[] PPsettings = AssetDatabase.FindAssets("t:PrefabPlacementSO");
            string assetPath = AssetDatabase.GUIDToAssetPath(PPsettings[0]);
            pps = (PrefabPlacementSO)AssetDatabase.LoadAssetAtPath(assetPath, typeof(PrefabPlacementSO));
            
            window.Show();
        }
        
        void OnGUI()
        {

            prePlace = EditorGUILayout.ObjectField("Prefab Placer Settings", prePlace, typeof(PrefabPlacementSO), false) as PrefabPlacementSO;
            
            EditorGUILayout.BeginToggleGroup("Select an object to place prefabs", Selection.gameObjects.Length > 0);
            if (GUILayout.Button("Place Prefabs"))
            {
                //get children of selected object
                Transform[] children = Selection.gameObjects[0].GetComponentsInChildren<Transform>();
                
                //for each prefab group
                foreach (var group in prePlace.groups)
                {
                    //create new gameobject for parenting
                    GameObject parent = new GameObject($"{group.groupName} Parent");
                    
                    //for each child object
                    foreach (var child in children)
                    {
                        //split string on _ to get first part to check against group name
                        string[] nameSplit = child.name.Split('_');
                        
                        
                        //if name of object starts with group string
                        if (nameSplit[0] == group.groupName)
                        {
                            //get centriod of mesh of object
                            Vector3 center = child.gameObject.GetComponent<Renderer>().bounds.center;
                            
                            //get random prefab from group
                            GameObject prefab = Instantiate(group.GetPrefab(), parent.transform);

                            //move prefab to the spot!
                            prefab.transform.position = center;

                        }
                    }
                }
            }
            //do this stuff to get seeds working
            //get all objects of a group, add them to a list. change prefab placement to take a number of G.O.s to get
            //run over that new list going through the gotten G.O.s to instantiate
            
            
            EditorGUILayout.EndToggleGroup();

            
        }
        
        [CustomEditor(typeof(PrefabPlacementEditor), true)]
        public class ListTestEditorDrawer : Editor {
 
            public override void OnInspectorGUI() {
                var list = serializedObject.FindProperty("ListTest");
                EditorGUILayout.PropertyField(list, new GUIContent("My List Test"), true);
            }
        }
    }
    
}

