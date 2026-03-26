/* Framework Code
 * Lesen Sie gerne mal rein um zu verstehen, was passiert, sich etwas an
 * Asmyptote zu gewöhnen, wir werden es noch ein paar mal verwenden.
 *
 * Weiter unten sollen Sie selbst Code einfügen.
 *
 */
unitsize(1cm);

pen B[] = {rgb("2e75b6"), rgb("5b9bd5"), rgb("9dc3e6")};
pen O[] = {rgb("000000"), rgb("ed7d31"), rgb("f9cbad")};
pen G[] = {rgb("000000"), rgb("70ad47"), rgb("a9d18e")};

void draw_pixelgrid(int w, int h, pen lines = lightgray, pen dots = invisible) {
  for (int x = 0; x <= w; ++x)
    draw((x, 0)--(x, h), lightgray);
  for (int y = 0; y <= h; ++y)
    draw((0, y)--(w, y), lightgray);
  for (int x = 0; x < w; ++x)
    for (int y = 0; y < h; ++y)
      dot((x + .5, y + .5), linewidth(4) + dots);
}

struct pixel_pos {
  int x, y;
  void operator init(int x, int y) {
    this.x = x;
    this.y = y;
  }
};

void draw_pixel(real x, real y, pen border = black + linewidth(2),
                pen fill = lightgray) {
  void draw_pixel_discrete(int x, int y) {
    filldraw((x, y)--(x + 1, y)--(x + 1, y + 1)--(x, y + 1)-- cycle, fill,
             border);
  }
  draw_pixel_discrete((int)x, (int)y);
}

pair line_normal(pair a, pair b) {
  pair v = b - a;
  v = v / sqrt(dot(v, v));
  return (-v.y, v.x);
}

struct tri {
  pair a, b, c;
  void operator init(pair a, pair b, pair c) {
    this.a = a;
    this.b = b;
    this.c = c;
  }
  void draw(pen outline = black + linewidth(2), pen inner = invisible,
            bool labels = true) {
    filldraw(a-- b-- c-- cycle, inner, outline);
    if (labels) {
      label("\huge$a$", a - .5 * unit(line_normal(a, b) + line_normal(c, a)));
      label("\huge$b$", b - .5 * unit(line_normal(a, b) + line_normal(b, c)));
      label("\huge$c$", c - .5 * unit(line_normal(b, c) + line_normal(c, a)));
    }
  }
};

int res_x = 16, res_y = 9;

/*
 * Aufgabe 3 & 4.
 * Erweitern Sie diese Funktion wie beschrieben.
 * Der Code weiter oben muss dafür nicht verändert werden.
 *
 */
void raster_signed_distance(tri tri, bool conservative) {
  pair[] corners = {tri.a, tri.b, tri.c};
  path tri_path = tri.a-- tri.b-- tri.c-- cycle;
  pair lo = min(tri_path) - (1, 1);
  pair hi = max(tri_path) + (1, 1);
  for (int y = 0; y <= res_y; y += 1)
    for (int x = 0; x <= res_x; x += 1) {
      bool is_inside_triangle = true;
      for (int i = 0; i < corners.length; ++i) {
        pair p = (x + 0.5, y + 0.5);

        pair v1 = corners[i];
        pair v2 = corners[(i + 1) % corners.length];

        pair v = v2 - v1;
        pair mid = v1 + v / 2;

        pair v_norm = line_normal(v1, v2);
        pair v_p = p - mid;

        real angle_rad_acos = dot(v_p, v_norm) / (length(v_p) * length(v_norm));
        if (angle_rad_acos > 1.0)
          angle_rad_acos = 1.0;
        if (angle_rad_acos < -1.0)
          angle_rad_acos = -1.0;
        if (acos(angle_rad_acos) > pi / 2) {
          is_inside_triangle = false;
          break;
        }
      }
      if (is_inside_triangle) {
        draw_pixel(x, y, B[1], B[2]);
        continue;
      }
      if (!conservative) {
        continue;
      }
      path pixel_path = (x, y)--(x + 1, y)--(x + 1, y + 1)--(x, y + 1)-- cycle;
      if (
          lo.x <= x &&
          lo.y <= y &&
          hi.x >= x &&
          hi.y >= y &&
          intersect(pixel_path, tri_path).length > 0
      ) {
        draw_pixel(x, y, G[1], G[2]);
      }
    }
}

/*
 * Aufgabe 3 & 4.
 * Demonstrieren Sie ihre Implementierung mit einzelnen Beispielen.
 * Gruppierung in {} der Übersichtlichkeit halber.
 *
 */

{
  tri tri = tri((1.2, 8.3), (2.7, 2.2), (14.3, 1.1));

  draw_pixelgrid(res_x, res_y, dots = lightgray);

  raster_signed_distance(tri, true);
  tri.draw(B[1] + linewidth(2));

  shipout("raster-tri-1.pdf");
  erase();
}
