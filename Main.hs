import Text.Printf

svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>" w h

svgEnd :: String
svgEnd = "</svg>"

svgPolygon :: Float -> Float -> Float -> Float -> Float -> Float -> String
svgPolygon x y width height radius border = 
    printf "<path d='M %.4f %.4f a %.4f %.4f 0 0 1 %.4f 0 l %.4f %.4f a %.4f %.4f 0 0 1 %.4f %.4f l 0 %.4f a %.4f %.4f 0 0 1 %.4f %.4f l %.4f %.4f a %.4f %.4f 0 0 1 %.4f 0 l %.4f %.4f a %.4f %.4f 0 0 1 %.4f %.4f l 0 %.4f a %.4f %.4f 0 0 1 %.4f %.4fz' style='fill:black;stroke:yellow;stroke-width:%.4f;fill-rule:nonzero;stroke-linejoin:round;stroke-linecap:round;'/>\n"
    x y radius radius radius
    width height radius radius (radius/2) (radius*0.866)
    (height *2) radius radius (-radius/2) (radius *0.866)
    (-width) height radius radius (-radius)
    (-width) (-height) radius radius (-radius/2) ((-radius/2 ) * 0.866)
    (-height * 2) radius radius (-radius/2) ((-radius/2 ) * 0.866) border


svgAll :: String 
svgAll = svgBegin 1920 1080 ++
    svgPolygon 150 30 100 50 5 10 ++
    svgEnd

main ::IO ()
main = do
    print svgAll
    writeFile "polygon.svg" svgAll

