within Tests.Controllers;
package Logic "Tests of Controllers.Logic"
  extends Modelica.Icons.ExamplesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>Tests of <a href=\"modelica://IndustrialControlSystems.Controllers.Logic\">IndustrialControlSystems.Controllers.Logic</a>.</p>
  <p>
  This package contains example models that demonstrate the logic controllers in the
  <b>Logic</b> sub-package. The example provided is:
  <ul>
  <li><b>TestRelay</b> &mdash; illustrates the behaviour of the relay and relay-with-hysteresis
      controllers when connected to a process. The example shows the characteristic
      on/off switching action, the effect of the hysteresis band on the switching frequency,
      and the resulting limit-cycle oscillation in the process output.</li>
  </ul>
  </p>
  </HTML>",
  revisions="<html>
</html>"));
end Logic;
