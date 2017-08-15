from strutils import parseInt, split
from math import sqrt

const dim = 20
const sq = 4
type SquareMatrix = array[1..dim, array[1..dim, int]]

proc computeLargestProductInAGrid(data: SquareMatrix): int =
  for i in 1..dim-sq:
    for j in 1..dim-sq:
      var
        pHoriz = 1
        pVert = 1
        pDiagMain = 1
        pDiagOther = 1
      for off in 0..<sq:
        pHoriz *= data[i][j+off]
        pVert *= data[i+off][j]
        pDiagMain *= data[i+off][j+off]
        pDiagOther *= data[i+off][j-off+sq]
        flushFile(stdout)

      if pHoriz > result:
        result = pHoriz
      if pVert > result:
        result = pVert
      if pDiagMain > result:
        result = pDiagMain
      if pDiagOther > result:
        result = pDiagOther



when isMainModule:

  var data: SquareMatrix

  for i in 1..dim:
    let ss = split(readLine(stdin), " ")
    for j in 1..dim:
      flushFile(stdout)
      data[i][j] = parseInt(ss[j - 1])
  stdout.writeLine($(computeLargestProductInAGrid(data)))
