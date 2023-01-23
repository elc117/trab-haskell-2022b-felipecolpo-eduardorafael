use std::{fs::File, io::Write};
use rand::prelude::*;

#[derive(Clone,Copy)]
struct Coordenadas{
    x: f32,
    y: f32,
    width: f32,
    height: f32,
    radius: f32,
    border: f32
}

impl Coordenadas {
    fn new_x(&mut self){
        if self.x > 1920.0{
            self.x = self.x - (self.width + self.height) ;
        }
        else{
            self.x = self.x + (self.width + self.border) ;
        }
    }
}
fn init_svg() -> String {
    String::from("<svg viewBox='0 0 1920 1080' xmlns='http://www.w3.org/2000/svg'> <rect width='100%' height='100%' fill='black'/>" )
}

fn end_svg() -> String{
    String::from("</svg>")
}

fn create_polygon(p1: Coordenadas) -> String{
    format!("<path d='M {} {} a {} {} 0 0 1 {} 0
    l {} {} a {} {} 0 0 1 {} {}
    l 0 {} a {} {} 0 0 1 {} {}
    l {} {} a {} {} 0 0 1 {} 0
    l {} {} a {} {} 0 0 1 {} {}
    l 0 {} a {} {} 0 0 1 {} {}
    z' style='fill:black;stroke:yellow;stroke-width:{};fill-rule:nonzero;stroke-linejoin:round;stroke-linecap:round;'/>\n",
    p1.x, p1.y, p1.radius, p1.radius, p1.radius,
    p1.width, p1.height, p1.radius, p1.radius, p1.radius/2.0, p1.radius * 0.866,
    p1.height * 2.0, p1.radius, p1.radius, -(p1.radius/2.0), p1.radius * 0.866,
    -(p1.width), p1.height, p1.radius, p1.radius, -(p1.radius),
    -(p1.width), -(p1.height), p1.radius, p1.radius, -(p1.radius/2.0), -(p1.radius * 0.866),
    -(p1.height * 2.0), p1.radius, p1.radius, (p1.radius/2.0), -(p1.radius * 0.866), p1.border)

}

fn horizontal_line(coord: Coordenadas) -> Vec<String>{
    let mut line: Vec<String> = Vec::new();
    let mut coord_aux = coord.clone();
    loop {
        if coord_aux.x > 1920.0 + coord.width {
            break;
        }
        line.push(create_polygon(coord_aux));

        coord_aux.x = coord_aux.x + ((coord.width * 2.0 ) + (coord.radius * 1.866)) + coord.border;
    }

    coord_aux.x = coord.x - ((coord.width * 2.0 ) + (coord.radius  * 1.866) + coord.border );
    loop {
        if coord_aux.x < (0.0 - coord.width ){
            break;
        }
        line.push(create_polygon(coord_aux));
        coord_aux.x = coord_aux.x - ((coord.width * 2.0 ) + ( coord.radius* 1.866) + coord.border);
    }
    line
}   

fn vertical_lines(coord: Coordenadas) -> Vec<Vec<String>> {
    let mut lines: Vec<Vec<String>> = Vec::new();
    let mut coord_aux = coord.clone();
    loop {
        if coord_aux.y > 1080.0 + (coord.height * 3.0) {
            break;
        }
        lines.push(horizontal_line(coord_aux));

        coord_aux.y = coord_aux.y + coord.height * 3.0 + coord.radius;
        coord_aux.new_x(); 
    }

    coord_aux = coord.clone();
    coord_aux.y = coord.y -( coord.height * 3.0 + coord.radius + (coord.border/2.0));
    coord_aux.new_x();

    loop {
        if coord_aux.y < (0.0 - (coord.height * 3.0)) {
            break;
        }

        lines.push(horizontal_line(coord_aux));
        coord_aux.y= coord_aux.y - (coord.height * 3.0 + coord.radius);
        coord_aux.new_x();
    }

    lines
}

fn main() {
    let mut file = File::create("polygon.svg").unwrap();
    
    let height = rand::thread_rng().gen_range(20.0..300.0);
    let width = rand::thread_rng().gen_range(height..400.0);

    println!("Coor {} {}",height,width);
    let coord = Coordenadas{
        x : rand::thread_rng().gen_range(0.0..1920.0),
        y : rand::thread_rng().gen_range(0.0..1080.0),
        height: height,
        width: width,
        radius : 10.0,
        border : 10.0
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
