using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

namespace genaralskar.Tools
{
    public class ColliderTool: EditorWindow
    {
        
        private enum ColliderType{Mesh, Box, Sphere}
    
        private static string prefix;
        private static string suffix;
        private static ColliderType colliderType;
        private static bool convexMesh = true;

        public static bool isTrigger;
        
        private static PhysicMaterial physicMat;
        
        private static bool removeMeshRenders;
    
        
        
        
        [MenuItem("Tools/genaralskar/Collider Tool")]
        static void Init()
        {
            // Get existing open window or if none, make a new one:
            ColliderTool window = (ColliderTool)EditorWindow.GetWindow(typeof(ColliderTool));
            window.Show();
        }
    
        private void OnGUI()
        {
            //prefix/suffix input
            prefix = EditorGUILayout.TextField("Collider Mesh Prefix", prefix);
            suffix = EditorGUILayout.TextField("Collider Mesh Suffix", suffix);
            
            //collider type enum
            colliderType = (ColliderType) EditorGUILayout.EnumPopup("Collider Type", colliderType);
            
            //convex mesh if colliderType is mesh
            if (colliderType == ColliderType.Mesh)
            {
                convexMesh = EditorGUILayout.Toggle("Convex", convexMesh);
            }
            
            //set trigger
            isTrigger = EditorGUILayout.Toggle("Is Trigger", isTrigger);

            //physics material
            physicMat = (PhysicMaterial)EditorGUILayout.ObjectField("Physic Material", physicMat, typeof(PhysicMaterial), false);
            
            //Remove mesh renderers toggle
            removeMeshRenders = EditorGUILayout.Toggle("Remove Mesh Renderers", removeMeshRenders);
            
            
            
            if (GUILayout.Button("Put 'em on!"))
            {   
                GetColliders(Selection.gameObjects);
            }
        }
    
        //split obj names and see if they match prefix/suffix
        static void GetColliders(GameObject[] sels)
        {
            foreach (var sel in sels)
            {
    
                Transform[] children = sel.GetComponentsInChildren<Transform>();
                
                foreach (var child in children)
                {
                    string[] splits = child.name.Split('_');
    
                    //add colliders from suffix
                    if (prefix != "" && splits[0] == prefix)
                    {
                        AddCollider(child.gameObject);
                    }
                    
                    //add colliders with prefix
                    if(suffix != "" && splits[splits.Length - 1] == suffix)
                    {
                        AddCollider(child.gameObject);
                    }
                }                
            }
        }
    
        static void AddCollider(GameObject obj)
        {
            bool addedCol = false;
            switch (colliderType)
            {
                    case ColliderType.Mesh:
                        MeshFilter mf = obj.GetComponent<MeshFilter>();
                        if (mf == null)
                        {
                            Debug.LogWarning($"GameObject {obj} does not have a mesh for a collider");
                            break;
                        }
    
                        MeshCollider mCol = Undo.AddComponent<MeshCollider>(obj);
                        addedCol = true;
                        //MeshCollider col = obj.AddComponent<MeshCollider>();
                        mCol.sharedMesh = mf.sharedMesh;
                        if (convexMesh)
                        {
                            mCol.convex = true;
                        }
                        break;
                    case ColliderType.Box:
                        if (obj.GetComponent<BoxCollider>())
                        {
                            Debug.LogWarning($"GameObject {obj} already has a box collider!");
                            break;
                        }
                        Undo.AddComponent<BoxCollider>(obj);
                        addedCol = true;
                        break;
                    case ColliderType.Sphere:
                        if (obj.GetComponent<SphereCollider>())
                        {
                            Debug.LogWarning($"GameObject {obj} already has a sphere collider!");
                            break;
                        }
                        addedCol = true;
                        break;
            }

            if (addedCol)
            {
                Collider col = obj.GetComponent<Collider>();

                //physics material stuff
                if (addedCol && physicMat != null)
                {
                    col.sharedMaterial = physicMat;
                }

                //is trigger
                col.isTrigger = isTrigger;
            }

            
            //remove mesh renderers
            if (removeMeshRenders)
            {
                if (obj.GetComponent<MeshRenderer>())
                {
                    Undo.DestroyObjectImmediate(obj.GetComponent<MeshRenderer>());
                }
            }
        }
    }

}

