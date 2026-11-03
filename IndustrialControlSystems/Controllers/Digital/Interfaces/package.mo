within IndustrialControlSystems.Controllers.Digital;
package Interfaces "Interfaces"
extends IndustrialControlSystems.Icons.InterfacesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the interface definitions used by the digital controllers in the
  <b>Digital</b> sub-package. The primary interface is:
  <ul>
  <li><b>Controller</b> &mdash; a partial model that declares the standard connector
      signals for a digital (discrete-time) controller: set point (SP), process variable
      (PV) and control signal (CS), together with the sampling period parameter Ts and
      conditional connectors for tracking reference (TR), track switch (TS) and bias
      (Bias).</li>
  </ul>
  Concrete digital controller models extend this interface and provide the algorithmic
  or equation-based implementation of the control law.
  </p>
  </HTML>",
  revisions="<html>
</html>"));
end Interfaces;
