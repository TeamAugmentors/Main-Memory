Shader "UI/TVGlitchUI"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Intensity ("Intensity", Range(0,1)) = 0.5
        _Color ("Tint", Color) = (1,1,1,1)
    }

    SubShader
    {
        Tags 
        { 
            "Queue"="Transparent" 
            "IgnoreProjector"="True" 
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        Cull Off
        Lighting Off
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float2 uv : TEXCOORD0;
                fixed4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            fixed4 _Color;
            float _Intensity;

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.color = v.color * _Color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float t = _Time.y * 10.0;

                // Base sample
                fixed4 src = tex2D(_MainTex, i.uv);

                // Random horizontal shift
                float shift = frac(sin(dot(i.uv * t, float2(12.9898,78.233))) * 43758.5453) * _Intensity;

                // RGB channel separation
                half r = tex2D(_MainTex, i.uv + float2(shift * 0.02, 0)).r;
                half g = tex2D(_MainTex, i.uv).g;
                half b = tex2D(_MainTex, i.uv - float2(shift * 0.02, 0)).b;

                fixed4 col = fixed4(r, g, b, src.a) * i.color;

                // Horizontal tearing lines
                float lineNoise = frac(sin((i.uv.y * 200.0 + t) * 3.14159) * 43758.5453);
                if (lineNoise < 0.05 * _Intensity)
                {
                    col.rgb *= lineNoise;
                }

                return col;
            }
            ENDHLSL
        }
    }
}
