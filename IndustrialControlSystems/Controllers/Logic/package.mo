within IndustrialControlSystems.Controllers;
package Logic "Logic controllers"
  extends Modelica.Icons.Package;




  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This sub-package contains basic discontinuous (logic) controllers that produce a
  binary or quantised control output rather than a continuously variable signal. The
  following models are provided:
  <ul>
  <li><b>Relay</b> &mdash; an ideal two-position relay controller. The control signal
      switches between a high output value and a low output value depending on the sign
      of the error (SP &minus; PV). No hysteresis is applied, so switching occurs exactly
      at the zero-crossing of the error.</li>
  <li><b>RelayHysteresis</b> &mdash; a relay with a configurable hysteresis band. The
      output switches to the high value when the error exceeds the upper threshold and
      returns to the low value only when the error falls below the lower threshold. The
      hysteresis reduces unwanted chattering near the switching point and is the element
      used internally by the auto-tuning controllers in the <b>AutoTuning</b> sub-package
      to induce controlled oscillations in the process.</li>
  </ul>
  Simulation examples are provided in the <b>Examples</b> sub-package.
  </p>
  </HTML>",
          revisions="<html>
</html>"));
end Logic;
