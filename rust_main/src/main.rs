use std::{fs::File, io::Write};
use rand::prelude::*;

const POLIGON_WIDTH: f32 = 123.0;
const POLYGON_HEIGHT: f32 = 80.0;
const RADIUS: f32 = 10.0;
const BORDER: f32 = 20.0;

#[derive(Clone,Copy)]
struct Coordenadas{
    x: f32,
    y: f32,
}

impl Coordenadas {
    fn new_x(&mut self){
        if self.x > 1920.0{
            self.x = self.x - (POLIGON_WIDTH + RADIUS) ;
        }
        else{
            self.x = self.x + (POLIGON_WIDTH + RADIUS) ;
        }
    }
}
fn init_svg() -> String {
    String::from("<svg viewBox='0 0 1920 1080' xmlns='http://www.w3.org/2000/svg'> <rect width='100%' height='100%' fill='black'/>" )
}

fn end_svg() -> String{
    String::from("</svg>")
}

fn create_polygon(p1: Coordenadas, p2: Coordenadas, p3:Coordenadas, p4:Coordenadas, p5: Coordenadas, p6: Coordenadas) -> String{
    format!("<path d='M {} {} a {} {} 0 0 1 {} 0
    l {} {} a {} {} 0 0 1 {} {}
    l {} {} a {} {} 0 0 1 {} {}
    l {} {} a {} {} 0 0 1 {} 0
    l {} {} a {} {} 0 0 1 {} {}
    l {} {} a {} {} 0 0 1 {} {}
    z' style='fill:black;stroke:yellow;stroke-width:{};fill-rule:nonzero;stroke-linejoin:round;stroke-linecap:round;'/>\n",
    p1.x, p1.y, RADIUS, RADIUS, RADIUS,
    p2.x, p2.y, RADIUS, RADIUS, RADIUS/2.0, RADIUS * 0.866,
    p3.x, p3.y, RADIUS, RADIUS, -RADIUS/2.0, RADIUS * 0.866,
    p4.x, p4.y, RADIUS, RADIUS, -RADIUS,
    p5.x, p5.y, RADIUS, RADIUS, -RADIUS/2.0, -RADIUS * 0.866,
    p6.x, p6.y, RADIUS, RADIUS, RADIUS/2.0, -RADIUS * 0.866, BORDER)

}

fn horizontal_line(coord: Coordenadas) -> Vec<String>{
    let mut line: Vec<String> = Vec::new();
    let mut x = coord.x;
    loop {
        if x > 1920.0 + POLIGON_WIDTH {
            break;
        }
        line.push(create_polygon(Coordenadas { x: x, y: coord.y }, Coordenadas { x:POLIGON_WIDTH, y:POLYGON_HEIGHT },
            Coordenadas { x: 0.0, y: POLYGON_HEIGHT * 2.0 }, Coordenadas { x: -POLIGON_WIDTH, y: POLYGON_HEIGHT }, Coordenadas { x: -POLIGON_WIDTH, y: -POLYGON_HEIGHT }, 
            Coordenadas { x: 0.0, y: -POLYGON_HEIGHT* 2.0 }));

        x = x + ((POLIGON_WIDTH * 2.0 ) + (RADIUS * 1.866)) + BORDER;
    }

    x = coord.x - ((POLIGON_WIDTH * 2.0 ) + (RADIUS  * 1.866) + BORDER ) ;
    loop {
        if x < (0.0 - POLIGON_WIDTH ){
            break;
        }
        line.push(create_polygon(Coordenadas { x: x, y: coord.y }, Coordenadas { x:POLIGON_WIDTH, y:POLYGON_HEIGHT },
            Coordenadas { x: 0.0, y: POLYGON_HEIGHT * 2.0 }, Coordenadas { x: -POLIGON_WIDTH, y: POLYGON_HEIGHT }, Coordenadas { x: -POLIGON_WIDTH, y: -POLYGON_HEIGHT }, 
            Coordenadas { x: 0.0, y: -POLYGON_HEIGHT* 2.0 }));
        x = x - ((POLIGON_WIDTH * 2.0 ) + RADIUS + RADIUS * 0.866 + BORDER);
    }
    line
}   

fn vertical_lines(mut coord: Coordenadas) -> Vec<Vec<String>> {
    let mut lines: Vec<Vec<String>> = Vec::new();
    let mut height = coord.y;
    let mut initial_coord = coord.clone();
    loop {
        if height > 1080.0 + (POLYGON_HEIGHT * 3.0) {
            break;
        }
        lines.push(horizontal_line(Coordenadas { x: coord.x, y: height }));

        height = height + POLYGON_HEIGHT * 3.0 + RADIUS;
        coord.new_x(); 
    }

    height = coord.y -( POLYGON_HEIGHT * 3.0 + RADIUS);
    initial_coord.new_x();

    loop {
        if height < (0.0 - (POLYGON_HEIGHT * 3.0)) {
            break;
        }

        lines.push(horizontal_line(Coordenadas { x: initial_coord.x, y: height }));
        height = height - (POLYGON_HEIGHT * 3.0 + RADIUS);
        initial_coord.new_x();
    }

    lines
}

fn main() {
    let mut file = File::create("polygon.svg").unwrap();
    
    let coord = Coordenadas{
        x : rand::thread_rng().gen_range(POLIGON_WIDTH..1920.0),
        y : rand::thread_rng().gen_range(POLYGON_HEIGHT..1080.0),
    };
   
    file.write(init_svg().as_bytes()).unwrap();
    let lines = vertical_lines(coord);
    for line in lines{
        for l in line{
            file.write(l.as_bytes()).unwrap();
        }
    }

    file.write(end_svg().as_bytes()).unwrap();

}
