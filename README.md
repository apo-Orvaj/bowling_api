# Ruby Bowling API
A game of standard 10-pin American bowling, implemented in Ruby.

## Bowling Rules

- 10 turns allowed per game.
- 2 rolls allowed per turn.
- If bowler fails to knock both down, score for that turn is sum of its rolls rolls.
- Spare: bowler knocks down 10 on roll #2. Score is 10 + next roll score.
- Strike: bowler knocks down 10 on roll #1. Score is 10 + next 2 throw scores.
- Spare or strike on last turn (turn 10), gets 1 or 2 bonus rolls respectively. These bonus rolls count toward the 10th turn.
