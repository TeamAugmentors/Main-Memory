using System;
using System.IO;
using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEngine;
using UnityEngine.UI;

public static class WebGLUIInputValidation
{
    [MenuItem("Tools/UI Input/Validate RenderTexture Coordinates")]
    public static void Validate()
    {
        var root = new GameObject("UI coordinate validation") { hideFlags = HideFlags.HideAndDontSave };
        var texture = new RenderTexture(1920, 1080, 0);
        try
        {
            var source = Child<Camera>(root, "Texture camera");
            source.enabled = false;
            source.transform.position = new Vector3(0, 0, -10);
            source.orthographic = true;
            source.orthographicSize = 540;
            source.aspect = 1920f / 1080f;
            source.targetTexture = texture;

            var screen = Child<Camera>(root, "Display camera");
            screen.enabled = false;
            screen.transform.position = source.transform.position;
            screen.orthographic = true;
            screen.orthographicSize = 540;
            screen.aspect = source.aspect;

            var displayCanvas = Child<Canvas>(root, "Display canvas");
            displayCanvas.renderMode = RenderMode.WorldSpace;
            displayCanvas.worldCamera = screen;
            var image = Child<RawImage>(displayCanvas.gameObject, "Display");
            image.rectTransform.sizeDelta = new Vector2(1920, 1080);
            image.texture = texture;

            var contentCanvas = Child<Canvas>(root, "Content canvas");
            contentCanvas.renderMode = RenderMode.WorldSpace;
            contentCanvas.worldCamera = source;
            var raycaster = contentCanvas.gameObject.AddComponent<RenderTextureGraphicRaycaster>();
            var serialized = new SerializedObject(raycaster);
            serialized.FindProperty("renderCamera").objectReferenceValue = source;
            serialized.FindProperty("display").objectReferenceValue = image;
            serialized.ApplyModifiedPropertiesWithoutUndo();

            int checks = 0;
            float maxError = 0;
            foreach (var viewport in new[] {
                new Rect(0, 0, 960, 600), new Rect(0, 0, 1920, 1080),
                new Rect(0, 0, 1280, 720), new Rect(0, 0, 390, 844),
                new Rect(70, 61, 960, 600), new Rect(0, 0, 780, 1000) })
            foreach (var uv in new[] { new Rect(0, 0, 1, 1), new Rect(.1f, .2f, .8f, .6f) })
            {
                screen.pixelRect = viewport;
                screen.projectionMatrix = source.projectionMatrix;
                image.uvRect = uv;
                var eventCamera = raycaster.eventCamera;
                foreach (var point in new[] { new Vector2(.15f, .15f), new Vector2(.5f, .5f),
                    new Vector2(.85f, .85f), new Vector2(.3f, .75f) })
                {
                    var texturePoint = new Vector3(uv.x + point.x * uv.width,
                        uv.y + point.y * uv.height, 10);
                    var world = source.ViewportToWorldPoint(texturePoint);
                    var expected = new Vector2(viewport.x + point.x * viewport.width,
                        viewport.y + point.y * viewport.height);
                    var actual = (Vector2)eventCamera.WorldToScreenPoint(world);
                    float error = Vector2.Distance(expected, actual);
                    maxError = Mathf.Max(maxError, error);
                    if (error > .05f)
                        throw new Exception($"Coordinate mismatch: {viewport}, {uv}, {expected} != {actual}; display rect={screen.pixelRect}, input rect={eventCamera.pixelRect}, image={image.rectTransform.rect}, position={image.transform.position}");
                    var ray = eventCamera.ScreenPointToRay(expected);
                    var plane = new Plane(Vector3.forward, world);
                    if (!plane.Raycast(ray, out float distance) || Vector3.Distance(ray.GetPoint(distance), world) > .05f)
                        throw new Exception("Pointer/caret ray does not return to the displayed UI plane.");
                    checks++;
                }
                if (eventCamera.enabled || eventCamera.targetTexture != null || source.targetTexture != texture)
                    throw new Exception("Input mapping changed the rendering setup.");
            }
            Directory.CreateDirectory("Build");
            var report = $"PASS: {checks} projection and pointer-ray round trips; maximum error {maxError:F5} pixels.\n"
                + "Sizes: 960x600, 1920x1080, 1280x720, 390x844, offset viewport, 780x1000; full and cropped UVs.\n";
            File.WriteAllText("Build/ui-input-validation.txt", report);
            Debug.Log(report);
        }
        finally
        {
            UnityEngine.Object.DestroyImmediate(root);
            UnityEngine.Object.DestroyImmediate(texture);
        }
    }

    private static T Child<T>(GameObject parent, string name) where T : Component
    {
        var child = new GameObject(name) { hideFlags = HideFlags.HideAndDontSave };
        child.transform.SetParent(parent.transform, false);
        return child.AddComponent<T>();
    }

    [MenuItem("Tools/UI Input/Validate and Build WebGL")]
    public static void Build()
    {
        Validate();
        var report = BuildPipeline.BuildPlayer(new BuildPlayerOptions {
            scenes = new[] { "Assets/Scenes/Menu.unity" },
            locationPathName = "Build/WebGL-UI-Fix",
            target = BuildTarget.WebGL,
            options = BuildOptions.None
        });
        File.WriteAllText("Build/ui-input-build.txt", report.summary.result + "\n"
            + report.summary.totalErrors + " errors\n" + report.summary.totalTime);
        if (report.summary.result != BuildResult.Succeeded)
            throw new Exception("WebGL UI verification build failed: " + report.summary.result);
    }
}


