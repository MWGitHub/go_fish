# Go Fish

## Rules

* You have **1 hour** for the assessment. Do not worry if you do not
  complete all the assessment; finish as much as you can.
* Descriptions of each method to implement are written into the `lib/`
  files. For each `lib/` file, there is a corresponding `spec/` file.
* Run the specs as you solve the assessment. Solve the assessment in
  this order:

```
bundle exec rspec spec/deck_spec.rb
bundle exec rspec spec/hand_spec.rb
bundle exec rspec spec/player_spec.rb
bundle exec rspec spec/game_spec.rb
```

* Wait until you finish to run `rspec spec`, which will run all the
  tests. Do this as a final check that you have them all passing.

## Game Rules

* Each player has a hand of cards.
* The goal is to have the most "books" (sets of 4-of-a-kind) at the end
  of the game.
* Play goes around in turns. On each turn:
  * The current player asks a target player for a card by value.
  * If the target player has any cards matching the requested value:
    * The current player takes those cards, and then takes another turn.
  * Otherwise:
    * The current player draws from the deck ("goes fish"), and the turn
      passes to the next player.
  * At the end of a player's turn, she removes any books from her hand
    and counts them toward her score.
