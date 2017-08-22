from util import pow
from strutils import parseInt
import future
import sequtils
import sets

proc computePandigitalProduct(n: int): int =
  # If d(x) is the number of digits of x, the product p=a*b is going to have
  # either d(p)=d(a)+d(b) or d(p)=d(a)+d(b)+1 digits.
  # We want d(a)+d(b)+d(p) <= n. Now we want to calculate the highest number
  # of digits for d(a) and d(b) such that the relationship holds:
  # d(a)+d(b)+d(a)+d(b)+1 = n
  # 2*d(a)+2*d(b)+1 = n
  # d(a) = (n - 2*d(b)) / 2
  # We know both d(a) and d(b) have to be at least 1, so the most digits a
  # can have is (n - 2) / 2. To round up, let's put a +1, so (n-1)/2
  # In all this we assume a > b, just to avoid repeating the same product twice.
  let
    highA = pow(10, (n-1) div 2)


  var prods = initSet[int]()
  for a in 1..highA:
    for b in 1..highA div a + 1:
      let
        prod = a * b
        s = $(prod) & ($a) & ($b)
      if s.len != n: # for performance
        continue
      let digitsInProduct = lc[s.contains(c) | (c <- "123456789"[0..<n]), bool]
      if foldl(digitsInProduct, a and b, true):
        if prods.contains(prod):
          continue
        prods.incl(prod)
        result += prod


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computePandigitalProduct(n)))
