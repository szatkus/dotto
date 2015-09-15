module Events where
  import Data.IORef

  import Haste.DOM
  import Haste.Events

  data InputState = InputState  {keys :: [Bool]}

  attachEvents :: IORef InputState -> IO ()
  attachEvents stateRef = do
    _ <- onEvent document KeyDown $ onKeyDown stateRef
    _ <- onEvent document KeyUp $ onKeyUp stateRef
    return ()

  onKeyDown :: IORef InputState -> KeyData -> IO ()
  onKeyDown stateRef keyData = changeKeyState stateRef keyData True

  onKeyUp :: IORef InputState -> KeyData -> IO ()
  onKeyUp stateRef keyData = changeKeyState stateRef keyData False

  changeKeyState :: IORef InputState -> KeyData -> Bool -> IO ()
  changeKeyState stateRef keyData value = do
    state <- readIORef stateRef
    let code = keyCode keyData
        (keysHead, _:keysTail) = splitAt code $ keys state
        newState = state {keys=keysHead ++ [value] ++ keysTail}
    print code
    writeIORef stateRef newState
