within IndustrialControlSystems.Controllers;
package Interfaces "Interfaces"
  extends IndustrialControlSystems.Icons.InterfacesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the partial interface models that form the contractual basis for
  all controllers and control blocks in the <b>Controllers</b> package. The key interfaces
  are:
  <ul>
  <li><b>BaseBlock</b> &mdash; partial SISO block declaring a real scalar input (u) and
      output (y) together with the sampling-period parameter Ts. Extended by blocks in the
      Blocks sub-package.</li>
  <li><b>Block</b> &mdash; partial control block that adds saturation limits (CSmin,
      CSmax), optional tracking connectors (TR, TS) and an optional bias input (Bias).
      Extended by the Blocks sub-package components.</li>
  <li><b>Controller</b> &mdash; partial controller model declaring the standard industrial
      controller connectors: set point (SP), process variable (PV) and control signal
      (CS), plus conditional connectors for tracking (TR, TS), bias (Bias) and auto-tuning
      request (ATreq). All concrete P, I, D, PI, PD and PID controllers extend this
      interface.</li>
  </ul>
  </p>
  </HTML>",
  revisions="<html>
</html>"));
end Interfaces;
