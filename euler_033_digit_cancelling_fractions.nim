from util import pow, allCombinations, `-`, gcd, count
import fractions
import strutils
import tables

proc countZeros(s: string): int =
  for i in countdown(s.len-1,0):
    if s[i] == '0':
      result += 1
    else:
      break

proc computeDigitCancellingFractions(nDigits, nCancellations: int): tuple[n: int, d: int] =
  let
    min = pow(10, nDigits - 1)
    max = min * 10 - 1
  var
    totNum = 0
    totDen = 0

  for n in min..max:
    let nCombs = allCombinations($n, nDigits-nCancellations)
    let numDigits = ($n).count

    for d in n+1..max:
      let dCombs = allCombinations($d, nDigits-nCancellations)
      let denDigits = ($d).count

      if gcd(n, d) == 1:
        continue

      let origFrac = Fraction(num: n, den: d)

      block testing:
        for newDen in dCombs:
          let newDenInt = parseInt(newDen)
          if newDenInt == 0:
            continue
          let newDenDigits = newDen.count

          for newNum in nCombs:
            let newNumInt = parseInt(newNum)
            if newNumInt == 0:
              continue
            let newNumDigits = newNum.count

            if numDigits - newNumDigits != denDigits - newDenDigits:
              continue

            let newFrac = Fraction(num: newNumInt, den: newDenInt)
            if origFrac != newFrac:
              continue

            if countZeros($n) != countZeros($newNum):
              continue

            if n div d == newNumInt div newDenInt:
              totNum += n
              totDen += d
              break testing
  return (totNum, totDen)


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let
      line = stdin.readLine()
      ss = split(line)
      n = parseInt(ss[0])
      k = parseInt(ss[1])
      res = computeDigitCancellingFractions(n, k)
    stdout.writeLine($res.n & " " & $res.d)
