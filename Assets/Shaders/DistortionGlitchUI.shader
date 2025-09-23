Shader "UI/DistortionGlitchUI"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Amount  ("Glitch Amount", Range(0,0.05)) = 0.02
        _Speed   ("Glitch Speed", Range(0,10)) = 4
        _Color   ("Tint", Color) = (1,1,1,1)
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
                float2 uv     : TEXCOORD0;
                float4 color  : COLOR;
            };

            struct v2f
            {
                float4 pos  : SV_POSITION;
                float2 uv   : TEXCOORD0;
                fixed4 col  : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Color;
            float  _Amount;
            float  _Speed;

            v2f vert (appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv  = TRANSFORM_TEX(v.uv, _MainTex);
                o.col = v.color * _Color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float t = _Time.y * _Speed;
                float offset = (sin(i.uv.y * 50 + t * 10) * 0.5 + 0.5) * _Amount;

                half r = tex2D(_MainTex, i.uv + float2(offset,0)).r;
                half g = tex2D(_MainTex, i.uv).g;
                half b = tex2D(_MainTex, i.uv - float2(offset,0)).b;

                fixed4 col = fixed4(r,g,b,1) * i.col;
                return col;
            }
            ENDHLSL
        }
    }
}
