Shader "Custom/SnowTrack" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SnowTex("Snow",2D)="white"{}
		_Normal("Normal",2D)="bump"{}
		_Snowfactor("Factor",float)=0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows vertex:vert

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _SnowTex;
		sampler2D _Normal;
		float _Snowfactor;
		struct Input {
			float2 uv_MainTex;
		};
		fixed4 _Color;

		void vert(inout appdata_full o ){
			
			o.vertex.y-= tex2Dlod(_SnowTex,float4(o.texcoord.xy,0,0)).r*_Snowfactor;
		
		}
		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			// Metallic and smoothness come from slider variables
			o.Normal = UnpackNormal(tex2D(_Normal,IN.uv_MainTex) );
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
