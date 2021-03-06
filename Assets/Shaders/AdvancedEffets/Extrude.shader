Shader "AdvancedEffects/Extrude"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Slider("Normal Slider", Range(-1, 1)) = 0
    }
    SubShader
    {
       
        CGPROGRAM
        #pragma surface surf Lambert vertex:vert

        sampler2D _MainTex;
        float _Slider;

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
        };

        void vert(inout appdata v) {
            v.vertex.xyz += v.normal * _Slider;
        }

        struct Input
        {
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
