// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Dither And Pixelate"
{
	Properties
	{
		[Toggle]_ToggleDither("Toggle Dither", Float) = 1
		_Intensity("Intensity", Range( 0 , 1)) = 0.5
		[Toggle]_TogglePixelation("Toggle Pixelation", Float) = 0
		_PixelationAmount("Pixelation Amount", Float) = 1
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
			
			uniform float _ToggleDither;
			uniform float _TogglePixelation;
			uniform float _PixelationAmount;
			uniform float _Intensity;

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

				float2 uv019 = i.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float pixelWidth71 =  1.0f / ( ( _ScreenParams.x + 1.0 ) / _PixelationAmount );
				float pixelHeight71 = 1.0f / ( ( _ScreenParams.y + 1.0 ) / _PixelationAmount );
				half2 pixelateduv71 = half2((int)(uv019.x / pixelWidth71) * pixelWidth71, (int)(uv019.y / pixelHeight71) * pixelHeight71);
				float4 tex2DNode24 = tex2D( _MainTex, lerp(uv019,pixelateduv71,_TogglePixelation) );
				float2 clipScreen52 = ase_ppsScreenPosFragNorm.xy * _ScreenParams.xy;
				float dither52 = Dither8x8Bayer( fmod(clipScreen52.x, 8), fmod(clipScreen52.y, 8) );
				dither52 = step( dither52, tex2DNode24.r );
				float clampResult67 = clamp( ( ( dither52 - _Intensity ) + 1.0 ) , 0.0 , 1.0 );
				

				float4 color = lerp(tex2DNode24,( tex2DNode24 * clampResult67 ),_ToggleDither);
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=17101
-1364;220;1215;671;104.2409;723.2467;1.3;True;True
Node;AmplifyShaderEditor.ScreenParams;72;-2172.169,-275.0477;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;81;-1883.297,-336.0974;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;82;-1888.297,-154.0976;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;75;-1949.581,-461.7317;Inherit;False;Property;_PixelationAmount;Pixelation Amount;3;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;79;-1640.36,-345.4091;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;80;-1621.36,-219.4093;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;19;-1533.604,-638.4573;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCPixelate;71;-1391.471,-385.3784;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;78;-1192.915,-554.4873;Inherit;False;Property;_TogglePixelation;Toggle Pixelation;2;0;Create;True;0;0;False;0;0;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;23;-790.8151,-713.1919;Inherit;False;0;0;_MainTex;Pass;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;-581.5424,-572.9522;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;60;-247.0712,-618.4661;Inherit;False;Property;_Intensity;Intensity;1;0;Create;True;0;0;False;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;52;-241.1345,-821.8586;Inherit;False;1;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;65;132.3228,-648.71;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;291.5002,-570.1989;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;67;430.0407,-514.2485;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;552.014,-365.6572;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;58;688.0499,-223.5609;Inherit;False;Property;_ToggleDither;Toggle Dither;0;0;Create;True;0;0;False;0;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;11;1031.433,-221.5524;Float;False;True;2;ASEMaterialInspector;0;2;Dither And Pixelate;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;False;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;0
WireConnection;81;0;72;1
WireConnection;82;0;72;2
WireConnection;79;0;81;0
WireConnection;79;1;75;0
WireConnection;80;0;82;0
WireConnection;80;1;75;0
WireConnection;71;0;19;0
WireConnection;71;1;79;0
WireConnection;71;2;80;0
WireConnection;78;0;19;0
WireConnection;78;1;71;0
WireConnection;24;0;23;0
WireConnection;24;1;78;0
WireConnection;52;0;24;0
WireConnection;65;0;52;0
WireConnection;65;1;60;0
WireConnection;68;0;65;0
WireConnection;67;0;68;0
WireConnection;53;0;24;0
WireConnection;53;1;67;0
WireConnection;58;0;24;0
WireConnection;58;1;53;0
WireConnection;11;0;58;0
ASEEND*/
//CHKSM=04CB279B07CE38EB6C0EC7BF627304A611872534