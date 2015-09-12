import Haste.DOM
import Haste.Graphics.Canvas
import Control.Monad.IO.Class
import Haste.Graphics.AnimationFrame

data GameObject = GameObject {
  x :: Double,
  y :: Double,
  width :: Double,
  height :: Double
}

data GameState = GameState {
  objects :: [GameObject]
}

renderObject :: Canvas -> GameObject -> Picture ()
renderObject canvas object = fill $ rect (x object, y object) (x object + width object, y object + height object)

renderFrame :: Canvas -> GameState ->  IO ()
renderFrame canvas state = do
  let renders = map (renderObject canvas) (objects state)
  render canvas $ foldr (>>) (setFillColor (RGB 0 0 0)) renders

stepState :: GameState -> HRTimeStamp -> GameState
stepState state _ = state

doGameLoop :: GameState -> Canvas -> HRTimeStamp -> IO ()
doGameLoop state canvas timestamp = do
  let newState = stepState state timestamp
  renderFrame canvas newState
  requestAnimationFrame $ doGameLoop newState canvas
  return ()

startGame :: Canvas -> IO ()
startGame canvas = do
  let initialState = GameState {
    objects=[GameObject {x=30, y=40, width=40, height=60}]
  }
  requestAnimationFrame $ doGameLoop initialState canvas
  return ()

main = do
  Just canvas <- getCanvasById "screen"
  startGame canvas
