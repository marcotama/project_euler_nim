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
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let k = parseInt(split(stdin.readLine(), " ")[1])
    let s = stdin.readLine()
    stdout.writeLine($(computeLargestProductInASeries(s, k)))
