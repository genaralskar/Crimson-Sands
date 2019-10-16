// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "CutoutTest"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_CutoffRamp("Cutoff Ramp", Range( 1 , 50)) = 5
		_TextureSample0("Texture Sample 0", 2D) = "black" {}
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_FadeStrength("Fade Strength", Range( 1 , 100)) = 1
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "white" {}
		_ScaleandOffset("Scale and Offset", Range( 0 , 1)) = 0.5
		_Tint("Tint", Color) = (1,1,1,0)
		_RimOffset("Rim Offset", Float) = 1
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_RimTint("Rim Tint", Color) = (0.1131185,0.7239776,0.7735849,0)
		_SpecCoverage("Spec Coverage", Range( 0 , 2)) = 0.5
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
		#pragma target 4.6
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
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _FadeStrength;
		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _ToonRamp;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _ScaleandOffset;
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
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode27 = tex2D( _TextureSample0, uv_TextureSample0 );
			float4 blendOpSrc28 = ( ( ( _Time.x * i.vertexColor.a ) / _CutoffRamp ) * tex2DNode27 );
			float4 blendOpDest28 = tex2DNode27;
			float4 lerpBlendMode28 = lerp(blendOpDest28,( blendOpSrc28 * blendOpDest28 ),( i.vertexColor.a * _FadeStrength * _Time.x ));
			float4 AlphaCutoff54 = ( saturate( lerpBlendMode28 ));
			float4 temp_output_55_0 = AlphaCutoff54;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 Albedo43 = ( i.vertexColor * ( _Tint * tex2D( _Albedo, uv_Albedo ) ) );
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float4 NormalMap66 = tex2D( _Normal, uv_Normal );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult63 = dot( (WorldNormalVector( i , NormalMap66.rgb )) , ase_worldlightDir );
			float normal_lightDir64 = dotResult63;
			float2 temp_cast_3 = ((normal_lightDir64*_ScaleandOffset + _ScaleandOffset)).xx;
			float4 Shadow52 = ( Albedo43 * tex2D( _ToonRamp, temp_cast_3 ) );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			UnityGI gi77 = gi;
			float3 diffNorm77 = WorldNormalVector( i , NormalMap66.rgb );
			gi77 = UnityGI_Base( data, 1, diffNorm77 );
			float3 indirectDiffuse77 = gi77.indirect.diffuse + diffNorm77 * 0.0001;
			float4 Light80 = ( ( Shadow52 * ase_lightColor ) * float4( ( indirectDiffuse77 + ase_lightAtten ) , 0.0 ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult70 = dot( (WorldNormalVector( i , NormalMap66.rgb )) , ase_worldViewDir );
			float normal_viewDir71 = dotResult70;
			float4 RimLight100 = ( saturate( ( pow( ( 1.0 - saturate( ( normal_viewDir71 + _RimOffset ) ) ) , _RimPower ) * ( normal_lightDir64 * ase_lightAtten ) ) ) * ( ase_lightColor * _RimTint ) );
			float dotResult108 = dot( ( ase_worldViewDir + _WorldSpaceLightPos0.xyz ) , normalize( (WorldNormalVector( i , NormalMap66.rgb )) ) );
			float smoothstepResult112 = smoothstep( 1.1 , 1.12 , pow( dotResult108 , _SpecCoverage ));
			float2 uv_SpecMap = i.uv_texcoord * _SpecMap_ST.xy + _SpecMap_ST.zw;
			float4 Spec119 = ( ( ( smoothstepResult112 * tex2D( _SpecMap, uv_SpecMap ) ) * _SpecIntensity ) * ase_lightAtten );
			c.rgb = ( ( Light80 + RimLight100 ) + Spec119 ).rgb;
			c.a = temp_output_55_0.r;
			clip( temp_output_55_0.r - _Cutoff );
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
			#pragma target 4.6
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
1921;1;1918;1137;2651.167;348.0651;1;True;True
Node;AmplifyShaderEditor.SamplerNode;65;-3246.048,722.6817;Inherit;True;Property;_Normal;Normal;6;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;66;-2924.728,729.9432;Float;False;NormalMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;67;-2326.578,950.9426;Inherit;False;1064.234;402.6019;Normal.ViewDir;5;72;71;70;69;68;Normal View Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;59;-2342.663,415.6386;Inherit;False;1063.142;404.1316;Normal.LightDir;5;64;63;62;61;60;Normal Light Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-2312.509,1006.221;Inherit;False;66;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-2334.944,477.0046;Inherit;False;66;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;61;-2025.067,651.1119;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;62;-1991.272,465.6386;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;69;-1963.736,1000.943;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;68;-1959.652,1178.594;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;37;-2018.542,-682.6221;Inherit;False;849.7145;490.3647;Albedo;6;43;42;41;39;40;38;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;39;-2004.198,-620.308;Float;False;Property;_Tint;Tint;8;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;63;-1728.339,562.7864;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;70;-1667.651,1100.999;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;-1999.368,-423.8665;Inherit;True;Property;_Albedo;Albedo;5;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-1719.167,-496.9478;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;64;-1539.521,571.6415;Float;False;normal_lightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;45;-2347.52,-102.7623;Inherit;False;1234.996;448.3327;Shadow;7;52;51;50;49;48;47;46;Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;83;-2865.711,1472.687;Inherit;False;1742.358;685.106;Rim Light;17;100;99;98;97;96;95;94;93;92;91;90;89;88;87;86;85;84;Rim Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;71;-1519.344,1092.665;Float;False;normal_viewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;40;-1777.174,-666.4758;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1555.361,-550.0736;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-2807.186,1646.307;Float;False;Property;_RimOffset;Rim Offset;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-2302.52,93.60297;Float;False;Property;_ScaleandOffset;Scale and Offset;7;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;101;-2852.583,2281.033;Inherit;False;2576.032;1040.895;Spec;18;119;118;117;116;115;114;113;112;111;110;109;108;107;106;105;104;103;102;Specularity;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-2228.111,-28.67419;Inherit;False;64;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;84;-2815.711,1522.687;Inherit;False;71;normal_viewDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;102;-2802.583,2723.716;Inherit;False;66;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;103;-2715.205,2331.033;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightPos;104;-2772.892,2511.192;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;86;-2564.209,1552.526;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;48;-2019.769,55.4494;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;43;-1386.255,-489.5424;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;105;-2481.594,2414.742;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;49;-1809.51,85.841;Inherit;True;Property;_ToonRamp;Toon Ramp;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;106;-2586.386,2722.029;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;50;-1738.991,-30.90302;Inherit;False;43;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;87;-2419.276,1550.395;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;88;-2446.859,1784.137;Inherit;False;64;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;89;-2253.029,1548.264;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;91;-2365.991,1676.146;Float;False;Property;_RimPower;Rim Power;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-2343.892,2594.643;Float;False;Property;_SpecCoverage;Spec Coverage;12;0;Create;True;0;0;False;0;0.5;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;73;-1135.125,427.7326;Inherit;False;1091.024;661.9529;Light Color;9;82;81;80;79;78;77;76;75;74;Light Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;108;-2325.312,2459.52;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-1504.704,16.63361;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;90;-2468.836,1881.2;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-1992.625,2538.763;Float;False;Constant;_Min;Min;7;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;52;-1328.057,42.31079;Float;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;53;-978.2903,1176.076;Inherit;False;1348.995;676.5421;Alpha Cutoff;10;5;18;21;6;27;33;24;25;32;28;Alpha Cutoff;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;110;-2151.343,2476.411;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;109;-1989.247,2626.593;Float;False;Constant;_Max;Max;9;0;Create;True;0;0;False;0;1.12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;93;-2039.892,1614.336;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;-1073.508,820.409;Inherit;False;66;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-2098.899,1820.765;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;94;-1862.111,1949.193;Float;False;Property;_RimTint;Rim Tint;11;0;Create;True;0;0;False;0;0.1131185,0.7239776,0.7735849,0;0.1131185,0.7239776,0.7735849,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;81;-828.142,477.7325;Inherit;False;52;Shadow;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;77;-835.6248,787.4178;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TimeNode;5;-928.2902,1248.209;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;95;-1824.193,1802.451;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;113;-1884.578,2692.104;Inherit;True;Property;_SpecMap;Spec Map;14;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;112;-1796.697,2466.135;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;-1818.699,1637.628;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;75;-806.1067,872.4999;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;18;-898.6508,1394.793;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;76;-798.5889,610.7204;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-522.1779,1344.229;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;-1505.143,2460.646;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;78;-564.7505,726.6452;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-558.6577,541.6045;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-532.4926,1226.076;Inherit;False;Property;_CutoffRamp;Cutoff Ramp;1;0;Create;True;0;0;False;0;5;1;1;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;97;-1658.072,1772.132;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;98;-1675.852,1641.291;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;115;-1194.013,2715.38;Float;False;Property;_SpecIntensity;Spec Intensity;13;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;24;-246.3946,1291.94;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;-1533.004,1641.291;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-407.6403,639.8264;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-835.7741,1723.202;Inherit;False;Property;_FadeStrength;Fade Strength;4;0;Create;True;0;0;False;0;1;0;1;100;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;-985.7244,2490.745;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;116;-930.3259,2689.037;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-444.8611,1463.935;Inherit;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;black;LockedToTexture2D;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;-710.4113,2539.727;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-474.9972,1696.618;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-65.79454,1434.94;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;80;-257.5813,637.2294;Float;False;Light;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;100;-1366.353,1636.344;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendOpsNode;28;133.7049,1529.04;Inherit;False;Multiply;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;119;-519.5502,2581.952;Float;False;Spec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;120;-668.9633,120.4088;Inherit;False;80;Light;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;121;-669.6743,204.9738;Inherit;False;100;RimLight;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;122;-445.5353,197.3268;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;-502.3542,336.9008;Inherit;False;119;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;54;442.4692,1554.945;Inherit;False;AlphaCutoff;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;123;-254.4434,251.1938;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;55;-231.8447,140.0522;Inherit;False;54;AlphaCutoff;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;6;ASEMaterialInspector;0;0;CustomLighting;CutoutTest;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;66;0;65;0
WireConnection;62;0;60;0
WireConnection;69;0;72;0
WireConnection;63;0;62;0
WireConnection;63;1;61;0
WireConnection;70;0;69;0
WireConnection;70;1;68;0
WireConnection;41;0;39;0
WireConnection;41;1;38;0
WireConnection;64;0;63;0
WireConnection;71;0;70;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;86;0;84;0
WireConnection;86;1;85;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;48;2;47;0
WireConnection;43;0;42;0
WireConnection;105;0;103;0
WireConnection;105;1;104;1
WireConnection;49;1;48;0
WireConnection;106;0;102;0
WireConnection;87;0;86;0
WireConnection;89;0;87;0
WireConnection;108;0;105;0
WireConnection;108;1;106;0
WireConnection;51;0;50;0
WireConnection;51;1;49;0
WireConnection;52;0;51;0
WireConnection;110;0;108;0
WireConnection;110;1;107;0
WireConnection;93;0;89;0
WireConnection;93;1;91;0
WireConnection;92;0;88;0
WireConnection;92;1;90;0
WireConnection;77;0;74;0
WireConnection;112;0;110;0
WireConnection;112;1;111;0
WireConnection;112;2;109;0
WireConnection;96;0;93;0
WireConnection;96;1;92;0
WireConnection;6;0;5;1
WireConnection;6;1;18;4
WireConnection;114;0;112;0
WireConnection;114;1;113;0
WireConnection;78;0;77;0
WireConnection;78;1;75;0
WireConnection;82;0;81;0
WireConnection;82;1;76;0
WireConnection;97;0;95;0
WireConnection;97;1;94;0
WireConnection;98;0;96;0
WireConnection;24;0;6;0
WireConnection;24;1;21;0
WireConnection;99;0;98;0
WireConnection;99;1;97;0
WireConnection;79;0;82;0
WireConnection;79;1;78;0
WireConnection;117;0;114;0
WireConnection;117;1;115;0
WireConnection;118;0;117;0
WireConnection;118;1;116;0
WireConnection;32;0;18;4
WireConnection;32;1;33;0
WireConnection;32;2;5;1
WireConnection;25;0;24;0
WireConnection;25;1;27;0
WireConnection;80;0;79;0
WireConnection;100;0;99;0
WireConnection;28;0;25;0
WireConnection;28;1;27;0
WireConnection;28;2;32;0
WireConnection;119;0;118;0
WireConnection;122;0;120;0
WireConnection;122;1;121;0
WireConnection;54;0;28;0
WireConnection;123;0;122;0
WireConnection;123;1;124;0
WireConnection;0;9;55;0
WireConnection;0;10;55;0
WireConnection;0;13;123;0
ASEEND*/
//CHKSM=8938FF63B388FEDABC0AD407E807168BD170429B