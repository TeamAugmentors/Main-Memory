Shader "Custom/TVGlitch"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Intensity ("Intensity", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }
        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
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
            float4 _MainTex_ST;
            float _Intensity;

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = TRANSFORM_TEX(IN.uv, _MainTex);
                return OUT;
            }

            half4 frag(Varyings IN) : SV_Target
            {
                // Unity built-in time (_TimeParameters.y = time in seconds)
                float t = _TimeParameters.y * 10.0;

                // Generate shift value (per-pixel pseudo-random)
                float shift = frac(sin(dot(IN.uv * t, float2(12.9898,78.233))) * 43758.5453) * _Intensity;

                // RGB channel separation
                half r = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv + float2(shift * 0.02, 0)).r;
                half g = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv).g;
                half b = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, IN.uv - float2(shift * 0.02, 0)).b;

                half4 color = half4(r, g, b, 1);

                // Horizontal tearing lines
                float lineNoise = frac(sin((IN.uv.y * 200.0 + t) * 3.14159) * 43758.5453);
                if (lineNoise < 0.05 * _Intensity)
                {
                    color.rgb *= lineNoise; // dark glitchy strip
                }

                return color;
            }
            ENDHLSL
        }
    }
}
