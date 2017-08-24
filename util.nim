from math import sqrt, nextPowerOfTwo
import sets
import algorithm
import tables
import bigints
import future

proc count*[T](ss: seq[T]): CountTable[T] =
  result = initCountTable[T]()
  for el in ss:
    if result.contains(el):
      result[el] += 1
    else:
      result[el] = 1

proc count*(ss: string): CountTable[char] =
  result = initCountTable[char]()
  for el in ss:
    if result.contains(el):
      result[el] += 1
    else:
      result[el] = 1

proc `-`*[T](s, t: CountTable[T]): CountTable[T] =
  let doc = """
  Computes the "set difference" of two CountTable instances.
  """
  result = initCountTable[T]()
  for k in s.keys:
    if not t.contains(k):
      result[k] = s[k]
    else:
      result[k] = s[k] - t[k]

proc toString*(str: seq[char]): string =
  let doc = """
  Converts a sequence of characters in a string.
  """
  result = newStringOfCap(str.len)
  for ch in str:
    result.add(ch)


proc fetch[T](pool: seq[T], indices: seq[int]): seq[T] =
  let doc = """
  Returns a sequence with the elements of pool at the positions specified in indices.
  """
  result = newSeq[T]()
  for i in indices:
    result.add(pool[i])


iterator combinations*[T](pool: seq[T], r: int): seq[T] =
  let doc = """
  Iterates over all the combinations of elements in pool.
  """
  # combinations(@['A','B','C','D'], 2) --> AB AC AD BC BD CD
  block it:
    let n = pool.len
    if r > n:
      break it

    # var indices = lc[i | (i <- 0..<r), int]
    var indices = newSeq[int]()
    for i in 0..<r:
      indices.add(i)

    # yield lc[pool[i] | (i <- indices), T]
    yield fetch(pool, indices)
    while true:
      var i = r - 1
      block forElse:
        while i >= 0:
          if indices[i] != i + n - r:
            break forElse
          i -= 1
        break it
      indices[i] += 1
      for j in i+1..<r:
        indices[j] = indices[j-1] + 1
      # yield lc[pool[i] | (i <- indices), T]
      yield fetch(pool, indices)

iterator combinations*(pool: string, r: int): string =
  let doc = """
  Iterates over all the combination of characters in pool (as strings).
  """
  # combinations("ABCD"], 2) --> AB AC AD BC BD CD
  let pool = lc[c | (c <- pool), char]
  for combination in combinations(pool, r):
    yield combination.toString

proc allCombinations*[T](pool: seq[T], r: int): seq[seq[T]] =
  let doc = """
  Returns a sequence with all the combinations of elements in pool.
  """
  result = newSeq[seq[T]]()
  for comb in combinations(pool, r):
    result.add(comb)

proc allCombinations*(pool: string, r: int): seq[string] =
  let doc = """
  Returns a sequence with all the combinations of characters in pool (as strings).
  """
  result = newSeq[string]()
  for comb in combinations(pool, r):
    result.add(comb)



proc isPrime*(n: int): bool =
  let doc = """
  Tests primality of n.
  """
  if n <= 1:
    return false
  elif n <= 3:
    return true
  elif n mod 2 == 0 or n mod 3 == 0:
    return false

  let limit = int(sqrt(float(n)))
  var i = 5
  while i <= limit:
    if n mod i == 0 or n mod (i + 2) == 0:
      return false
    i += 6
  return true


proc pow*(b, e: int): int =
  let doc = """
  Computes b^e for integers (e >= 0).
  """
  result = 1
  if e >= 0:
    for i in 1..e:
      result *= b
  else:
    raise newException(ValueError, "The exponent must be positive")


proc bigPow*(b, e: int): BigInt =
  let doc = """
  Computes b^e in arbitrary-size integers (e >= 0).
  """
  let b = initBigInt(b)
  result = initBigInt(1)
  if e >= 0:
    for i in 1..e:
      result *= b
  else:
    raise newException(ValueError, "The exponent must be positive")


