using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class music : MonoBehaviour
{
    public List<AudioClip> songs;
    public AudioSource player;
    public int currentSong;
    public float currentTime;
    // Start is called before the first frame update
    void Start()
    {
        player.clip = songs[currentSong];
        player.Play();
    }

    // Update is called once per frame
    void Update()
    {
        if (!player.isPlaying && currentSong < songs.Count-1)
        {
            currentSong += 1;
            player.clip = songs[currentSong];
            player.Play();
        }

        currentTime = player.time/player.clip.length;
    }

    [ContextMenu("Skip")]
    public void Skip()
    {
        currentSong += 1;
        player.clip = songs[currentSong];
        player.Play();
    }
}
