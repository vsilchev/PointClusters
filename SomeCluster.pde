class SomeCluster {
  PVector centroid;
  ArrayList<PVector> somePoints;
  float maxDist;
  
  SomeCluster(PVector newCentroid) {
    centroid = newCentroid.get();
    somePoints = new ArrayList<PVector>();
    somePoints.add(newCentroid);
    maxDist = 0;
  }
  
  void add(PVector newPoint) {
    somePoints.add(newPoint.get());
    float d = PVector.dist(newPoint, centroid);
    if (d > maxDist)
      maxDist = d;
  }
  
  float dist(PVector pp) {
    return centroid.dist(pp);
  }
  
  void recalculate() {
    int n = 0;
    float x = 0, y = 0;
    for (PVector yetAnotherPoint : somePoints) {
      x += yetAnotherPoint.x;
      y += yetAnotherPoint.y;
      n++;
    }
    centroid = new PVector(x/n, y/n);
    maxDist = 0;
    for (PVector yetAnotherPoint : somePoints) {
      float dd = centroid.dist(yetAnotherPoint);
      if (dd > maxDist)
        maxDist = dd;
    }
  }
  
  void draw() {
    // draw cluster area
    ellipseMode(RADIUS);
    strokeWeight(1);
    noStroke();
    fill(200+random(55), 200+random(55), 200+random(55), 50);
    ellipse(centroid.x, height-centroid.y, maxDist, maxDist);
    
    // draw cluster points
    noFill();
    strokeCap(ROUND);
    for (PVector yetAnotherPoint : somePoints) {
      strokeWeight(5);
      stroke(0xFFA08000);
      point(yetAnotherPoint.x, height-yetAnotherPoint.y);
      strokeWeight(1);
      stroke(0);
      line(yetAnotherPoint.x, height-yetAnotherPoint.y, centroid.x, height-centroid.y);
    }
    
    // draw centroid
    strokeWeight(1);
    stroke(0xFFFF0000);
    line(centroid.x-3, height-centroid.y, centroid.x+3, height-centroid.y);
    line(centroid.x, height-centroid.y-3, centroid.x, height-centroid.y+3);
    fill(0);
    textSize(10);
    text("("+(0.25*centroid.x)+", "+(0.25*centroid.y)+")", centroid.x+2, height-centroid.y+2);
  }
}


