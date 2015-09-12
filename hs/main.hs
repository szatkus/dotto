import Control.Monad.IO.Class

import Haste.DOM
import Haste.Graphics.Canvas
import Haste.Graphics.AnimationFrame

import Game

main = do
  Just canvas <- getCanvasById "screen"
  startGame canvas
