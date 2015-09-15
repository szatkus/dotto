module Objects where
  import Haste.Graphics.Canvas

  data Action = Move Double Double | NoAction deriving (Show)

  data GameObject = GameObject {
    x :: Double,
    y :: Double,
    width :: Double,
    height :: Double,
    speed :: Double,
    image :: Bitmap,
    actions :: [Action]
  } | Player GameObject
