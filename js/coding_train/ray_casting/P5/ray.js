class Ray {
  constructor(
    pos,
    angle,
    hsb = [0, 100, 100],
    max_reflections = 10,
    reflection_idx = 0
  ) {
    this.hsb = hsb;
    this.reflection_idx = reflection_idx;
    this.max_reflections = max_reflections;
    this.update(pos, angle);
  }

  update(pos, angle) {
    this.pos = pos;
    this.angle = angle;
    this.dir = p5.Vector.fromAngle(radians(this.angle));
    this.inf_dir = this.dir.copy().mult(2 * max(width, height));
    this.reflection = null;
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
        const d = p5.Vector.dist(this.pos, pt);
        if (d < record && d >= 0.9) {
          record = d;
          closest_point = pt;
          closest_refl_vect = refl_vect;
        }
      }
    }
    if (closest_point) {
      this.reflection = this.createReflection(closest_point, closest_refl_vect);
      if (this.reflection) {
        this.reflection.show(walls);
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
      const v1 = createVector(x4 - x3, y4 - y3).normalize();
      const v2 = createVector(x2 - x1, y2 - y1).normalize();
      const k = p5.Vector.dot(v1, v2) / p5.Vector.dot(v2, v2);
      const k2_v2 = v2.copy().mult(2 * k);
      const refl_vect = v1.copy().mult(-1).add(k2_v2);
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
    const brightness = this.hsb[2] * 0.9;
    if (brightness <= 0 || reflection_idx > this.max_reflections) {
      return null;
    } else {
      return new Ray(
        pos,
        angle,
        [this.hsb[0], this.hsb[1], brightness],
        this.max_reflections,
        reflection_idx
      );
    }
  }
}
