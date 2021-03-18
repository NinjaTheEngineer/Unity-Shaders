Shader "Holistic/Buffer" 
{
    Properties {
        _MainTex("Base (RGB)", 2D) = "white" {}
    }

        SubShader{

          ZWrite Off

          CGPROGRAM
            #pragma surface surf Lambert

        struct Input {
            float uv_MainTex;
        };
            
        sampler2D _MainTex;

        
        void surf (Input IN, inout SurfaceOutput o) {
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
            //o.Albedo = texCUBE(_myCube, IN.worldRefl).rgb;
            //o.Normal = UnpackNormal(tex2D(_myBump, IN.uv_myBump));
            //o.Normal *= float3(_mySlider, _mySlider, 1);
            //o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
        }
      
      ENDCG
    }
    Fallback "Diffuse"
  }
