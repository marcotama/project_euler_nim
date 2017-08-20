from strutils import parseInt
import tables

let
  digits = {
    1: "one",
    2: "two",
    3: "three",
    4: "four",
    5: "five",
    6: "six",
    7: "seven",
    8: "eight",
    9: "nine",
  }.toTable
  tens = {
    2: "twenty",
    3: "thirty",
    4: "forty",
    5: "fifty",
    6: "sixty",
    7: "seventy",
    8: "eighty",
    9: "ninety",
  }.toTable
  numbers_10_20 = {
    10: "ten",
    11: "eleven",
    12: "twelve",
    13: "thirteen",
    14: "fourteen",
    15: "fifteen",
    16: "sixteen",
    17: "seventeen",
    18: "eighteen",
    19: "nineteen",
  }.toTable


proc toEngStr(n: int): string =
  var
    n = n
  result = newString(0)

  if n >= 1000:
    result &= digits[n div 1000] & "thousand"
    n = n mod 1000

  if n >= 100:
    result &= digits[n div 100] & "hundred"
    n = n mod 100
    if n > 0:
      result &= "and"

  if n >= 20:
    result &= tens[n div 10]
    n = n mod 10

  if n >= 10:
    result &= numbers_10_20[n]
    return result

  if n > 0:
    result &= digits[n]

  return result


proc calcNumberLetterCount(n: int): int =
  for i in 1..n:
    result += toEngStr(i).len


when isMainModule:
  let n_test_cases = parseInt(readLine(stdin))

  for i in 1..n_test_cases:
    let n = parseInt(readLine(stdin))
    stdout.writeLine($(calcNumberLetterCount(n)))
