# ;;; inim.el --- Inim minor mode for Nim Repl support

# ;; Copyright (C) 2018 Andres Mariscal

# ;; Author: Andres Mariscal <carlos.mariscal.melgar@gmail.com>
# ;; Created: 26 Sep 2018
# ;; Version: 0.0.1
# ;; Keywords: nim languages repl
# ;; URL: https://github.com/serialdev/inim-mode
# ;; Package-Requires: ((emacs "24.3", parsec ))
# ;;; Commentary:
# ;; Nim Repl support through inim repl

# ;; Usage

proc neumaierSum( input:openArray[float] ): float =
  var sum = input[0]
  var c = 0.0   # A running compensation for lost low-order bits
  for i in 1 ..< input.len:
    var t = sum + input[i]
    if sum >= input[i]:
      c += (sum - t) + input[i] # If sum is bigger, low-order digits of input[i] are lost
    else:
      c += (input[i] - t) + sum # Else low-order digits of sum are lost
    sum = t   # Correction is only applied at the very end
  return sum + c


proc kahanSum(input:openArray[float]): float =
  var sum = 0.0
  var c = 0.0  # A runnng compensation for lost low-order bits
  for i in 0 ..< input.len:
    var y = input[i] - c    # c is zero
    var t = sum + y         # sum ist big, y is small so low-order digits of y are lost
    c = (t - sum) - y       # (t - sum) cancels the high-order part of y; substracting y recovers negative (low part of y)
    sum = t                 # Algebraically, c should always be zero. Risk of loss of accuracy due to overly-agressive optimizing compilers!
  return sum

let numbers:seq[float64] = @[1.2 ,2.0,3.0,4.0,5.0]

numbers.echo()
neumaierSum(numbers).echo
kahanSum(numbers).echo


let zc = [[[1,2,3], [4,5,6] ],
          [[11,22,33], [44,55,66]],
          [[111,222,333], [444,555,666]   ],
          [[1111,2222,3333],[4444,5555,6666]] ].toTensor()
