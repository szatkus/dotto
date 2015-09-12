module Game where
  import Haste.DOM
  import Haste.Graphics.Canvas
  import Haste.Graphics.AnimationFrame

  import Renderer
  import Objects
  import State

  doGameLoop :: GameState -> Canvas -> HRTimeStamp -> IO ()
  doGameLoop state canvas timestamp = do
    let newState = stepState state timestamp
    renderFrame canvas newState
    requestAnimationFrame $ doGameLoop newState canvas
    return ()

  startGame :: Canvas -> IO ()
  startGame canvas = do
    image <- loadBitmap "images/stickman.png"
    let initialState = GameState {
          objects=[GameObject {x=30, y=40, width=24, height=32, image=image}]
        }
    requestAnimationFrame $ doGameLoop initialState canvas
    return ()
