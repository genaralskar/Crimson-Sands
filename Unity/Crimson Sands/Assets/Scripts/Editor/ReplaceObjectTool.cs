using System;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace genaralskar.Tools
{
    public class ReplaceObjectTool : EditorWindow
    {
        private static GameObject rObj;
        private static bool copyTransform = true;
        private static bool copyRotation = true;
        private static bool copyScale = true;
        
        [MenuItem("Tools/genaralskar/Object Replacer")]
        static void Init()
        {
            ReplaceObjectTool window = (ReplaceObjectTool) EditorWindow.GetWindow(typeof(ReplaceObjectTool));
            window.Show();
        }

        private void OnGUI()
        {
            //game object selection
            rObj = (GameObject)EditorGUILayout.ObjectField("Replacer Object", rObj, typeof(GameObject), false);

            //toggles
            copyTransform = EditorGUILayout.Toggle("Copy Transform", copyTransform);
            copyRotation = EditorGUILayout.Toggle("Copy Rotation", copyRotation);
            copyScale = EditorGUILayout.Toggle("Copy Scale", copyScale);

            //replace button. only enabled if the replacer object has been selected, and an object is selected
            GUI.enabled = rObj != null && Selection.gameObjects.Length > 0;
            if (GUILayout.Button("Replace"))
            {
                ReplaceObjs(rObj);
            }
        }

        private static void ReplaceObjs(GameObject rObj)
        {
            var sels = Selection.gameObjects;

            foreach (var sel in sels)
            {
                //instantiate new obj
                var obj = PrefabUtility.InstantiatePrefab(rObj);
                Undo.RegisterCreatedObjectUndo(obj, "Create Object");
                GameObject newObj = obj as GameObject;

                //if obj is parented, move it to parent
                newObj.transform.SetParent(sel.transform.parent);
                
                //set position, rotation, and scale with old object
                if(copyTransform)
                    newObj.transform.localPosition = sel.transform.localPosition;
                if(copyRotation)
                    newObj.transform.localRotation = sel.transform.localRotation;
                if(copyScale)
                    newObj.transform.localScale = sel.transform.localScale;
                
                //delete old object
                Undo.DestroyObjectImmediate(sel);
            }
        }
    }    
}

