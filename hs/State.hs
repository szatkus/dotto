module State where
  import Objects

  data GameState = GameState {
    objects :: [GameObject]
  }

  stepState :: GameState -> Double -> GameState
  stepState state _ = state
