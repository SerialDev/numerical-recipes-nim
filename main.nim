proc neumaierSum( input:openArray[float] ): float =
  var sum = input[0]
  var c = 0.0   # A running compensation for lost low-order bits
  for i in 1 ..< input.len:
    var t = sum + input[i]
    if sum >= input[i]:
      c += (sum - t) + input[i] # If sum is bigger, low-order digits of input[i] are lost
    else:
      c += (input[i] - t) + sum # Else low-order digits of sum are lost
    sum = t
  return sum + c  # Correction is only applied at the very end


proc kahanSum(input:openArray[float]): float =
  var sum = 0.0
  var c = 0.0  # A runnng compensation for lost low-order bits
  for i in 0 ..< input.len:
    var y = input[i] - c    # c is zero
    var t = sum + y         # sum ist big, y is small so low-order digits of y are lost
    c = (t - sum) - y       # (t - sum) cancels the high-order part of y; substracting y recovers negative (low part of y)
    sum = t                 # Algebraically, c should always be zero. Risk of loss of accuracy due to overly-agressive optimizing compilers!
  return sum


