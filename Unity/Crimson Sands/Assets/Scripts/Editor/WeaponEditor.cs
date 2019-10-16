using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

[CustomEditor(typeof(Weapon))]
[CanEditMultipleObjects]
public class WeaponEditor : Editor
{
    private SerializedProperty damage;
    private SerializedProperty firePoint;
    private SerializedProperty useRaycast;
    private SerializedProperty raycastProjectileLayerMask;
    private SerializedProperty raycastProjectileInfo;
    private SerializedProperty projectile;
    private SerializedProperty isPlayer;
    private SerializedProperty layerInfo;
    private SerializedProperty fireSoundSource;
    private SerializedProperty muzzleFlash;
    

    private void OnEnable()
    {
        damage = serializedObject.FindProperty("damage");
        firePoint = serializedObject.FindProperty("firePoint");
        useRaycast = serializedObject.FindProperty("useRaycast");
        raycastProjectileLayerMask = serializedObject.FindProperty("raycastProjectileLayerMask");
        raycastProjectileInfo = serializedObject.FindProperty("raycastProjectileInfo");
        projectile = serializedObject.FindProperty("projectile");
        isPlayer = serializedObject.FindProperty("isPlayer");
        layerInfo = serializedObject.FindProperty("layerInfo");
        fireSoundSource = serializedObject.FindProperty("fireSoundSource");
        muzzleFlash = serializedObject.FindProperty("muzzleFlash");
        
    }

    public override void OnInspectorGUI()
    {
        serializedObject.Update();
        
        EditorGUILayout.PropertyField(damage);
        EditorGUILayout.PropertyField(firePoint);
        EditorGUILayout.PropertyField(useRaycast);
        if (useRaycast.boolValue)
        {
            EditorGUILayout.PropertyField(raycastProjectileInfo);
            EditorGUILayout.PropertyField(raycastProjectileLayerMask);
        }
        else
        {
            EditorGUILayout.PropertyField(projectile);
        }
        
        EditorGUILayout.PropertyField(isPlayer);
        EditorGUILayout.PropertyField(layerInfo);
        EditorGUILayout.PropertyField(fireSoundSource);
        EditorGUILayout.PropertyField(muzzleFlash);
        
        EditorGUILayout.Space();
        DrawUILine(Color.black);
        
        serializedObject.ApplyModifiedProperties();
        
        EditorGUILayout.LabelField("Not custom editor stuff");
        base.OnInspectorGUI();
        
        
    }
    
    public static void DrawUILine(Color color, int thickness = 2, int padding = 10)
    {
        Rect r = EditorGUILayout.GetControlRect(GUILayout.Height(padding+thickness));
        r.height = thickness;
        r.y+=padding/2;
        r.x-=2;
        r.width +=6;
        EditorGUI.DrawRect(r, color);
    }
}
