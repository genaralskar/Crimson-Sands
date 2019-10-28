using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerInput : MonoBehaviour
{
    private RCC_CarControllerV3 cc;

    public string gasBrakeInput = "Vertical";
    //public string breakReverseInput = "Vertical";
    public string steerInput = "Horizontal";
    public string handBreakInput = "Brake";
    public string boostInput = "Boost";
    public string fireWeaponInput = "Fire1";

    private void Awake()
    {
        cc = GetComponent<RCC_CarControllerV3>();
    }

    private void Update()
    {
        float gas = Input.GetAxis(gasBrakeInput);
        //float breaks = Input.GetAxis(breakReverseInput);
        float steer = Input.GetAxis(steerInput);
        float handBreak = Input.GetAxis(handBreakInput);
        float boost = Input.GetAxis(boostInput);
        
        Debug.Log($"Gas: {gas}, Steer: {steer}, Hand Break: {handBreak}, Boost: {boost}");

        if (gas > 0)
        {
            cc.gasInput = gas;
        }
        else
        {
            cc.gasInput = 0;
        }
        
        if (gas < 0)
        {
            cc.brakeInput = -gas;
        }
        else
        {
            cc.brakeInput = 0;
        }

        cc.steerInput = steer;
        cc.handbrakeInput = handBreak;
        cc.boostInput = boost;
    }
}
