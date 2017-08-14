type ArrayFrom100To999 = array[100..999, int]

proc min(a, b: int): int =
  if a < b:
    result = a
  else:
    result = b

proc indexOfMax(a: ArrayFrom100To999, exc: int): int =
  var maxValue = a[a.low]
  result = a.low
  for i in a.low+1..a.high:
    if i == exc:
      continue
    if a[i] > maxValue:
      maxValue = a[i]
      result = i

proc checkPalindrome(n: int): bool =
  let s = $(n)
  for i in 0..s.len div 2:
    if s[i] != s[s.len-i-1]:
      return false
  return true

proc computeLargestPalindromProduct(n: int): int =
  var
    maxProducts: ArrayFrom100To999
    coFactors: ArrayFrom100To999
    nextLargestProduct = 999 * 999
    nextLargestProductIndex = 999
  for i in 100..999:
    coFactors[i] = min(n div i, 999)
    maxProducts[i] = coFactors[i] * i

  var i = nextLargestProductIndex
  nextLargestProductIndex = indexOfMax(maxProducts, i)
  nextLargestProduct = maxProducts[i]
  while maxProducts[i] > 10000:
    var prod = i * coFactors[i]

    if prod < nextLargestProduct:
      maxProducts[i] = prod
      i = nextLargestProductIndex
      nextLargestProductIndex = indexOfMax(maxProducts, i)
      nextLargestProduct = maxProducts[i]
      prod = i * coFactors[i]

    if checkPalindrome(prod):
      result = prod
      return

    coFactors[i] -= 1





when isMainModule:
  from strutils import parseInt
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(computeLargestPalindromProduct(n)))
