using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SongController : MonoBehaviour
{
    public List<AudioClip> tracks;
    public AudioSource player;
    public int currentTrack;
    public ConcentricZones zones;
    // Start is called before the first frame update
    void Start()
    {
        currentTrack = 0;
    }

    // Update is called once per frame
    void Update()
    {
        if (zones.changedZones)
        {
            currentTrack = zones.currentZone;
            player.clip = tracks[currentTrack];
            if(!player.isPlaying)
                player.Play();
            //zones.changedZones = false;
        }
        
    }
}
