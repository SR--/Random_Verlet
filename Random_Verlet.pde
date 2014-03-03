//this is just trying to convert Random Arboretum from traer physics
//to verlet physics from toxy

import java.util.Iterator;

import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics "world" (2D)
VerletPhysics2D physics;

//Make the system of particle
System system;

void setup() {
  size(1920, 1080);
  smooth();
  // Initialize the physics world
  physics = new VerletPhysics2D();
  physics.setWorldBounds(new Rect(0, 0, width, height));

  //Initialise the particle system

  system = new System();
  system.initialize();

  // Setup controls
  cp5 = new ControlP5(this);
  
  // by calling function addControlFrame() a
  // new frame is created and an instance of class
  // ControlFrame is instanziated.
  cf = addControlFrame("Controls", 300, 200);
}

void draw() {
  background(255);

  // Update physics
  physics.update();
  // Draw system of particles
  system.update();
}

void mousePressed()
{
  system.addNode();
}

void mouseDragged()
{
  system.addNode();
}