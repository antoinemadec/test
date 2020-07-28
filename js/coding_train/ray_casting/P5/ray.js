class Ray {
  constructor(
    pos = createVector(0, 0),
    angle = 0,
    hsb = [0, 100, 100],
    max_reflections = 10,
    reflection_idx = -1
  ) {
    this.hsb = hsb;
    this.reflection_idx = reflection_idx;
    this.max_reflections = max_reflections;
    this.reflections = [];
    // create reflections array if "top" ray
    if (reflection_idx == -1) {
      let brightness = hsb[2];
      for (var i = 0; i < max_reflections; i++) {
        brightness *= 0.9;
        this.reflections.push(
          new Ray(
            createVector(0, 0),
            0,
            [hsb[0], hsb[1], brightness],
            max_reflections,
            i
          )
        );
        this.reflections[i].reflections = this.reflections;
      }
    }
    this.update(pos, angle);
  }

  update(pos, angle) {
    this.pos = pos;
    this.angle = angle;
    this.dir = p5.Vector.fromAngle(radians(this.angle));
    this.inf_dir = this.dir.copy().mult(2 * max(width, height));
  }

  show(walls) {
    let closest_point = null;
    let closest_refl_vect = null;
    let record = Infinity;
    for (let wall of walls) {
      const r = this.cast(wall);
      if (r) {
        const pt = r[0];
        const refl_vect = r[1];
        const dist_square =
          pow(this.pos.x - pt.x, 2) + pow(this.pos.y - pt.y, 2);
        if (dist_square < record && dist_square >= 0.9) {
          record = dist_square;
          closest_point = pt;
          closest_refl_vect = refl_vect;
        }
      }
    }
    if (closest_point) {
      let reflection = this.createReflection(closest_point, closest_refl_vect);
      if (reflection) {
        reflection.show(walls);
      }
      colorMode(HSB, 100);
      stroke(this.hsb[0], this.hsb[1], this.hsb[2]);
      line(this.pos.x, this.pos.y, closest_point.x, closest_point.y);
    } else {
      colorMode(HSB, 100);
      stroke(this.hsb[0], this.hsb[1], this.hsb[2]);
      line(
        this.pos.x,
        this.pos.y,
        this.pos.x + this.inf_dir.x,
        this.pos.y + this.inf_dir.y
      );
    }
  }

  cast(wall) {
    const x1 = wall.a.x;
    const y1 = wall.a.y;
    const x2 = wall.b.x;
    const y2 = wall.b.y;
    const x3 = this.pos.x;
    const y3 = this.pos.y;
    const x4 = this.pos.x + this.dir.x;
    const y4 = this.pos.y + this.dir.y;

    const den = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
    if (den == 0) {
      return;
    }

    const t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / den;
    const u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / den;
    if (t > 0 && t < 1 && u > 0) {
      // reflection vector
      const v1 = [x4 - x3, y4 - y3];
      const v2 = [x2 - x1, y2 - y1];
      const k = (v1[0] * v2[0] + v1[1] * v2[1]) / (v2[0] * v2[0] + v2[1] * v2[1]);
      const refl_vect = createVector(
        -v1[0] + 2 * k * v2[0],
        -v1[1] + 2 * k * v2[1]
      );
      // intersection point
      const pt = createVector();
      pt.x = x1 + t * (x2 - x1);
      pt.y = y1 + t * (y2 - y1);
      return [pt, refl_vect];
    } else {
      return;
    }
  }

  createReflection(point, vect) {
    const pos = point;
    const angle = degrees(createVector(1, 0).angleBetween(vect));
    const reflection_idx = this.reflection_idx + 1;
    if (reflection_idx + 1 > this.max_reflections) {
      return null;
    } else {
      let reflection = this.reflections[reflection_idx];
      reflection.update(pos, angle);
      return reflection;
    }
  }
}
