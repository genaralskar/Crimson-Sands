using UnityEngine;

public class BlendMaterials : MonoBehaviour
{
    // Blends between two materials

    public Material material1;
    public Material material2;
    float duration = 0.5f;
    Renderer rend;

    void Start()
    {
        rend = GetComponent<Renderer> ();

        // At start, use the first material
        rend.material = material1;
    }

    void Update()
    {
        // ping-pong between the materials over the duration
        float lerp = Mathf.PingPong(Time.time, duration) / duration;
        rend.material.Lerp(material1, material2, lerp);
    }
}