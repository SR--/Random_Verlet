class System {

  float springLength;
  float springStrength;
  float attrStrength;
  float attrRadius;

  // This list is redundant since we can ask for physics.particles, but in case we have many of these
  // it's a convenient to keep track of our own list
  ArrayList<Particle> particles;

  //Particle system constructor
  System(){
    particles = new ArrayList<Particle>();

    springLength = 15;
    springStrength = 0.01;
    attrStrength = 3;
    attrRadius = 80;
  }

  // Initialise the particle system and add the first particle
  void initialize(){
    physics.clear();
    Particle particle = new Particle(width/2, height/2);

    physics.addParticle(particle);
    particles.add(particle);

    physics.addBehavior(new AttractionBehavior2D(particle, attrRadius, -attrStrength, 0.01f));
  }

  // Update the first particle and draw the nodes
  // Update all values dynamically
  void update(){
    changeSprings();
    changeAttractors();
    drawParticles();
  }

  // Add a particle to the system (at a random place)
  void addNode()
  { 
    // Position this new particle within limited distance from an
    // existing particle and link it with a spring
    Particle q = particles.get((int)random(0, particles.size()-1));

    // Make a new particle and add it to the two arrays
    Particle p = new Particle(q.x + random(-1, 1), q.y + random(-1, 1));
    physics.addParticle(p);
    particles.add(p);

    addAttraction(p);
    makeSpring(p, q);
  }

  void makeSpring(Particle particle, Particle previous){
    VerletSpring2D spring = new VerletSpring2D(particle, previous, springLength, springStrength);
    // Add the spring to the physics world
    physics.addSpring(spring);
  }

  void addAttraction(Particle p){
    physics.addBehavior(new AttractionBehavior2D(p, attrRadius, -attrStrength, 0.01f));
  }

///////////////////////////////////
// Functions for modifying values dynamically

  void changeAttractors() {
    // Update physics world attraction behaviour force radius
    for (Iterator b = physics.behaviors.iterator(); b.hasNext();) {
      AttractionBehavior2D att = (AttractionBehavior2D)b.next();
      att.setRadius(attrRadius);
      att.setStrength(-attrStrength);
    }
  }

  void changeSprings() {
    // Update physics world attraction behaviour force radius
    for (Iterator b = physics.springs.iterator(); b.hasNext();) {
      VerletSpring2D sp = (VerletSpring2D)b.next();
      sp.setRestLength(springLength);
      sp.setStrength(springStrength);
    }
  }

  void drawParticles() {
    // Update physics world attraction behaviour force radius
    for (Iterator b = physics.particles.iterator(); b.hasNext();) {
      Particle p = (Particle)b.next();
      p.display();
    }
  }
}