module Renderer where
  import Haste.Graphics.Canvas

  import State
  import Objects

  renderObject :: Canvas -> GameObject -> Picture ()
  renderObject canvas object = fill $ rect (x object, y object) (x object + width object, y object + height object)

  renderFrame :: Canvas -> GameState ->  IO ()
  renderFrame canvas state = do
    let renders = map (renderObject canvas) (objects state)
    render canvas $ foldr (>>) (setFillColor (RGB 0 0 0)) renders