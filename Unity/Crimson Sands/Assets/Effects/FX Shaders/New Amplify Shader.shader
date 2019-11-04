// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FX/Distortion"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "black" {}
		_Vector0("Vector 0", Vector) = (10,10,0,0)
		_Remap_Min("Remap_Min", Vector) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma target 5.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _Texture0;
		uniform float2 _Vector0;
		uniform float2 _Remap_Min;


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
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float4 computeGrabScreenPos20 = ComputeGrabScreenPos( ase_screenPosNorm );
			float2 uv_TexCoord14 = i.uv_texcoord * _Vector0;
			float simplePerlin2D10 = snoise( uv_TexCoord14 );
			simplePerlin2D10 = simplePerlin2D10*0.5 + 0.5;
			o.Alpha = tex2D( _Texture0, ( computeGrabScreenPos20 * (_Remap_Min.x + (simplePerlin2D10 - 0.0) * (1.0 - _Remap_Min.x) / (1.0 - 0.0)) ).xy ).r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
20;571;1792;912;2526.885;456.8599;1.828042;True;True
Node;AmplifyShaderEditor.Vector2Node;15;-2094.01,395.393;Inherit;False;Property;_Vector0;Vector 0;1;0;Create;True;0;0;False;0;10,10;10,10;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1767.009,215.084;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;16;-1435.646,649.0476;Inherit;False;Property;_Remap_Min;Remap_Min;2;0;Create;True;0;0;False;0;0,0;0.88,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.NoiseGeneratorNode;10;-1507.622,331.559;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;50,50;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;2;-1501.658,-20.12854;Inherit;True;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;8;-1187.603,432.6651;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0.88;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComputeGrabScreenPosHlpNode;20;-1284.372,-189.1785;Inherit;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;7;-879.227,-92.91985;Inherit;True;Property;_Texture0;Texture 0;0;0;Create;True;0;0;False;0;None;None;False;black;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-935.5402,239.4503;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GrabScreenPosition;19;-1599.148,-213.6271;Inherit;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-512.9069,139.9648;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;21;-341.5706,386.8933;Inherit;False;Property;_Float0;Float 0;3;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;7;ASEMaterialInspector;0;0;Standard;FX/Distortion;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.9;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;1;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;15;0
WireConnection;10;0;14;0
WireConnection;8;0;10;0
WireConnection;8;3;16;0
WireConnection;20;0;2;0
WireConnection;4;0;20;0
WireConnection;4;1;8;0
WireConnection;3;0;7;0
WireConnection;3;1;4;0
WireConnection;0;9;3;0
WireConnection;0;10;21;0
ASEEND*/
//CHKSM=EA93A75DEBDC47D3B019D595E79730C2829B9761