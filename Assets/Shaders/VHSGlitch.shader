Shader "Custom/StripGlitch"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Intensity ("Intensity", Range(0,1)) = 0.5
        _StripStrength ("Strip Strength", Range(0,0.1)) = 0.05
        _NoiseStrength ("Noise Strength", Range(0,1)) = 0.3
    }
    SubShader
    {
        Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" }
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
            float _StripStrength;
            float _NoiseStrength;

            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                OUT.positionHCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = TRANSFORM_TEX(IN.uv, _MainTex);
                return OUT;
            }

            // random helper
            float rand(float2 co)
            {
                return frac(sin(dot(co, float2(12.9898, 78.233))) * 43758.5453);
            }

            half4 frag(Varyings IN) : SV_Target
            {
                float t = _TimeParameters.y;

                // horizontal strip index
                float stripIndex = floor(IN.uv.y * 40.0); // 40 strips
                float stripRand = rand(float2(stripIndex, floor(t)));

                // horizontal offset per strip
                float offset = (stripRand - 0.5) * _StripStrength * _Intensity;

                // RGB shifts
                float2 uvR = IN.uv + float2(offset + 0.01 * _Intensity, 0);
                float2 uvG = IN.uv + float2(offset, 0);
                float2 uvB = IN.uv + float2(offset - 0.01 * _Intensity, 0);

                // sample channels
                half r = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uvR).r;
                half g = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uvG).g;
                half b = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uvB).b;
                half4 col = half4(r, g, b, 1);

                // add static noise
                float noise = rand(IN.uv * t * 1000.0) * _NoiseStrength * _Intensity;
                col.rgb += noise;

                // glitch strip cutoff
                if (stripRand < 0.05 * _Intensity)
                {
                    col.rgb *= 0.2; // dark broken strips
                }

                return col;
            }
            ENDHLSL
        }
    }
}
