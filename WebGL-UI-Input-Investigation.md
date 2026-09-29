# WebGL UI input investigation

## Cause and reproduction

The conversation UI is a world-space Canvas rendered by `ConversationCam` into
`RT_Conversation` (1920 x 1080). `UI/ConversationDisplay` stretches that texture
over the screen. The original GraphicRaycaster used `ConversationCam` directly,
so it interpreted screen pointer positions as render-texture pixel positions.
No conversion connected the displayed RawImage rectangle to that camera.

The existing browser build reproduced this at a 960 x 600 drawing buffer (DPR 1).
With the canvas at browser position (70, 61):

- The normal Options button worked at its visible center.
- The conversation Yes button at approximately (390, 525) did not respond.
- Clicking (710, 416), the displaced texture-coordinate location, activated Yes.
- Clicking the visible name input at (550, 456) and typing did nothing.
- Clicking its displaced region at (900, 292) allowed `Baseline` to be typed.

This demonstrates displaced hit testing and failure to acquire focus, rather
than a keyboard-capture failure after focus. The Editor Game view was set to
1920 x 1080, masking the mismatch. Different iframe sizes, fullscreen sizes,
browser zoom and device pixel ratios expose it on desktop as well as mobile.

## Inspection

- The enabled build scene is `Assets/Scenes/Menu.unity`.
- There is one EventSystem and one InputSystemUIInputModule in the scene and
  referenced prefabs. Active Input Handling is Input System only. The module
  uses the package's DefaultInputActions with mouse and touchscreen UI bindings.
  The separate project-wide action asset is not a second UI input module.
- Main UI: Screen Space Camera, assigned Camera, Scale With Screen Size,
  1920 x 1080 reference, match 0.8. Conversation: World Space, assigned texture
  camera, 1920 x 1080 RectTransform; its CanvasScaler does not convert input
  coordinates between a RenderTexture and its displayed image.
- Main and conversation raycasters have physics blocking disabled. Nested
  Options and FileSystem canvases/raycasters were also inspected. FileSystem
  has override sorting 5000. No duplicate EventSystem is instantiated by scripts.
- ConversationDisplay already has Raycast Target disabled. It is not an
  invisible full-screen click interceptor.
- Buttons and TMP input fields have their target Image on the same GameObject
  and RectTransform, with zero raycast padding and Raycast Target enabled.
  Text labels and panel graphics also participate in raycasts. The transparent
  Options Dropdown/Fill/Arrow graphics belong to those controls; no evidence
  linked them to the reproduced conversation offset.
- GameVisualChanges is a raycastable visual overlay behind ConversationDisplay
  in the main Canvas, initially disabled. It did not cause the reproduced issue.
- The Exit popup deliberately has a pointer-enter runaway-button script. This
  existing behavior was retained, as were the disabled Start button and the
  story's Options/Enable Start Game flow.
- TMP fields are editable; mobile input and soft keyboard are not disabled.
  Name submission uses OnEndEdit (including loss of focus), which is unchanged.
- There are no custom WebGL templates, JavaScript plugins, resolution/fullscreen
  scripts, pointer rewrites or WebGL keyboard-capture overrides in Assets.
- The selected built-in Default Web template uses a 960 x 600 desktop container,
  mobile viewport metadata/full-area canvas, and Unity SetFullscreen. Automatic
  drawing-buffer/DOM sizing remains enabled. At the tested desktop size the DOM
  and buffer were both 960 x 600. Its loading overlay hides when loading finishes.
  A desktop iframe narrower than 960 can crop this default layout; that is a
  separate layout limitation, not the reproduced coordinate offset.

## Changes

- `Assets/Scripts/UI/RenderTextureGraphicRaycaster.cs` and its meta: a scoped
  GraphicRaycaster subclass with a disabled, hidden event-only camera. It copies
  the rendering projection and maps it to the RawImage's current screen rectangle
  (including UV cropping). Pointer positions remain unchanged, so buttons,
  TMP caret placement and drag selection use the same screen-space event camera.
  It updates on query, including after resize/fullscreen, and cleans up its camera.
- `Assets/Scenes/Menu.unity`: replaces only ConversationCanvas's raycaster and
  supplies its existing camera and RawImage references.
- `Assets/Editor/WebGLUIInputValidation.cs` and Editor meta files: repeatable
  coordinate regression checks and a separate WebGL verification build command
  under **Tools > UI Input**. The build goes to `Build/WebGL-UI-Fix`.

UI graphics, dimensions, Canvas Scalers, input actions, keyboard settings,
story callbacks, rendering camera and texture are unchanged. The separate
GlitchFeature_Compat rendering warning is outside this fix.

The checked-out project and running Editor report **6000.6.2f1 (Unity 6.6)**,
although the request described 6.4. Existing upgrade/package/rendering edits
were already present and were preserved.

## Verification

The Editor compiled the new code. The coordinate harness passed 48 projection
and inverse pointer-ray checks with maximum error 0.00008 pixels, covering
960 x 600, 1920 x 1080, 1280 x 720, 390 x 844, an offset viewport and 780 x 1000,
with full and cropped UV rectangles. The original texture remains assigned and
the event camera remains disabled and has no render target.

## Fresh itch.io upload checks

1. Build the updated Menu scene, or use Tools > UI Input > Validate and Build
   WebGL. Upload the complete build with index.html at the ZIP root. Use a fresh
   page load so cached files from an older build are not mixed with the new build.
2. At normal embed size and 100% zoom, open Options, enable Start Game and close
   Options. Click the centers and near edges of Yes and No across the dialogue.
   Wait for typewriter text to finish because choices are intentionally hidden
   until then. No click should need a displaced point.
3. Follow Yes three times to the name field. Click it, type, use Backspace and
   arrow keys, drag-select text, and submit with Enter. Verify the story advances
   once. Keep the existing OnEndEdit behavior in mind when clicking outside it.
4. Repeat after entering and exiting fullscreen, changing window size and using
   80%, 125% and 150% browser zoom. Also open the save panel and edit a slot name;
   verify its close button and that the panel takes input over the conversation.
5. On real Android Chrome and iOS Safari, test taps and the software keyboard in
   portrait/landscape, including after rotation and keyboard dismissal. Check
   fullscreen where the browser supports it. Desktop size simulation cannot
   verify a real touchscreen or mobile keyboard.

If only itch.io still fails, record browser, device, zoom, embed size, fullscreen
state and whether there is a caret before typing. Those distinguish an embedding
or keyboard issue from a return of the demonstrated coordinate mismatch.
