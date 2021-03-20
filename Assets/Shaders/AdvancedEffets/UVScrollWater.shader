Shader "AdvancedEffects/UVScrollWater"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SecTex ("Sec Texture", 2D) = "white"{}
		_ScrollX("Scroll X", Range(-5, 5)) = 0
		_ScrollY ("Scroll Y", Range(-5, 5)) = 0
	}
	SubShader
	{
		CGPROGRAM
		#pragma surface surf Lambert

		struct Input {
			float2 uv_MainTex;
};
		sampler2D _MainTex;
		sampler2D _SecTex;
		float _ScrollX;
		float _ScrollY;

		void surf(Input IN, inout SurfaceOutput o) {
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			float3 mainT = (tex2D(_MainTex, IN.uv_MainTex +
				float2(_ScrollX, _ScrollY))).rgb;

			float3 secT = (tex2D(_SecTex, IN.uv_MainTex +
				float2(_ScrollX/2.0, _ScrollY/2.0))).rgb;

			o.Albedo = (mainT + secT) / 2.0;
		}
		ENDCG

	}

}
