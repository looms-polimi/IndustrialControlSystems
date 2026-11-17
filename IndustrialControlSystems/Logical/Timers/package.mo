within IndustrialControlSystems.Logical;
package Timers "This package contains various types of timers."
  extends Modelica.Icons.Package;


  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains sampled-data timer blocks modelled after IEC 61131-3 timer function
  blocks. All timers share a common interface: a Boolean Set input <em>S</em>, a Boolean Reset
  input <em>R</em>, a real-valued Programmed Value input <em>PV</em> (duration in seconds), and
  a Boolean status output <em>Q</em>. The Reset signal immediately clears the timer regardless
  of its state. Available timer types are:
  </p>
  <ul>
  <li><b>Timer_On</b> &mdash; on-delay timer: Q is true while S is active and the elapsed time
  is within PV.</li>
  <li><b>Timer_On_Redge</b> &mdash; on-delay timer triggered by the rising edge of S.</li>
  <li><b>Timer_OffDelay</b> &mdash; off-delay timer: Q becomes true after the elapsed time
  exceeds PV while S is active.</li>
  <li><b>Timer_OffDelay_Redge</b> &mdash; off-delay timer triggered by the rising edge of S.</li>
  <li><b>Timer_OffDelay_Fedge</b> &mdash; off-delay timer triggered by the falling edge of S.</li>
  </ul>
  <p>
  Residual-time variants additionally expose a real output <em>tr</em> giving the remaining time
  before the timer expires.
  </p>
  </HTML>", revisions="<html>
</html>"));
end Timers;
