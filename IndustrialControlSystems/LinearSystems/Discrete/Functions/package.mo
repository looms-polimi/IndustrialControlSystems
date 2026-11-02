within IndustrialControlSystems.LinearSystems.Discrete;
package Functions "Functions"
  extends IndustrialControlSystems.Icons.FunctionsPackage;







annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package collects the low-level discrete-time functions used internally
  by the discrete linear system blocks.  Each function implements one
  particular continuous-time transfer function structure and evaluates the
  corresponding discrete recurrence equation for one time step.
  </p>
  <p>
  Available functions:
  <ul>
    <li><b>fIntegrator</b> &mdash; pure integrator k/s</li>
    <li><b>fDerivator</b> &mdash; pure derivative k*s</li>
    <li><b>f1Pole</b> &mdash; first-order lag k/(1+s*tau)</li>
    <li><b>f1p1z</b> &mdash; lead-lag k*(1+s*T1)/(1+s*T2)</li>
    <li><b>f2p2z</b> &mdash; integrator with pole and two zeros k*(1+s*T1)*(1+s*T2)/(s*(1+s*T3))</li>
    <li><b>fCmplx</b> &mdash; second-order system with complex poles mu*omegan^2/(s^2+2*xi*omegan*s+omegan^2)</li>
  </ul>
  All functions accept a discretisation parameter <code>alfa</code> that
  selects the numerical integration scheme: 0 for Forward Euler, 1 for
  Backward Euler, and 0.5 for Tustin (bilinear) approximation.
  </p>
  </HTML>", revisions="<html>
</html>"));
end Functions;
