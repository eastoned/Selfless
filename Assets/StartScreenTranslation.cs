using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class StartScreenTranslation : MonoBehaviour
{
    public Vector3 targetPos;
    public float targetOrthSize, speed;

    public bool shrink, swap;

    public Camera cam;
    public MouseLook ml, ml2;
    // Start is called before the first frame update
    void Start()
    {
        cam = GetComponent<Camera>();
    }

    // Update is called once per frame
    void Update()
    {
        if (shrink)
        {
            transform.parent.position = Vector3.Lerp(transform.parent.position, targetPos, speed * Time.deltaTime);
            cam.orthographicSize = Mathf.Lerp(cam.orthographicSize, targetOrthSize, speed * Time.deltaTime);
        }

        if (swap)
        {
            transform.parent.position = new Vector3(0, 0.4f, 0);
            transform.localEulerAngles = new Vector3(91f, 0, 0);
            cam.orthographic = false;
            cam.fieldOfView = 60f;
            ml.enabled = true;
            ml2.enabled = true;
        }

    }
}
