module Objects where
  import Haste.Graphics.Canvas
  
  data GameObject = GameObject {
    x :: Double,
    y :: Double,
    width :: Double,
    height :: Double,
    image :: Bitmap
  }
