module Game where
  import Data.IORef

  import Haste.DOM
  import Haste.Events
  import Haste.Graphics.Canvas
  import Haste.Graphics.AnimationFrame

  import Events
  import Renderer
  import Objects
  import State

  doGameLoop :: GameState -> Canvas -> IORef InputState -> HRTimeStamp -> IO ()
  doGameLoop state canvas inputStateRef timestamp = do
    let newState = stepState state timestamp
    renderFrame canvas newState
    requestAnimationFrame $ doGameLoop newState canvas inputStateRef
    return ()

  startGame :: Canvas -> IO ()
  startGame canvas = do
    image <- loadBitmap "images/stickman.png"
    inputStateRef <- newIORef $ InputState $ replicate 256 False
    attachEvents inputStateRef
    let initialState = GameState {
          objects=[GameObject {x=30, y=40, width=24, height=32, image=image}]
        }
    requestAnimationFrame $ doGameLoop initialState canvas inputStateRef
    return ()
