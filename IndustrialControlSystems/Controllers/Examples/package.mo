within IndustrialControlSystems.Controllers;
package Examples "Examples"
  extends IndustrialControlSystems.Icons.ExamplesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains example models that test and illustrate the standard controllers
  provided in the <b>Controllers</b> package. Two categories of tests are included for
  each controller type (P, I, D, PI, PD, PID):
  <ul>
  <li><b>TestX_bias</b> &mdash; compares three closed-loop configurations: uncontrolled
      process, process with the controller in automatic mode, and process with the same
      controller augmented by a bias input. A step set-point change and an external
      disturbance signal are applied to show steady-state error behaviour and the effect
      of the bias in rejecting the disturbance.</li>
  <li><b>TestX_tracking</b> &mdash; compares the automatic and tracking modes of the
      controller. A BooleanTable signal enables tracking at a specified time, forcing the
      control signal to follow an externally provided track reference (TR). The examples
      also demonstrate bumpless transition back to automatic mode for controllers with
      integrating action (PI, PID).</li>
  </ul>
  All examples support both continuous-time and discrete-time operation through the
  model parameter <b>Ts</b>: setting Ts &gt; 0 switches the controllers to their
  discrete-time equivalents, allowing the effect of different sampling periods and
  discretisation methods to be studied.
  </p>
  </HTML>",
  revisions="<html>
</html>"));
end Examples;
