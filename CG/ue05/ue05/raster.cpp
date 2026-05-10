#include "raster.h"

#include <glm/gtc/random.hpp>

using namespace glm;
using namespace png;
using namespace std;

bool overlaps_pixel(const vec2 &p, const triangle &tri, render_target &target);

vector<rgb_pixel> color_palette;

render_target raster_triangles(const vector<triangle> &triangles) {
  // set up color palette to visualize different triangles
  color_palette.resize(triangles.size());
  for (int i = 0; i < triangles.size(); ++i)
    color_palette[i] =
        rgb_pixel(linearRand(0, 255), linearRand(0, 255), linearRand(0, 255));

  // set up render target and clear to dark grey
  render_target target;
  target.framebuffer.resize(cmdline.vp_w, cmdline.vp_h);
  target.depth_buffer.assign(
      cmdline.vp_w * cmdline.vp_h,
      std::numeric_limits<float>::infinity()
  );
  for (png::uint_32 y = 0; y < cmdline.vp_h; ++y)
    for (png::uint_32 x = 0; x < cmdline.vp_w; ++x)
      target.framebuffer[y][x] = png::rgb_pixel(60, 60, 60);

  // go over all triangles
  for (int i = 0; i < triangles.size(); ++i) {
    const triangle &tri = triangles[i];
    // find bounding box
    vec3 bb_min, bb_max;
    bb_min = floor(min(tri.a, min(tri.b, tri.c)));
    bb_max = ceil(max(tri.a, max(tri.b, tri.c)));
    // clip bounding box
    bb_min.x = fmaxf(bb_min.x, 0.0f);
    bb_min.y = fmaxf(bb_min.y, 0.0f);
    bb_max.x = fminf(bb_max.x, cmdline.vp_w - 1.0f);
    bb_max.y = fminf(bb_max.y, cmdline.vp_h - 1.0f);

    // baycentric interpolation precalculations
    vec3 u = tri.b - tri.a;
    vec3 v = tri.c - tri.a;
    auto d = u.x * v.y - u.y * v.x;

    // go over all pixels in bounding box
    // NOTE: here, we assume to be in window coordinates, NOT NDC
    for (int y = int(bb_min.y); y < int(bb_max.y); ++y)
      for (int x = int(bb_min.x); x < int(bb_max.x); ++x) {
        if (overlaps_pixel(vec2(x + 0.5f, y + 0.5f), tri, target)) {
          int inv_y = target.framebuffer.get_height() - 1 - y;

          // baycentric depth interpolation
          auto p = vec2(x, y);
          vec3 pma = vec3(p, 0.0f) - vec3(vec2(tri.a), 0.0f);
          float beta = 1 / d * dot(vec3(v.y, -v.x, 0.0f), pma);
          float gamma = 1 / d * dot(vec3(-u.y, u.x, 0.0f), pma);
          float alpha = 1 - beta - gamma;

          vec3 zs = vec3(tri.a.z, tri.b.z, tri.c.z);
          vec3 bary = vec3(alpha, beta, gamma);
          float z = dot(zs, bary);

          if (z < target.depth_buffer[y * cmdline.vp_w + x]) {
            target.depth_buffer[y * cmdline.vp_w + x] = z;
            target.framebuffer[inv_y][x] = color_palette[i];
          }
        }
      }
  }

  return target;
}

vec2 line_normal(vec2 a, vec2 b) {
  vec2 v = normalize(b - a);
  return vec2(-v.y, v.x);
}

bool overlaps_pixel(const vec2 &p, const triangle &tri, render_target &target) {
  if (dot(line_normal(tri.a, tri.b), p - vec2(tri.a)) < 0)
    return false;
  if (dot(line_normal(tri.b, tri.c), p - vec2(tri.b)) < 0)
    return false;
  if (dot(line_normal(tri.c, tri.a), p - vec2(tri.c)) < 0)
    return false;

  if (cmdline.pipeline != window_only)
    if (tri.a.z < 0 || tri.b.z < 0 || tri.c.z < 0)
      return false;

  return true;
}
