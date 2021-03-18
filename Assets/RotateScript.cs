using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateScript : MonoBehaviour
{
    [Range(0, 5)] public float rotateSpeed = 2  ;

    void Update()
    {
        this.transform.Rotate(0, rotateSpeed, 0);
    }
}