proc max*[T](s: seq[T]): T =
  let doc = """
  Finds the maximum element in the sequence and returns it.
  """
  result = s[0]
  for i in 1..<s.len:
    if result < s[i]:
      result = s[i]


proc max*[T](s: varargs[T]): T =
  let doc = """
  Finds the maximum element among the arguments and returns it.
  """
  result = s[0]
  for i in 1..<s.len:
    if result < s[i]:
      result = s[i]


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


proc findPrimesUpToHashSet*(limit: int): HashSet[int] =
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
  return primesHashSet


proc findPrimesUpToUnsorted*(limit: int): seq[int] =
  let doc = """
  Finds all prime numbers <= limit. Returns them unsorted in a seq.
  """
  let primesHashSet = findPrimesUpToHashSet(limit)
  return lc[n | (n <- primesHashSet), int]



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
  for i in 1..int(sqrt(float(n))) + 1:
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



proc findFactorsDecomposition*(n: int): CountTable[int] =
  let doc = """
  Decomposes n in prime factors and tracks the powers of each factor.
  Returns a HashMap mapping each factor to its power in the product.
  """
  var
    n = n
    factors: CountTable[int]
    limit = int(sqrt(float(n)))
    d = 3

  factors = initCountTable[int]()
  while n mod 2 == 0:
    n = n div 2
    limit = int(sqrt(float(n)))
    if factors.hasKey(2):
      factors[2] += 1
    else:
      factors[2] = 1

  while d <= limit:
    if n mod d == 0:
      n = n div d
      limit = int(sqrt(float(n)))
      if factors.hasKey(d):
        factors[d] += 1
      else:
        factors[d] = 1
      continue
    d += 2

  if n != 1:
    if factors.hasKey(n):
      factors[n] += 1
    else:
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
  let
    comp = lc[s | (s <- combinations(@['A','B','C','D'], 2)), seq[char]]
    corr = @[@['A','B'], @['A','C'], @['A','D'], @['B','C'], @['B','D'], @['C','D']]
  assert comp == corr
  assert lc[c | (c <- combinations("ABCD", 2)), string] == @["AB", "AC", "AD", "BC", "BD", "CD"]
  assert allCombinations("ABCD", 2) == @["AB", "AC", "AD", "BC", "BD", "CD"]
  assert pow(1, 0) == 1
  assert pow(2, 0) == 1
  assert pow(1, 10) == 1
  assert pow(10, 1) == 10
  assert pow(8, 3) == 512

  assert max(0, 0) == 0
  assert max(0, 1) == 1
  assert max(0, 2, 1, 0) == 2
  assert max(1, 1, 0) == 1
  assert max(@[0, 0]) == 0
  assert max(@[0, 1]) == 1
  assert max(@[0, 2, 1, 0]) == 2
  assert max(@[1, 1, 0]) == 1

  assert findNPrimes(1) == @[2]
  assert findNPrimes(10) == @[2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

  assert findPrimesUpToSorted(17) == @[2, 3, 5, 7, 11, 13, 17]
  assert findPrimesUpToSorted(20) == @[2, 3, 5, 7, 11, 13, 17, 19]

  assert findAllFactorsSorted(1) == @[1]
  assert findAllFactorsSorted(2) == @[1, 2]
  assert findAllFactorsSorted(10) == @[1, 2, 5, 10]
  assert findAllFactorsSorted(100) == @[1, 2, 4, 5, 10, 20, 25, 50, 100]

  assert findFactorsDecomposition(1) == newSeq[int]().count
  assert findFactorsDecomposition(2) == @[2].count
  assert findFactorsDecomposition(9) == @[3, 3].count
  assert findFactorsDecomposition(15) == @[3, 5].count
  assert findFactorsDecomposition(17) == @[17].count
  assert findFactorsDecomposition(36) == @[2, 2, 3, 3].count
