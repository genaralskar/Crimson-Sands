
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class ArmorSetupEditor : ScriptableObject
{
    [MenuItem("Tools/Setup Armor")]
    static void ArmorSetup()
    {
        GameObject s = Selection.gameObjects[0];

        if (s.transform != s.transform.root)
        {
            //Debug.LogError("Please select a root object");
            return;
        }

        MeshRenderer[] childrenA = s.transform.GetComponentsInChildren<MeshRenderer>();
        List<MeshRenderer> children = new List<MeshRenderer>();
        children.AddRange(childrenA);

        List<GameObject> armorBases = new List<GameObject>();
        
        //Debug.Log($"Children Count = {children.Count}");
        
        //get rid of mesh renderes with children
        for (int i = children.Count - 1; i >= 0; i--)
        {
            //Debug.Log($"array ref = {i}");
            var child = children[i];
            if (child.transform.childCount > 0)
            {
                armorBases.Add(child.gameObject);
                children.Remove(child);
            }
        }
        
        
        
        
        //add armor set component to base object if not already one
        if(!s.GetComponent<ArmorSet>())
            s.AddComponent<ArmorSet>();

        ArmorHealth healthRef = new ArmorHealth();
        
        //add armor health and rigidbody to each armor base
        foreach (var armorBase in armorBases)
        {
            //add rigidbody if not already one
            if(!armorBase.GetComponent<Rigidbody>())
                armorBase.AddComponent<Rigidbody>();

            //add armor health if not already one
            if(!armorBase.GetComponent<ArmorHealth>())
                healthRef = armorBase.AddComponent<ArmorHealth>();

            //add fixed joint if not already one
            if(!armorBase.GetComponent<FixedJoint>())
                armorBase.AddComponent<FixedJoint>();

            //add projectile impact audio

            
            //set layer to RCCStuff
            
        }
        
        
        
        //remove children with no parent ArmorHealth
        for (int i = children.Count - 1; i >= 0; i--)
        {
            //Debug.Log($"array ref = {i}");
            var child = children[i];
            if (!child.transform.GetComponentInParent<ArmorHealth>())
            {
                children.Remove(child);
            }
        }
        
        
        
        //add mesh collider and hurtbox to each collider mesh
        foreach (var child in children)
        {
            Hurtbox hb = child.gameObject.GetComponent<Hurtbox>();
            //add hurtbox if not already one
            if(!hb)
                hb = child.gameObject.AddComponent<Hurtbox>();

            //assign hurtbox health to armor health
            //hb.health = healthRef;
            if(hb)
                hb.health = child.transform.GetComponentInParent<ArmorHealth>();

            //add mesh collider if not already one
            if(!child.gameObject.GetComponent<MeshCollider>())
            {
                MeshCollider mc = child.gameObject.AddComponent<MeshCollider>();

                //set mesh collider to convex
                mc.convex = true;
            }

            //set layer to RCCStuff
        }

    }
}
