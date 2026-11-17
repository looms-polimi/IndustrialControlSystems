within IndustrialControlSystems.Controllers.Digital;
package Examples "Examples"
extends IndustrialControlSystems.Icons.ExamplesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains example models for the digital controllers in the
  <b>Digital</b> sub-package. The examples demonstrate two-degree-of-freedom discrete-time
  PID controllers and their variants:
  <ul>
  <li><b>TestPID</b> &mdash; basic test of the discrete-time two-degree-of-freedom PID
      controller (PID_2dof) showing set-point tracking and disturbance rejection.</li>
  <li><b>TestPID_TDO</b> &mdash; test of the PID_2dof_TDO variant, which uses a
      time-driven output update scheme to evaluate the effect of the sampling period on
      closed-loop performance.</li>
  <li><b>TestPID_TDOe</b> &mdash; test of the fully event-based variant
      (PID_2dof_TDO_FullyEventBased) that generates output updates triggered by state
      events rather than a fixed clock.</li>
  </ul>
  </p>
  </HTML>",
  revisions="<html>
</html>"));
end Examples;
