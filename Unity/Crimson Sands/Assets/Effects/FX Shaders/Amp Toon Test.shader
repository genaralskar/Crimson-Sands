// Upgrade NOTE: upgraded instancing buffer 'SmokeNoiseToon' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Smoke Noise Toon"
{
	Properties
	{
		_NoiseTexture("Noise Texture", 2D) = "white" {}
		_FadeSlider("Fade Slider", Range( 0 , 5)) = 1.231126
		_Cutoff( "Mask Clip Value", Float ) = 0.1
		_NoiseGenerator1("Noise Generator", Vector) = (1,0.1,0,0)
		_NoiseGenerator("Noise Generator", Vector) = (0.1,2,0,0)
		_CutoffRamp("Cutoff Ramp", Range( 0 , 2)) = 0
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_ScaleAndOffset("Scale And Offset", Range( 0 , 1)) = 0.5
		_Normal("Normal", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_Tint("Tint", Color) = (0,0,0,0)
		_RimOffset("Rim Offset", Float) = 1
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_SpecCoverage("Spec Coverage", Range( 0 , 2)) = 0.5
		_RimTint("Rim Tint", Color) = (0.1131185,0.7239776,0.7735849,0)
		_Metallic("Metallic?", Range( 0 , 1)) = 0
		_SpecIntensity("Spec Intensity", Range( 0 , 1)) = 0.5
		_LightWrap("Light Wrap", Range( 0 , 10)) = 0
		_SpecMap("Spec Map", 2D) = "white" {}
		_Float4("Float 4", Range( 0 , 1)) = 0
		_Speed1("Speed", Range( 0 , 1)) = 0.6420124
		_Length("Length", Float) = 0
		_Offset("Offset", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" }
		Cull Front
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
			float eyeDepth;
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
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

		uniform float _Length;
		uniform float _Offset;
		uniform sampler2D _NoiseTexture;
		uniform float2 _NoiseGenerator1;
		uniform float2 _NoiseGenerator;
		uniform float _FadeSlider;
		uniform float _CutoffRamp;
		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform sampler2D _ToonRamp;
		uniform float _ScaleAndOffset;
		uniform sampler2D _Normal;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float _LightWrap;
		uniform float _Float4;
		uniform float _Metallic;
		uniform float _SpecCoverage;
		uniform sampler2D _SpecMap;
		uniform float _SpecIntensity;
		uniform float4 _RimTint;
		uniform float _Cutoff = 0.1;

		UNITY_INSTANCING_BUFFER_START(SmokeNoiseToon)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Albedo_ST)
#define _Albedo_ST_arr SmokeNoiseToon
			UNITY_DEFINE_INSTANCED_PROP(float4, _Normal_ST)
#define _Normal_ST_arr SmokeNoiseToon
			UNITY_DEFINE_INSTANCED_PROP(float4, _SpecMap_ST)
#define _SpecMap_ST_arr SmokeNoiseToon
			UNITY_DEFINE_INSTANCED_PROP(float, _Speed1)
#define _Speed1_arr SmokeNoiseToon
		UNITY_INSTANCING_BUFFER_END(SmokeNoiseToon)


		//https://www.shadertoy.com/view/XdXGW8
		float2 GradientNoiseDir( float2 x )
		{
			const float2 k = float2( 0.3183099, 0.3678794 );
			x = x * k + k.yx;
			return -1.0 + 2.0 * frac( 16.0 * k * frac( x.x * x.y * ( x.x + x.y ) ) );
		}
		
		float GradientNoise( float2 UV, float Scale )
		{
			float2 p = UV * Scale;
			float2 i = floor( p );
			float2 f = frac( p );
			float2 u = f * f * ( 3.0 - 2.0 * f );
			return lerp( lerp( dot( GradientNoiseDir( i + float2( 0.0, 0.0 ) ), f - float2( 0.0, 0.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 0.0 ) ), f - float2( 1.0, 0.0 ) ), u.x ),
					lerp( dot( GradientNoiseDir( i + float2( 0.0, 1.0 ) ), f - float2( 0.0, 1.0 ) ),
					dot( GradientNoiseDir( i + float2( 1.0, 1.0 ) ), f - float2( 1.0, 1.0 ) ), u.x ), u.y );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
		}

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
			float cameraDepthFade237 = (( i.eyeDepth -_ProjectionParams.y - _Offset ) / _Length);
			float _Speed1_Instance = UNITY_ACCESS_INSTANCED_PROP(_Speed1_arr, _Speed1);
			float mulTime226 = _Time.y * _Speed1_Instance;
			float2 temp_cast_0 = (_Speed1_Instance).xx;
			float2 panner227 = ( mulTime226 * temp_cast_0 + float2( 0,0 ));
			float2 uv_TexCoord210 = i.uv_texcoord + panner227;
			float grayscale215 = (tex2D( _NoiseTexture, uv_TexCoord210 ).rgb.r + tex2D( _NoiseTexture, uv_TexCoord210 ).rgb.g + tex2D( _NoiseTexture, uv_TexCoord210 ).rgb.b) / 3;
			float2 _HoritontalMovement1 = float2(1,0);
			float mulTime229 = _Time.y * _HoritontalMovement1.x;
			float2 panner231 = ( mulTime229 * _HoritontalMovement1 + float2( 0,0 ));
			float2 uv_TexCoord232 = i.uv_texcoord * _NoiseGenerator1 + panner231;
			float gradientNoise233 = GradientNoise(uv_TexCoord232,1.0);
			gradientNoise233 = gradientNoise233*0.5 + 0.5;
			float2 _HoritontalMovement = float2(0,1);
			float mulTime221 = _Time.y * _HoritontalMovement.x;
			float2 panner218 = ( mulTime221 * _HoritontalMovement + float2( 0,0 ));
			float2 uv_TexCoord209 = i.uv_texcoord * _NoiseGenerator + panner218;
			float gradientNoise211 = GradientNoise(uv_TexCoord209,1.0);
			gradientNoise211 = gradientNoise211*0.5 + 0.5;
			float blendOpSrc217 = grayscale215;
			float blendOpDest217 = ( gradientNoise233 * gradientNoise211 );
			float lerpBlendMode217 = lerp(blendOpDest217,(( blendOpDest217 > 0.5 ) ? ( 1.0 - 2.0 * ( 1.0 - blendOpDest217 ) * ( 1.0 - blendOpSrc217 ) ) : ( 2.0 * blendOpDest217 * blendOpSrc217 ) ),_FadeSlider);
			float NoiseTex189 = ( saturate( lerpBlendMode217 ));
			float TextureMask131 = ( cameraDepthFade237 + ( NoiseTex189 - ( ( 1.0 - i.vertexColor.a ) * _CutoffRamp ) ) );
			float4 _Albedo_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Albedo_ST_arr, _Albedo_ST);
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST_Instance.xy + _Albedo_ST_Instance.zw;
			float4 Albedo28 = ( i.vertexColor * ( _Tint * tex2D( _Albedo, uv_Albedo ) ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult2 = dot( ase_worldNormal , ase_worldlightDir );
			float normal_lightDir8 = dotResult2;
			float2 temp_cast_5 = ((normal_lightDir8*_ScaleAndOffset + _ScaleAndOffset)).xx;
			float4 Shadow14 = ( Albedo28 * tex2D( _ToonRamp, temp_cast_5 ) );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			float4 _Normal_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_Normal_ST_arr, _Normal_ST);
			float2 uv_Normal = i.uv_texcoord * _Normal_ST_Instance.xy + _Normal_ST_Instance.zw;
			float4 NormalMap21 = tex2D( _Normal, uv_Normal );
			UnityGI gi37 = gi;
			float3 diffNorm37 = WorldNormalVector( i , NormalMap21.rgb );
			gi37 = UnityGI_Base( data, 1, diffNorm37 );
			float3 indirectDiffuse37 = gi37.indirect.diffuse + diffNorm37 * 0.0001;
			float4 Light35 = ( ( Shadow14 * ase_lightColor ) * float4( ( indirectDiffuse37 + ase_lightAtten ) , 0.0 ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult7 = dot( ase_worldNormal , ase_worldViewDir );
			float normal_viewDir9 = dotResult7;
			float3 LightWrapVector47_g7 = (( _LightWrap * 0.5 )).xxx;
			float3 CurrentNormal23_g7 = normalize( (WorldNormalVector( i , NormalMap21.rgb )) );
			float dotResult20_g7 = dot( CurrentNormal23_g7 , ase_worldlightDir );
			float NDotL21_g7 = dotResult20_g7;
			float3 AttenuationColor8_g7 = ( ase_lightColor.rgb * ase_lightAtten );
			float3 temp_cast_9 = (( ase_lightAtten / _Float4 )).xxx;
			float3 DiffuseColor70_g7 = ( ( ( max( ( LightWrapVector47_g7 + ( ( 1.0 - LightWrapVector47_g7 ) * NDotL21_g7 ) ) , float3(0,0,0) ) * AttenuationColor8_g7 ) + (UNITY_LIGHTMODEL_AMBIENT).rgb ) * temp_cast_9 );
			float3 normalizeResult77_g7 = normalize( _WorldSpaceLightPos0.xyz );
			float3 normalizeResult28_g7 = normalize( ( normalizeResult77_g7 + ase_worldViewDir ) );
			float3 HalfDirection29_g7 = normalizeResult28_g7;
			float dotResult32_g7 = dot( HalfDirection29_g7 , CurrentNormal23_g7 );
			float SpecularPower14_g7 = exp2( ( ( _Metallic * 10.0 ) + 1.0 ) );
			float dotResult67 = dot( ( ase_worldViewDir + _WorldSpaceLightPos0.xyz ) , normalize( (WorldNormalVector( i , NormalMap21.rgb )) ) );
			float smoothstepResult71 = smoothstep( 1.1 , 1.12 , pow( dotResult67 , _SpecCoverage ));
			float4 _SpecMap_ST_Instance = UNITY_ACCESS_INSTANCED_PROP(_SpecMap_ST_arr, _SpecMap_ST);
			float2 uv_SpecMap = i.uv_texcoord * _SpecMap_ST_Instance.xy + _SpecMap_ST_Instance.zw;
			float4 Spec78 = ( ( ( smoothstepResult71 * tex2D( _SpecMap, uv_SpecMap ) ) * _SpecIntensity ) * ase_lightAtten );
			float3 specularFinalColor42_g7 = ( AttenuationColor8_g7 * pow( max( dotResult32_g7 , 0.0 ) , SpecularPower14_g7 ) * Spec78.r );
			float4 RimLight49 = ( float4( saturate( ( pow( ( 1.0 - saturate( ( normal_viewDir9 + _RimOffset ) ) ) , _RimPower ) * ( normal_lightDir8 + ( DiffuseColor70_g7 + specularFinalColor42_g7 ) ) ) ) , 0.0 ) * ( ase_lightColor * _RimTint ) );
			c.rgb = ( ( ( Albedo28 + Light35 ) + RimLight49 ) + Spec78 ).rgb;
			c.a = 1;
			clip( TextureMask131 - _Cutoff );
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
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows vertex:vertexDataFunc 

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
				float3 customPack1 : TEXCOORD1;
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
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.x = customInputData.eyeDepth;
				o.customPack1.yz = customInputData.uv_texcoord;
				o.customPack1.yz = v.texcoord;
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
				surfIN.eyeDepth = IN.customPack1.x;
				surfIN.uv_texcoord = IN.customPack1.yz;
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
0;522.6667;1476;599;-246.839;-3114.31;1.364664;True;True
Node;AmplifyShaderEditor.SamplerNode;20;-1000.742,609.8088;Inherit;True;Property;_Normal;Normal;10;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-679.4219,617.0703;Float;False;NormalMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;87;-1078.975,1582.074;Inherit;False;2576.032;1040.895;Spec;18;64;62;66;63;65;67;68;69;72;70;80;71;81;77;74;76;78;75;Specularity;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;64;-999.2842,1812.233;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;66;-1028.975,2024.757;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;62;-941.5972,1632.074;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;65;-812.7785,2023.07;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-707.9866,1715.783;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-570.2838,1895.684;Float;False;Property;_SpecCoverage;Spec Coverage;16;0;Create;True;0;0;False;0;0.5;1.33;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;67;-551.7044,1760.561;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;10;-1090.413,-299.6574;Inherit;False;1063.142;404.1316;Normal.LightDir;5;8;2;1;3;22;Normal Light Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1090.446,141.2234;Inherit;False;1064.234;402.6019;Normal.ViewDir;5;6;5;9;7;23;Normal View Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-219.017,1839.804;Float;False;Constant;_Min;Min;7;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-739.0222,-249.6574;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;72;-215.639,1927.634;Float;False;Constant;_Max;Max;9;0;Create;True;0;0;False;0;1.12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;29;558.5024,-702.3755;Inherit;False;849.7145;490.3647;Albedo;5;26;24;28;27;90;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;3;-772.8171,-64.18403;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PowerNode;69;-377.7347,1777.452;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;6;-723.5203,368.8746;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SamplerNode;80;-110.9701,1993.145;Inherit;True;Property;_SpecMap;Spec Map;21;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;71;-23.08953,1767.176;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;2;-476.0887,-152.5096;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;497.6761,-437.9059;Inherit;True;Property;_Albedo;Albedo;12;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;5;-727.604,191.2234;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ColorNode;26;572.8464,-640.0615;Float;False;Property;_Tint;Tint;13;0;Create;True;0;0;False;0;0,0,0,0;0.735849,0.5622997,0.5622997,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;75;579.5939,2016.421;Float;False;Property;_SpecIntensity;Spec Intensity;19;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;89;764.1563,-870.5159;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;7;-431.5192,291.28;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;857.8776,-516.7015;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1086.811,-808.8864;Inherit;False;1234.996;448.3327;Shadow;7;17;12;14;13;16;30;31;Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-287.2713,-143.6544;Float;False;normal_lightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;268.4644,1761.687;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;77;843.2814,1990.078;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;1021.683,-569.8273;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-283.212,282.9457;Float;False;normal_viewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;58;-214.042,688.2211;Inherit;False;1742.358;685.106;Rim Light;23;44;42;43;45;46;47;48;51;50;53;57;52;54;49;59;138;142;143;144;146;147;149;150;Rim Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1036.811,-632.5211;Float;False;Property;_ScaleAndOffset;Scale And Offset;9;0;Create;True;0;0;False;0;0.5;0.419;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;234;-3449.362,3039.997;Inherit;False;Constant;_HoritontalMovement;Horitontal Movement;27;0;Create;True;0;0;False;0;0,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;787.8831,1791.786;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;235;-3516.934,2647.278;Inherit;False;Constant;_HoritontalMovement1;Horitontal Movement;27;0;Create;True;0;0;False;0;1,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;225;-3509.133,2359.2;Inherit;False;InstancedProperty;_Speed1;Speed;24;0;Create;True;0;0;False;0;0.6420124;0.721;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-967.4016,-734.7983;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;226;-3385.633,2454.1;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;1190.789,-509.2961;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleTimeNode;221;-3237.942,3234.07;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;229;-3230.521,2751.852;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;16;-759.0596,-650.6747;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-164.042,738.2211;Inherit;False;9;normal_viewDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-155.5166,861.8408;Float;False;Property;_RimOffset;Rim Offset;14;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;1063.196,1840.768;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-548.8008,-620.2831;Inherit;True;Property;_ToonRamp;Toon Ramp;6;0;Create;True;0;0;False;0;None;b0f67e5b0d50b994f99364a7803b1b8f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightAttenuation;142;-71.03381,952.7395;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;1254.057,1882.993;Float;False;Spec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;87.45969,768.0603;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;149;-9.055973,1020.744;Inherit;False;Property;_Float4;Float 4;22;0;Create;True;0;0;False;0;0;0.361;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;231;-3018.621,2660.851;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;218;-3029.923,3040.842;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;227;-3173.733,2363.1;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;230;-3022.437,2821.227;Inherit;False;Property;_NoiseGenerator1;Noise Generator;3;0;Create;True;0;0;False;0;1,0.1;1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;208;-3027.19,3225.231;Inherit;False;Property;_NoiseGenerator;Noise Generator;4;0;Create;True;0;0;False;0;0.1,2;0.1,2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;30;-478.2823,-737.0271;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;45;232.3934,765.9291;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-243.9948,-689.4905;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;144;-96.92422,1250.246;Inherit;False;Property;_Metallic;Metallic?;18;0;Create;True;0;0;False;0;0;0.157;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;232;-2738.855,2759.754;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,25;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;150;143.3104,979.7855;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;209;-2750.158,3139.745;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,25;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;146;-21.62129,1176.3;Inherit;False;78;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;145;-26.62428,1329.446;Inherit;False;Property;_LightWrap;Light Wrap;20;0;Create;True;0;0;False;0;0;3.96;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;210;-2837.68,2412.718;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;36;16.60074,-38.83282;Inherit;False;1091.024;661.9529;Light Color;9;41;35;40;39;38;37;34;32;33;Light Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;-25.42426,1092.946;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;211;-2436.903,3144.861;Inherit;True;Gradient;True;False;2;0;FLOAT2;5,1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;78.21757,353.8435;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;47;285.6777,891.6802;Float;False;Property;_RimPower;Rim Power;15;0;Create;True;0;0;False;0;0;0.64;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;147;282.6758,1086.447;Inherit;False;BlinnPhongLightWrap;-1;;7;139fed909c1bc1a42a96c42d8cf09006;0;5;1;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT;0;False;44;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;46;398.6401,763.7978;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;212;-2568.265,2400.258;Inherit;True;Property;_NoiseTexture;Noise Texture;0;0;Create;True;0;0;False;0;bcb8a8d20459e6349bf5cfce27e04e22;bcb8a8d20459e6349bf5cfce27e04e22;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;233;-2425.601,2764.87;Inherit;True;Gradient;True;False;2;0;FLOAT2;5,1;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;368.7731,998.7782;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-69.34851,-663.8133;Float;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;216;-2096.915,2822.344;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;-2584.63,3446.325;Inherit;False;Property;_FadeSlider;Fade Slider;1;0;Create;True;0;0;False;0;1.231126;2.3;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;48;611.7776,829.8701;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;215;-2230.074,2430.362;Inherit;False;2;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;33;353.1364,144.1549;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.LightAttenuation;38;345.6186,405.9345;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;37;316.1005,320.8524;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;323.5833,11.16708;Inherit;False;14;Shadow;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;138;612.8555,1069.755;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;52;789.5577,1164.727;Float;False;Property;_RimTint;Rim Tint;17;0;Create;True;0;0;False;0;0.1131185,0.7239776,0.7735849,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LightColorNode;50;827.4756,1017.985;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;39;586.9748,260.0797;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;832.9702,853.1619;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;593.0676,75.03902;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;133;758.0463,3709.144;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendOpsNode;217;-1743.288,2876.562;Inherit;True;Overlay;True;3;0;FLOAT;0;False;1;FLOAT;0.9811321;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;59;975.8173,856.8246;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;993.5967,987.6664;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;189;-1383.05,2801.685;Inherit;False;NoiseTex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;744.085,173.2609;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;135;786.1779,3906.979;Inherit;False;Property;_CutoffRamp;Cutoff Ramp;5;0;Create;True;0;0;False;0;0;1.26;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;134;1025.277,3653.575;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1118.665,856.8245;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;238;1015.145,3269.881;Inherit;False;Property;_Length;Length;26;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;178;817.0332,3508.027;Inherit;False;189;NoiseTex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;239;1017.874,3362.678;Inherit;False;Property;_Offset;Offset;27;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;1178.546,3733.274;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;894.144,170.664;Float;False;Light;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;130;1273.59,3512.441;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;237;1275.795,3265.787;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1652.673,1254.31;Inherit;False;35;Light;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;148;1610.953,1159.825;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;1285.316,851.8781;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;1773.209,1346.268;Inherit;False;49;RimLight;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;241;1424.544,3499.145;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;236;1852.297,1221.33;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;2054.529,1554.195;Inherit;False;78;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;19;2140.849,1112.145;Inherit;False;506.2102;482;Output;3;88;99;132;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;1621.924,3568.036;Inherit;False;TextureMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;1997.348,1338.621;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;194;-150.6665,4284.137;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;173;-96.14791,3968.671;Inherit;False;Property;_Color;Color;11;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WorldNormalVector;224;-1167.877,3502.505;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;169;-577.3989,3728.827;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotatorNode;203;-1306.463,3750.929;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendOpsNode;175;314.441,4096.377;Inherit;True;Darken;True;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;176;722.7156,4115.266;Inherit;False;myVarName;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;168;-267.7438,3455.509;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;93;1090.253,-790.3092;Float;False;VertColAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;165;-530.0498,3423.975;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;167;-958.9769,3873.224;Inherit;False;Property;_SliceDriver;Slice Driver;7;0;Create;True;0;0;False;0;-5;0.13;-5;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;174;-331.756,4475.382;Inherit;False;9;normal_viewDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;171;-129.1829,3728.024;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;2149.22,1266.202;Inherit;False;131;TextureMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;164;-616.5388,3492.233;Inherit;True;Property;_Noise;Noise;8;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;170;-223.3439,3622.636;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;192;-353.6048,4293.679;Inherit;False;Property;_LineStrength;Line Strength;23;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;193;-6.666473,4261.137;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-352.1473,4204.878;Inherit;False;189;NoiseTex;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;2188.44,1392.488;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;223;-2860.785,2201.705;Inherit;True;Property;_TextureSample0;Texture Sample 0;25;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1078.573,-230.0505;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1076.377,196.5013;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;172;125.302,3686.367;Inherit;False;myVarName;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;99;2411.264,1157.546;Float;False;True;7;ASEMaterialInspector;0;0;CustomLighting;Smoke Noise Toon;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;True;0;True;TransparentCutout;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;10;False;-1;0;1;False;-1;10;False;-1;0;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;2;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;21;0;20;0
WireConnection;65;0;66;0
WireConnection;63;0;62;0
WireConnection;63;1;64;1
WireConnection;67;0;63;0
WireConnection;67;1;65;0
WireConnection;69;0;67;0
WireConnection;69;1;68;0
WireConnection;71;0;69;0
WireConnection;71;1;70;0
WireConnection;71;2;72;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;9;0;7;0
WireConnection;8;0;2;0
WireConnection;27;0;26;0
WireConnection;27;1;24;0
WireConnection;8;0;2;0
WireConnection;81;0;71;0
WireConnection;81;1;80;0
WireConnection;90;0;89;0
WireConnection;90;1;27;0
WireConnection;9;0;7;0
WireConnection;74;0;81;0
WireConnection;74;1;75;0
WireConnection;226;0;225;0
WireConnection;28;0;90;0
WireConnection;221;0;234;0
WireConnection;229;0;235;0
WireConnection;16;0;12;0
WireConnection;16;1;17;0
WireConnection;16;2;17;0
WireConnection;76;0;74;0
WireConnection;76;1;77;0
WireConnection;13;1;16;0
WireConnection;78;0;76;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;231;2;235;0
WireConnection;231;1;229;0
WireConnection;218;2;234;0
WireConnection;218;1;221;0
WireConnection;227;2;225;0
WireConnection;227;1;226;0
WireConnection;45;0;43;0
WireConnection;31;0;30;0
WireConnection;31;1;13;0
WireConnection;232;0;230;0
WireConnection;232;1;231;0
WireConnection;150;0;142;0
WireConnection;150;1;149;0
WireConnection;209;0;208;0
WireConnection;209;1;218;0
WireConnection;210;1;227;0
WireConnection;211;0;209;0
WireConnection;147;1;150;0
WireConnection;147;4;143;0
WireConnection;147;2;146;0
WireConnection;147;3;144;0
WireConnection;147;44;145;0
WireConnection;46;0;45;0
WireConnection;212;1;210;0
WireConnection;233;0;232;0
WireConnection;14;0;31;0
WireConnection;216;0;233;0
WireConnection;216;1;211;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;215;0;212;0
WireConnection;37;0;40;0
WireConnection;138;0;54;0
WireConnection;138;1;147;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;57;0;48;0
WireConnection;57;1;138;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;217;0;215;0
WireConnection;217;1;216;0
WireConnection;217;2;213;0
WireConnection;59;0;57;0
WireConnection;51;0;50;0
WireConnection;51;1;52;0
WireConnection;189;0;217;0
WireConnection;41;0;34;0
WireConnection;41;1;39;0
WireConnection;134;0;133;4
WireConnection;53;0;59;0
WireConnection;53;1;51;0
WireConnection;136;0;134;0
WireConnection;136;1;135;0
WireConnection;35;0;41;0
WireConnection;130;0;178;0
WireConnection;130;1;136;0
WireConnection;237;0;238;0
WireConnection;237;1;239;0
WireConnection;49;0;53;0
WireConnection;241;0;237;0
WireConnection;241;1;130;0
WireConnection;236;0;148;0
WireConnection;236;1;60;0
WireConnection;131;0;241;0
WireConnection;61;0;236;0
WireConnection;61;1;15;0
WireConnection;194;0;190;0
WireConnection;194;1;192;0
WireConnection;169;0;224;0
WireConnection;169;1;167;0
WireConnection;175;1;193;0
WireConnection;176;0;175;0
WireConnection;168;0;165;0
WireConnection;168;1;164;0
WireConnection;93;0;89;3
WireConnection;171;0;170;0
WireConnection;170;0;168;0
WireConnection;170;1;169;0
WireConnection;193;0;194;0
WireConnection;193;1;174;0
WireConnection;88;0;61;0
WireConnection;88;1;79;0
WireConnection;172;0;171;0
WireConnection;99;10;132;0
WireConnection;99;13;88;0
ASEEND*/
//CHKSM=20211C5726332320C987BAED9AE5EFC546BD9C52