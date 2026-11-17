within IndustrialControlSystems.Controllers;
package Blocks "Simple linear blocks for control purposes"
  extends Modelica.Icons.Package;








  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This sub-package contains the basic building blocks for control system design. Unlike the
  blocks in the LinearSystems package, these components include output saturation with
  configurable limits (CSmin, CSmax) and a tracking mode that allows bumpless transfer
  between automatic control and an externally supplied reference signal. The following
  blocks are provided:
  <ul>
  <li><b>P</b> &mdash; proportional block with gain Kp, saturation and tracking mode.</li>
  <li><b>I</b> &mdash; pure integrator with time constant T, saturation and tracking mode.</li>
  <li><b>FO</b> &mdash; first-order (lag) filter with gain and time constant, saturation
      and tracking mode.</li>
  <li><b>LeadLAG</b> &mdash; lead-lag compensator, saturation and tracking mode.</li>
  <li><b>ComplexPoles</b> &mdash; second-order block with complex conjugate poles.</li>
  </ul>
  Each block can be configured for either continuous-time or discrete-time operation by
  setting the sampling period parameter Ts. When Ts is greater than zero the block uses
  a discrete-time approximation; when Ts equals zero a continuous-time formulation is used.
  </p>
  </HTML>",
          revisions="<html>
</html>"));
end Blocks;
