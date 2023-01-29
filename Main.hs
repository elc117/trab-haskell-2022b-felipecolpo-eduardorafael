import Data.List
import System.Random
import Text.Printf

svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>" w h

svgEnd :: String
svgEnd = "</svg>"

svgPolygon :: (Float, Float, Float, Float, Float, Float) -> String
svgPolygon (x, y, width, height, radius, border) = do
  printf
    "<path d='M %.4f %.4f a %.4f %.4f 0 0 1 %.4f 0 l %.4f %.4f a %.4f %.4f 0 0 1 %.4f %.4f l 0 %.4f a %.4f %.4f 0 0 1 %.4f %.4f l %.4f %.4f a %.4f %.4f 0 0 1 %.4f 0 l %.4f %.4f a %.4f %.4f 0 0 1 %.4f %.4f l 0 %.4f a %.4f %.4f 0 0 1 %.4f %.4fz' style='fill:black;stroke:yellow;stroke-width:%.4f;fill-rule:nonzero;stroke-linejoin:round;stroke-linecap:round;'/>\n"
    x
    y
    radius
    radius
    radius
    width
    height
    radius
    radius
    (radius / 2)
    (radius * 0.866)
    (height * 2)
    radius
    radius
    (-radius / 2)
    (radius * 0.866)
    (-width)
    height
    radius
    radius
    (-radius)
    (-width)
    (-height)
    radius
    radius
    (-radius / 2)
    ((-radius / 2) * 0.866)
    (-height * 2)
    radius
    radius
    (-radius / 2)
    ((-radius / 2) * 0.866)
    border

toFloat :: Int -> Float
toFloat x = fromIntegral x

svgAll :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> String
svgAll x y w h r b distance = do
  let n = 9
  let polygon i = (x + i * ((w * 2) + distance), y, w, h, r, b)
  let polygonRow i = map (polygon) [0 .. n - 1]
  let polygonLevel i = map (\(x, y, w, h, r, b) -> (x - w, y + i * (h * 3 + distance), w, h, r, b)) (polygonRow 0)
  let polygonList i = concat (map polygonLevel [-1, 0, 1])

  --deveria ficar assim mais ou menos a estrutura, fiz com três linhas
  -- let polygons = [(x, y, w, h, r, b), (x + (w * 2) + distance, y, w, h, r, b), (x + 2 * ((w * 2) + distance), y, w, h, r, b), (x + 3 * ((w * 2) + distance), y, w, h, r, b), (x + 4 * ((w * 2) + distance), y, w, h, r, b), (x + 5 * ((w * 2) + distance), y, w, h, r, b), (x + 6 * ((w * 2) + distance), y, w, h, r, b), (x + 7 * ((w * 2) + distance), y, w, h, r, b), (x - w, y + h * 3 + distance, w, h, r, b), (x - w + (w * 2) + distance, y + h * 3 + distance, w, h, r, b), (x - w + 2 * ((w * 2) + distance), y + h * 3 + distance, w, h, r, b), (x - w + 3 * ((w * 2) + distance), y + h * 3 + distance, w, h, r, b), (x - w + 4 * ((w * 2) + distance), y + h * 3 + distance, w, h, r, b), (x - w + 5 * ((w * 2) + distance), y + h * 3 + distance, w, h, r, b), (x - w + 6 * ((w * 2) + distance), y + h * 3 + distance, w, h, r, b), (x - w + 7 * ((w * 2) + distance), y + h * 3 + distance, w, h, r, b), (x - w, y - h * 3 - distance, w, h, r, b), (x - w + (w * 2) + distance, y - h * 3 - distance, w, h, r, b), (x - w + 2 * ((w * 2) + distance), y - h * 3 - distance, w, h, r, b), (x - w + 3 * ((w * 2) + distance), y - h * 3 - distance, w, h, r, b), (x - w + 4 * ((w * 2) + distance), y - h * 3 - distance, w, h, r, b), (x - w + 5 * ((w * 2) + distance), y - h * 3 - distance, w, h, r, b), (x - w + 6 * ((w * 2) + distance), y - h * 3 - distance, w, h, r, b), (x - w + 7 * ((w * 2) + distance), y - h * 3 - distance, w, h, r, b)]

  -- let polygonsAsFloat = map (\(x, y, w, h, r, b) -> (toFloat x, toFloat y, toFloat w, toFloat h, toFloat r, toFloat b)) polygonList

  let polygonAsFloat = map (\(x, y, w, h, r, b) -> (fromIntegral x, fromIntegral y, fromIntegral w, fromIntegral h, fromIntegral r, fromIntegral b)) (polygonList n)

  svgBegin 400 400
    ++ concat (map svgPolygon polygonAsFloat)
    ++ svgEnd

randomNumber :: StdGen -> Int -> Int -> [Int]
randomNumber gen x y = take 1 (randomRs (x, y) gen :: [Int])

main :: IO ()
main = do
  number_randgen <- newStdGen
  let height = head (randomNumber number_randgen 20 40)
  let width = head (randomNumber number_randgen height 40)

  let distance = head (randomNumber number_randgen 15 20)

  let x = head (randomNumber number_randgen 0 (width * 2))
  let y = head (randomNumber number_randgen 0 400)
  writeFile "polygon.svg" (svgAll x y width height 2 5 distance)
