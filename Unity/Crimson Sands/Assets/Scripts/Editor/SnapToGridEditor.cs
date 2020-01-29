using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class SnapToGridEditor
{
    [MenuItem("Tools/Snap To Grid")]
    static void SnapToPoint()
    {
        var sels = Selection.gameObjects;

        foreach (var sel in sels)
        {
            Vector3 newPos = sel.transform.position;
            newPos = new Vector3((int)newPos.x, (int)newPos.y, (int)newPos.z);
            sel.transform.position = newPos;
        }
    }
}
