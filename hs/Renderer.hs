module Renderer where
  import Haste.Graphics.Canvas

  import State
  import Objects

  renderObject :: Canvas -> GameObject -> Picture ()
  renderObject canvas object = drawScaled (image object) (Rect (x object) (y object) (width object) (height object))

  renderFrame :: Canvas -> GameState ->  IO ()
  renderFrame canvas state = do
    let renders = map (renderObject canvas) (objects state)
    render canvas $ foldr (>>) (setFillColor (RGB 0 0 0)) renders
