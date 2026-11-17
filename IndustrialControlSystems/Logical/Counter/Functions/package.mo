within IndustrialControlSystems.Logical.Counter;
package Functions "Functions"
  extends IndustrialControlSystems.Icons.FunctionsPackage;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains the pure algorithmic function <em>count</em> that implements the
  core logic of the up/down counter. The function is called at each sampling step and computes
  the new counter value and status output based on the current and previous states of the
  Set, Reset, Count-Up, and Count-Down signals.
  </p>
  </HTML>", revisions="<html>
</html>"));
end Functions;
