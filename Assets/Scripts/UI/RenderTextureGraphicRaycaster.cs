using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

/// <summary>
/// Raycasts a world-space canvas shown through an axis-aligned RawImage.
/// Keep pointer positions in screen space so TMP caret placement and dragging
/// use the same mapping as hit testing through PointerEventData's event camera.
/// </summary>
public sealed class RenderTextureGraphicRaycaster : GraphicRaycaster
{
    [SerializeField] private Camera renderCamera;
    [SerializeField] private RawImage display;

    private Camera inputCamera;
    private readonly Vector3[] corners = new Vector3[4];

    public override Camera eventCamera
    {
        get
        {
            if (renderCamera == null || display == null || display.canvas == null)
                return null;

            if (inputCamera == null)
            {
                var cameraObject = new GameObject("RenderTexture UI Event Camera");
                cameraObject.hideFlags = HideFlags.HideAndDontSave;
                inputCamera = cameraObject.AddComponent<Camera>();
                inputCamera.enabled = false;
            }

            var displayCanvas = display.canvas.rootCanvas;
            var displayCamera = displayCanvas.renderMode == RenderMode.ScreenSpaceOverlay
                ? null : displayCanvas.worldCamera;
            display.rectTransform.GetWorldCorners(corners);
            var bottomLeft = RectTransformUtility.WorldToScreenPoint(displayCamera, corners[0]);
            var topRight = RectTransformUtility.WorldToScreenPoint(displayCamera, corners[2]);

            inputCamera.CopyFrom(renderCamera);
            inputCamera.enabled = false;
            inputCamera.targetTexture = null;
            inputCamera.cullingMask = 0;
            inputCamera.transform.SetPositionAndRotation(renderCamera.transform.position,
                renderCamera.transform.rotation);
            inputCamera.worldToCameraMatrix = renderCamera.worldToCameraMatrix;
            inputCamera.pixelRect = Rect.MinMaxRect(bottomLeft.x, bottomLeft.y, topRight.x, topRight.y);

            // Preserve the texture camera's projection even when the browser has
            // a different aspect ratio. Account for the RawImage's UV rectangle.
            var uv = display.uvRect;
            var crop = Matrix4x4.identity;
            crop.m00 = 1f / uv.width;
            crop.m11 = 1f / uv.height;
            crop.m03 = (1f - 2f * uv.x - uv.width) / uv.width;
            crop.m13 = (1f - 2f * uv.y - uv.height) / uv.height;
            inputCamera.projectionMatrix = crop * renderCamera.projectionMatrix;
            return inputCamera;
        }
    }

    public override void Raycast(PointerEventData eventData, List<RaycastResult> results)
    {
        if (renderCamera == null || display == null || !display.isActiveAndEnabled
            || display.texture != renderCamera.targetTexture
            || display.rectTransform.rect.width <= 0f || display.rectTransform.rect.height <= 0f
            || Mathf.Approximately(display.uvRect.width, 0f)
            || Mathf.Approximately(display.uvRect.height, 0f))
            return;

        base.Raycast(eventData, results);
    }

    protected override void OnDisable()
    {
        base.OnDisable();
        if (inputCamera == null)
            return;

        if (Application.isPlaying)
            Destroy(inputCamera.gameObject);
        else
            DestroyImmediate(inputCamera.gameObject);
        inputCamera = null;
    }
}
