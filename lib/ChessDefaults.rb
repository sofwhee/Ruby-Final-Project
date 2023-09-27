class ChessDefaults

  def default_positions
    black_positions = {
      "rooks"   => [['a', '8'], ['h', '8']]
      "knights" => [['b', '8'], ['g', '8']]
      "bishops" => [['c', '8'], ['f', '8']]
      "queens"  => [['d', '8']]
      "kings"   => [['e', '8']]
      "pawns"   => nil
    }

    white_positions = {
      "rooks"   => [['a', '1'], ['h', '1']]
      "knights" => [['b', '1'], ['g', '1']]
      "bishops" => [['c', '1'], ['f', '1']]
      "queens"  => [['d', '1']]
      "kings"   => [['e', '1']]
      "pawns"   => nil
    }

    black_pawns = []
    white_pawns = []

    for i in (1..8)
      letters = %w(a b c d e f g h)
      black_pawns << [letters[i-1], '7']
      white_pawns << [letters[i-1], '2']
    end

    black_positions["pawns"] = black_pawns
    white_positions["pawns"] = white_pawns

    [black_positions, white_positions]
  end

end