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

svgAll :: Int -> Int -> Int -> Int -> Int -> Int -> Int -> Int -> String
svgAll x y w h r b distance n = do
  let polygon i = (x + i * ((w * 2) + distance), y, w, h, r, b)
  let polygonRow i = map (polygon) [0 .. n - 1]
  let polygonLevel i = map (\(x, y, w, h, r, b) -> ((x + i * w) - (2 * n * w), y + i * (h * 3 + distance), w, h, r, b)) (polygonRow n)
  let polygonList i = concat (map polygonLevel [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

  let polygonAsFloat = map (\(x, y, w, h, r, b) -> (fromIntegral x, fromIntegral y, fromIntegral w, fromIntegral h, fromIntegral r, fromIntegral b)) (polygonList n)

  svgBegin 1920 1080
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
  let quantidade = head (randomNumber number_randgen 100 300)

  let x = head (randomNumber number_randgen 0 (width * 2))
  let y = head (randomNumber number_randgen 0 0)
  writeFile "polygon.svg" (svgAll x y width height 2 5 distance quantidade)
