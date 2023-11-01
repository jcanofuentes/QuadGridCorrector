# QuadGridCorrector

QuadGridCorrector is a snippet for Processing to correct image distortion when drawing on a quad using four points. By dividing the quad into multiple segments and leveraging OpenGL, it ensures the image remains undistorted.

## Usage:
1. Define the four points of your quad.
2. Call the `updateGrid` function to set up the grid.
3. Use the `drawQuad` function to draw your image onto the quad.
4. Adjust the `nSegments` parameter for grid granularity.
5. Optional:   drawHandlers( ... )

## Requirements:
- Processing 3.x or newer.
