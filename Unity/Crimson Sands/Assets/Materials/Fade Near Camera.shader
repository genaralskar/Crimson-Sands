// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fade Near Camera"
{
	Properties
	{
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Cull Off
		ZWrite Off
		ZTest Always
		
		Pass
		{
			CGPROGRAM

			

			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"

		
			struct ASEAttributesDefault
			{
				float3 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				
			};

			struct ASEVaryingsDefault
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoordStereo : TEXCOORD1;
			#if STEREO_INSTANCING_ENABLED
				uint stereoTargetEyeIndex : SV_RenderTargetArrayIndex;
			#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
			uniform float4 _CameraDepthTexture_TexelSize;

			inline float Dither8x8Bayer( int x, int y )
			{
				const float dither[ 64 ] = {
			 1, 49, 13, 61,  4, 52, 16, 64,
			33, 17, 45, 29, 36, 20, 48, 32,
			 9, 57,  5, 53, 12, 60,  8, 56,
			41, 25, 37, 21, 44, 28, 40, 24,
			 3, 51, 15, 63,  2, 50, 14, 62,
			35, 19, 47, 31, 34, 18, 46, 30,
			11, 59,  7, 55, 10, 58,  6, 54,
			43, 27, 39, 23, 42, 26, 38, 22};
				int r = y * 8 + x;
				return dither[r] / 64; // same # of instructions as pre-dividing due to compiler magic
			}
			

			float2 TransformTriangleVertexToUV (float2 vertex)
			{
				float2 uv = (vertex + 1.0) * 0.5;
				return uv;
			}

			ASEVaryingsDefault Vert( ASEAttributesDefault v  )
			{
				ASEVaryingsDefault o;
				o.vertex = float4(v.vertex.xy, 0.0, 1.0);
				o.texcoord = TransformTriangleVertexToUV (v.vertex.xy);
#if UNITY_UV_STARTS_AT_TOP
				o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
#endif
				o.texcoordStereo = TransformStereoScreenSpaceTex (o.texcoord, 1.0);

				v.texcoord = o.texcoordStereo;
				float4 ase_ppsScreenPosVertexNorm = float4(o.texcoordStereo,0,1);

				

				return o;
			}

			float4 Frag (ASEVaryingsDefault i  ) : SV_Target
			{
				float4 ase_ppsScreenPosFragNorm = float4(i.texcoordStereo,0,1);

				float2 uv_MainTex = i.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 tex2DNode3 = tex2D( _MainTex, uv_MainTex );
				float2 clipScreen26 = ase_ppsScreenPosFragNorm.xy * _ScreenParams.xy;
				float dither26 = Dither8x8Bayer( fmod(clipScreen26.x, 8), fmod(clipScreen26.y, 8) );
				float eyeDepth4 = (SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_ppsScreenPosFragNorm.xy )*( _ProjectionParams.z - _ProjectionParams.y ));
				float smoothstepResult21 = smoothstep( 0.0 , 0.5 , eyeDepth4);
				float temp_output_27_0 = (0.0 + (smoothstepResult21 - 0.0) * (10.0 - 0.0) / (1.0 - 0.0));
				dither26 = step( dither26, temp_output_27_0 );
				float4 lerpResult38 = lerp( tex2DNode3 , ( dither26 * tex2DNode3 ) , 0.3);
				

				float4 color = lerpResult38;
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17101
-1424;271;1215;651;134.4132;456.1147;1.6;True;True
Node;AmplifyShaderEditor.ScreenDepthNode;4;-785.2913,-115.359;Inherit;False;0;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;21;-398.8644,-248.9124;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;27;-207.8963,212.9483;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;2;-785.4399,79.79882;Inherit;False;0;0;_MainTex;Pass;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-551.2311,103.5928;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DitheringNode;26;440.0186,270.8011;Inherit;False;1;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;749.48,148.0769;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;39;723.9353,349.8323;Inherit;False;Constant;_Float1;Float 1;0;0;Create;True;0;0;False;0;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareLower;46;94.95218,239.4083;Inherit;False;4;0;FLOAT;0;False;1;FLOAT;0.01;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;48;-1114.501,109.0717;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;62;-2729.247,147.2103;Inherit;False;1;0;FLOAT;-0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;61;-2503.047,136.8103;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;-2530.464,489.3929;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;53;-2328.012,405.7408;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,10;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;38;919.0648,46.66885;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;59;-2032.563,18.793;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;10,10;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;51;-2047.992,331.0369;Inherit;True;Gradient;True;False;2;0;FLOAT2;10,10;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;64;-1646.341,184.3317;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;55;-1330.3,308.9247;Inherit;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;57;-2756.664,499.7929;Inherit;False;1;0;FLOAT;-1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-1066.276,342.7474;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.001;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;63;-2300.595,53.15821;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;5,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;1183.077,-19.96117;Float;False;True;2;ASEMaterialInspector;0;2;Fade Near Camera;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;False;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;21;0;4;0
WireConnection;27;0;21;0
WireConnection;3;0;2;0
WireConnection;26;0;27;0
WireConnection;30;0;26;0
WireConnection;30;1;3;0
WireConnection;46;0;27;0
WireConnection;46;3;27;0
WireConnection;48;1;56;0
WireConnection;61;0;62;0
WireConnection;58;1;57;0
WireConnection;53;1;58;0
WireConnection;38;0;3;0
WireConnection;38;1;30;0
WireConnection;38;2;39;0
WireConnection;59;0;63;0
WireConnection;51;0;53;0
WireConnection;64;0;59;0
WireConnection;64;1;51;0
WireConnection;55;0;64;0
WireConnection;56;0;55;0
WireConnection;63;1;61;0
WireConnection;1;0;38;0
ASEEND*/
//CHKSM=47AD49DFFA1D2A2F3B6EE676FCF98435E02B4D2A