class Particle {
  constructor(pos, angle, ray_nb, max_reflections = 10, fov_degrees = 360) {
    this.ray_nb = ray_nb;
    this.rays = [];
    for (let i = 0; i < ray_nb; i++) {
      let hue = (i * 100) / ray_nb;
      this.rays.push(
        new Ray(createVector(0, 0), 0, [hue, 100, 100], max_reflections)
      );
    }
    this.update(pos, angle, fov_degrees);
  }

  update(pos, angle, fov_degrees) {
    this.pos = pos;
    this.angle = angle;
    this.fov_degrees = fov_degrees;
    let i = 0;
    let a_fract = fov_degrees / this.ray_nb;
    for (let ray of this.rays) {
      ray.update(pos, angle + i * a_fract);
      i++;
    }
  }

  move(d_x, d_y) {
    let new_pos = createVector(this.pos.x + d_x, this.pos.y + d_y);
    this.update(new_pos, this.angle, this.fov_degrees);
  }

  rotate(d_angle) {
    this.update(this.pos, this.angle + d_angle, this.fov_degrees);
  }

  show(walls) {
    for (let ray of this.rays) {
      ray.show(walls);
    }
    fill(255);
    ellipse(this.pos.x, this.pos.y, 7);
  }
}
