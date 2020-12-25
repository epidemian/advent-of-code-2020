require 'set'

at_exit do
  decks = File.read('inputs/day22').split("\n\n").map { |s|
    s.lines.drop(1).map(&:to_i)
  }

  play_combat(decks)
  play_recursive_combat(decks)
end

def play_combat(decks)
  decks = decks.map(&:dup)

  while decks.none?(&:empty?)
    cards_played = decks.map(&:shift)
    round_winner = cards_played.index(cards_played.max)
    decks[round_winner].concat(cards_played.sort.reverse)
  end

  puts score(decks[round_winner])
end

def play_recursive_combat(decks, recurring: false)
  previous_rounds = Set.new

  while decks.none?(&:empty?)
    serialized = Marshal.dump(decks)
    return 0 if previous_rounds.include?(serialized)
    previous_rounds << serialized

    cards_played = decks.map(&:shift)
    if cards_played.zip(decks).all? { |card, deck| card <= deck.size }
      subdecks = cards_played.zip(decks).map { |card, deck| deck.take(card) }
      round_winner = play_recursive_combat(subdecks, recurring: true)
    else
      round_winner = cards_played.index(cards_played.max)
    end
    decks[round_winner].push(cards_played[round_winner], cards_played[round_winner - 1])
  end

  puts score(decks[round_winner]) unless recurring

  round_winner
end

def score(deck)
  deck.reverse.map.with_index { |c, i| c * i.next }.sum
end
