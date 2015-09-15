module State where
  import Objects

  data GameState = GameState {
    objects :: [GameObject],
    lastUpdate :: Double
  }

  applyActions :: Double -> GameObject -> [Action] -> GameObject
  applyActions _ object [] = object
  applyActions delta object (NoAction:actions) = applyActions delta object actions
  applyActions delta object ((Move dx dy):actions) = applyActions delta object' actions where
    object' = object {x=x object + dx * delta, y=y object + dy * delta}

  stepObject :: Double -> GameObject -> GameObject
  stepObject delta (Player object) = Player $ stepObject delta object
  stepObject delta object = object'{actions=[]} where
    object' = applyActions delta object $ actions object

  stepState :: GameState -> Double -> GameState
  stepState state delta = state {objects=map (stepObject delta) objects'} where objects' = objects state
