within IndustrialControlSystems.Controllers;
package AutoTuning "Automatic Tuning controllers"
  extends Modelica.Icons.Package;




  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This sub-package contains PI controllers equipped with a relay-based automatic tuning
  algorithm (AT). Two realisations are provided:
  <ul>
  <li><b>ATPIrelayNCdigital</b> &mdash; a fully discrete-time PI controller that switches
      between normal PI mode and an auto-tuning mode. During auto-tuning a relay-plus-integrator
      drives the control signal to induce a periodic oscillation in the process output.
      Once the oscillation is deemed permanent (period variation within a user-defined
      tolerance and a minimum number of cycles observed), the oscillation frequency and
      amplitude are used to compute the PI gains for a specified phase margin.</li>
  <li><b>ATPIrelayNCmixedMode</b> &mdash; a mixed continuous/discrete-time version in which
      the PI controller itself is realised as a continuous-time equation system while the
      auto-tuning state machine runs in discrete time. Handshaking between the two domains
      is handled by reinitialising the integrator state at the start and end of the tuning
      phase, resulting in bumpless transitions.</li>
  </ul>
  Both controllers expose an ATreq boolean input that triggers the tuning procedure, and
  return to normal PI operation automatically once valid parameters have been computed.
  Simulation examples are provided in the <b>Examples</b> sub-package.
  </p>
  </HTML>",
          revisions="<html>
</html>"));
end AutoTuning;
