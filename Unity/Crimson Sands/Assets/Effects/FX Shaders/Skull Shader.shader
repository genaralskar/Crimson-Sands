// Upgrade NOTE: upgraded instancing buffer 'SkullShader' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Skull Shader"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0
		_DissolveTexture("Dissolve Texture", 2D) = "white" {}
		_UVLerp("UVLerp", Range( 0 , 1)) = 0.12
		_CutoffRamp("Cutoff Ramp", Range( 0 , 2)) = 0
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_Speed("Speed", Vector) = (0.1,0.1,0,0)
		_ScaleAndOffset("Scale And Offset", Range( 0 , 1)) = 0.5
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_Albedo("Albedo", 2D) = "white" {}
		_Tint("Tint", Color) = (0,0,0,0)
		_RimOffset("Rim Offset", Float) = 1
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_SpecCoverage("Spec Coverage", Range( 0 , 2)) = 0.5
		_RimTint("Rim Tint", Color) = (0.1131185,0.7239776,0.7735849,0)
		_SpecIntensity("Spec Intensity", Range( 0 , 1)) = 0.5
		_SpecMap("Spec Map", 2D) = "white" {}
		_ToonIntensity("Toon Intensity", Range( 0 , 1)) = 0
		_Metallic("Metallic?", Range( 0 , 1)) = 0
		_LightWrap("Light Wrap", Range( 0 , 10)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Off
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma multi_compile_instancing
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
			half3 worldNormal;
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

		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform sampler2D _DissolveTexture;
		uniform half2 _Speed;
		uniform half _UVLerp;
		uniform half _CutoffRamp;
		uniform sampler2D _ToonRamp;
		uniform sampler2D _Normal;
		uniform float _ScaleAndOffset;
		uniform half _ToonIntensity;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform half _LightWrap;
		uniform half _Metallic;
		uniform float _SpecCoverage;
		uniform sampler2D _SpecMap;
		uniform float _SpecIntensity;
		uniform float4 _RimTint;
		uniform float _Cutoff = 0;

		UNITY_INSTANCING_BUFFER_START(SkullShader)
			UNITY_DEFINE_INSTANCED_PROP(half4, _Albedo_ST)
#define _Albedo_ST_arr SkullShader
			UNITY_DEFINE_INSTANCED_PROP(half4, _Normal_ST)
#define _Normal_ST_arr SkullShader
		UNITY_INSTANCING_BUFFER_END(SkullShader)

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
			half2 panner125 = ( _Time.y * _Speed + i.uv_texcoord);
			half2 temp_cast_1 = (tex2D( _DissolveTexture, panner125 ).r).xx;
			half2 lerpResult129 = lerp( i.uv_texcoord , temp_cast_1 , _UVLerp);
			half2 temp_cast_2 = (( ( 1.0 - i.vertexColor.a ) * _CutoffRamp )).xx;
			half2 TextureMask131 = ( lerpResult129 - temp_cast_2 );
			half4 _Albedo_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Albedo_ST_arr, _Albedo_ST);
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST_Instance.xy + _Albedo_ST_Instance.zw;
			float4 Albedo28 = ( i.vertexColor * ( _Tint * tex2D( _Albedo, uv_Albedo ) ) );
			half4 _Normal_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Normal_ST_arr, _Normal_ST);
			float2 uv_Normal = i.uv_texcoord * _Normal_ST_Instance.xy + _Normal_ST_Instance.zw;
			float3 NormalMap21 = UnpackNormal( tex2D( _Normal, uv_Normal ) );
			half3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			half3 ase_worldlightDir = 0;
			#else //aseld
			half3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			half dotResult2 = dot( (WorldNormalVector( i , NormalMap21 )) , ase_worldlightDir );
			float normal_lightDir8 = dotResult2;
			half2 temp_cast_4 = ((normal_lightDir8*_ScaleAndOffset + _ScaleAndOffset)).xx;
			float4 Shadow14 = ( ( Albedo28 * tex2D( _ToonRamp, temp_cast_4 ) ) * _ToonIntensity );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			half4 ase_lightColor = 0;
			#else //aselc
			half4 ase_lightColor = _LightColor0;
			#endif //aselc
			UnityGI gi37 = gi;
			float3 diffNorm37 = WorldNormalVector( i , NormalMap21 );
			gi37 = UnityGI_Base( data, 1, diffNorm37 );
			half3 indirectDiffuse37 = gi37.indirect.diffuse + diffNorm37 * 0.0001;
			float4 Light35 = ( ( Shadow14 * ase_lightColor ) * half4( ( indirectDiffuse37 + ase_lightAtten ) , 0.0 ) );
			half3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			half dotResult7 = dot( (WorldNormalVector( i , NormalMap21 )) , ase_worldViewDir );
			float normal_viewDir9 = dotResult7;
			float3 LightWrapVector47_g7 = (( _LightWrap * 0.5 )).xxx;
			float3 CurrentNormal23_g7 = normalize( (WorldNormalVector( i , NormalMap21 )) );
			half dotResult20_g7 = dot( CurrentNormal23_g7 , ase_worldlightDir );
			float NDotL21_g7 = dotResult20_g7;
			float3 AttenuationColor8_g7 = ( ase_lightColor.rgb * ase_lightAtten );
			half3 temp_cast_6 = (ase_lightAtten).xxx;
			float3 DiffuseColor70_g7 = ( ( ( max( ( LightWrapVector47_g7 + ( ( 1.0 - LightWrapVector47_g7 ) * NDotL21_g7 ) ) , float3(0,0,0) ) * AttenuationColor8_g7 ) + (UNITY_LIGHTMODEL_AMBIENT).rgb ) * temp_cast_6 );
			half3 normalizeResult77_g7 = normalize( _WorldSpaceLightPos0.xyz );
			half3 normalizeResult28_g7 = normalize( ( normalizeResult77_g7 + ase_worldViewDir ) );
			float3 HalfDirection29_g7 = normalizeResult28_g7;
			half dotResult32_g7 = dot( HalfDirection29_g7 , CurrentNormal23_g7 );
			float SpecularPower14_g7 = exp2( ( ( _Metallic * 10.0 ) + 1.0 ) );
			half dotResult67 = dot( ( ase_worldViewDir + _WorldSpaceLightPos0.xyz ) , normalize( (WorldNormalVector( i , NormalMap21 )) ) );
			half smoothstepResult71 = smoothstep( 1.1 , 1.12 , pow( dotResult67 , _SpecCoverage ));
			float4 Spec78 = ( ( ( smoothstepResult71 * tex2D( _SpecMap, i.uv_texcoord ) ) * _SpecIntensity ) * ase_lightAtten );
			float3 specularFinalColor42_g7 = ( AttenuationColor8_g7 * pow( max( dotResult32_g7 , 0.0 ) , SpecularPower14_g7 ) * Spec78.r );
			float4 RimLight49 = ( half4( saturate( ( pow( ( 1.0 - saturate( ( normal_viewDir9 + _RimOffset ) ) ) , _RimPower ) * ( ( DiffuseColor70_g7 + specularFinalColor42_g7 ) + normal_lightDir8 ) ) ) , 0.0 ) * ( ase_lightColor * _RimTint ) );
			c.rgb = ( ( Light35 + RimLight49 ) + Spec78 ).rgb;
			c.a = 1;
			clip( TextureMask131.x - _Cutoff );
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
			half4 _Albedo_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Albedo_ST_arr, _Albedo_ST);
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST_Instance.xy + _Albedo_ST_Instance.zw;
			float4 Albedo28 = ( i.vertexColor * ( _Tint * tex2D( _Albedo, uv_Albedo ) ) );
			o.Albedo = Albedo28.rgb;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows noshadow exclude_path:deferred 

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
0;294.6667;1643;827;6181.922;2594.199;6.848815;True;True
Node;AmplifyShaderEditor.CommentaryNode;175;-1072.646,764.2458;Inherit;False;619.9868;280;Comment;2;21;20;Normal Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;20;-1022.646,814.2458;Inherit;True;Property;_Normal;Normal;10;1;[Normal];Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-701.3259,821.5074;Float;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;87;-4242.757,-804.6946;Inherit;False;2576.032;1040.895;Spec;19;141;78;76;77;74;75;81;71;80;70;69;72;68;67;63;65;64;62;66;Specularity;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;64;-4163.066,-574.5356;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;66;-4192.757,-362.0117;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;62;-4105.379,-754.6946;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;65;-3976.56,-363.6987;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-3871.768,-670.9856;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1098.446,141.2234;Inherit;False;1064.234;402.6019;Normal.ViewDir;5;23;9;6;5;7;Normal View Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1078.573,-230.0505;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DotProductOpNode;67;-3715.486,-626.2075;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-3734.066,-491.0847;Float;False;Property;_SpecCoverage;Spec Coverage;15;0;Create;True;0;0;False;0;0.5;0.9;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1084.377,196.5013;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-3382.799,-546.9646;Float;False;Constant;_Min;Min;7;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;3;-794.0833,-108.2354;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;29;438.8181,-702.3755;Inherit;False;1010.2;585.5681;Albedo;6;28;90;27;24;26;93;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-3379.421,-459.1345;Float;False;Constant;_Max;Max;9;0;Create;True;0;0;False;0;1.12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;69;-3541.516,-609.3167;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-739.0222,-249.6574;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;141;-3558.678,-287.0624;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;26;572.8464,-640.0615;Float;False;Property;_Tint;Tint;12;0;Create;True;0;0;False;0;0,0,0,0;0.5754716,0.4641774,0.4641774,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;71;-3186.871,-619.5925;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;80;-3274.752,-393.6235;Inherit;True;Property;_SpecMap;Spec Map;18;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;497.6761,-437.9059;Inherit;True;Property;_Albedo;Albedo;11;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;6;-731.5203,368.8746;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;2;-476.0887,-152.5096;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;5;-735.604,191.2234;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;857.8776,-516.7015;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-287.2713,-143.6544;Float;False;normal_lightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-2584.188,-370.3477;Float;False;Property;_SpecIntensity;Spec Intensity;17;0;Create;True;0;0;False;0;0.5;0.55;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;89;818.5583,-690.9894;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;7;-439.5192,291.28;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;-2895.317,-625.0815;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-291.212,282.9457;Float;False;normal_viewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;77;-2320.5,-396.6907;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1066.711,-628.6212;Float;False;Property;_ScaleAndOffset;Scale And Offset;9;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-2375.898,-594.9827;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-1035.002,-742.5982;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;58;-214.042,688.2211;Inherit;False;1742.358;685.106;Rim Light;22;153;54;157;158;159;160;162;44;42;49;53;59;51;57;52;50;48;47;46;45;43;161;Rim Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;1010.803,-401.1811;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-164.042,738.2211;Inherit;False;9;normal_viewDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1086.811,-808.8864;Inherit;False;1234.996;448.3327;Shadow;1;13;Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-2100.585,-546.0007;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;1215.27,-389.6117;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;16;-777.2596,-551.8748;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-155.5166,861.8408;Float;False;Property;_RimOffset;Rim Offset;13;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-480.2823,-738.0271;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-559.5604,-622.2703;Inherit;True;Property;_ToonRamp;Toon Ramp;7;0;Create;True;0;0;False;0;None;65f561815c2c2ca44a74029faa863168;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;-1909.724,-503.7756;Float;False;Spec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;87.45969,768.0603;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-358.4609,-403.2377;Inherit;False;Property;_ToonIntensity;Toon Intensity;19;0;Create;True;0;0;False;0;0;0.223;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;157;32.45058,1231.626;Inherit;False;78;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;162;-16.96198,1053.939;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;-154.4818,1304.835;Inherit;False;Property;_LightWrap;Light Wrap;21;0;Create;True;0;0;False;0;0;1.5;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;28.64761,1148.272;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-243.9948,-689.4905;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;45;232.3934,765.9291;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;160;-42.85236,1260.657;Inherit;False;Property;_Metallic;Metallic?;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;46;398.6401,763.7978;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;138;-168.7609,-573.7377;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;158;336.7477,1141.773;Inherit;False;BlinnPhongLightWrap;-1;;7;139fed909c1bc1a42a96c42d8cf09006;0;5;1;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;44;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;47;285.6777,891.6802;Float;False;Property;_RimPower;Rim Power;14;0;Create;True;0;0;False;0;0;0.498;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;94.39932,979.4916;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;174;-4143.67,504.9733;Inherit;False;2663.875;1794.667;Comment;25;123;122;121;124;125;133;126;128;135;134;129;136;130;131;170;165;169;171;168;164;166;172;167;163;173;Cutoff Noise Filter;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-47.24852,-675.5132;Float;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;153;571.6541,959.2341;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;48;611.7776,829.8701;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;78.21757,353.8435;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightAttenuation;38;345.6186,405.9345;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;123;-3335.874,1054.274;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;832.9702,853.1619;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;37;316.1005,320.8524;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;121;-3392.948,880.8334;Inherit;False;Property;_Speed;Speed;8;0;Create;True;0;0;False;0;0.1,0.1;0.05,0.05;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;122;-3212.198,777.3983;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;32;323.5833,11.16708;Inherit;False;14;Shadow;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;33;353.1364,144.1549;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightColorNode;50;771.5756,985.485;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;52;789.5577,1164.727;Float;False;Property;_RimTint;Rim Tint;16;0;Create;True;0;0;False;0;0.1131185,0.7239776,0.7735849,0;1,0.5928926,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;125;-3060.275,963.2734;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;993.5967,987.6664;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;586.9748,260.0797;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TexturePropertyNode;124;-3103.675,554.9733;Inherit;True;Property;_DissolveTexture;Dissolve Texture;3;0;Create;True;0;0;False;0;bcb8a8d20459e6349bf5cfce27e04e22;bcb8a8d20459e6349bf5cfce27e04e22;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;593.0676,75.03902;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;59;975.8173,856.8246;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexColorNode;133;-2488.626,1205.563;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1118.665,856.8245;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-2460.494,1403.399;Inherit;False;Property;_CutoffRamp;Cutoff Ramp;6;0;Create;True;0;0;False;0;0;1.43;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;134;-2221.396,1149.995;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;126;-2789.146,851.7074;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;128;-2763.324,1066.383;Inherit;False;Property;_UVLerp;UVLerp;4;0;Create;True;0;0;False;0;0.12;0.463;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;744.085,173.2609;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;894.144,170.664;Float;False;Light;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;19;1761.239,1112.145;Inherit;False;893.8208;562.6921;Output;8;99;132;88;140;79;60;15;61;Output;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;1285.316,851.8781;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;129;-2389.448,807.5062;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-2068.127,1229.694;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1773.92,1261.703;Inherit;False;35;Light;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;130;-1973.083,1008.861;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;1785.209,1346.268;Inherit;False;49;RimLight;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;1997.348,1338.621;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;2054.529,1554.195;Inherit;False;78;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;-1728.463,1052.175;Inherit;False;TextureMask;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;170;-2717.758,1899.062;Inherit;True;Screen;True;3;0;FLOAT;0;False;1;FLOAT;0.9811321;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;2188.44,1392.488;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;2157.22,1266.202;Inherit;False;131;TextureMask;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;173;-3168.881,1881.66;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;171;-2434.22,1796.885;Inherit;False;NoiseTex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;169;-2892.752,1697.221;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;172;-3690.669,2184.641;Inherit;False;InstancedProperty;_FadeSlider;Fade Slider;2;0;Create;True;0;0;False;0;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;1174.576,-616.2228;Float;False;VertColAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;167;-3197.871,1752.47;Inherit;False;2;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;165;-3544.838,1638.995;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;False;0;None;bcb8a8d20459e6349bf5cfce27e04e22;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;164;-3825.149,1640.558;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;168;-3503.038,1875.695;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;5,1;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;2179.007,1155.638;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;163;-4093.67,1897.381;Inherit;False;Property;_Vector2;Vector 2;5;0;Create;True;0;0;False;0;0,0;2,7;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;166;-3838.738,1905.495;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,25;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;99;2419.264,1157.546;Half;False;True;7;ASEMaterialInspector;0;0;CustomLighting;Skull Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;0;1;False;-1;10;False;-1;0;1;False;-1;10;False;-1;0;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;36;16.60074,-38.83282;Inherit;False;1091.024;661.9529;Light Color;0;Light Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;10;-1090.413,-299.6574;Inherit;False;1063.142;404.1316;Normal.LightDir;0;Normal Light Direction;1,1,1,1;0;0
WireConnection;21;0;20;0
WireConnection;65;0;66;0
WireConnection;63;0;62;0
WireConnection;63;1;64;1
WireConnection;67;0;63;0
WireConnection;67;1;65;0
WireConnection;69;0;67;0
WireConnection;69;1;68;0
WireConnection;1;0;22;0
WireConnection;71;0;69;0
WireConnection;71;1;70;0
WireConnection;71;2;72;0
WireConnection;80;1;141;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;5;0;23;0
WireConnection;27;0;26;0
WireConnection;27;1;24;0
WireConnection;8;0;2;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;81;0;71;0
WireConnection;81;1;80;0
WireConnection;9;0;7;0
WireConnection;74;0;81;0
WireConnection;74;1;75;0
WireConnection;90;0;89;0
WireConnection;90;1;27;0
WireConnection;76;0;74;0
WireConnection;76;1;77;0
WireConnection;28;0;90;0
WireConnection;16;0;12;0
WireConnection;16;1;17;0
WireConnection;16;2;17;0
WireConnection;13;1;16;0
WireConnection;78;0;76;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;31;0;30;0
WireConnection;31;1;13;0
WireConnection;45;0;43;0
WireConnection;46;0;45;0
WireConnection;138;0;31;0
WireConnection;138;1;137;0
WireConnection;158;1;162;0
WireConnection;158;4;159;0
WireConnection;158;2;157;0
WireConnection;158;3;160;0
WireConnection;158;44;161;0
WireConnection;14;0;138;0
WireConnection;153;0;158;0
WireConnection;153;1;54;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;57;0;48;0
WireConnection;57;1;153;0
WireConnection;37;0;40;0
WireConnection;125;0;122;0
WireConnection;125;2;121;0
WireConnection;125;1;123;0
WireConnection;51;0;50;0
WireConnection;51;1;52;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;59;0;57;0
WireConnection;53;0;59;0
WireConnection;53;1;51;0
WireConnection;134;0;133;4
WireConnection;126;0;124;0
WireConnection;126;1;125;0
WireConnection;41;0;34;0
WireConnection;41;1;39;0
WireConnection;35;0;41;0
WireConnection;49;0;53;0
WireConnection;129;0;122;0
WireConnection;129;1;126;1
WireConnection;129;2;128;0
WireConnection;136;0;134;0
WireConnection;136;1;135;0
WireConnection;130;0;129;0
WireConnection;130;1;136;0
WireConnection;61;0;60;0
WireConnection;61;1;15;0
WireConnection;131;0;130;0
WireConnection;170;0;167;0
WireConnection;170;1;168;0
WireConnection;170;2;169;0
WireConnection;88;0;61;0
WireConnection;88;1;79;0
WireConnection;173;1;172;0
WireConnection;171;0;170;0
WireConnection;169;0;167;0
WireConnection;169;1;168;0
WireConnection;93;0;89;3
WireConnection;167;0;165;0
WireConnection;165;1;164;0
WireConnection;168;0;166;0
WireConnection;166;0;163;0
WireConnection;99;0;140;0
WireConnection;99;10;132;0
WireConnection;99;13;88;0
ASEEND*/
//CHKSM=B0D5F8AA7C372C1807F41B4E73E3AE7250E75347