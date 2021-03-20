Shader "AdvancedEffects/UVScroll"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
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
		float _ScrollX;
		float _ScrollY;

		void surf(Input IN, inout SurfaceOutput o) {
			_ScrollX *= _Time;
			_ScrollY *= _Time;
			float2 newuv = IN.uv_MainTex + float2(_ScrollX, _ScrollY);
			o.Albedo = tex2D(_MainTex, newuv);
		}
		ENDCG

	}

}
