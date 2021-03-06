My [Advent of Code 2020](https://adventofcode.com/2020/) solutions in Ruby.

## Notes/learnings

- Day 1: Ruby's `Array#combination(n)` made this so straightforward and elegant ❤️
- Day 2: legit use of xor (`^`) operator
- Day 3: simple modular arithmetic helped.
- Day 4: -
- Day 5: could be solved very easily with a tricky insight: boarding pass codes could be transformed to 0s and 1s to form the seat ID number in binary.
- Day 6: part 1 vs part 2 solutions could be mapped to using either set union (`|`) or intersection (`&`) respectively.
- Day 7: -
- Day 8: Fun little interpreter
- Day 9: part 2 solution is terribly inefficient but it harness the power of `Array#combination(n)` once again.
- Day 10: First part super easy, but the second one was supe tricky. Did a horrible solution first that only worked for joltage differences of 1 or 3 (no 2s) and only up to 4 consecutive jumps of 1, which was enough for the given input. Then checked the interwebs and found out how clever other people are, and copied a solution that i sort of understood.
- Day 11: weird game-of-life-kinda challenge.
- Day 12: fun simulation challenge.
- Day 13: math-heavy. Modular arithmetic and insight about prime numbers was needed for the second part.
- Day 14: nice bit-fiddling challenge.
- Day 15: first solution for part 1 didn't scale to the 30M iterations of part two (probably could leave it to run and get a result on less than 10 minutes though). Very imperative solution, with very simple "memoization" scaled charmingly without switching to a faster language :)
- Day 16: tricky challenge.
- Day 17: generalizing the solution to N dimensions was fun. The **object recursion pattern** was a nice fit to have n-dimensional grids delegate to (n-1)-dimensional grids and so on.
- Day 18: cheesy `eval()` solution. Instead of actually parsing anything, Ruby allowed to override normal `+` and `*` behavior and evaluate the expressions as Ruby code.
- Day 19: **Ruby regular expressions support recursion!** Part 1 could be mapped into a regex quite intuitively. Part 2, with its recursive rules, didn't look like it. But thankfully Ruby's regexes support recursive patterns, so the regex-based approach still worked :)
- Day 20: part 1 was relatively easy due to some insight about the input data. Part 2 was a total PITA.
- Day 21: a piece of cake compared to previous day!
- Day 22: CPU-intensive challenge with *lots* of recursion! Using `map(&:shift)` should be illegal. Learned about `String#lines`, a useful alternative to `str.split("\n")` for many of these. Also used a couple of optimizations to trim some time:
    - Using a `Set` instead of an array to remember previous rounds reduced the running time from almost 2 minutes to ~10 seconds.
    - Saving the previous rounds as marshalled values reduced the time from 10 to 3.5 seconds.
- Day 23: initial solution for part 1 could not scale to part 2. Ended up using an array to keep the next of each cup, acting both as a sort of linked list and also as a direct-access dictionary.
- Day 24: interesting hexagonal cellular automata. I didn't investigate if representing hex grid coordinates with whole numbers makes sense, nor did i take time to optimize the pretty inefficient solution.
- Day 25: nice ending :)
