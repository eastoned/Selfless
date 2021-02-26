using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ConcentricZones : MonoBehaviour
{

    public List<float> ZoneSizes;
    public int currentZone;
    public Transform player;
    public bool changedZones;

    // Start is called before the first frame update
    void Start()
    {
        currentZone = 0;
    }

    // Update is called once per frame
    void Update()
    {
        
        if (Input.anyKey)
        {
            changedZones = false;
            //need to check its not the last zone to prevent error
            if (currentZone < ZoneSizes.Count)
            {
                //only changes zone if player distance is greater than the current zone border and increments up
                if (GetPlayerDistance(player.position) > ZoneSizes[currentZone])
                {
                    changedZones = true;
                    currentZone += 1;
                }
                    
            }

            //need to check its not the first zone to prevent error
            if (currentZone > 0)
            {
                //checks if the player has retreated back into old zone and increments down
                if (GetPlayerDistance(player.position) < ZoneSizes[currentZone - 1])
                {
                    changedZones = true;
                    currentZone -= 1;
                }
            }

        }

    }

    float GetPlayerDistance(Vector3 pos)
    {
        return Vector3.Distance(pos, transform.position);
    }

    void OnDrawGizmosSelected()
    {
        for(int i = 0; i < ZoneSizes.Count; i++)
        {
            Gizmos.color = Color.red - new Color(0, 0, 0, 0.8f);
            Gizmos.DrawSphere(transform.position, ZoneSizes[i] * transform.localScale.magnitude);
        }
    }
}
