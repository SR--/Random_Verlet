// Create a jawa.awt frame and use controls in a separate window

// Control-related dependencies and variables
import java.awt.Frame;
import java.awt.BorderLayout;
import controlP5.*;

private ControlP5 cp5;

ControlFrame cf;
float springLengthDef = 10;
float springStrengthDef = 0.01;
float attrRadiusDef = 80;
float attrStrengthDef = 3;

ControlFrame addControlFrame(String theName, int theWidth, int theHeight) {
  Frame f = new Frame(theName);
  ControlFrame p = new ControlFrame(this, theWidth, theHeight);
  f.add(p);
  p.init();
  f.setTitle(theName);
  f.setSize(p.w, p.h);
  f.setLocation(100, 100);
  f.setResizable(false);
  f.setVisible(true);
  return p;
}


// the ControlFrame class extends PApplet, so we 
// are creating a new processing applet inside a
// new frame with a controlP5 object loaded
public class ControlFrame extends PApplet {

  int w, h;

  public void setup() {
    size(w, h);
    frameRate(15);
    cp5 = new ControlP5(this);
    cp5.addSlider("Spring Length").plugTo(system, "springLength").setValue(springLengthDef).setRange(1, 50).setPosition(10, 10);
    cp5.addSlider("Spring Strength").plugTo(system, "springStrength").setValue(springStrengthDef).setRange(0.001, 0.05).setPosition(10, 30);
    cp5.addSlider("Attraction Radius").plugTo(system, "attrRadius").setValue(attrRadiusDef).setRange(5, 200).setPosition(10, 50);
    cp5.addSlider("Attraction Strength").plugTo(system, "attrStrength").setValue(attrStrengthDef).setRange(0.3, 4).setPosition(10, 70);
  }

  public void draw() {

  }
  
  private ControlFrame() {
  }

  public ControlFrame(Object theParent, int theWidth, int theHeight) {
    parent = theParent;
    w = theWidth;
    h = theHeight;
  }

  public ControlP5 control() {
    return cp5;
  }
  
  ControlP5 cp5;

  Object parent;
}