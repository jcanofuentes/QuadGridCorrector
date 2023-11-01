void drawPoint(PGraphics g, PVector v, float radius, int c)
{
  g.beginDraw();
  g.pushMatrix();
  g.stroke(0);
  g.fill(c);
  g.ellipse(v.x, v.y, radius, radius);
  g.popMatrix();
  g.endDraw();
}

void drawQuad(PImage srcImage, ArrayList<ArrayList> grid, boolean flipX, boolean flipY, PGraphics pg )
{
  int nSegments = grid.get(0).size()-1;
  float uOffset = (srcImage.width) / nSegments;
  float vOffset = (srcImage.height)/ nSegments;
  if (flipX)
  {
    pg.translate(srcImage.width, 0, 0);
    pg.scale(-1, 1, 1);
  }
  if (flipY)
  {
    pg.translate(0, srcImage.height, 0);
    pg.scale(1, -1, 1);
  }
  for (int idy = 0; idy < nSegments; idy++)
  {
    for (int idx = 0; idx < nSegments; idx++)
    {
      // Get points for current quad
      PVector tr = (PVector) grid.get(idy).get(idx+1);
      PVector br = (PVector) grid.get(idy+1).get(idx+1);
      PVector bl = (PVector) grid.get(idy+1).get(idx);
      PVector tl = (PVector) grid.get(idy).get(idx);

      pg.noStroke();
      pg.beginShape();
      pg.texture(srcImage);
      pg.vertex(uOffset * idx, vOffset * (idy+1), bl.x, bl.y);   
      pg.vertex(uOffset * idx, vOffset * idy, tl.x, tl.y); 
      pg.vertex(uOffset *(idx+1), vOffset * (idy), tr.x, tr.y);  
      pg.vertex(uOffset *(idx+1), vOffset * (idy+1), br.x, br.y);  
      pg.endShape();
    }
  }
}

ArrayList<ArrayList> updateGrid(PVector topLeft, PVector topRight, PVector bottomRight, PVector bottomLeft, int nSegments, PGraphics pg, boolean drawGrid )
{
  ArrayList<ArrayList> grid = new ArrayList<ArrayList>();
  // Create left and right directions
  PVector leftEdge = PVector.sub(bottomLeft, topLeft);
  PVector rightEdge = PVector.sub(bottomRight, topRight);
  // Create offset vector for first and last columns
  PVector leftEdgeOffset = leftEdge.copy();
  leftEdgeOffset.div(nSegments);
  PVector rightEdgeOffset = rightEdge.copy();
  rightEdgeOffset.div(nSegments);
  // Create first and last point in row
  PVector firstPointInRow = topLeft.copy();
  PVector lastPointInRow = topRight.copy();

  for (int i = 0; i < nSegments + 1; i++)
  {
    // Create a new offset vector for current row
    PVector horizontalEdge = PVector.sub(lastPointInRow, firstPointInRow);
    PVector horizontalEdgeOffset = horizontalEdge.copy();
    horizontalEdgeOffset.div(nSegments);
    PVector nextPointInRow = firstPointInRow.copy();
    ArrayList<PVector> pointsInRow = new ArrayList<PVector>();
    for (int j = 0; j < nSegments + 1; j++)
    {
      if (drawGrid)
      {
        pg.fill(120, 90);
        pg.rectMode(CENTER);
        pg.rect( nextPointInRow.x, nextPointInRow.y, 10, 10 );
      }
      // Store point
      pointsInRow.add(nextPointInRow.copy());
      // Add offset
      nextPointInRow.add(horizontalEdgeOffset);
    }
    grid.add(pointsInRow);
    // Add left and right offsets
    firstPointInRow.add(leftEdgeOffset);
    lastPointInRow.add(rightEdgeOffset);
  }
  return grid;
}

void drawHandlers( ArrayList<PVector>points, PGraphics pg, int size, int c )
{
  println("------");
  for ( int i = 0; i<points.size(); i++)
  {
    PVector p = points.get(i);
    pg.pushStyle();
    pg.pushMatrix();
    pg.stroke(0);
    pg.fill(c, 100);
    pg.translate(p.x, p.y);
    pg.ellipse(0, 0, size, size);
    pg.stroke(0);
    pg.fill(c, 255);
    pg.ellipse(0, 0, size/2, size/2);
    pg.popStyle();
    pg.popMatrix();

    println(p);
  }
  PVector v0 = points.get(0);
  PVector v1 = points.get(1);
  PVector v2 = points.get(2);
  PVector v3 = points.get(3);

  pg.pushStyle();
  pg.stroke(c+c, 100);
  pg.strokeWeight(6);
  pg.line(v0.x, v0.y, v1.x, v1.y);
  pg.line(v1.x, v1.y, v2.x, v2.y);
  pg.line(v2.x, v2.y, v3.x, v3.y);
  pg.line(v3.x, v3.y, v0.x, v0.y);
  pg.popStyle();

  pg.pushStyle();
  pg.stroke(0);
  pg.strokeWeight(1);
  pg.line(v0.x, v0.y, v1.x, v1.y);
  pg.line(v1.x, v1.y, v2.x, v2.y);
  pg.line(v2.x, v2.y, v3.x, v3.y);
  pg.line(v3.x, v3.y, v0.x, v0.y);
  pg.popStyle();
}
