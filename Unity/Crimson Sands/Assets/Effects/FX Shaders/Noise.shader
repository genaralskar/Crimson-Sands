// Upgrade NOTE: upgraded instancing buffer 'Noise' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Noise"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_FadeSlider("Fade Slider", Range( 0 , 5)) = 1
		_Vector0("Vector 0", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" }
		Cull Off
		CGPROGRAM
		#pragma target 5.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float2 _Vector0;
		uniform float _Cutoff = 0.5;

		UNITY_INSTANCING_BUFFER_START(Noise)
			UNITY_DEFINE_INSTANCED_PROP(float, _FadeSlider)
#define _FadeSlider_arr Noise
		UNITY_INSTANCING_BUFFER_END(Noise)


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
			float grayscale20 = (tex2D( _TextureSample0, i.uv_texcoord ).rgb.r + tex2D( _TextureSample0, i.uv_texcoord ).rgb.g + tex2D( _TextureSample0, i.uv_texcoord ).rgb.b) / 3;
			float2 uv_TexCoord3 = i.uv_texcoord * _Vector0;
			float simplePerlin2D1 = snoise( uv_TexCoord3*6.0 );
			simplePerlin2D1 = simplePerlin2D1*0.5 + 0.5;
			float _FadeSlider_Instance = UNITY_ACCESS_INSTANCED_PROP(_FadeSlider_arr, _FadeSlider);
			float temp_output_11_0 = ( simplePerlin2D1 / _FadeSlider_Instance );
			float blendOpSrc2 = grayscale20;
			float blendOpDest2 = temp_output_11_0;
			float lerpBlendMode2 = lerp(blendOpDest2,( 1.0 - ( 1.0 - blendOpSrc2 ) * ( 1.0 - blendOpDest2 ) ),( grayscale20 * temp_output_11_0 ));
			clip( ( saturate( lerpBlendMode2 )) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
7.333333;519.3334;1464;595;2614.313;288.7311;2.2;True;True
Node;AmplifyShaderEditor.Vector2Node;19;-1866.592,250.3644;Inherit;False;Property;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;3;-1611.66,258.478;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,25;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1598.071,-6.45842;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NoiseGeneratorNode;1;-1275.96,228.6779;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;5,1;False;1;FLOAT;6;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1317.76,-8.022018;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;bcb8a8d20459e6349bf5cfce27e04e22;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1305.494,460.9236;Inherit;False;InstancedProperty;_FadeSlider;Fade Slider;2;0;Create;True;0;0;False;0;1;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;11;-941.8032,234.6434;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;20;-970.7926,105.4548;Inherit;False;2;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-665.6738,50.20457;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;2;-490.6802,252.0453;Inherit;True;Screen;True;3;0;FLOAT;0;False;1;FLOAT;0.9811321;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;7;ASEMaterialInspector;0;0;Standard;Noise;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;False;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;19;0
WireConnection;1;0;3;0
WireConnection;6;1;7;0
WireConnection;11;0;1;0
WireConnection;11;1;8;0
WireConnection;20;0;6;0
WireConnection;21;0;20;0
WireConnection;21;1;11;0
WireConnection;2;0;20;0
WireConnection;2;1;11;0
WireConnection;2;2;21;0
WireConnection;0;10;2;0
ASEEND*/
//CHKSM=7150DA44811FB1E01B066B76D783C6AB7DCD49B5