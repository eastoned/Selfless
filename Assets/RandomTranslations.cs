using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RandomTranslations : MonoBehaviour
{
    public float depth;
    // Start is called before the first frame update
    void Start()
    {
        // speed = Random.Range(0, speed);
        // distance = Random.Range(0, distance);
        depth = -248;
    }

    // Update is called once per frame
    void Update()
    {
        transform.position += new Vector3(0, Mathf.Sin(Time.time + transform.position.x)/300f, 0);
        //transform.position = Vector3.MoveTowards(transform.position, new Vector3(transform.position.x, transform.position.y, depth), Time.deltaTime/5f);
    }
}
