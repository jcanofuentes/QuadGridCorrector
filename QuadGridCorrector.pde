import java.util.ArrayList;
import processing.core.*;

int targetWidth = 640;
int targetHeight = 640;

ArrayList<PVector> points = null;
PImage sourceImage;
PGraphics sourcePG = null;
PGraphics destPG = null;

void settings()
{
  size(1300, 640, P2D);
}

void setup()
{
  // Load input image
  sourceImage = loadImage("source.png");

  // Create PGraphics
  sourcePG = createGraphics(targetWidth, targetHeight, P2D);
  destPG = createGraphics(targetWidth, targetHeight, P2D);

  points = new ArrayList();
  points.add(new PVector(354.0, 59.0, 0));
  points.add(new PVector(614.0, 59.0, 0));
  points.add(new PVector(549.0, 586.0, 0));
  points.add(new PVector(419.0, 585.0, 0));
}

void draw()
{
  background(120);

  sourcePG.beginDraw();
  sourcePG.image(sourceImage, 0, 0, targetWidth, targetHeight);
  ArrayList<ArrayList> grid = updateGrid( points.get(0), points.get(1), points.get(2), points.get(3), 8, sourcePG, false);
  sourcePG.endDraw();

  image( sourcePG, 0, 0, targetWidth, targetHeight);
  text( "Source image: drag the handlers with the mouse to adjust the image's perspective", 10,20 );
  
  drawHandlers(points, this.g, 14, color(120, 180, 8));

  destPG.beginDraw();
  destPG. background(120);
  drawQuad( sourcePG, grid, false, false, destPG );
  destPG.endDraw();

  image( destPG, targetWidth+20, 0, targetWidth, targetHeight);
}

public void mouseDragged()
{
  for (int i=0; i <points.size(); i++)
  {
    PVector mouseLoc = new PVector(mouseX, mouseY, 0);
    float d = mouseLoc.dist(points.get(i));
    if (d< 60)
    {
      points.get(i).x = mouseLoc.x;
      points.get(i).y = mouseLoc.y;
    }
  }
}
