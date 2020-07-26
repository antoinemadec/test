let walls = [];
let particle;
let slider_ray_nb;
let slider_reflections;
let slider_fov;
let fps;

function setup() {
  createCanvas(800, 800);
  for (let i = 0; i < 5; i++) {
    let x1 = random(width);
    let x2 = random(width);
    let y1 = random(height);
    let y2 = random(height);
    walls[i] = new Boundary(x1, y1, x2, y2);
  }
  fps = new Fps(60, 2);
  slider_ray_nb = new Slider(1, 2000, 720);
  slider_reflections = new Slider(0, 20, 10);
  slider_fov = new Slider(1, 360, 15);
  particle = new Particle(
    createVector(width / 2, height / 2),
    0,
    slider_ray_nb.value(),
    slider_reflections.value(),
    slider_fov.value()
  );
  show();
}

function show() {
  background(0);
  for (let wall of walls) {
    wall.show();
  }
  particle.show(walls);
}

function draw() {
  // updates from user
  let update = 0;
  if (keyIsDown(LEFT_ARROW)) {
    particle.move(-2, 0);
    update++;
  }
  if (keyIsDown(RIGHT_ARROW)) {
    particle.move(2, 0);
    update++;
  }
  if (keyIsDown(UP_ARROW)) {
    particle.move(0, -2);
    update++;
  }
  if (keyIsDown(DOWN_ARROW)) {
    particle.move(0, +2);
    update++;
  }
  if (keyIsDown(SHIFT)) {
    particle.rotate(1);
    update++;
  }
  if (slider_ray_nb.has_changed() || slider_reflections.has_changed()) {
    update++;
    particle = new Particle(
      particle.pos,
      particle.angle,
      slider_ray_nb.value(),
      slider_reflections.value(),
      slider_fov.value()
    );
  }
  if (slider_fov.has_changed()) {
    update++;
    particle.update(particle.pos, particle.angle, slider_fov.value());
  }

  if (update > 0) {
    show();
  }

  fps.show();
}
