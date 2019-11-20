// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TriplanarToonTest"
{
	Properties
	{
		_ASEOutlineWidth( "Outline Width", Float ) = 10
		_ASEOutlineColor( "Outline Color", Color ) = (0,0,0,0)
		_Cutoff( "Mask Clip Value", Float ) = 0
		_DissolveTexture("Dissolve Texture", 2D) = "white" {}
		_CutoffRamp("Cutoff Ramp", Range( 0 , 2)) = 0
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		_Speed("Speed", Vector) = (0.1,0.1,0,0)
		_ScaleAndOffset("Scale And Offset", Range( 0 , 1)) = 0.5
		_RimOffset("Rim Offset", Float) = 1
		_RimPower("Rim Power", Range( 0 , 1)) = 0
		_SpecCoverage("Spec Coverage", Range( 0 , 2)) = 0.5
		_RimTint("Rim Tint", Color) = (0.1131185,0.7239776,0.7735849,0)
		_SpecIntensity("Spec Intensity", Range( 0 , 1)) = 0.5
		_SpecMap("Spec Map", 2D) = "white" {}
		_normaltriplanar("normal triplanar", 2D) = "white" {}
		_Texture0("Texture 0", 2D) = "white" {}
		_light_denominator("light_denominator", Range( 0 , 1)) = 1
		_lightatt("light att", Range( 0.001 , 1)) = 1
		[Toggle(_KEYWORD0_ON)] _Keyword0("Keyword 0", Float) = 1
		_triplanartiling("triplanar tiling", Vector) = (1,1,0,0)
		_uvtiling("uv tiling", Vector) = (1,1,0,0)
		_triplanarfalloff("triplanar falloff", Range( 0 , 50)) = 1
		_uvfalloff("uv falloff", Range( 0 , 50)) = 1
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
		#pragma shader_feature _KEYWORD0_ON
		#define ASE_TEXTURE_PARAMS(textureName) textureName

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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
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

		uniform sampler2D _Texture0;
		uniform float2 _triplanartiling;
		uniform float _triplanarfalloff;
		uniform sampler2D _DissolveTexture;
		uniform float2 _Speed;
		uniform float _CutoffRamp;
		uniform sampler2D _ToonRamp;
		uniform sampler2D _normaltriplanar;
		uniform float2 _uvtiling;
		uniform float _uvfalloff;
		uniform float _ScaleAndOffset;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float _light_denominator;
		uniform float4 _RimTint;
		uniform float _SpecCoverage;
		uniform sampler2D _SpecMap;
		uniform float4 _SpecMap_ST;
		uniform float _SpecIntensity;
		uniform float _lightatt;
		uniform float _Cutoff = 0;


		inline float4 TriplanarSamplingSF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			return xNorm * projNormal.x + yNorm * projNormal.y + zNorm * projNormal.z;
		}


		inline float3 TriplanarSamplingSNF( sampler2D topTexMap, float3 worldPos, float3 worldNormal, float falloff, float2 tiling, float3 normalScale, float3 index )
		{
			float3 projNormal = ( pow( abs( worldNormal ), falloff ) );
			projNormal /= ( projNormal.x + projNormal.y + projNormal.z ) + 0.00001;
			float3 nsign = sign( worldNormal );
			half4 xNorm; half4 yNorm; half4 zNorm;
			xNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.zy * float2( nsign.x, 1.0 ) ) );
			yNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xz * float2( nsign.y, 1.0 ) ) );
			zNorm = ( tex2D( ASE_TEXTURE_PARAMS( topTexMap ), tiling * worldPos.xy * float2( -nsign.z, 1.0 ) ) );
			xNorm.xyz = half3( UnpackNormal( xNorm ).xy * float2( nsign.x, 1.0 ) + worldNormal.zy, worldNormal.x ).zyx;
			yNorm.xyz = half3( UnpackNormal( yNorm ).xy * float2( nsign.y, 1.0 ) + worldNormal.xz, worldNormal.y ).xzy;
			zNorm.xyz = half3( UnpackNormal( zNorm ).xy * float2( -nsign.z, 1.0 ) + worldNormal.xy, worldNormal.z ).xyz;
			return normalize( xNorm.xyz * projNormal.x + yNorm.xyz * projNormal.y + zNorm.xyz * projNormal.z );
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
			float4 tex2DNode126 = tex2D( _DissolveTexture, panner125 );
			float TextureMask131 = ( tex2DNode126.r - ( ( 1.0 - i.vertexColor.a ) * _CutoffRamp ) );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar146 = TriplanarSamplingSF( _Texture0, ase_worldPos, ase_worldNormal, _triplanarfalloff, _triplanartiling, 1.0, 0 );
			float4 Albedo28 = triplanar146;
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3x3 ase_worldToTangent = float3x3( ase_worldTangent, ase_worldBitangent, ase_worldNormal );
			float3 triplanar182 = TriplanarSamplingSNF( _normaltriplanar, ase_worldPos, ase_worldNormal, _uvfalloff, _uvtiling, 1.0, 0 );
			float3 tanTriplanarNormal182 = mul( ase_worldToTangent, triplanar182 );
			float3 NormalMap21 = tanTriplanarNormal182;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float dotResult2 = dot( (WorldNormalVector( i , NormalMap21 )) , ase_worldlightDir );
			float normal_lightDir8 = dotResult2;
			float2 temp_cast_1 = ((normal_lightDir8*_ScaleAndOffset + _ScaleAndOffset)).xx;
			float4 Shadow14 = ( Albedo28 * tex2D( _ToonRamp, temp_cast_1 ) );
			#if defined(LIGHTMAP_ON) && ( UNITY_VERSION < 560 || ( defined(LIGHTMAP_SHADOW_MIXING) && !defined(SHADOWS_SHADOWMASK) && defined(SHADOWS_SCREEN) ) )//aselc
			float4 ase_lightColor = 0;
			#else //aselc
			float4 ase_lightColor = _LightColor0;
			#endif //aselc
			UnityGI gi37 = gi;
			float3 diffNorm37 = WorldNormalVector( i , NormalMap21 );
			gi37 = UnityGI_Base( data, 1, diffNorm37 );
			float3 indirectDiffuse37 = gi37.indirect.diffuse + diffNorm37 * 0.0001;
			float4 Light35 = ( ( Shadow14 * ase_lightColor ) * float4( ( indirectDiffuse37 + ase_lightAtten ) , 0.0 ) );
			float3 ase_worldViewDir = Unity_SafeNormalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult7 = dot( (WorldNormalVector( i , NormalMap21 )) , ase_worldViewDir );
			float normal_viewDir9 = dotResult7;
			float4 RimLight49 = ( saturate( ( pow( ( 1.0 - saturate( ( normal_viewDir9 + _RimOffset ) ) ) , _RimPower ) * ( normal_lightDir8 * ase_lightAtten ) ) ) * ( ( ase_lightColor / _light_denominator ) * _RimTint ) );
			float dotResult67 = dot( ( ase_worldViewDir + _WorldSpaceLightPos0.xyz ) , normalize( (WorldNormalVector( i , NormalMap21 )) ) );
			float smoothstepResult71 = smoothstep( 1.1 , 1.12 , pow( dotResult67 , _SpecCoverage ));
			float2 uv_SpecMap = i.uv_texcoord * _SpecMap_ST.xy + _SpecMap_ST.zw;
			#ifdef _KEYWORD0_ON
				float4 staticSwitch169 = ( ( ( smoothstepResult71 * tex2D( _SpecMap, uv_SpecMap ) ) * _SpecIntensity ) * ( ase_lightAtten / _lightatt ) );
			#else
				float4 staticSwitch169 = float4( 0,0,0,0 );
			#endif
			float4 Spec78 = staticSwitch169;
			c.rgb = ( ( Light35 + RimLight49 ) + Spec78 ).xyz;
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
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float4 triplanar146 = TriplanarSamplingSF( _Texture0, ase_worldPos, ase_worldNormal, _triplanarfalloff, _triplanartiling, 1.0, 0 );
			float4 Albedo28 = triplanar146;
			o.Albedo = Albedo28.xyz;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows exclude_path:deferred 

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
46;860;1743;890;2328.754;-383.0089;1.3;True;True
Node;AmplifyShaderEditor.TexturePropertyNode;180;-1591.732,852.3817;Inherit;True;Property;_normaltriplanar;normal triplanar;14;0;Create;True;0;0;False;0;84508b93f15f2b64386ec07486afc7a3;84508b93f15f2b64386ec07486afc7a3;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.WorldPosInputsNode;179;-1839.982,1021.613;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;181;-1382.305,1252.465;Inherit;False;Property;_uvfalloff;uv falloff;22;0;Create;True;0;0;False;0;1;0;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;178;-1590.305,1198.465;Inherit;False;Property;_uvtiling;uv tiling;20;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TriplanarNode;182;-1052.17,989.616;Inherit;True;Spherical;World;True;Top Texture 1;_TopTexture1;white;0;None;Mid Texture 1;_MidTexture1;white;1;None;Bot Texture 1;_BotTexture1;white;0;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;11;-1090.446,141.2234;Inherit;False;1064.234;402.6019;Normal.ViewDir;5;6;5;9;7;23;Normal View Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;10;-1090.413,-299.6574;Inherit;False;1063.142;404.1316;Normal.LightDir;5;8;2;1;3;22;Normal Light Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-679.4219,617.0703;Float;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;22;-1078.573,-230.0505;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;23;-1076.377,196.5013;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-739.0222,-249.6574;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;6;-723.5203,368.8746;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;3;-816.5764,-61.6744;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;5;-727.604,191.2234;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DotProductOpNode;2;-476.0887,-152.5096;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;7;-431.5192,291.28;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;29;558.5024,-702.3755;Inherit;False;849.7145;490.3647;Albedo;4;28;146;149;151;Albedo;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-1086.811,-808.8864;Inherit;False;1234.996;448.3327;Shadow;7;17;12;14;13;16;30;31;Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;171;581.5298,-275.5114;Inherit;False;Property;_triplanartiling;triplanar tiling;19;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;149;580.1024,-621.5951;Inherit;True;Property;_Texture0;Texture 0;15;0;Create;True;0;0;False;0;84508b93f15f2b64386ec07486afc7a3;84508b93f15f2b64386ec07486afc7a3;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;58;-214.042,688.2211;Inherit;False;1742.358;685.106;Rim Light;19;44;42;43;45;46;47;48;51;50;53;57;55;56;52;54;49;59;154;155;Rim Light;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;9;-283.212,282.9457;Float;False;normal_viewDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;87;-1078.975,1582.074;Inherit;False;2576.032;1040.895;Spec;21;64;62;66;63;65;67;68;69;72;70;80;71;81;77;74;76;78;75;161;162;169;Specularity;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;8;-287.2713,-143.6544;Float;False;normal_lightDir;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;151;537.1458,-432.2367;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;172;789.5298,-221.5114;Inherit;False;Property;_triplanarfalloff;triplanar falloff;21;0;Create;True;0;0;False;0;1;0;0;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldSpaceLightPos;64;-999.2842,1812.233;Inherit;False;0;3;FLOAT4;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;62;-941.5972,1632.074;Float;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;44;-155.5166,861.8408;Float;False;Property;_RimOffset;Rim Offset;8;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TriplanarNode;146;827.1544,-501.8041;Inherit;True;Spherical;World;False;Top Texture 0;_TopTexture0;white;0;None;Mid Texture 0;_MidTexture0;white;-1;None;Bot Texture 0;_BotTexture0;white;-1;None;Triplanar Sampler;False;10;0;SAMPLER2D;;False;5;FLOAT;1;False;1;SAMPLER2D;;False;6;FLOAT;0;False;2;SAMPLER2D;;False;7;FLOAT;0;False;9;FLOAT3;0,0,0;False;8;FLOAT;1;False;3;FLOAT2;1,1;False;4;FLOAT;1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;12;-967.4016,-734.7983;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;42;-164.042,738.2211;Inherit;False;9;normal_viewDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;66;-1028.975,2024.757;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-1036.811,-632.5211;Float;False;Property;_ScaleAndOffset;Scale And Offset;6;0;Create;True;0;0;False;0;0.5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;28;1209.149,-590.6019;Float;False;Albedo;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;87.45969,768.0603;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;16;-759.0596,-650.6747;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;65;-812.7785,2023.07;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;63;-707.9866,1715.783;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;45;232.3934,765.9291;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;30;-478.2823,-737.0271;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;68;-570.2838,1895.684;Float;False;Property;_SpecCoverage;Spec Coverage;10;0;Create;True;0;0;False;0;0.5;1.041;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;67;-551.7044,1760.561;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;13;-548.8008,-620.2831;Inherit;True;Property;_ToonRamp;Toon Ramp;4;0;Create;True;0;0;False;0;None;3010f7ad2fa61e3439b5260105434762;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;47;285.6777,891.6802;Float;False;Property;_RimPower;Rim Power;9;0;Create;True;0;0;False;0;0;0.168;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;54;2.471196,976.174;Inherit;False;8;normal_lightDir;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;46;398.6401,763.7978;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;36;16.60074,-38.83282;Inherit;False;1091.024;661.9529;Light Color;9;41;35;40;39;38;37;34;32;33;Light Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.LightAttenuation;56;-28.64314,1078.458;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-219.017,1839.804;Float;False;Constant;_Min;Min;7;0;Create;True;0;0;False;0;1.1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;69;-377.7347,1777.452;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;72;-215.639,1927.634;Float;False;Constant;_Max;Max;9;0;Create;True;0;0;False;0;1.12;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-243.9948,-689.4905;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;155;596.2672,1109.742;Inherit;False;Property;_light_denominator;light_denominator;16;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;71;-23.08953,1767.176;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;14;-69.34851,-663.8133;Float;False;Shadow;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PowerNode;48;611.7776,829.8701;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;366.0969,1001.053;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;80;-110.9701,1993.145;Inherit;True;Property;_SpecMap;Spec Map;13;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;40;78.21757,353.8435;Inherit;False;21;NormalMap;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LightColorNode;50;650.3211,989.8336;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.IndirectDiffuseLighting;37;316.1005,320.8524;Inherit;False;Tangent;1;0;FLOAT3;0,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;75;475.5939,1962.421;Float;False;Property;_SpecIntensity;Spec Intensity;12;0;Create;True;0;0;False;0;0.5;0.523;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;161;741.1863,2111.329;Inherit;False;Property;_lightatt;light att;17;0;Create;True;0;0;False;0;1;1;0.001;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LightColorNode;33;353.1364,144.1549;Inherit;False;0;3;COLOR;0;FLOAT3;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;268.4644,1761.687;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LightAttenuation;77;773.2814,2018.078;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;52;730.6279,1202.584;Float;False;Property;_RimTint;Rim Tint;11;0;Create;True;0;0;False;0;0.1131185,0.7239776,0.7735849,0;0.9245283,0.8678355,0.871885,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;154;880.8462,953.0927;Inherit;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;832.9702,853.1619;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;32;323.5833,11.16708;Inherit;False;14;Shadow;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LightAttenuation;38;345.6186,405.9345;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;59;975.8173,856.8246;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;122;-734.7694,2900.274;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;162;1027.186,2028.329;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;787.8831,1791.786;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;121;-1032.319,2997.309;Inherit;False;Property;_Speed;Speed;5;0;Create;True;0;0;False;0;0.1,0.1;0.05,0.05;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;39;586.9748,260.0797;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;123;-975.2454,3170.749;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;593.0676,75.03902;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;133;-127.9968,3322.038;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;993.5967,987.6664;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-99.86516,3519.874;Inherit;False;Property;_CutoffRamp;Cutoff Ramp;3;0;Create;True;0;0;False;0;0;1.06;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;125;-699.6465,3079.749;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.1,0.1;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;124;-743.0463,2671.449;Inherit;True;Property;_DissolveTexture;Dissolve Texture;1;0;Create;True;0;0;False;0;bcb8a8d20459e6349bf5cfce27e04e22;bcb8a8d20459e6349bf5cfce27e04e22;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;1118.665,856.8245;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;744.085,173.2609;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.OneMinusNode;134;139.2338,3266.47;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;1063.196,1840.768;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;292.5024,3346.169;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;894.144,170.664;Float;False;Light;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;169;1215.27,1968.718;Inherit;False;Property;_Keyword0;Keyword 0;18;0;Create;True;0;0;False;0;0;1;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;126;-428.5172,2968.183;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;49;1285.316,851.8781;Float;False;RimLight;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;1773.209,1346.268;Inherit;False;49;RimLight;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;1773.92,1261.703;Inherit;False;35;Light;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;78;1375.057,1880.993;Float;False;Spec;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;130;387.5466,3125.337;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;632.1667,3168.65;Inherit;False;TextureMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;1997.348,1338.621;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;19;2140.849,1112.145;Inherit;False;506.2102;482;Output;4;88;99;132;153;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;79;1954.297,1501.215;Inherit;False;78;Spec;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;2149.22,1266.202;Inherit;False;131;TextureMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;88;2188.44,1392.488;Inherit;True;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;177;-1768.01,609.3332;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;-1455.719,605.8121;Inherit;True;Property;_Normal;Normal;7;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;129;-28.81836,2923.982;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;2208.93,1188.5;Inherit;False;28;Albedo;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-1016.276,800.0035;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;175;-1269.105,883.0413;Inherit;False;Property;_normalintensity;normal intensity;23;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;128;-402.6953,3182.858;Inherit;False;Property;_UVLerp;UVLerp;2;0;Create;True;0;0;False;0;0.12;0.19;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;176;-900.475,717.337;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;99;2411.264,1157.546;Float;False;True;7;ASEMaterialInspector;0;0;CustomLighting;TriplanarToonTest;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;;AlphaTest;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;1;False;-1;10;False;-1;0;1;False;-1;10;False;-1;0;False;-1;1;False;-1;0;True;10;0,0,0,0;VertexScale;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;182;0;180;0
WireConnection;182;9;179;0
WireConnection;182;3;178;0
WireConnection;182;4;181;0
WireConnection;21;0;182;0
WireConnection;1;0;22;0
WireConnection;5;0;23;0
WireConnection;2;0;1;0
WireConnection;2;1;3;0
WireConnection;7;0;5;0
WireConnection;7;1;6;0
WireConnection;9;0;7;0
WireConnection;8;0;2;0
WireConnection;146;0;149;0
WireConnection;146;9;151;0
WireConnection;146;3;171;0
WireConnection;146;4;172;0
WireConnection;28;0;146;0
WireConnection;43;0;42;0
WireConnection;43;1;44;0
WireConnection;16;0;12;0
WireConnection;16;1;17;0
WireConnection;16;2;17;0
WireConnection;65;0;66;0
WireConnection;63;0;62;0
WireConnection;63;1;64;1
WireConnection;45;0;43;0
WireConnection;67;0;63;0
WireConnection;67;1;65;0
WireConnection;13;1;16;0
WireConnection;46;0;45;0
WireConnection;69;0;67;0
WireConnection;69;1;68;0
WireConnection;31;0;30;0
WireConnection;31;1;13;0
WireConnection;71;0;69;0
WireConnection;71;1;70;0
WireConnection;71;2;72;0
WireConnection;14;0;31;0
WireConnection;48;0;46;0
WireConnection;48;1;47;0
WireConnection;55;0;54;0
WireConnection;55;1;56;0
WireConnection;37;0;40;0
WireConnection;81;0;71;0
WireConnection;81;1;80;0
WireConnection;154;0;50;0
WireConnection;154;1;155;0
WireConnection;57;0;48;0
WireConnection;57;1;55;0
WireConnection;59;0;57;0
WireConnection;162;0;77;0
WireConnection;162;1;161;0
WireConnection;74;0;81;0
WireConnection;74;1;75;0
WireConnection;39;0;37;0
WireConnection;39;1;38;0
WireConnection;34;0;32;0
WireConnection;34;1;33;0
WireConnection;51;0;154;0
WireConnection;51;1;52;0
WireConnection;125;0;122;0
WireConnection;125;2;121;0
WireConnection;125;1;123;0
WireConnection;53;0;59;0
WireConnection;53;1;51;0
WireConnection;41;0;34;0
WireConnection;41;1;39;0
WireConnection;134;0;133;4
WireConnection;76;0;74;0
WireConnection;76;1;162;0
WireConnection;136;0;134;0
WireConnection;136;1;135;0
WireConnection;35;0;41;0
WireConnection;169;0;76;0
WireConnection;126;0;124;0
WireConnection;126;1;125;0
WireConnection;49;0;53;0
WireConnection;78;0;169;0
WireConnection;130;0;126;1
WireConnection;130;1;136;0
WireConnection;131;0;130;0
WireConnection;61;0;60;0
WireConnection;61;1;15;0
WireConnection;88;0;61;0
WireConnection;88;1;79;0
WireConnection;129;0;122;0
WireConnection;129;1;126;1
WireConnection;129;2;128;0
WireConnection;174;0;20;0
WireConnection;174;1;175;0
WireConnection;176;0;174;0
WireConnection;99;0;153;0
WireConnection;99;10;132;0
WireConnection;99;13;88;0
ASEEND*/
//CHKSM=A161E5933E7547BF9A2249EB63D0CE68528FF55D