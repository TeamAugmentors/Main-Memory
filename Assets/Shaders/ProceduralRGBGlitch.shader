Shader "Custom/ProceduralRGBGlitch"
{
    Properties
    {
        _Intensity ("Glitch Intensity", Range(0,1)) = 0.6
        _RGBShift ("RGB Shift", Range(0,0.05)) = 0.02
        _StripDensity ("Strip Density", Range(5,200)) = 60
        _Speed ("Glitch Speed", Range(0,10)) = 2
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }
        Pass
        {
            Name "ProceduralRGBGlitch"
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            float _Intensity;
            float _RGBShift;
            float _StripDensity;
            float _Speed;

            struct Attributes
            {
                float4 positionOS : POSITION;
                float2 uv         : TEXCOORD0;
            };

            struct Varyings
            {
                float4 positionCS : SV_POSITION;
                float2 uv         : TEXCOORD0;
            };

            Varyings vert (Attributes IN)
            {
                Varyings OUT;
                OUT.positionCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = IN.uv;
                return OUT;
            }

            // Hash for pseudo-random noise
            float hash21(float2 p)
            {
                p = frac(p * float2(123.34, 345.45));
                p += dot(p, p + 34.345);
                return frac(p.x * p.y);
            }

            half4 frag (Varyings IN) : SV_Target
            {
                // Black base background
                float3 col = 0;

                // Horizontal strip index
                float band = floor(IN.uv.y * _StripDensity);

                // Random per-band offset
                float shift = (hash21(float2(band, floor(_Time.y * _Speed))) - 0.5) * _Intensity;

                // Procedural RGB glitch strips
                float r = step(0.48, frac(IN.uv.x + shift + _RGBShift));
                float g = step(0.48, frac(IN.uv.x + shift));
                float b = step(0.48, frac(IN.uv.x + shift - _RGBShift));

                // Each strip flashes on/off
                float flash = hash21(float2(band * 1.234, floor(_Time.y * _Speed * 0.5)));
                col = float3(r, g, b) * flash;

                return half4(col, 1.0);
            }
            ENDHLSL
        }
    }
}
