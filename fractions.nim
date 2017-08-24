from util import gcd

type
  Fraction* = object
    num*, den*: int


proc simplify*(frac: var Fraction, by: int) =
  frac.num = frac.num div by
  frac.den = frac.den div by

proc simplify*(frac: var Fraction) =
  let gcd = gcd(frac.num, frac.den)
  simplify(frac, gcd)



proc simplified*(frac: Fraction, by: int): Fraction =
  return Fraction(num: frac.num div by, den: frac.den div by)

proc simplified*(frac: Fraction): Fraction =
  let gcd = gcd(frac.num, frac.den)
  result = simplified(frac, gcd)


proc `==`*(frac1, frac2: Fraction): bool =
  let
    f1s = simplified(frac1)
    f2s = simplified(frac2)
  return f1s.num == f2s.num and f1s.den == f2s.den


proc toFloat*(frac: Fraction): float =
  return frac.num / frac.den


proc `$`*(frac: Fraction): string =
  return $(frac.num) & "/" & $(frac.den)



when isMainModule:
  assert Fraction(num: 49, den: 98).simplified == Fraction(num: 1, den: 2)
