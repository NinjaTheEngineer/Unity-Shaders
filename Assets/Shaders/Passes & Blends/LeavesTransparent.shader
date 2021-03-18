Shader "Holistic/LeavesTransparent"
{
    Properties
    {
        _MainTex ("MainTex", 2D) = "black" {}
    }
        SubShader
    {
        Tags{
            "Queue" = "Transparent"
        }
        Cull Off
        Blend SrcAlpha OneMinusSrcAlpha
        Pass{
            SetTexture[_MainTex] { combine texture}
        }
    }
    FallBack "Diffuse"
}

