Shader "Custom/ProceduralVirusRGBGlitch"
{
    Properties
    {
        // Core look
        _StripDensity   ("Strip Density (rows)", Range(40, 400)) = 180
        _CellRepeatX    ("Cell Repeat X", Range(10, 400)) = 160
        _StreakWidth    ("Streak Width", Range(0.001, 0.08)) = 0.02
        _RGBShift       ("RGB Shift", Range(0, 0.05)) = 0.007

        // Dynamics
        _Speed          ("Speed", Range(0, 10)) = 2.2
        _Jitter         ("Jitter Amount", Range(0, 0.2)) = 0.035
        _FlashProb      ("Row Flash Probability", Range(0, 1)) = 0.70
        _SpeckleProb    ("Speckle Probability", Range(0, 1)) = 0.05

        // Tonemix / palette
        _MagentaBias    ("Magenta Bias", Range(0, 2)) = 1.0
        _BlueBias       ("Blue Bias",    Range(0, 2)) = 1.0
        _GreenBurst     ("Green Bursts", Range(0, 2)) = 0.9
        _RedBurst       ("Red Bursts",   Range(0, 2)) = 0.6
        _StripAlpha     ("Strip Alpha",  Range(0, 1)) = 0.85

        // Film / vignette / bulge
        _GrainAmount    ("Film Grain", Range(0, 0.2)) = 0.05
        _Vignette       ("Vignette",   Range(0, 2)) = 1.2
        _CenterWarp     ("Center Warp", Range(-1, 1)) = 0.22
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" "RenderPipeline"="UniversalPipeline" }
        Pass
        {
            Name "ProceduralVirusRGBGlitch"
            ZWrite Off Cull Off Blend One OneMinusSrcAlpha

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"

            // ---------- parameters ----------
            float _StripDensity, _CellRepeatX, _StreakWidth, _RGBShift;
            float _Speed, _Jitter, _FlashProb, _SpeckleProb;
            float _MagentaBias, _BlueBias, _GreenBurst, _RedBurst, _StripAlpha;
            float _GrainAmount, _Vignette, _CenterWarp;

            struct Attributes { float4 positionOS : POSITION; float2 uv : TEXCOORD0; };
            struct Varyings   { float4 positionCS : SV_POSITION; float2 uv : TEXCOORD0; };

            Varyings vert (Attributes IN)
            {
                Varyings OUT;
                OUT.positionCS = TransformObjectToHClip(IN.positionOS.xyz);
                OUT.uv = IN.uv;
                return OUT;
            }

            // --------- small helpers (no textures) ----------
            // fast hash
            float hash21(float2 p)
            {
                p = frac(p * float2(123.34, 345.45));
                p += dot(p, p + 34.345);
                return frac(p.x * p.y);
            }

            // iq-like noise (cheap)
            float noise(float2 p)
            {
                float2 i = floor(p);
                float2 f = frac(p);
                float a = hash21(i);
                float b = hash21(i + float2(1,0));
                float c = hash21(i + float2(0,1));
                float d = hash21(i + float2(1,1));
                float2 u = f*f*(3-2*f);
                return lerp(lerp(a,b,u.x), lerp(c,d,u.x), u.y);
            }

            // palette tilt toward magenta/blue with rare green/red pops
            float3 palette(float3 rgb, float laneRand)
            {
                // base magenta-blue mix
                rgb.r *= (0.7 + _MagentaBias * 0.6);
                rgb.g *= (0.6);
                rgb.b *= (0.9 + _BlueBias * 0.7);

                // sparse color “bursts”
                float gBurst = step(1.0 - _GreenBurst * 0.15, laneRand);
                float rBurst = step(1.0 - _RedBurst   * 0.12, frac(laneRand*13.7));
                rgb += float3(0.0, 0.8*gBurst, 0.5*rBurst);

                // clamp
                return saturate(rgb);
            }

            // subtle center bulge (fisheye-ish)
            float2 warpCenter(float2 uv)
            {
                float2 p = uv - 0.5;
                float r2 = dot(p, p);
                float k  = _CenterWarp * 0.6;   // gentle
                float2 pw = p * (1.0 + k * r2); // barrel (k>0) / pincushion (k<0)
                return pw + 0.5;
            }

            half4 frag (Varyings IN) : SV_Target
            {
                // black base
                float3 col = 0;

                // warped coordinates to mimic the center focus/bulge
                float2 uv = warpCenter(IN.uv);

                // per-row lane
                float lane = floor(uv.y * _StripDensity);

                // flicker rows on/off (to get sparse distribution)
                float laneSeed   = hash21(float2(lane, floor(_Time.y * _Speed)));
                if (laneSeed > _FlashProb) return half4(0,0,0,1);

                // jitter per lane (causes phase offsets & micro breaks)
                float jx = (hash21(float2(lane, 11.2)) - 0.5) * _Jitter;
                float n  = noise(uv * float2(_CellRepeatX*0.07, 6.0) + _Time.y*0.6);
                float nx = n * (_Jitter * 0.8);

                // RGB channel shifts per lane
                float sR = (hash21(float2(lane, 1.0)) - 0.5) * _RGBShift;
                float sG = (hash21(float2(lane, 2.0)) - 0.5) * _RGBShift;
                float sB = (hash21(float2(lane, 3.0)) - 0.5) * _RGBShift;

                // stochastic cell pattern along X so lengths vary
                float cell = frac(uv.x * _CellRepeatX + jx + nx);
                float maskR = smoothstep(_StreakWidth, 0.0, abs(cell - sR));
                float maskG = smoothstep(_StreakWidth, 0.0, abs(cell - sG));
                float maskB = smoothstep(_StreakWidth, 0.0, abs(cell - sB));

                float3 baseRGB = float3(maskR, maskG, maskB);

                // palette & intensity shaping
                baseRGB = palette(baseRGB, laneSeed);

                // introduce micro gaps so lines feel chopped like the reference
                float chop = step(0.18, noise(float2(uv.x * _CellRepeatX*0.5, lane*1.91 + _Time.y*1.7)));
                baseRGB *= chop;

                // film speckles / hot pixels (very rare)
                float speck = step(1.0 - _SpeckleProb, hash21(frac(uv * float2(311.7, 227.3) + _Time.yy)));
                float3 speckRGB = float3(0.9, 0.2, 1.2) * speck;

                // additive build
                col += baseRGB * _StripAlpha + speckRGB * 0.4;

                // subtle film grain & vignetting (dark edges, brighter center)
                float g = (noise(uv * 960.0 + _Time.y * 13.0) - 0.5) * _GrainAmount * 2.0;
                float2 c = uv - 0.5;
                float vign = saturate(1.0 - _Vignette * dot(c, c));
                col = saturate(col * vign + g);

                return half4(col, 1);
            }
            ENDHLSL
        }
    }
}
