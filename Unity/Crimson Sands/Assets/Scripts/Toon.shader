Shader "Roystan/Toon"
{
	Properties
	{
		_Color("Color", Color) = (0.5, 0.65, 1, 1)
		[HDR]
		_AmbientColor("Ambient Color", Color) = (0.4, 0.4, 0.4, 1)
		_ColorBlend("Color Blend", Float) = 0.01
		[HDR]
		_SpecularColor("Specular Color", Color) = (0.9, 0.9, 0.9, 1)
		_Glossiness("Glossiness", Float) = 32
		_RimColor("Rim Color", Color) = (1,1,1,1)
		_RimAmount("Rim Amount", Range(0, 1)) = 0.716
		_RimThreshold("Rim Threshold", Range(0,1)) = 0.1
		_MainTex("Main Texture", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
	}
	SubShader
	{
	    Tags
	    {
	        "LightMode" = "ForwardBase"
	        //"PassFlags" = "OnlyDirectional"
	    }
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fwdbase
			
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "AutoLight.cginc"

			struct appdata
			{
				float4 vertex : POSITION;				
				float4 uv : TEXCOORD0;
				float3 normal: NORMAL;
			};
			
			struct Input
			{
			    float uv_NormalMap;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 worldNormal : NORMAL;
				float3 viewDir : TEXCOORD1;
				SHADOW_COORDS(2)
				float3 normal :TEXCOORD3;
				
				half3 tspace0 : TEXCOORD4;
				half3 tspace1 : TEXCOORD5;
				half3 tspace2 : TEXCOORD6;
				
				float3 worldPos : TEXCOORD7;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _NormalMap;
			
			v2f vert (appdata v, float4 vertex : POSITION, float4 tangent : TANGENT)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.worldPos = mul(unity_ObjectToWorld, vertex).xyz;
				half3 wNormal = UnityObjectToWorldNormal(v.normal);
				half3 wTangent = UnityObjectToWorldDir(tangent.xyz);
				//compute bitangent
				half tangentSign = tangent.w * unity_WorldTransformParams.w;
				half3 wBitangent = cross(wNormal, wTangent) * tangentSign;
				//output the tangent space matrix
                o.tspace0 = half3(wTangent.x, wBitangent.x, wNormal.x);
                o.tspace1 = half3(wTangent.y, wBitangent.y, wNormal.y);
                o.tspace2 = half3(wTangent.z, wBitangent.z, wNormal.z);
				
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.worldNormal = UnityObjectToWorldNormal(v.normal);
				//o.tangentNormal = UnityObjectToWorldNormal(_NormalMap);
				o.viewDir = WorldSpaceViewDir(v.vertex);
				
				o.normal = v.uv;
				
				TRANSFER_SHADOW(o)
				return o;
			}
			
			float4 _Color;
            float4 _AmbientColor;
            float _ColorBlend;
            float _Glossiness;
            float4 _SpecularColor;
            float4 _RimColor;
            float _RimAmount;
            float _RimThreshold;
            
			float4 frag (v2f i) : SV_Target
			{
			    //dark/light blend
			    //float3 normal = normalize(i.worldNormal);
			    float3 tnormal = UnpackNormal(tex2D(_NormalMap, i.normal));
			    //convert from tangent to world space
			    half3 worldNormal;
                worldNormal.x = dot(i.tspace0, tnormal);
                worldNormal.y = dot(i.tspace1, tnormal);
                worldNormal.z = dot(i.tspace2, tnormal);
			    
			    
			    float NdotL = dot(_WorldSpaceLightPos0, worldNormal);
			    float shadow = SHADOW_ATTENUATION(i);
			    float lightIntensity = smoothstep(0, _ColorBlend, NdotL * shadow);
			    float4 light = lightIntensity * _LightColor0;
			    
			    //specular stuff
			    float3 viewDir = normalize(i.viewDir);
			    float3 halfVector = normalize(_WorldSpaceLightPos0 + viewDir);
			    float NdotH = dot(worldNormal, halfVector);
			    float specularIntensity = pow(NdotH * lightIntensity, _Glossiness * _Glossiness);
			    float specularIntensitySmooth = smoothstep(0.005, 0.01,specularIntensity);
			    float4 specular  = specularIntensitySmooth * _SpecularColor;
			    
			    //rim Lighting
			    float4 rimDot = 1 - dot(viewDir, worldNormal);
			    float rimIntensity = rimDot * pow(NdotL, _RimThreshold);
			    rimIntensity = smoothstep(_RimAmount - 0.01, _RimAmount + 0.01, rimIntensity);
			    float4 rim = rimIntensity * _RimColor;
			    
				float4 sample = tex2D(_MainTex, i.uv);
				return _Color * sample * (_AmbientColor + light + specular + rim);
			}
			
			void surf(Input IN, inout SurfaceOutput o)
			{
			    o.Normal = UnpackNormal(tex2D (_NormalMap, IN.uv_NormalMap));
			}
			ENDCG
		}
		UsePass "Legacy Shaders/VertexLit/SHADOWCASTER"
	}
}