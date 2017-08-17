from math import sqrt, nextPowerOfTwo
import sets
import algorithm
import tables


proc findNPrimes*(n: int): seq[int] =
  let doc = """
  Finds the first n prime numbers. Returns them sorted in a seq.
  """
  if n == 0:
    return @[]

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
  return primes


proc findPrimesUpToUnsorted*(limit: int): seq[int] =
  let doc = """
  Finds all prime numbers <= limit. Returns them unsorted in a seq.
  """
  var primesHashSet: HashSet[int]
  primesHashSet.init(nextPowerOfTwo(limit))
  for n in 2..limit:
    primesHashSet.incl(n)
  for i in 2..int(sqrt(float(limit))):
    for j in countup(2*i, limit, i):
      primesHashSet.excl(j)

  var primes = newSeq[int]()
  for p in primesHashSet:
    primes.add(p)
  return primes



proc findPrimesUpToSorted*(limit: int): seq[int] =
  let doc = """
  Finds all prime numbers <= limit. Returns them sorted in a seq.
  """
  let primes = findPrimesUpToUnsorted(limit)
  return sorted(primes, system.cmp)



proc findAllFactorsUnsorted*(n: int): seq =
  let doc = """
  Finds all factors of n. Returns them unsorted in a seq.
  """
  var factorsHashSet: HashSet[int]
  factorsHashSet.init(nextPowerOfTwo(int(sqrt(float(n)))))
  factorsHashSet.incl(1)
  for i in 2..int(sqrt(float(n))) + 1:
    if n mod i == 0:
      factorsHashSet.incl(i)
      factorsHashSet.incl(int(n div i))

  var factors = newSeq[int]()
  for p in factorsHashSet:
    if p == 0:
      continue
    factors.add(p)
  return factors



proc findAllFactorsSorted*(limit: int): seq[int] =
  let doc = """
  Finds all factors of n. Returns them sorted in a seq.
  """
  let primes = findAllFactorsUnsorted(limit)
  return sorted(primes, system.cmp)



proc findFactorsDecomposition*(n: int): OrderedTable[int, int] =
  let doc = """
  Decomposes n in prime factors and tracks the powers of each factor.
  Returns a HashMap mapping each factor to its power in the product.
  """
  var
    n = n
    factors: OrderedTable[int, int]
    limit = n div 2
    d = 3

  factors = initOrderedTable[int, int](nextPowerOfTwo(int(sqrt(float(n)))))
  while n mod 2 == 0:
    n = n div 2
    if not factors.hasKey(2):
      factors[2] = 0
    factors[2] += 1

  while d <= limit:
    if n mod d == 0:
      n = n div d
      limit = n
      if not factors.hasKey(d):
        factors[d] = 0
      factors[d] += 1
      continue
    d += 2

  if factors.len == 0:
    factors[n] = 1

  return factors



proc gcd*(a, b: int): int =
  let doc = """
  Finds the greatest common divisor between a and b.
  """
  var
    a = a
    b = b
  while b != 0:
    let t = b
    b = a mod b
    a = t
  result = a



proc lcm*(a, b: int): int =
  let doc = """
  Finds the least common multiple between a and b.
  """
  result = a div gcd(a, b) * b



when isMainModule:
  assert findPrimesSorted(17) == @[2, 3, 5, 7, 11, 13, 17]
  assert findPrimesSorted(20) == @[2, 3, 5, 7, 11, 13, 17, 19]

  assert findAllFactorsSorted(1) == @[1]
  assert findAllFactorsSorted(2) == @[1, 2]
  assert findAllFactorsSorted(10) == @[1, 2, 5]
  assert findAllFactorsSorted(100) == @[1, 2, 4, 5, 10, 20, 25, 50]

  assert findFactorsDecomposition(1) == {1: 1}.toOrderedTable
  assert findFactorsDecomposition(2) == {2: 1}.toOrderedTable
  assert findFactorsDecomposition(15) == {3: 1, 5: 1}.toOrderedTable
  assert findFactorsDecomposition(17) == {17: 1}.toOrderedTable
  assert findFactorsDecomposition(36) == {2: 2, 3: 2}.toOrderedTable