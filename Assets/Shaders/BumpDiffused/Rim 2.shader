Shader "Holistic/Rim2" 
{
    Properties{
        _myDiffuse("Diffuse Texture", 2D) = "white" {}
        _mySlider("Stripe Size", Range(0,10)) = 1
        _RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0.0)
        _RimPower("Rim Power", Range(0.5, 10.0)) = 3.0
    }
    SubShader {

      CGPROGRAM
        #pragma surface surf Lambert

        sampler2D _myDiffuse;
        half _mySlider;

        float4 _RimColor;
        float _RimPower;

        struct Input {
            float3 viewDir;
            float2 uv_myDiffuse;
            float3 worldPos;
        };

        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_myDiffuse, IN.uv_myDiffuse).rgb;
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = frac(IN.worldPos.y * _mySlider * 0.5) > 0.4 ?
                float3(0, 1, 0) * rim: float3(1, 0, 0) * rim;
        }
        //rim > 0.5 ? float3(1,0,0): rim > 0.3 ? float3(0, 1, 0) : rim > 0 ? float3(0, 0, 1) : 0;


      ENDCG
    }
    Fallback "Diffuse"
  }
