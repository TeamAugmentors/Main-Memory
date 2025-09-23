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

        [Obsolete("This rendering path is for compatibility mode only (when Render Graph is disabled). Use Render Graph API instead.", false)]
        public override void Execute(ScriptableRenderContext context, ref RenderingData renderingData)
        {
            if (!enabled || mat == null) return;

            CommandBuffer cmd = CommandBufferPool.Get(profilerTag);

            RenderTargetIdentifier source = renderingData.cameraData.renderer.cameraColorTargetHandle;
            int tempID = Shader.PropertyToID("_TempColorTexture");

            // Allocate temp RT with same descriptor as camera
            cmd.GetTemporaryRT(tempID, renderingData.cameraData.cameraTargetDescriptor);
            RenderTargetIdentifier tempRT = new RenderTargetIdentifier(tempID);

            // Copy camera color into temp
            cmd.Blit(source, tempRT);

            // Blit temp → camera using glitch material
            cmd.Blit(tempRT, source, mat);

            // Cleanup
            cmd.ReleaseTemporaryRT(tempID);

            context.ExecuteCommandBuffer(cmd);
            CommandBufferPool.Release(cmd);
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
