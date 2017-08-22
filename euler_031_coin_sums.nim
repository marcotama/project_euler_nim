from util import pow
from strutils import parseInt
import sets
import tables

proc computeCoinSums(target: int): int =
  let coins = [1,2,5,10,20,50,100,200]
  var ways = initTable[int,int]()
  ways[0] = 1
  for coin in coins:
    for amount in coin..target:
      if not ways.contains(amount):
        ways[amount] = 0
      ways[amount] += ways[amount - coin]
  return ways[target]


when isMainModule:
  let nTestCases = parseInt(stdin.readLine())

  for i in 1..nTestCases:
    let n = parseInt(stdin.readLine())
    stdout.writeLine($(computeCoinSums(n)))
