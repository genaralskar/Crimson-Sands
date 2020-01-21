using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess(typeof(PostProcessOutlineRenderer), PostProcessEvent.BeforeStack, "Roystan/Post Process Outline")]
public sealed class PostProcessOutline : PostProcessEffectSettings
{
    public IntParameter scale = new IntParameter {value = 1};
    public FloatParameter depthThreshold = new FloatParameter {value = 1.5f};
    [Range(0, 1)]
    public FloatParameter normalThreshold = new FloatParameter { value = 0.4f };
    [Range(0, 1)]
    public FloatParameter depthNormalThreshold = new FloatParameter { value = 0.5f };
    public FloatParameter depthNormalThresholdScale = new FloatParameter { value = 7 };
    public ColorParameter color = new ColorParameter { value = Color.black };

    public TextureParameter noiseTexture = new TextureParameter {value = null};
    public Vector2Parameter noiseTiling = new Vector2Parameter { value = new Vector2(1, 1) };
    public Vector2Parameter noiseOffset = new Vector2Parameter { value = new Vector2(0, 0) };

}

public sealed class PostProcessOutlineRenderer : PostProcessEffectRenderer<PostProcessOutline>
{
    public override void Render(PostProcessRenderContext context)
    {
        var sheet = context.propertySheets.Get(Shader.Find("Hidden/Roystan/Outline Post Process"));
        
        sheet.properties.SetFloat("_Scale", settings.scale);
        sheet.properties.SetFloat("_DepthThreshold", settings.depthThreshold);
        sheet.properties.SetFloat("_NormalThreshold", settings.normalThreshold);
        sheet.properties.SetFloat("_DepthNormalThreshold", settings.depthNormalThreshold);
        sheet.properties.SetFloat("_DepthNormalThresholdScale", settings.depthNormalThresholdScale);
        sheet.properties.SetColor("_Color", settings.color);

        var imageTexture = settings.noiseTexture.value == null
            ? RuntimeUtilities.transparentTexture
            : settings.noiseTexture.value;
        
        sheet.properties.SetTexture("_NoiseTexture", imageTexture);
        sheet.properties.SetVector("_NoiseTiling", settings.noiseTiling);
        sheet.properties.SetVector("_NoiseOffset", settings.noiseOffset);

        Matrix4x4 clipToView = GL.GetGPUProjectionMatrix(context.camera.projectionMatrix, true).inverse;
        sheet.properties.SetMatrix("_ClipToView", clipToView);
        
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }
}