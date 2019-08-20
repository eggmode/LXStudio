// In this file you can define your own custom patterns
import heronarts.lx.LX;
import heronarts.lx.LXPattern;
import heronarts.lx.model.LXPoint;
import heronarts.lx.modulator.LXModulator;
import heronarts.lx.modulator.SawLFO;
import heronarts.lx.modulator.SinLFO;

// Here is a fairly basic example pattern that renders a plane that can be moved
// across one of the axes.
@LXCategory("Form")
public static class PlanePattern extends LXPattern {
  
  public enum Axis {
    X, Y, Z
  };
  
  public final EnumParameter<Axis> axis =
    new EnumParameter<Axis>("Axis", Axis.X)
    .setDescription("Which axis the plane is drawn across");
  
  public final CompoundParameter pos = new CompoundParameter("Pos", 0, 1)
    .setDescription("Position of the center of the plane");
  
  public final CompoundParameter wth = new CompoundParameter("Width", .4, 0, 1)
    .setDescription("Thickness of the plane");
  
  public PlanePattern(LX lx) {
    super(lx);
    addParameter("axis", this.axis);
    addParameter("pos", this.pos);
    addParameter("width", this.wth);
  }
  
  public void run(double deltaMs) {
    float pos = this.pos.getValuef();
    float falloff = 100 / this.wth.getValuef();
    float n = 0;
    for (LXPoint p : model.points) {
      switch (this.axis.getEnum()) {
      case X: n = p.xn; break;
      case Y: n = p.yn; break;
      case Z: n = p.zn; break;
      }
      colors[p.index] = LXColor.gray(max(0, 100 - falloff*abs(n - pos))); 
    }
  }
}

public class YaxisPattern extends LXPattern {

   private final LXModulator hue = startModulator(new SinLFO(180, 200, 9000));
   private final LXModulator brightness = startModulator(new SinLFO(100, 100, 4000));
   private final LXModulator yPos = startModulator(new SinLFO(0, 1, 10000));
   private final LXModulator xPos = startModulator(new SinLFO(1, 0, 10000));
   private final LXModulator zPos = startModulator(new SawLFO(100, 0, 10000));
   private final LXModulator width = startModulator(new SinLFO(.4, 1, 3000));

   public YaxisPattern(LX lx) {
     super(lx);
   }

   @Override
   public void run(double deltaMs) {
     float hue = this.hue.getValuef();
     float brightness = this.brightness.getValuef();
     float xPos = this.xPos.getValuef();
     float yPos = this.yPos.getValuef();
     float zPos = this.zPos.getValuef();

     float falloff = 250 / (this.width.getValuef());
     for (LXPoint p : model.points) {
       colors[p.index] = LX.hsb(hue, 100, Math.max(0, brightness - falloff * Math.abs(p.xn - xPos)));
       // colors[p.index] = LX.hsb(hue, 100, Math.max(0, brightness - falloff * Math.abs(p.zn - zPos)));


       // colors[p.index] = LX.hsb(hue, 100, Math.max(0, brightness - falloff * Math.abs(p.yn - yPos)));

       // colors[p.index] = LX.hsb(hue, 100, Math.max(0, brightness - falloff * Math.abs(p.xn - xPos)));

     }
   }
 }
 public class TrinitronPattern extends LXPattern {

   private final LXModulator hue = startModulator(new SinLFO(180, 200, 9000));
   private final LXModulator brightness = startModulator(new SinLFO(100, 100, 4000));
   private final LXModulator yPos = startModulator(new SinLFO(0, 1, 200));
   private final LXModulator xPos = startModulator(new SawLFO(0, 1, 0));
   private final LXModulator width = startModulator(new SinLFO(.4, 1, 3000));
   private final LXModulator crazy = startModulator(new SinLFO(.4, 1, 3000));


   public TrinitronPattern(LX lx) {
     super(lx);
   }

   @Override
   public void run(double deltaMs) {
     float hue = this.hue.getValuef();
     float brightness = this.brightness.getValuef();
     float crazy = this.crazy.getValuef();
     float xPos = this.xPos.getValuef();
     float yPos = this.yPos.getValuef();
     float falloff = 100 / (this.width.getValuef());
     for (LXPoint p : model.points) {
      float x = brightness - falloff * Math.abs(p.xn - xPos * crazy/2);
      float y = brightness - falloff * Math.abs(p.xn - yPos * crazy/2);
       colors[p.index] = LX.hsb(hue, 100, Math.max(0, x));
     }
   }
 }
 
 
public class Amoeba extends LXPattern {

   private final LXModulator hue = startModulator(new SinLFO(180, 200, 9000));
   private final LXModulator brightness = startModulator(new SinLFO(100, 100, 4000));
   private final LXModulator yPos = startModulator(new SinLFO(0, 1, 50000));
   private final LXModulator xPos = startModulator(new SawLFO(100, 0, 5000));
   private final LXModulator width = startModulator(new SinLFO(.1, 1, 3000));

   public Amoeba(LX lx) {
     super(lx);
   }

   @Override
   public void run(double deltaMs) {
     float hue = this.hue.getValuef();
     float brightness = this.brightness.getValuef();
     float xPos = this.xPos.getValuef();
     float yPos = this.yPos.getValuef();

     float falloff = 100 / (this.width.getValuef());
     for (LXPoint p : model.points) {
       colors[p.index] = LX.hsb(hue, 100, Math.max(0, brightness - falloff * Math.abs(p.yn - yPos)));
       // colors[p.index] = LX.hsb(hue, 100, Math.max(0, brightness - falloff * Math.abs(p.xn - xPos)));

     }
   }
 }
