from math import sqrt, nextPowerOfTwo
import sets
import algorithm
import tables
import bigints
import future

let digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
proc fromBaseToInt*(s: string, b: int): int =
  var bp = 1
  for i in countdown(s.len-1, 0):
    result += bp * find(digits, s[i])
    bp *= b

proc fromIntToBase*(n: int, b: int): string =
  result = ""
  var n = n
  while n > 0:
    result = digits[n mod b] & result
    n = n div b


proc isPalindrome*(s: string): bool =
  for i in 0..s.len div 2:
    if s[i] != s[s.len-i-1]:
      return false
  return true

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

  assert (not isPalindrome("ciao"))
  assert isPalindrome("12321")
  assert isPalindrome("1221")

  assert fromBaseToInt("1", 16) == 1
  assert fromBaseToInt("10", 16) == 16
  assert fromBaseToInt("A", 16) == 10
  assert fromBaseToInt("11", 10) == 11
  assert fromBaseToInt("11", 2) == 3
  assert fromBaseToInt("101", 2) == 5

  assert fromIntToBase(11, 2) == "1011"
  assert fromIntToBase(65, 16) == "41"
  assert fromIntToBase(65, 10) == "65"
