within IndustrialControlSystems.Controllers.Blocks;
package Examples "Examples"
  extends IndustrialControlSystems.Icons.ExamplesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains example models that demonstrate the control blocks available in
  the <b>Blocks</b> sub-package. The examples cover the anti-windup and tracking behaviour
  of the basic continuous/discrete-time building blocks:
  <ul>
  <li><b>TestAntiWindupBlocks</b> &mdash; illustrates output saturation and anti-windup
      for the proportional (P), integrator (I), first-order (FO) and lead-lag (LeadLAG)
      blocks when the control signal hits its bounds.</li>
  <li><b>TestTrackingFO</b> &mdash; demonstrates the tracking mode of the first-order
      filter block, showing bumpless transition between automatic and track modes.</li>
  <li><b>TestTrackingI</b> &mdash; demonstrates the tracking mode of the integrator
      block.</li>
  <li><b>TestTrackingLL</b> &mdash; demonstrates the tracking mode of the lead-lag
      block.</li>
  <li><b>TestTrackingP</b> &mdash; demonstrates the tracking mode of the proportional
      block.</li>
  </ul>
  </p>
  </HTML>",
  revisions="<html>
</html>"));
end Examples;