public class Sparkle extends LXPattern {
  
  public final CompoundParameter rate = new CompoundParameter("rate", 10, 0, 5)
    .setDescription("Sparkle motion");

  public Sparkle(LX lx) {
    super(lx);
    addParameter("rate", this.rate);
  }
  
  public void run(double deltaMs) {
    float rate = this.rate.getValuef();

    for (LXPoint p : model.points) {
      if (random(0,100) < rate) {
        colors[p.index] = LXColor.hsb(random (125, 200), 100, random(0, 100));
      } else {
        colors[p.index] = LXColor.hsb(0, 0, 0);
      }
    }
  }
}

public class Ripple extends LXPattern {
  public final CompoundParameter duration = new CompoundParameter("duration", 3058, 100, 5000)
    .setDescription("duration (ms)");

  public final CompoundParameter thickness = new CompoundParameter("thickness", 10, 1, 80)
    .setDescription("thickness");

  public Ripple(LX lx) {
    super(lx);
    addParameter("duration", this.duration);
    addParameter("thickness", this.thickness);
  }

  private final int black = LXColor.hsb(0, 0, 0);
  private float previous_t = 0;
  private LXPoint center = model.points[(int)random(model.points.length - 1)];
  private float jitter = random(500);

  public void run(double deltaMs) {
    // constants
    float radiusFudgeFactor = 0.05; // radius is in global units, so we need to scale it so a pulse travels the whole glome in 1000ms at 1 speed by default

    // parameters
    float pulseDuration = this.duration.getValuef(); // + jitter;
    float pulseThickness = this.thickness.getValuef();

    // computed values
    float t = millis() % pulseDuration;
    float radius = t * radiusFudgeFactor;
    float pulseBrightness = t / pulseDuration;
    float easedPulseBrightness = 1 - pow(pulseBrightness, 3);

    // new pulse detected
    if (t < previous_t) {
      center = model.points[(int)random(model.points.length - 1)];
      jitter = random(500);
    }

    for (LXPoint p : model.points) {
      float distanceToCenter = dist(center.x, center.y, center.z, p.x, p.y, p.z);
      float distanceToRadius = abs(distanceToCenter - radius + pulseThickness); // pulse is eased on both sides
      //float distanceToRadius = distanceToCenter - radius + pulseThickness; // pulse is eased on back side only; front is solid

      if (distanceToRadius < pulseThickness) {
        float proximityToPulseCenter = distanceToRadius / pulseThickness;
        float easedPulseThickness = 1 - pow(proximityToPulseCenter, 3);

        colors[p.index] = LXColor.hsb(181, 100, 100 * easedPulseThickness * easedPulseBrightness);
      } else {
        colors[p.index] = black;
      }
    }

    previous_t = t;
  }
}

@LXCategory("Form")
public class Clouds extends LXPattern {
    
  public final CompoundParameter speed = new CompoundParameter("speed", 50, 1, 500)
    .setDescription("Speed of the clouds");

  public final CompoundParameter noisiness = new CompoundParameter("noisiness", 500, 5, 1000)
    .setDescription("Noisiness of the background");

  public final CompoundParameter saturation_one = new CompoundParameter("saturation_one", 0.5, 0.0, 1.0)
    .setDescription("saturation_one");

  public final CompoundParameter saturation_two = new CompoundParameter("saturation_two", 100, 0, 100)
    .setDescription("saturation_two");

  public final CompoundParameter zoom = new CompoundParameter("zoom", 10, 1, 100)
    .setDescription("Look into the clouds");


  public Clouds(LX lx) {
    super(lx);
    //addParameter("axis", this.axis);
    //addParameter("pos", this.pos);
    addParameter("speed", this.speed);
    addParameter("noisiness", this.noisiness);
    addParameter("saturation_one", this.saturation_one);
    addParameter("saturation_two", this.saturation_two);
    addParameter("zoom", this.zoom);
  }
  
  public void run(double deltaMs) {
    float speed = this.speed.getValuef() / 1000000;
    float noisiness = this.noisiness.getValuef();
    float saturation_one = this.saturation_one.getValuef();
    float saturation_two = this.saturation_two.getValuef();
    float zoom = this.zoom.getValuef() / 1000;

    float hue = (noise(millis() * speed) * 200) % 360;
    float dx = millis() * speed;

    for (LXPoint p : model.points) {
      float n = noisiness * (noise(dx + p.x * zoom, p.y * zoom, p.z * zoom) * saturation_one);

      colors[p.index] = LXColor.hsb(hue, saturation_two, n); 
    }
  }
}

public static class RainbowRoll extends LXPattern {
   float hoo;
   
   public final CompoundParameter angle = new CompoundParameter("Angle", 180, 0, 360)
    .setDescription("barrel roll angle");
    
  public RainbowRoll(LX lx){
     super(lx);   
     addParameter("Angle", this.angle);
  }
  
 public void run(double deltaMs) {
     //anglemod=anglemod+1;
     //if (anglemod > 360){
       //anglemod = anglemod % 360;
     //}
     
    for (LXPoint p: model.points) {
      //conveniently, hue is on a scale of 0-360
      hoo=((atan(p.x/p.z))*360/PI+this.angle.getValuef());
      colors[p.index]=lx.hsb(hoo,80,50);
    }
  }
}
