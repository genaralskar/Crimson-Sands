// Amplify Shader Editor - Visual Shader Editing Tool
// Copyright (c) Amplify Creations, Lda <info@amplify.pt>
#if UNITY_POST_PROCESSING_STACK_V2
using System;
using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

[Serializable]
[PostProcess( typeof( FadeNearCameraPPSRenderer ), PostProcessEvent.AfterStack, "FadeNearCamera", true )]
public sealed class FadeNearCameraPPSSettings : PostProcessEffectSettings
{
}

public sealed class FadeNearCameraPPSRenderer : PostProcessEffectRenderer<FadeNearCameraPPSSettings>
{
	public override void Render( PostProcessRenderContext context )
	{
		var sheet = context.propertySheets.Get( Shader.Find( "Fade Near Camera" ) );
		context.command.BlitFullscreenTriangle( context.source, context.destination, sheet, 0 );
	}
}
#endif
