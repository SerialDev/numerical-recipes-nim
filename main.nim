proc NeumaierSum( input:openArray[float] ): float =
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


