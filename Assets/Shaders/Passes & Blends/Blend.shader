Shader "Holistic/Blend"
{
    Properties
    {
        _MainTex("MainTex", 2D) = "black" {}
    }
        SubShader
    {
        Tags{
            "Queue" = "Transparent"
        }
        
        //Blend One One
        //Blend SrcAlpha OneMinusSrcAlpha
        Blend DstColor Zero

        Pass{
            SetTexture[_MainTex] { combine texture }
        }
    }
}   
