class Particle extends VerletParticle2D {

  float radius = 2;  // Adding a radius for each particle
  
  Particle(float x, float y) {
    super(x,y);
  }

  // All we're doing really is adding a display() function to a VerletParticle
  void display() {
    fill(0);
    //stroke(0);
    //strokeWeight(1);
    ellipse(x, y, radius*2, radius*2);
  }
}