within IndustrialControlSystems.Logical.Timers;
package Functions "Functions"
extends IndustrialControlSystems.Icons.FunctionsPackage;


  annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the pure algorithmic functions that implement the internal logic of the
  timer blocks. Available functions are:
  </p>
  <ul>
  <li><em>positiveEdge</em> &mdash; detects a 0-to-1 transition of the Set signal and records
  the start time.</li>
  <li><em>risingEdge</em> &mdash; detects a rising edge and maintains a Run flag until Reset.</li>
  <li><em>fallingEdge</em> &mdash; detects a 1-to-0 transition and maintains a Run flag until
  Reset.</li>
  <li><em>hold</em> &mdash; latches the Set signal high across transitions until Reset clears
  it.</li>
  <li><em>tim</em> &mdash; on-delay timer output: true while Set is active and elapsed time is
  within the programmed duration.</li>
  <li><em>odt</em> &mdash; off-delay timer output: true when Set is active and the elapsed time
  exceeds the programmed duration.</li>
  <li><em>odts</em> &mdash; off-delay timer output used with edge-triggered variants: true when
  elapsed time exceeds the programmed duration and Run is active.</li>
  </ul>
  </HTML>", revisions="<html>
</html>"));
end Functions;
