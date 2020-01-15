using UnityEngine;
using UnityEngine.Events;

/// <summary>
/// This goes on the object for the weapon that has the animation controller.
/// Sends UnityAction OnWeaponFire when FireWeapon() is called.
/// FireWeapon() should be called from an animation event in the weapon's firing animation
/// </summary>

public class WeaponFireHandler : MonoBehaviour
{
    public UnityAction OnWeaponFire;

    public UnityAction<bool> WeaponCharge;
    
    public void FireWeapon()
    {
        OnWeaponFire?.Invoke();
    }

    public void StartWeaponCharge()
    {
        WeaponCharge?.Invoke(true);
    }

    public void StopWeaponCharge()
    {
        WeaponCharge?.Invoke(false);
    }
}
