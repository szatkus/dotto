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

  attachActionsFromInput :: InputState -> GameObject -> GameObject
  attachActionsFromInput inputState (Player object) =
    Player $ object {actions=actions object ++ newActions} where
      newActions = [moveRight, moveLeft, moveUp, moveDown]
      moveRight = if keys inputState !! 39 then Move (speed object) 0 else NoAction
      moveLeft = if keys inputState !! 37 then Move (-speed object) 0 else NoAction
      moveUp = if keys inputState !! 38 then Move 0 (-speed object) else NoAction
      moveDown = if keys inputState !! 40 then Move 0 (speed object) else NoAction
  attachActionsFromInput _ object@GameObject {} = object

  applyInputs :: GameState -> InputState -> GameState
  applyInputs gameState inputState = gameState {objects=objects'} where
    objects' = map (attachActionsFromInput inputState) (objects gameState)

  doGameLoop :: GameState -> Canvas -> IORef InputState -> HRTimeStamp -> IO ()
  doGameLoop state canvas inputStateRef timestamp = do
    inputState <- readIORef inputStateRef
    let state' = applyInputs state inputState
        newState = (stepState state' delta) {lastUpdate=timestamp}
        delta = (timestamp - (lastUpdate state)) / 1000
    renderFrame canvas newState
    requestAnimationFrame $ doGameLoop newState canvas inputStateRef
    return ()

  startGame :: Canvas -> IO ()
  startGame canvas = do
    image <- loadBitmap "images/stickman.png"
    inputStateRef <- newIORef $ InputState $ replicate 256 False
    attachEvents inputStateRef
    let initialState = GameState {
          objects=[Player $ GameObject {x=30, y=40, width=24, height=32, image=image, speed=40, actions=[]}],
          lastUpdate=0
        }
    requestAnimationFrame $ doGameLoop initialState canvas inputStateRef
    return ()
