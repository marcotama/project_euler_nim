from strutils import parseInt, split
import tables
import future
from util import max


proc computeNumberLetterCount(triangle: seq[seq[int]]): int =
  var cumulativeTriangle: seq[seq[int]] = @[]
  cumulativeTriangle.add(@[triangle[0][0]])

  for level in 1..<triangle.len:
    let
      prevRow = cumulativeTriangle[level-1]
      curRow = triangle[level]
    var cumRow = lc[ curRow[i] | (i <- 0..<curRow.len), int]
    cumRow[0] += prevRow[0]
    cumRow[cumRow.len-1] += prevRow[prevRow.len-1]
    for i in 1..<cumRow.len-1:
      cumRow[i] += max(prevRow[i-1], prevRow[i])
    cumulativeTriangle.add(cumRow)
  return max(cumulativeTriangle[cumulativeTriangle.len-1])

when isMainModule:
  let nTestCases = parseInt(readLine(stdin))

  for i in 1..nTestCases:
    let nRows = parseInt(readLine(stdin))
    var data: seq[seq[int]] = @[]
    for j in 1..nRows:
      let line = split(readLine(stdin))
      data.add(lc[parseInt(n) | (n <- line), int])
    stdout.writeLine($(computeNumberLetterCount(data)))
