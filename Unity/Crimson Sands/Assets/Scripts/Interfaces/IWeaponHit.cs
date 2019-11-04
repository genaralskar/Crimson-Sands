using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public interface IWeaponHit
{
    void OnWeaponHit(Weapon weapon, Vector3 hitPoint);
}
