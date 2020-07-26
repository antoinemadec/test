class Slider {
  constructor(min_val, max_val, default_val) {
    this.prev_val = default_val;
    this.pointer = createSlider(min_val, max_val, default_val);
  }

  value() {
    return this.pointer.value();
  }

  has_changed() {
    let old_val = this.prev_val;
    let new_val = this.value();
    this.prev_val = new_val;
    return old_val != new_val;
  }
}

class Fps {
  constructor(target, display_rate) {
    this.display_rate = (target + display_rate - 1) / display_rate;
    this.fps_idx = 0;
    this.fps = null;
    this.fps_str = "";
    frameRate(target);
  }

  show() {
    this.fps_idx++;
    if (this.fps_idx > this.display_rate) {
      this.fps_idx = 0;
      this.fps = frameRate();
    }
    if (this.fps) {
      // remove previous text
      fill(0);
      stroke(0);
      text(this.fps_str, 10, height - 10);
      // add new text
      fill(255);
      stroke(0);
      this.fps_str = "FPS: " + this.fps.toFixed(2);
      text(this.fps_str, 10, height - 10);
    }
  }
}
