// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SandFall"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_Texture2("Texture 2", 2D) = "white" {}
		_Tiling("Tiling", Vector) = (0.5,0.5,0,0)
		_Tiling2("Tiling2", Vector) = (0.5,0.5,0,0)
		_Color("Color", Color) = (0.6415094,0.3416532,0.07564969,0)
		_Color0("Color 0", Color) = (0.8679245,0.4396374,0.06140975,0)
		_Speed("Speed", Vector) = (0,-1,0,0)
		_Speed2("Speed2", Vector) = (0,1,0,0)
		_Texture1("Texture 1", 2D) = "white" {}
		_noiseAlpha("noiseAlpha", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _Color0;
		uniform float4 _Color;
		uniform sampler2D _Texture2;
		uniform float2 _Tiling2;
		uniform float2 _Speed2;
		uniform sampler2D _noiseAlpha;
		uniform float2 _Tiling;
		uniform float2 _Speed;
		uniform sampler2D _Texture1;
		uniform float4 _Texture1_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord42 = i.uv_texcoord * _Tiling2 + ( _Speed2 * _Time.y );
			float4 lerpResult72 = lerp( _Color0 , _Color , tex2D( _Texture2, tex2D( _Texture2, uv_TexCoord42 ).rg ));
			o.Albedo = lerpResult72.rgb;
			o.Alpha = 1;
			float2 uv_TexCoord30 = i.uv_texcoord * _Tiling + ( _Speed * _Time.y );
			float2 uv_Texture1 = i.uv_texcoord * _Texture1_ST.xy + _Texture1_ST.zw;
			clip( ( tex2D( _noiseAlpha, uv_TexCoord30 ) * tex2D( _Texture1, uv_Texture1 ) ).r - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
70;334;1330;886;-16.0105;1286.903;2.026683;True;True
Node;AmplifyShaderEditor.SimpleTimeNode;39;-827.8405,-1023;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;38;-824.8405,-1164;Inherit;False;Property;_Speed2;Speed2;7;0;Create;True;0;0;False;0;0,1;0,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;40;-679.238,-1318.022;Inherit;False;Property;_Tiling2;Tiling2;3;0;Create;True;0;0;False;0;0.5,0.5;0.1,0.1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;-642.8406,-1121;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;32;-436.0028,-159.7292;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;33;-433.0028,-300.7293;Inherit;False;Property;_Speed;Speed;6;0;Create;True;0;0;False;0;0,-1;0,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;42;-486.2379,-1280.022;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;43;-641.2053,-1560.407;Inherit;True;Property;_Texture2;Texture 2;1;0;Create;True;0;0;False;0;bcb8a8d20459e6349bf5cfce27e04e22;bdbe94d7623ec3940947b62544306f1c;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-251.0029,-257.7292;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;29;-287.4004,-454.7507;Inherit;False;Property;_Tiling;Tiling;2;0;Create;True;0;0;False;0;0.5,0.5;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TexturePropertyNode;63;246.0539,-435.0673;Inherit;True;Property;_noiseAlpha;noiseAlpha;9;0;Create;True;0;0;False;0;09319e105922246498caed573b84f774;f122eb56829cb244f98192565238fbb1;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;35;370.0476,-162.5939;Inherit;True;Property;_Texture1;Texture 1;8;0;Create;True;0;0;False;0;f122eb56829cb244f98192565238fbb1;f122eb56829cb244f98192565238fbb1;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;30;-94.40045,-416.7507;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;44;-255.2379,-1315.022;Inherit;True;Property;_TextureSample3;Texture Sample 3;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;45;305.9891,-1534.345;Inherit;False;Property;_Color0;Color 0;5;0;Create;True;0;0;False;0;0.8679245,0.4396374,0.06140975,0;0.3584906,0.1681197,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;27;348.6273,-1050.119;Inherit;False;Property;_Color;Color;4;0;Create;True;0;0;False;0;0.6415094,0.3416532,0.07564969,0;0.7924528,0.371633,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;273.9985,-1330.508;Inherit;True;Property;_TextureSample4;Texture Sample 4;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;36;616.4293,-164.8529;Inherit;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;64;481.5036,-433.6823;Inherit;True;Property;_TextureSample5;Texture Sample 5;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;982.8885,-368.6777;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;72;938.4984,-1144.977;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1429.891,-736.7963;Float;False;True;2;ASEMaterialInspector;0;0;Standard;SandFall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;41;0;38;0
WireConnection;41;1;39;0
WireConnection;42;0;40;0
WireConnection;42;1;41;0
WireConnection;34;0;33;0
WireConnection;34;1;32;0
WireConnection;30;0;29;0
WireConnection;30;1;34;0
WireConnection;44;0;43;0
WireConnection;44;1;42;0
WireConnection;46;0;43;0
WireConnection;46;1;44;0
WireConnection;36;0;35;0
WireConnection;64;0;63;0
WireConnection;64;1;30;0
WireConnection;37;0;64;0
WireConnection;37;1;36;0
WireConnection;72;0;45;0
WireConnection;72;1;27;0
WireConnection;72;2;46;0
WireConnection;0;0;72;0
WireConnection;0;10;37;0
ASEEND*/
//CHKSM=856CB2267164A01E9999D45D49ECDCD6409EECDD