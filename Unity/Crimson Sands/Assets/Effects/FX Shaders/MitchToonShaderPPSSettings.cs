// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( MitchToonShaderPPSRenderer ), PostProcessEvent.BeforeTransparent, "MitchToonShader", true )]
public sealed class MitchToonShaderPPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Alpha Cutoff On" )]
	public FloatParameter _AlphaCutoffOn = new FloatParameter { value = 0f };
	[Tooltip( "Mask Clip Value" )]
	public FloatParameter _Cutoff = new FloatParameter { value = 0f };
	[Tooltip( "Dissolve Texture" )]
	public TextureParameter _DissolveTexture = new TextureParameter {  };
	[Tooltip( "Albedo" )]
	public TextureParameter _Albedo = new TextureParameter {  };
	[Tooltip( "Cutoff Ramp" )]
	public FloatParameter _CutoffRamp = new FloatParameter { value = 0f };
	[Tooltip( "Toon Ramp" )]
	public TextureParameter _ToonRamp = new TextureParameter {  };
	[Tooltip( "Speed" )]
	public Vector4Parameter _Speed = new Vector4Parameter { value = new Vector4(0.1f,0.1f,0f,0f) };
	[Tooltip( "Scale And Offset" )]
	public FloatParameter _ScaleAndOffset = new FloatParameter { value = 0.5f };
	[Tooltip( "Normal" )]
	public TextureParameter _Normal = new TextureParameter {  };
	[Tooltip( "Tint" )]
	public ColorParameter _Tint = new ColorParameter { value = new Color(0f,0f,0f,0f) };
	[Tooltip( "Rim Offset" )]
	public FloatParameter _RimOffset = new FloatParameter { value = 1f };
	[Tooltip( "Rim Power" )]
	public FloatParameter _RimPower = new FloatParameter { value = 0f };
	[Tooltip( "Spec Coverage" )]
	public FloatParameter _SpecCoverage = new FloatParameter { value = 0.5f };
	[Tooltip( "Rim Tint" )]
	public ColorParameter _RimTint = new ColorParameter { value = new Color(0.8301887f,0.8183333f,0.7362049f,1f) };
	[Tooltip( "Spec On" )]
	public FloatParameter _SpecOn = new FloatParameter { value = 0f };
	[Tooltip( "Spec Intensity" )]
	public FloatParameter _SpecIntensity = new FloatParameter { value = 0.5f };
	[Tooltip( "Spec Map" )]
	public TextureParameter _SpecMap = new TextureParameter {  };
	[Tooltip( "Toon Intensity" )]
	public FloatParameter _ToonIntensity = new FloatParameter { value = 5f };
}

public sealed class MitchToonShaderPPSRenderer : PostProcessEffectRenderer<MitchToonShaderPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "Mitch Toon Shader" ) );
		sheet.properties.SetFloat( "_AlphaCutoffOn", settings._AlphaCutoffOn );
		sheet.properties.SetFloat( "_Cutoff", settings._Cutoff );
		if(settings._DissolveTexture.value != null) sheet.properties.SetTexture( "_DissolveTexture", settings._DissolveTexture );
		if(settings._Albedo.value != null) sheet.properties.SetTexture( "_Albedo", settings._Albedo );
		sheet.properties.SetFloat( "_CutoffRamp", settings._CutoffRamp );
		if(settings._ToonRamp.value != null) sheet.properties.SetTexture( "_ToonRamp", settings._ToonRamp );
		sheet.properties.SetVector( "_Speed", settings._Speed );
		sheet.properties.SetFloat( "_ScaleAndOffset", settings._ScaleAndOffset );
		if(settings._Normal.value != null) sheet.properties.SetTexture( "_Normal", settings._Normal );
		sheet.properties.SetColor( "_Tint", settings._Tint );
		sheet.properties.SetFloat( "_RimOffset", settings._RimOffset );
		sheet.properties.SetFloat( "_RimPower", settings._RimPower );
		sheet.properties.SetFloat( "_SpecCoverage", settings._SpecCoverage );
		sheet.properties.SetColor( "_RimTint", settings._RimTint );
		sheet.properties.SetFloat( "_SpecOn", settings._SpecOn );
		sheet.properties.SetFloat( "_SpecIntensity", settings._SpecIntensity );
		if(settings._SpecMap.value != null) sheet.properties.SetTexture( "_SpecMap", settings._SpecMap );
		sheet.properties.SetFloat( "_ToonIntensity", settings._ToonIntensity );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
