ArrayList<SomeCluster> someClusters;
JSONObject world;

void setup() {
  size(800, 800);
  
  someClusters = new ArrayList<SomeCluster>();
  world = loadJSONObject("data/world.json");
  
  // extract centroids
  JSONArray jCentroids = world.getJSONArray("centroids");
  for (int i = 0; i < jCentroids.size(); i++) {
    JSONArray jCentrPoint = jCentroids.getJSONArray(i);
    someClusters.add(new SomeCluster(new PVector(4.0*jCentrPoint.getFloat(0), 4.0*jCentrPoint.getFloat(1))));
    println("centroid " + i + " added.");
  }
  
  // assign points to the centroids
  JSONArray jPoints = world.getJSONArray("points");
  for (int i = 0; i < jPoints.size(); i++) {
    JSONArray jPt = jPoints.getJSONArray(i);
    PVector thePoint = new PVector(4.0*jPt.getFloat(0), 4.0*jPt.getFloat(1));
    SomeCluster fav = null;
    for (SomeCluster theCluster : someClusters) {
      if (fav == null || theCluster.dist(thePoint) < fav.dist(thePoint))
        fav = theCluster;
    }
    fav.add(thePoint);
    println(i+": point ("+thePoint.x+", "+thePoint.y+") added to cluster ("+fav.centroid.x+", "+fav.centroid.y+")");
  }
  
  noLoop();
}

void draw() {
  background(255);
  for (SomeCluster theCluster : someClusters)
    theCluster.draw();
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    for (SomeCluster theCluster : someClusters)
      theCluster.recalculate();
  }
  
  if (key == 'e' || key == 'E') {
    for (int i = 0; i < someClusters.size(); i++) {
      SomeCluster theCluster = someClusters.get(i);
      for (int j = 1; j < theCluster.somePoints.size(); j++) {
        PVector thePoint = theCluster.somePoints.get(j);
        int cand = -1;
        for (int k = 0; k < someClusters.size(); k++) {
          SomeCluster otherCluster = someClusters.get(k);
          if (theCluster.dist(thePoint) > otherCluster.dist(thePoint)) cand = k;
        }
        if (cand >= 0 && cand != i) {
          theCluster.somePoints.remove(j);
          someClusters.get(cand).add(thePoint);
        }
      }
    }
  }
  redraw();
}
