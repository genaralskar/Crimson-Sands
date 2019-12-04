// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fresnel"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard alpha:premul keepalpha noshadow exclude_path:deferred 
		struct Input
		{
			float4 vertexColor : COLOR;
		};

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 temp_output_6_0 = i.vertexColor;
			o.Albedo = temp_output_6_0.rgb;
			float temp_output_6_4 = i.vertexColor.a;
			o.Alpha = temp_output_6_4;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17101
31;491;1542;906;1001.828;415.8419;1.182422;True;True
Node;AmplifyShaderEditor.VertexColorNode;6;-351.2367,-406.6403;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;2;-664.0637,-34.53345;Inherit;False;Property;_Power;Power;0;0;Create;True;0;0;False;0;1;1.01;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-667.0637,-126.5334;Inherit;False;Property;_Scale;Scale;1;0;Create;True;0;0;False;0;1;1.2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;1;-359,-133.5;Inherit;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-75.23669,-12.64032;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-55.23669,-160.6403;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;151,-150;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Fresnel;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Front;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Premultiply;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;3;1;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;2;3;0
WireConnection;1;3;2;0
WireConnection;7;0;1;0
WireConnection;7;1;6;4
WireConnection;8;0;6;0
WireConnection;8;1;1;0
WireConnection;0;0;6;0
WireConnection;0;9;6;4
ASEEND*/
//CHKSM=FCDED050B0E4524B3F06B1195BF725E3C8F8CA67