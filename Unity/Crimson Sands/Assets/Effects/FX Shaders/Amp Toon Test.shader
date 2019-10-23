// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Amp Smoke Toon"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_CutoffRamp("Cutoff Ramp", Range( 1 , 50)) = 5
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_AlphaCutoff("Alpha Cutoff", 2D) = "black" {}
		_ScaleAndOffset("Scale And Offset", Range( 0 , 1)) = 0.5
		_Normal("Normal", 2D) = "white" {}
		_Float1("Float 1", Range( 1 , 100)) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Tint("Tint", Color) = (0,0,0,0)
		_RimOffset("Rim Offset", Float) = 1
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_SpecCoverage("Spec Coverage", Range( 0 , 2)) = 0.5
		_RimTint("Rim Tint", Color) = (0.1131185,0.7239776,0.7735849,0)
		_SpecIntensity("Spec Intensity", Range( 0 , 1)) = 0.5
		_SpecMap("Spec Map", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Geometry+0" }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			half3 Albedo;
			half3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			half Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform float _CutoffRamp;
		uniform sampler2D _AlphaCutoff;
		uniform float4 _AlphaCutoff_ST;
		uniform float _Float1;
		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _ToonRamp;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _ScaleAndOffset;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float4 _RimTint;
		uniform float _SpecCoverage;
		uniform sampler2D _SpecMap;
		uniform float4 _SpecMap_ST;
		uniform float _SpecIntensity;
		uniform float _Cutoff = 0.5;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#ifdef UNITY_PASS_FORWARDBASE
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			#if defined(HANDLE_SHADOWS_BLENDING_IN_GI)
			half bakedAtten = UnitySampleBakedOcclusion(data.lightmapUV.xy, data.worldPos);
			float zDist = dot(_WorldSpaceCameraPos - data.worldPos, UNITY_MATRIX_V[2].xyz);
			float fadeDist = UnityComputeShadowFadeDistance(data.worldPos, zDist);
			ase_lightAtten = UnityMixRealtimeAndBakedShadows(data.atten, bakedAtten, UnityComputeShadowFade(fadeDist));
			#endif
			float2 uv_AlphaCutoff = i.uv_texcoord * _AlphaCutoff_ST.xy + _AlphaCutoff_ST.zw;
			float4 tex2DNode116 = tex2D( _AlphaCutoff, uv_AlphaCutoff );
			float4 blendOpSrc120 = ( ( ( _Time.x * i.vertexColor.a ) / _CutoffRamp ) * tex2DNode116 );
			float4 blendOpDest120 = tex2DNode116;
			float4 lerpBlendMode120 = lerp(blendOpDest120,( blendOpSrc120 * blendOpDest120 ),( i.vertexColor.a * _Float1 * _Time.x ));
			float4 temp_output_120_0 = ( saturate( lerpBlendMode120 ));
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 Albedo28 = ( i.vertexColor * ( _Tint * tex2D( _Albedo, uv_Albedo ) ) );
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float4 NormalMap21 = tex2D( _Normal, uv_Normal );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult2 = dot( (WorldNormalVector( i , NormalMap21.rgb )) , ase_worldlightDir );
			float normal_lightDir8 = dotResult2;
			float2 temp_cast_3 = ((normal_lightDir8*_ScaleAndOffset + _ScaleAndOffset)).xx;
			float4 Shadow14 = ( Albedo28 * tex2D( _ToonRamp, temp_cast_3 ) );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			UnityGI gi37 = gi;
			float3 diffNorm37 = WorldNormalVector( i , NormalMap21.rgb );
			gi37 = UnityGI_Base( data, 1, diffNorm37 );
			float3 indirectDiffuse37 = gi37.indirect.diffuse + diffNorm37 * 0.0001;
			float4 Light35 = ( ( Shadow14 * ase_lightColor ) * float4( ( indirectDiffuse37 + ase_lightAtten ) , 0.0 ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult7 = dot( (WorldNormalVector( i , NormalMap21.rgb )) , ase_worldViewDir );
			float normal_viewDir9 = dotResult7;
			float4 RimLight49 = ( saturate( ( pow( ( 1.0 - saturate( ( normal_viewDir9 + _RimOffset ) ) ) , _RimPower ) * ( normal_lightDir8 * ase_lightAtten ) ) ) * ( ase_lightColor * _RimTint ) );
			float dotResult67 = dot( ( ase_worldViewDir + _WorldSpaceLightPos0.xyz ) , normalize( (WorldNormalVector( i , NormalMap21.rgb )) ) );
			float smoothstepResult71 = smoothstep( 1.1 , 1.12 , pow( dotResult67 , _SpecCoverage ));
			float2 uv_SpecMap = i.uv_texcoord * _SpecMap_ST.xy + _SpecMap_ST.zw;
			float4 Spec78 = ( ( ( smoothstepResult71 * tex2D( _SpecMap, uv_SpecMap ) ) * _SpecIntensity ) * ase_lightAtten );
			c.rgb = ( ( Light35 + RimLight49 ) + Spec78 ).rgb;
			c.a = temp_output_120_0.r;
			clip( temp_output_120_0.r - _Cutoff );
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
			o.Normal = float3(0,0,1);
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				half4 color : COLOR0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				o.color = v.color;
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				surfIN.vertexColor = IN.color;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
				surf( surfIN, o );
				UnityGI gi;
				UNITY_INITIALIZE_OUTPUT( UnityGI, gi );
				o.Alpha = LightingStandardCustomLighting( o, worldViewDir, gi ).a;
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
1921;1;1918;1137;-1076.225;-978.3901;1;True;True
Node;AmplifyShaderEditor.SamplerNode;20;-1000.742,609.8088;Inherit;True;Property;_Normal;Normal;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;10;-1090.413,-299.6574;Inherit;False;1063.142;404.1316;Normal.LightDir;5;8;2;1;3;22;Normal Light Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1090.446,141.2234;Inherit;False;1064.234;402.6019;Normal.ViewDir;5;6;5;9;7;23;Normal View Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-679.4219,617.0703;Float;False;NormalMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1078.573,-230.0505;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1076.377,196.5013;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;29;558.5024,-702.3755;Inherit;False;849.7145;490.3647;Albedo;5;26;24;28;27;90;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;3;-772.8171,-64.18403;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;6;-723.5203,368.8746;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;1;-739.0222,-249.6574;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;5;-727.604,191.2234;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;26;572.8464,-640.0615;Float;False;Property;_Tint;Tint;8;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;497.6761,-437.9059;Inherit;True;Property;_Albedo;Albedo;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;2;-476.0887,-152.5096;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;7;-431.5192,291.28;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;89;764.1563,-870.5159;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-283.212,282.9457;Float;False;normal_viewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;857.8776,-516.7015;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;58;-214.042,688.2211;Inherit;False;1742.358;685.106;Rim Light;17;44;42;43;45;46;47;48;51;50;53;57;55;56;52;54;49;59;Rim Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1086.811,-808.8864;Inherit;False;1234.996;448.3327;Shadow;7;17;12;14;13;16;30;31;Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-287.2713,-143.6544;Float;False;normal_lightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-164.042,738.2211;Inherit;False;9;normal_viewDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;1021.683,-569.8273;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-155.5166,861.8408;Float;False;Property;_RimOffset;Rim Offset;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;87;-1078.975,1582.074;Inherit;False;2576.032;1040.895;Spec;18;64;62;66;63;65;67;68;69;72;70;80;71;81;77;74;76;78;75;Specularity;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-967.4016,-734.7983;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1036.811,-632.5211;Float;False;Property;_ScaleAndOffset;Scale And Offset;4;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;1190.789,-509.2961;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-1028.975,2024.757;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;16;-759.0596,-650.6747;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;87.45969,768.0603;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;62;-941.5972,1632.074;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightPos;64;-999.2842,1812.233;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-707.9866,1715.783;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;45;232.3934,765.9291;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-478.2823,-737.0271;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-548.8008,-620.2831;Inherit;True;Property;_ToonRamp;Toon Ramp;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;65;-812.7785,2023.07;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;67;-551.7044,1760.561;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;204.8096,999.6713;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;46;398.6401,763.7978;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-243.9948,-689.4905;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;56;182.8331,1096.734;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-570.2838,1895.684;Float;False;Property;_SpecCoverage;Spec Coverage;11;0;Create;True;0;0;False;0;0.5;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;285.6777,891.6802;Float;False;Property;_RimPower;Rim Power;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;16.60074,-38.83282;Inherit;False;1091.024;661.9529;Light Color;9;41;35;40;39;38;37;34;32;33;Light Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-69.34851,-663.8133;Float;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;78.21757,353.8435;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;552.7704,1036.299;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-219.017,1839.804;Float;False;Constant;_Min;Min;7;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;69;-377.7347,1777.452;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;48;611.7776,829.8701;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-215.639,1927.634;Float;False;Constant;_Max;Max;9;0;Create;True;0;0;False;0;1.12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;50;827.4756,1017.985;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;32;323.5833,11.16708;Inherit;False;14;Shadow;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;71;-23.08953,1767.176;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;832.9702,853.1619;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;38;345.6186,405.9345;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;33;353.1364,144.1549;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;80;-110.9701,1993.145;Inherit;True;Property;_SpecMap;Spec Map;14;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IndirectDiffuseLighting;37;316.1005,320.8524;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;52;789.5577,1164.727;Float;False;Property;_RimTint;Rim Tint;12;0;Create;True;0;0;False;0;0.1131185,0.7239776,0.7735849,0;0.1131185,0.7239776,0.7735849,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;268.4644,1761.687;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;593.0676,75.03902;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;993.5967,987.6664;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;59;975.8173,856.8246;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;586.9748,260.0797;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;75;579.5939,2016.421;Float;False;Property;_SpecIntensity;Spec Intensity;13;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;111;-1038.337,2718.657;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;112;-1008.697,2865.242;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;744.085,173.2609;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;77;843.2814,1990.078;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1118.665,856.8245;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;787.8831,1791.786;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;1285.316,851.8781;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;894.144,170.664;Float;False;Light;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;1063.196,1840.768;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;114;-642.5404,2696.525;Inherit;False;Property;_CutoffRamp;Cutoff Ramp;1;0;Create;True;0;0;False;0;5;1;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-632.2253,2814.678;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;1254.057,1882.993;Float;False;Spec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;115;-356.4424,2762.389;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1773.92,1261.703;Inherit;False;35;Light;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;117;-945.8214,3193.651;Inherit;False;Property;_Float1;Float 1;6;0;Create;True;0;0;False;0;1;0;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;1773.209,1346.268;Inherit;False;49;RimLight;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;116;-554.9084,2934.384;Inherit;True;Property;_AlphaCutoff;Alpha Cutoff;3;0;Create;True;0;0;False;0;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;61;1997.348,1338.621;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;2054.529,1554.195;Inherit;False;78;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;-175.8418,2905.389;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;119;-585.0444,3167.067;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;19;2140.849,1112.145;Inherit;False;506.2102;482;Output;2;88;99;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;1090.253,-790.3092;Float;False;VertColAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;2188.44,1392.488;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;120;39.24539,2999.489;Inherit;False;Multiply;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;99;2411.264,1157.546;Float;False;True;7;ASEMaterialInspector;0;0;CustomLighting;Amp Smoke Toon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;10;False;-1;0;1;False;-1;10;False;-1;0;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;20;0
WireConnection;1;0;22;0
WireConnection;5;0;23;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;9;0;7;0
WireConnection;27;0;26;0
WireConnection;27;1;24;0
WireConnection;8;0;2;0
WireConnection;90;0;89;0
WireConnection;90;1;27;0
WireConnection;28;0;90;0
WireConnection;16;0;12;0
WireConnection;16;1;17;0
WireConnection;16;2;17;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;63;0;62;0
WireConnection;63;1;64;1
WireConnection;45;0;43;0
WireConnection;13;1;16;0
WireConnection;65;0;66;0
WireConnection;67;0;63;0
WireConnection;67;1;65;0
WireConnection;46;0;45;0
WireConnection;31;0;30;0
WireConnection;31;1;13;0
WireConnection;14;0;31;0
WireConnection;55;0;54;0
WireConnection;55;1;56;0
WireConnection;69;0;67;0
WireConnection;69;1;68;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;71;0;69;0
WireConnection;71;1;70;0
WireConnection;71;2;72;0
WireConnection;57;0;48;0
WireConnection;57;1;55;0
WireConnection;37;0;40;0
WireConnection;81;0;71;0
WireConnection;81;1;80;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;51;0;50;0
WireConnection;51;1;52;0
WireConnection;59;0;57;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;41;0;34;0
WireConnection;41;1;39;0
WireConnection;53;0;59;0
WireConnection;53;1;51;0
WireConnection;74;0;81;0
WireConnection;74;1;75;0
WireConnection;49;0;53;0
WireConnection;35;0;41;0
WireConnection;76;0;74;0
WireConnection;76;1;77;0
WireConnection;113;0;111;1
WireConnection;113;1;112;4
WireConnection;78;0;76;0
WireConnection;115;0;113;0
WireConnection;115;1;114;0
WireConnection;61;0;60;0
WireConnection;61;1;15;0
WireConnection;118;0;115;0
WireConnection;118;1;116;0
WireConnection;119;0;112;4
WireConnection;119;1;117;0
WireConnection;119;2;111;1
WireConnection;93;0;89;3
WireConnection;88;0;61;0
WireConnection;88;1;79;0
WireConnection;120;0;118;0
WireConnection;120;1;116;0
WireConnection;120;2;119;0
WireConnection;99;9;120;0
WireConnection;99;10;120;0
WireConnection;99;13;88;0
ASEEND*/
//CHKSM=6A5C6E97A202823E44B6E03BC2E1413BD2FF8D44