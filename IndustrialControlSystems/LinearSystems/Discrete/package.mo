within IndustrialControlSystems.LinearSystems;
package Discrete "Discretised linear systems"
  extends Modelica.Icons.Package;











  annotation (Icon(
        coordinateSystem(preserveAspectRatio=true,
          extent={{-100.0,-100.0},{100.0,100.0}}),
          graphics={
        Line(points={{-78.0,-42.0},{-52.0,-42.0},{-52.0,0.0},{-26.0,0.0},{-26.0,24.0},{-6.0,24.0},{-6.0,64.0},{18.0,64.0},{18.0,20.0},{38.0,20.0},{38.0,0.0},{44.0,0.0},{44.0,0.0},{62.0,0.0}},
          color={0,0,127})}), Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package provides discrete-time linear system blocks for use in
  sampled-data control system models.  All blocks are based on equivalent
  continuous-time transfer functions that are converted to recurrence
  equations using a selectable numerical integration method (Forward Euler,
  Backward Euler, or Tustin) via the <code>discrMethod</code> enumeration.
  </p>
  <p>
  The package is organised into the following sub-packages:
  <ul>
    <li><b>Functions</b> &mdash; low-level recurrence-equation functions for
        individual transfer-function structures (integrator, derivator,
        first-order, lead-lag, complex poles, etc.).</li>
    <li><b>Types</b> &mdash; enumeration type for the discretisation method
        selection.</li>
  </ul>
  In addition, discrete-time block models (e.g. Delay, MultiStepsDelay) are
  provided directly in this package.
  </p>
  </HTML>", revisions="<html>
</html>"));
end Discrete;
