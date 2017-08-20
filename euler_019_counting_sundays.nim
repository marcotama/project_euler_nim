from strutils import parseInt, split
import tables
import future
from util import max

const daysPerMonth = {
  1: 31,
  3: 31,
  4: 30,
  5: 31,
  6: 30,
  7: 31,
  8: 31,
  9: 30,
  10: 31,
  11: 30,
  12: 31
}.toTable()


proc daysInMonth(month, year: int): int =
  if month != 2:
    return daysPerMonth[month]
  else:
    if (year mod 4 == 0 and year mod 100 != 0) or year mod 400 == 0:
      return 29
    else:
      return 28


const sunday = 0
proc dayOfWeekJan1st(year: int): int =
  # Thanks to https://stackoverflow.com/a/478992
  return (year * 365 + (year-1) div 4 - (year-1) div 100 + (year-1) div 400) mod 7


proc dayOfTheWeek(year, month, day: int): int =
  result = dayOfWeekJan1st(year)
  for m in 1..<month:
    result += daysInMonth(m, year)
  result += day - 1
  result = result mod 7


proc calcCountingSundays(year1, month1, day1, year2, month2, day2: int): int =
  var dayOfWeek = dayOfTheWeek(year1, month1, day1)

  if day1 == 1:
    if dayOfWeek == sunday:
      result += 1
  dayOfWeek += daysInMonth(month1, year1)
  dayOfWeek = dayOfWeek mod 7

  for month in month1+1..12:
    if dayOfWeek == sunday:
      result += 1
    dayOfWeek += daysInMonth(month, year1)
    dayOfWeek = dayOfWeek mod 7

  for year in year1+1..year2-1:
    for month in 1..12:
      if dayOfWeek == sunday:
        result += 1
      dayOfWeek += daysInMonth(month, year)
      dayOfWeek = dayOfWeek mod 7

  for month in 1..month2:
    if dayOfWeek == sunday:
      result += 1
    dayOfWeek += daysInMonth(month, year2)
    dayOfWeek = dayOfWeek mod 7


when isMainModule:
  let nTestCases = parseInt(readLine(stdin))

  for i in 1..nTestCases:
    let
      data1 = split(readLine(stdin))
      data2 = split(readLine(stdin))
      y1 = parseInt(data1[0])
      m1 = parseInt(data1[1])
      d1 = parseInt(data1[2])
      y2 = parseInt(data2[0])
      m2 = parseInt(data2[1])
      d2 = parseInt(data2[2])
    stdout.writeLine($(calcCountingSundays(y1, m1, d1, y2, m2, d2)))
