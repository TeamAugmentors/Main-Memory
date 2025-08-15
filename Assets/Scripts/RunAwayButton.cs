using UnityEngine;

public class RunAwayButtonTeleport : MonoBehaviour
{
    [SerializeField] private RectTransform buttonRect;
    [SerializeField] private float safeDistance = 100f; // pixels in world space
    [SerializeField] private Camera uiCamera;

    private RectTransform canvasRect;

    private void Start()
    {
        if (buttonRect == null)
            buttonRect = GetComponent<RectTransform>();

        canvasRect = buttonRect.GetComponentInParent<Canvas>().GetComponent<RectTransform>();

        if (uiCamera == null)
            uiCamera = Camera.main;
    }

    private void Update()
    {
        // Mouse position in world space
        Vector3 mouseWorldPos = uiCamera.ScreenToWorldPoint(Input.mousePosition);
        mouseWorldPos.z = 0f;

        // Button world position
        Vector3 buttonWorldPos = buttonRect.position;

        Debug.Log(mouseWorldPos + " - " + buttonWorldPos + " - " + Vector2.Distance(buttonWorldPos, mouseWorldPos));
        
        if (Vector2.Distance(mouseWorldPos, buttonWorldPos) < safeDistance / uiCamera.pixelHeight * canvasRect.rect.height)
        {
            // Pick a random position inside the canvas (world space)
            Vector3 randomWorldPos = GetRandomWorldPositionAwayFrom(mouseWorldPos);

            // Convert world position to local position relative to button's parent
            buttonRect.localPosition = buttonRect.parent.InverseTransformPoint(randomWorldPos);
        }
    }

    private Vector3 GetRandomWorldPositionAwayFrom(Vector3 avoidPos)
    {
        // Canvas corners in world space
        Vector3[] corners = new Vector3[4];
        canvasRect.GetWorldCorners(corners);

        Vector3 randomPos;
        do
        {
            randomPos = new Vector3(
                Random.Range(corners[0].x, corners[2].x),
                Random.Range(corners[0].y, corners[2].y),
                0f
            );
        }
        while (Vector2.Distance(randomPos, avoidPos) < safeDistance * 1.5f);

        return randomPos;
    }
}