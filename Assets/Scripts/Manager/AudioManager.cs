using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;

public class AudioManager : MonoBehaviour
{
    [SerializeField] private Image VolumeMuteImage;
    [SerializeField] Sprite volumeOnSprite;
    [SerializeField] Sprite volumeOffSprite;
    
    public static AudioManager Instance;

    [System.Serializable]
    public class Sound
    {
        public string name;
        public AudioClip clip;
    }

    public List<Sound> sounds;

    private Dictionary<string, AudioClip> soundDict;

    private AudioSource musicSource;
    private AudioSource sfxSource;
    private AudioSource uiSource;

    // Volume settings
    [Range(0f, 1f)] public float musicVolume = 1f;
    [Range(0f, 1f)] public float sfxVolume = 1f;
    [Range(0f, 1f)] public float uiVolume = 1f;
    
    private bool isMuted = false;
    
    private void Awake()
    {
        // Singleton pattern
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(gameObject);
        }
        else
        {
            Destroy(gameObject);
            return;
        }

        // Setup channels
        musicSource = gameObject.AddComponent<AudioSource>();
        musicSource.loop = true;

        sfxSource = gameObject.AddComponent<AudioSource>();
        uiSource = gameObject.AddComponent<AudioSource>();

        // Build dictionary
        soundDict = new Dictionary<string, AudioClip>();
        foreach (var s in sounds)
        {
            if (!soundDict.ContainsKey(s.name))
                soundDict.Add(s.name, s.clip);
        }

        ApplyVolumes();
    }

    private void Start()
    {
        UpdateIcon();
        sounds = new List<Sound>();
    }
    
    // --- MUSIC ---
    public void PlayMusic(string name)
    {
        if (soundDict.ContainsKey(name))
        {
            musicSource.clip = soundDict[name];
            musicSource.Play();
        }
        else
        {
            Debug.LogWarning($"Music {name} not found!");
        }
    }

    public void StopMusic()
    {
        musicSource.Stop();
    }

    // --- SFX ---
    public void PlaySFX(string name)
    {
        if (soundDict.ContainsKey(name))
        {
            sfxSource.PlayOneShot(soundDict[name]);
        }
        else
        {
            Debug.LogWarning($"SFX {name} not found!");
        }
    }

    public void StopSFX()
    {
        sfxSource.Stop();
    }
    
    // --- UI ---
    public void PlayUI(string name)
    {
        if (soundDict.ContainsKey(name))
        {
            uiSource.PlayOneShot(soundDict[name]);
        }
        else
        {
            Debug.LogWarning($"UI sound {name} not found!");
        }
    }

    // Add new clips at runtime
    public void AddSound(string name, AudioClip clip)
    {
        if (!soundDict.ContainsKey(name))
        {
            soundDict.Add(name, clip);
            sounds.Add(new Sound { name = name, clip = clip });
        }
    }
    
    #region Volume Control
    
    public void SetMusicVolume(float volume)
    {
        musicVolume = Mathf.Clamp01(volume);
        musicSource.volume = isMuted ? 0f : musicVolume;
    }

    public void SetSFXVolume(float volume)
    {
        sfxVolume = Mathf.Clamp01(volume);
        sfxSource.volume = isMuted ? 0f : sfxVolume;
    }

    public void SetUIVolume(float volume)
    {
        uiVolume = Mathf.Clamp01(volume);
        uiSource.volume = isMuted ? 0f : uiVolume;
    }

    private void ApplyVolumes()
    {
        musicSource.volume = isMuted ? 0f : musicVolume;
        sfxSource.volume = isMuted ? 0f : sfxVolume;
        uiSource.volume = isMuted ? 0f : uiVolume;
    }
    
    public void MuteAll(bool mute)
    {
        isMuted = mute;
        ApplyVolumes();
    }
    
    public void ToggleMute()
    {
        isMuted = !isMuted;
        Instance.MuteAll(isMuted);
        UpdateIcon();
    }
    
    private void UpdateIcon()
    {
        VolumeMuteImage.sprite = isMuted ? volumeOffSprite : volumeOnSprite;
    }
    
    #endregion
}
