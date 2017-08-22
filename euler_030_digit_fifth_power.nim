from util import pow
from strutils import parseInt
import sets
import tables

proc computeDistinctPowers(power: int): int =
  for n in 10..pow(10,power+1):
    var sum = 0
    for c in $n:
      let d = ord(c) - ord('0')
      sum += pow(d, power)
    if n == sum:
      result += n


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeDistinctPowers(n)))
