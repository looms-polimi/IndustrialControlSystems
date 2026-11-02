within IndustrialControlSystems.Controllers.Logic;
package Examples "Examples"
  extends IndustrialControlSystems.Icons.ExamplesPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
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
end Examples;
