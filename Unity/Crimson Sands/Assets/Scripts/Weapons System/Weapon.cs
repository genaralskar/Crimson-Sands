using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Weapon : MonoBehaviour
{
    public int damage = 10;
    public Transform firePoint;
    public Animator anims;

    private bool isFiring;

    public bool IsFiring
    {
        get { return isFiring; }
        set
        {
            isFiring = value;
            SetAnimsFiring(value);
        }
    }

    private void SetAnimsFiring(bool value)
    {
        anims.SetBool("IsFiring", value);
    }

    private void Update()
    {
        if (Input.GetMouseButtonDown(0) && !IsFiring)
        {
            IsFiring = true;
        }

        if (Input.GetMouseButtonUp(0) && IsFiring)
        {
            IsFiring = false;
        }
    }

    public void FireParticle()
    {
        
    }
}
