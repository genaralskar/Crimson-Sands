using UnityEngine;
using UnityEngine.Events;
/// <summary>
/// This script can be used to send an event to change all players current weapons to a new weapon
/// This can be placed anywhere as it sends out a static event
/// </summary>
public class SendSwapWeaponEvent : MonoBehaviour
{
    public static UnityAction<WeaponInfo> SwapPlayerWeapon;

    public void SwapPlayerWeaponEvent(WeaponInfo newWeapon)
    {
        SwapPlayerWeapon?.Invoke(newWeapon);
    }
}
