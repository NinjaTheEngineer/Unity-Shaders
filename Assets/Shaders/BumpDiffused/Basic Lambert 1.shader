Shader "Holistic/BasicLambert1" 
{
    Properties{
        _Colour("Color", Color) = (1,1,1,1)
        _SpecColor("Spec Color", Color) = (1,1,1,1)
        _Spec("Specular", Range(0,1)) = 0.5
        _Gloss("Gloss", Range(0,1)) = 0.5
    }

    SubShader {

        CGPROGRAM
        #pragma surface surf BasicLambert

        half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten) {
            half NdotL = dot(s.Normal, lightDir);
            half4 c;
            c.rgb = s.Albedo *  (NdotL * atten);
            c.a = s.Alpha;
            return c;
}

        struct Input {
            float2 uv_MainTex;
        };
    
        float4 _Colour;
        half _Spec;
        fixed _Gloss;
        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = _Colour.rgb;
            o.Specular = _Spec;
            o.Gloss = _Gloss;
        }
      
        ENDCG
    }
    Fallback "Diffuse"
  }
