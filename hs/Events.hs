module Events where
  import Data.IORef

  import Haste.DOM
  import Haste.Events

  data InputState = InputState  {keys :: [Bool]}

  attachEvents :: IORef InputState -> IO ()
  attachEvents stateRef = do
    handler <- onEvent document KeyDown $ onKeyDown stateRef
    return ()

  onKeyDown :: IORef InputState -> KeyData -> IO ()
  onKeyDown stateRef keyData = do
    state <- readIORef stateRef
    let code = keyCode keyData
        (keysHead, _:keysTail) = splitAt code $ keys state
        newState = state {keys=keysHead ++ [True] ++ keysTail}
    print code
    writeIORef stateRef newState
