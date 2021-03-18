Shader "Holistic/StandardPBR"{
    Properties{
        _Color("Color", Color) = (1,1,1,1)
        _MetallicTex ("Metallic (R)", 2D) = "white"{}
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0
    }

    SubShader {
        Tags{
            "Queue" = "Geometry"
        }

        CGPROGRAM
        #pragma surface surf Standard

        struct Input {
            float2 uv_MetallicTex;
        };
    
        float4 _Color;
        half _Metallic;
        sampler2D _MetallicTex;
        
        void surf (Input IN, inout SurfaceOutputStandard o) {
            o.Albedo = _Color.rgb;
            o.Smoothness = tex2D(_MetallicTex, IN.uv_MetallicTex).r;
            o.Metallic = _Metallic;
        }
      
        ENDCG
    }
    Fallback "Diffuse"
  }
