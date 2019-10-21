Shader "Toon/Lit" {


    
    Properties {
        _Color ("Main Color", Color) = (0.5,0.5,0.5,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}
        _Ramp ("Toon Ramp (RGB)", 2D) = "gray" {}
    }
 
    SubShader {
        Tags {"Queue"="Transparency" "RenderType"="Transparency"}
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 200
       
CGPROGRAM
//#pragma surface surf ToonRamp
#pragma surface surf Standard alpha vertex:vert
 
sampler2D _Ramp;

     
    struct Input {
        float2 uv_MainTex;
    };

    
    struct appdata_particles{
    float4 color : COLOR;
    float4 textcoords: TEXCOORD0;
    float textcoords: TEXCOORD1;
    };
 
// custom lighting function that uses a texture ramp based
// on angle between light direction and normal

 
void vert(inout appdata_particles v, out Input o) {
    UNITY_INITIALIZE_OUTPUT(Input,o);
    o.uv_MainTex = v.texcoords.xy;
    o.texcoord1 = v.texcoords.zw;
    o.blend = v.texcoordBlend;
    o.color = v.color;
  }
 
 void surf (Input IN, inout SurfaceOutputStandard o) {
    fixed4 colA = tex2D(_MainTex, IN.uv_MainTex);
    fixed4 colB = tex2D(_MainTex, IN.texcoord1);
    fixed4 c = 1.0f * IN.color * lerp(colA, colB, IN.blend) * _Color;
         
    o.Albedo = c.rgb;
    // Metallic and smoothness come from slider variables
    o.Metallic = _Metallic;
    o.Smoothness = _Glossiness;
    o.Alpha = c.a;
    LightingToonRamp(s, lightDir, atten);
}    
    inline half4 LightingToonRamp (SurfaceOutput s, half3 lightDir, half atten)
    {
        #ifndef USING_DIRECTIONAL_LIGHT
        lightDir = normalize(lightDir);
        #endif
       
        half d = dot (s.Normal, lightDir)*0.5 + 0.5;
        half3 ramp = tex2D (_Ramp, float2(d,d)).rgb;
       
        half4 c;
        c.rgb = s.Albedo * _LightColor0.rgb * ramp * (atten * 2);
        c.a = 0;
        return c;
    }
 
 
sampler2D _MainTex;
float4 _Color;




ENDCG
 
    }
 
    Fallback "Diffuse"
}