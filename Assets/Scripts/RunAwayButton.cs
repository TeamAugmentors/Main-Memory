using System;
using UnityEngine;
using UnityEngine.EventSystems;
using Random = UnityEngine.Random;

public class ButtonEvents : MonoBehaviour, IPointerEnterHandler
{
    [SerializeField] RectTransform btnRectTransform;
    
    //set limit for the button to teleport
    private Vector2 windowMinRange = new(-500f, -800f);
    private Vector2 windowMaxRange = new(1500f, 500f);
    
    public void OnPointerEnter(PointerEventData eventData)
    {
        btnRectTransform.anchoredPosition = GetRandomButtonPosition();
    }

    private Vector2 GetRandomButtonPosition()
    {
        return new Vector2(Random.Range(windowMinRange.x, windowMaxRange.x), Random.Range(windowMinRange.y, windowMaxRange.y));
    }
}