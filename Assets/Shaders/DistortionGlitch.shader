Shader "Custom/DistortionGlitch"
{
    Properties
    {
        _MainTex ("Screen", 2D) = "white" {}
        _Amount  ("Glitch Amount", Range(0,0.05)) = 0.02
        _Speed   ("Glitch Speed", Range(0,10)) = 4
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalRenderPipeline" }
        Pass
        {
            ZTest Always Cull Off ZWrite Off
            HLSLPROGRAM
            #pragma vertex Vert
            #pragma fragment Frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
            };

            TEXTURE2D(_MainTex);
            SAMPLER(sampler_MainTex);

            float _Amount;
            float _Speed;

            Varyings Vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = IN.uv;
                return OUT;
            }

            half4 Frag(Varyings IN) : SV_Target
            {
                float t = _Time.y * _Speed;
                float offset = (sin(IN.uv.y * 50 + t * 10) * 0.5 + 0.5) * _Amount;

                half r = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv + float2(offset,0)).r;
                half g = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv).g;
                half b = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv - float2(offset,0)).b;

                return half4(r,g,b,1);
            }
            ENDHLSL
        }
    }
}
