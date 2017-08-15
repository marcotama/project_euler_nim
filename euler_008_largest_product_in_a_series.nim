from strutils import parseInt, split

proc computeLargestProductInASeries(s: string, k: int): int =
  for i in 0..s.len-k:
    let ss = s[i..i+k-1]
    var prod = 1
    for c in ss:
      prod *= parseInt($(c))
    if prod > result:
      result = prod


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let k = parseInt(split(readLine(stdin), " ")[1])
    let s = readLine(stdin)
    stdout.writeLine($(computeLargestProductInASeries(s, k)))
