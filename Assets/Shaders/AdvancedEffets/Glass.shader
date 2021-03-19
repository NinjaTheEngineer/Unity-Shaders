Shader "AdvancedEffects/Glass"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_BumpTex ("Normal Tex", 2D) = "bump" {}
		_ScaleUV ("Scale", Range(1,20)) = 1
	}
	SubShader
	{
		Tags{ "Queue" = "Transparent"}
		GrabPass{}
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv : TEXCOORD0;
				fixed4 texcoord : TEXCOORD1;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 uvgrab : TEXCOORD1;
				float2 uvbump : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			sampler2D _GrabTexture;
			float4 _GrabTexture_TexelSize;
			sampler2D _MainTex;
			float4 _MainTex_ST;
			sampler2D _BumpTex;
			float4 _BumpTex_ST;
			float _ScaleUV;
			
			v2f vert (appdata v)
			{
				v2f o;
				//o.vertex = UnityObjectToClipPos(v.vertex);
				//o.uv = ComputeGrabScreenPos(o.vertex);
				//o.uvgrab.xy = TRANSFORM_TEX(v.texcoord, _MainTex);
				//o.uvgrab.zw = TRANSFORM_TEX(v.texcoord, _BumpTex);
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uvgrab.xy = (float2(o.vertex.x, o.vertex.y * -1) + o.vertex.w) * 0.5;
				o.uvgrab.zw = o.vertex.zw;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uvbump = TRANSFORM_TEX(v.uv, _BumpTex);
				return o;
			}

			inline float4 ComputeGrabScreePon(float4 pos) {
#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
#else
				float scale = 1.0;
#endif
				float4 o = pos * 0.5f;
				o.xy = float2(o.x, o.y * scale) + o.w;
#ifdef UNITY_SINGLE_PASS_STEREO
				o.xy = TransformStereoScreenSpaceTex(o.xy, pos.w);
#endif
				o.zw = pos.zw;
				return o;
			}
			
			fixed4 frag(v2f i) : SV_Target
			{
				half2 bump = UnpackNormal(tex2D(_BumpTex, i.uvbump)).rg;
				float2 offset = bump.xy * _ScaleUV * _GrabTexture_TexelSize.xy;
				i.uvgrab.xy = offset * i.uvgrab.z + i.uvgrab.xy;

				fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				fixed4 tint = tex2D(_MainTex, i.uv);
				col *= tint;
				return col;
			}
			ENDCG
		}
	}
}
