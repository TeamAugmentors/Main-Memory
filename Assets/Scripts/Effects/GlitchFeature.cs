using System;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

public class GlitchFeature_Compat : ScriptableRendererFeature
{
    [System.Serializable]
    public class Settings
    {
        public Material glitchMaterial;
        public bool enabled = false;
        public RenderPassEvent when = RenderPassEvent.AfterRendering;
    }

    class GlitchPass : ScriptableRenderPass
    {
        private Material mat;
        private bool enabled;
        private string profilerTag = "GlitchPassCompat";

        public GlitchPass(Material mat, bool enabled, RenderPassEvent evt)
        {
            this.mat = mat;
            this.enabled = enabled;
            renderPassEvent = evt;
        }

        public void Update(Material mat, bool enabled, RenderPassEvent evt)
        {
            this.mat = mat;
            this.enabled = enabled;
            renderPassEvent = evt;
        }
    }

    public Settings settings = new Settings();
    private GlitchPass pass;

    public override void Create()
    {
        pass = new GlitchPass(settings.glitchMaterial, settings.enabled, settings.when);
    }

    public override void AddRenderPasses(ScriptableRenderer renderer, ref RenderingData renderingData)
    {
        pass.Update(settings.glitchMaterial, settings.enabled, settings.when);
        renderer.EnqueuePass(pass);
    }

    // Simple toggle API for runtime
    public void Toggle(bool on) => settings.enabled = on;
}
