within IndustrialControlSystems.LinearSystems;
package Continuous "Continuous time linear systems"
  extends Modelica.Icons.Package;









  annotation (Icon(graphics={Line(
          origin={0.061,4.184},
          points={{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,
              113.485},{-65.374,-61.217},{-78.061,-78.184}},
          color={95,95,95},
          smooth=Smooth.Bezier)}), Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package provides continuous-time linear system blocks for use in
  dynamic control system models.  All blocks extend the common
  <code>BaseBlock</code> partial model and expose a single Real input
  <code>u</code> and a single Real output <code>y</code>.
  </p>
  <p>
  The following continuous-time transfer function blocks are included:
  <ul>
    <li><b>Integrator</b> &mdash; pure integrator mu/s</li>
    <li><b>FirstOrder</b> &mdash; first-order lag mu/(1+s*tau)</li>
    <li><b>Delay</b> &mdash; pure time delay e^(-s*T)</li>
    <li><b>SmithDelay</b> &mdash; Smith predictor delay element (1-e^(-s*T))</li>
  </ul>
  </p>
  </HTML>", revisions="<html>
</html>"));
end Continuous;
