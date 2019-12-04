// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mitch Toon Shader"
{
	Properties
	{
		_ASEOutlineWidth( "Outline Width", Float ) = 0.02
		_ASEOutlineColor( "Outline Color", Color ) = (0,0,0,0)
		[Toggle]_AlphaCutoffOn("Alpha Cutoff On", Float) = 1
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_DissolveTexture("Dissolve Texture", 2D) = "white" {}
		_Albedo("Albedo", 2D) = "white" {}
		_CutoffRamp("Cutoff Ramp", Range( 0 , 2)) = 0
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_Speed("Speed", Vector) = (0.1,0.1,0,0)
		_ScaleAndOffset("Scale And Offset", Range( 0 , 1)) = 0.5
		[Normal]_Normal("Normal", 2D) = "white" {}
		_Tint("Tint", Color) = (0,0,0,0)
		_RimOffset("Rim Offset", Float) = 1
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_SpecCoverage("Spec Coverage", Range( 0 , 2)) = 0.5
		_RimTint("Rim Tint", Color) = (0.8301887,0.8183333,0.736205,1)
		[Toggle]_SpecOn("Spec On", Float) = 0
		_SpecIntensity("Spec Intensity", Range( 0 , 1)) = 0.5
		_SpecMap("Spec Map", 2D) = "white" {}
		_ToonIntensity("Toon Intensity", Range( 0 , 50)) = 5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline nofog  keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nometa noforwardadd vertex:outlineVertexDataFunc 
		uniform half4 _ASEOutlineColor;
		uniform half _ASEOutlineWidth;
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz *= ( 1 + _ASEOutlineWidth);
		}
		inline half4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return half4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o )
		{
			o.Emission = _ASEOutlineColor.rgb;
			o.Alpha = 1;
		}
		ENDCG
		

		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
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

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float _AlphaCutoffOn;
		uniform sampler2D _DissolveTexture;
		uniform float2 _Speed;
		uniform float _CutoffRamp;
		uniform float4 _Tint;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _ToonRamp;
		uniform float _ScaleAndOffset;
		uniform float _ToonIntensity;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float4 _RimTint;
		uniform float _SpecOn;
		uniform float _SpecCoverage;
		uniform sampler2D _SpecMap;
		uniform float4 _SpecMap_ST;
		uniform float _SpecIntensity;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_Normal = v.texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float4 NormalMap21 = tex2Dlod( _Normal, float4( uv_Normal, 0, 0.0) );
			v.normal = NormalMap21.rgb;
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
			float2 panner125 = ( _Time.y * _Speed + i.uv_texcoord);
			float TextureMask131 = lerp(0.0,( tex2D( _DissolveTexture, panner125 ).r - ( ( 1.0 - i.vertexColor.a ) * _CutoffRamp ) ),_AlphaCutoffOn);
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
			float2 temp_cast_1 = ((normal_lightDir8*_ScaleAndOffset + _ScaleAndOffset)).xx;
			float4 Shadow14 = ( ( Albedo28 * tex2D( _ToonRamp, temp_cast_1 ) ) * _ToonIntensity );
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
			float4 Spec78 = lerp(float4( 0,0,0,0 ),( ( ( smoothstepResult71 * tex2D( _SpecMap, uv_SpecMap ) ) * _SpecIntensity ) * ase_lightAtten ),_SpecOn);
			c.rgb = ( ( Light35 + RimLight49 ) + Spec78 ).rgb;
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
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 

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
				vertexDataFunc( v, customInputData );
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
107;231;1607;788;1216.199;-2772.847;1.33013;True;True
Node;AmplifyShaderEditor.SamplerNode;20;-1000.742,609.8088;Inherit;True;Property;_Normal;Normal;8;1;[Normal];Create;True;0;0;False;0;None;94babb0abefa0d141b987706c87c9ed3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-679.4219,617.0703;Float;False;NormalMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1078.573,-230.0505;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1076.377,196.5013;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;3;-794.0833,-108.2354;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;1;-739.0222,-249.6574;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;5;-727.604,191.2234;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;6;-723.5203,368.8746;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CommentaryNode;29;558.5024,-702.3755;Inherit;False;849.7145;490.3647;Albedo;1;89;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.DotProductOpNode;2;-476.0887,-152.5096;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;26;572.8464,-640.0615;Float;False;Property;_Tint;Tint;9;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;497.6761,-437.9059;Inherit;True;Property;_Albedo;Albedo;3;0;Create;True;0;0;False;0;None;a7d5f32113a415a4ea0526b14d7b0aa4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;7;-431.5192,291.28;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;89;822.3932,-684.5331;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;857.8776,-516.7015;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-287.2713,-143.6544;Float;False;normal_lightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;90;1021.683,-569.8273;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;12;-1035.002,-742.5982;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1066.711,-628.6212;Float;False;Property;_ScaleAndOffset;Scale And Offset;7;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-283.212,282.9457;Float;False;normal_viewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-164.042,738.2211;Inherit;False;9;normal_viewDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;1190.789,-509.2961;Float;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1086.811,-808.8864;Inherit;False;1234.996;448.3327;Shadow;1;13;Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-155.5166,861.8408;Float;False;Property;_RimOffset;Rim Offset;10;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-1028.975,2024.757;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;64;-999.2842,1812.233;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;62;-941.5972,1632.074;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ScaleAndOffsetNode;16;-777.2596,-551.8748;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-559.5604,-622.2703;Inherit;True;Property;_ToonRamp;Toon Ramp;5;0;Create;True;0;0;False;0;None;1403ffa56dbb037449d604b4c76d7f24;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-707.9866,1715.783;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-480.2823,-738.0271;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldNormalVector;65;-812.7785,2023.07;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;43;87.45969,768.0603;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;45;232.3934,765.9291;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;-358.4609,-403.2377;Inherit;False;Property;_ToonIntensity;Toon Intensity;17;0;Create;True;0;0;False;0;5;5;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;67;-551.7044,1760.561;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-243.9948,-689.4905;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-570.2838,1895.684;Float;False;Property;_SpecCoverage;Spec Coverage;12;0;Create;True;0;0;False;0;0.5;0.5;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightAttenuation;56;182.8331,1096.734;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;285.6777,891.6802;Float;False;Property;_RimPower;Rim Power;11;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;138;-168.7609,-573.7377;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-215.639,1927.634;Float;False;Constant;_Max;Max;9;0;Create;True;0;0;False;0;1.12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;69;-377.7347,1777.452;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;204.8096,999.6713;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-219.017,1839.804;Float;False;Constant;_Min;Min;7;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;46;398.6401,763.7978;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;40;78.21757,353.8435;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.PowerNode;48;611.7776,829.8701;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;552.7704,1036.299;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;80;-110.9701,1993.145;Inherit;True;Property;_SpecMap;Spec Map;16;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-47.24852,-675.5132;Float;False;Shadow;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;87;-1078.975,1582.074;Inherit;False;2576.032;1040.895;Spec;5;141;76;75;77;74;Specularity;1,1,1,1;0;0
Node;AmplifyShaderEditor.SmoothstepOpNode;71;-23.08953,1767.176;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;142;-1063.247,2732.067;Inherit;False;1963.152;1013.425;Alpha Cutoff;13;123;133;121;122;134;135;125;124;136;126;130;131;143;Alpha Cutoff;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;832.9702,853.1619;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;33;353.1364,144.1549;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleTimeNode;123;-956.1734,3281.367;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;268.4644,1761.687;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightColorNode;50;771.5756,985.485;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;122;-832.4972,3004.492;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;133;-108.9246,3432.656;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;121;-1013.247,3107.927;Inherit;False;Property;_Speed;Speed;6;0;Create;True;0;0;False;0;0.1,0.1;0.1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;75;302.6958,1988.088;Float;False;Property;_SpecIntensity;Spec Intensity;15;0;Create;True;0;0;False;0;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IndirectDiffuseLighting;37;316.1005,320.8524;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightAttenuation;38;345.6186,405.9345;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;323.5833,11.16708;Inherit;False;14;Shadow;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;52;789.5577,1164.727;Float;False;Property;_RimTint;Rim Tint;13;0;Create;True;0;0;False;0;0.8301887,0.8183333,0.736205,1;0.8301887,0.8183333,0.7362049,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;59;975.8173,856.8246;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;510.9852,1763.453;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-80.79298,3630.492;Inherit;False;Property;_CutoffRamp;Cutoff Ramp;4;0;Create;True;0;0;False;0;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;593.0676,75.03902;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;77;566.3834,1961.745;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;125;-680.5744,3190.367;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;134;158.3059,3377.088;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;124;-723.9742,2782.067;Inherit;True;Property;_DissolveTexture;Dissolve Texture;2;0;Create;True;0;0;False;0;bcb8a8d20459e6349bf5cfce27e04e22;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;993.5967,987.6664;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;586.9748,260.0797;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;311.5746,3456.787;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;744.085,173.2609;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;716.7515,1809.859;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;126;-409.445,3078.801;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1118.665,856.8245;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;130;406.6188,3235.955;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;141;1006.99,1846.153;Inherit;False;Property;_SpecOn;Spec On;14;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,1;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;1285.316,851.8781;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;894.144,170.664;Float;False;Light;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1773.92,1261.703;Inherit;False;35;Light;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;143;495.7812,3045.569;Inherit;False;Property;_AlphaCutoffOn;Alpha Cutoff On;0;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;1302.997,1863.675;Float;False;Spec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;1773.209,1346.268;Inherit;False;49;RimLight;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;1997.348,1338.621;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;651.2388,3279.268;Inherit;False;TextureMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;2054.529,1554.195;Inherit;False;78;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;2149.22,1266.202;Inherit;False;131;TextureMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;2188.44,1392.488;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;1814.835,1490.161;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;99;2411.264,1157.546;Float;False;True;7;ASEMaterialInspector;0;0;CustomLighting;Mitch Toon Shader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0.5;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;10;False;-1;0;1;False;-1;10;False;-1;0;False;-1;1;False;-1;0;True;0.02;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;10;-1090.413,-299.6574;Inherit;False;1063.142;404.1316;Normal.LightDir;0;Normal Light Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;58;-214.042,688.2211;Inherit;False;1742.358;685.106;Rim Light;0;Rim Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;36;16.60074,-38.83282;Inherit;False;1091.024;661.9529;Light Color;0;Light Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;19;2140.849,1112.145;Inherit;False;506.2102;482;Output;0;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;11;-1090.446,141.2234;Inherit;False;1064.234;402.6019;Normal.ViewDir;0;Normal View Direction;1,1,1,1;0;0
WireConnection;21;0;20;0
WireConnection;1;0;22;0
WireConnection;5;0;23;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;27;0;26;0
WireConnection;27;1;24;0
WireConnection;8;0;2;0
WireConnection;90;0;89;0
WireConnection;90;1;27;0
WireConnection;9;0;7;0
WireConnection;28;0;90;0
WireConnection;16;0;12;0
WireConnection;16;1;17;0
WireConnection;16;2;17;0
WireConnection;13;1;16;0
WireConnection;63;0;62;0
WireConnection;63;1;64;1
WireConnection;65;0;66;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;45;0;43;0
WireConnection;67;0;63;0
WireConnection;67;1;65;0
WireConnection;31;0;30;0
WireConnection;31;1;13;0
WireConnection;138;0;31;0
WireConnection;138;1;137;0
WireConnection;69;0;67;0
WireConnection;69;1;68;0
WireConnection;46;0;45;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;55;0;54;0
WireConnection;55;1;56;0
WireConnection;14;0;138;0
WireConnection;71;0;69;0
WireConnection;71;1;70;0
WireConnection;71;2;72;0
WireConnection;57;0;48;0
WireConnection;57;1;55;0
WireConnection;81;0;71;0
WireConnection;81;1;80;0
WireConnection;37;0;40;0
WireConnection;59;0;57;0
WireConnection;74;0;81;0
WireConnection;74;1;75;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;125;0;122;0
WireConnection;125;2;121;0
WireConnection;125;1;123;0
WireConnection;134;0;133;4
WireConnection;51;0;50;0
WireConnection;51;1;52;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;136;0;134;0
WireConnection;136;1;135;0
WireConnection;41;0;34;0
WireConnection;41;1;39;0
WireConnection;76;0;74;0
WireConnection;76;1;77;0
WireConnection;126;0;124;0
WireConnection;126;1;125;0
WireConnection;53;0;59;0
WireConnection;53;1;51;0
WireConnection;130;0;126;1
WireConnection;130;1;136;0
WireConnection;141;1;76;0
WireConnection;49;0;53;0
WireConnection;35;0;41;0
WireConnection;143;1;130;0
WireConnection;78;0;141;0
WireConnection;61;0;60;0
WireConnection;61;1;15;0
WireConnection;131;0;143;0
WireConnection;88;0;61;0
WireConnection;88;1;79;0
WireConnection;99;10;132;0
WireConnection;99;13;88;0
WireConnection;99;12;139;0
ASEEND*/
//CHKSM=D7888F1AD40A10688E5D5BC4C5A6D400CF670E1E