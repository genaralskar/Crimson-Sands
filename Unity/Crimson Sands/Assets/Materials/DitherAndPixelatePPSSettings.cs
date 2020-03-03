// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( DitherAndPixelatePPSRenderer ), PostProcessEvent.BeforeTransparent, "DitherAndPixelate", true )]
public sealed class DitherAndPixelatePPSSettings : PostProcessEffectSettings
{
	[Tooltip( "Toggle Dither" )]
	public FloatParameter _ToggleDither = new FloatParameter { value = 1f };
	[Tooltip( "Intensity" )]
	public FloatParameter _Intensity = new FloatParameter { value = 0.5f };
	[Tooltip( "Toggle Pixelation" )]
	public FloatParameter _TogglePixelation = new FloatParameter { value = 0f };
	[Tooltip( "Pixelation Amount" )]
	public FloatParameter _PixelationAmount = new FloatParameter { value = 1f };
}

public sealed class DitherAndPixelatePPSRenderer : PostProcessEffectRenderer<DitherAndPixelatePPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "Dither And Pixelate" ) );
		sheet.properties.SetFloat( "_ToggleDither", settings._ToggleDither );
		sheet.properties.SetFloat( "_Intensity", settings._Intensity );
		sheet.properties.SetFloat( "_TogglePixelation", settings._TogglePixelation );
		sheet.properties.SetFloat( "_PixelationAmount", settings._PixelationAmount );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
