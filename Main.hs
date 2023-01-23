import Text.Printf

svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>" w h

svgEnd :: String
svgEnd = "</svg>"

svgPolygon :: Int -> (Int, Int) -> (Int,Int) -> (Int,Int) -> (Int, Int) -> (Int, Int) -> Int -> String
svgPolygon x p1 p2 p3 p4 p5 y = 
    printf "<polygon points ='%d ,%d %d, %d %d, %d %d,%d %d, %d %d, %d' style='fill:lime;stroke:purple;stroke-width:5;fill-rule:nonzero;' ></polygon>" x (fst p1) (snd p1) (fst p2) (snd p2) (fst p3) (snd p3) (fst p4) (snd p4) (fst p5) (snd p5) y

svgAll :: String 
svgAll = svgBegin 1920 1080 ++
-- x(largura)
-- p1 ( vertice direita lateral cima) 
-- p2 ( vertice direita lateral baixo)
-- p3 ( vertice baixo)
-- p4 (vertice esquerda lateral baixo)
-- p5 (vertice esquerda lateral cima)
    svgPolygon 300 (150,225) (280,75) (280,0) (150,75) (20,225) 20 ++
    svgPolygon 300 (150,525) (280,75) (280,0) (150,75) (20,225) 20 ++
    svgEnd

main ::IO ()
main = do
    print svgAll
    writeFile "polygon.svg" svgAll

