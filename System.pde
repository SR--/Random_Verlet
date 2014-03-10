class System {

  float springLength;
  float springStrength;
  float attrStrength;
  float attrRadius;

  //Particle system constructor
  System(){
    springLength = 15;
    springStrength = 0.01;
    attrStrength = 3;
    attrRadius = 80;
  }

  // Initialize the particle system and add the first particle
  void initialize(){
    physics.clear();
    Particle particle = new Particle(width/2, height/2);
    physics.addParticle(particle);
    physics.addBehavior(new AttractionBehavior2D(particle, attrRadius, -attrStrength, 0.01f));
  }

  // Update the first particle and draw the nodes
  // Update all values dynamically
  void update(){
    changeSprings();
    changeAttractors();
    drawParticles();
  }

  // Add a particle to the system (at a random location and branch)
  void addNode()
  { 
    //check if all particles have been removed
    //if so, initialize
    if (physics.particles.isEmpty()){
      initialize();
    }
    // otherwise, position the new particle within limited distance from an
    // existing particle and link it with a spring
    else {
      Particle q = (Particle)physics.particles.get((int)random(0, physics.particles.size()-1));

      // Make a new particle and add it to the array
      Particle p = new Particle(q.x + random(-1, 1), q.y + random(-1, 1));
      physics.addParticle(p);

      //add the physics properties
      addAttraction(p);
      makeSpring(p, q);
    }
  }

  //Remove the last added particle and its spring
  void removeLastNode(){
    for (Iterator<VerletSpring2D> i = physics.springs.iterator(); i.hasNext();) {
      VerletSpring2D s = i.next();
      if (! i.hasNext()) {
        i.remove();
      }
    }

    for (Iterator<VerletParticle2D> i = physics.particles.iterator(); i.hasNext();) {
      VerletParticle2D p = i.next();
      if (! i.hasNext()) {
        i.remove();
      }
    }
  }

  //make a spring between two particles
  void makeSpring(Particle particle, Particle previous){
    VerletSpring2D spring = new VerletSpring2D(particle, previous, springLength, springStrength);
    // Add the spring to the physics world
    physics.addSpring(spring);
  }

  //add attraction to a particle
  void addAttraction(Particle p){
    physics.addBehavior(new AttractionBehavior2D(p, attrRadius, -attrStrength, 0.01f));
  }

///////////////////////////////////
// Functions for modifying values dynamically

  //adjust attraction properties
  void changeAttractors() {
    for (Iterator b = physics.behaviors.iterator(); b.hasNext();) {
      AttractionBehavior2D att = (AttractionBehavior2D)b.next();
      att.setRadius(attrRadius);
      att.setStrength(-attrStrength);
    }
  }

  //adjust spring properties
  void changeSprings() {
    for (Iterator b = physics.springs.iterator(); b.hasNext();) {
      VerletSpring2D sp = (VerletSpring2D)b.next();
      sp.setRestLength(springLength);
      sp.setStrength(springStrength);
    }
  }

  //draw all particles of the system
  void drawParticles() {
    for (Iterator b = physics.particles.iterator(); b.hasNext();) {
      Particle p = (Particle)b.next();
      p.display();
    }
  }
}