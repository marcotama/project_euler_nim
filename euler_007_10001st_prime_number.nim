from strutils import parseInt

proc computeNthPrime(n: int): int =
  var
    primes = @[2]
    k = 1

  while primes.len < n:
    k += 2
    var prime = true
    for d in primes:
      if k mod d == 0:
        prime = false
        break
    if prime:
      primes.add(k)
  result = k



when isMainModule:
  let nTestCases = parseInt(readLine(stdin))

  for i in 1..nTestCases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeNthPrime(n)))
