within IndustrialControlSystems.Logical;
package Comparisons "This package contains both Integer and Real relational operators (==,!=,>,<,...)."
  extends Modelica.Icons.Package;


  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains sampled-data relational operator blocks for both integer and real-valued
  signals. Supported operators are: equal (==), not-equal (!=), greater-than (&gt;),
  less-than (&lt;), greater-than-or-equal (&gt;=), and less-than-or-equal (&lt;=).
  </p>
  <p>
  The package is subdivided into two sub-packages:
  </p>
  <ul>
  <li><em>IntegerType</em> &mdash; comparison blocks for integer signals.</li>
  <li><em>RealType</em> &mdash; comparison blocks for real-valued signals, with a configurable
  numerical tolerance <em>eps</em> for equality tests.</li>
  </ul>
  <p>
  All blocks read their inputs at each sampling step (period <em>Ts</em>) and produce a Boolean
  output that reflects the result of the comparison.
  </p>
  </HTML>", revisions="<html>
</html>"));
end Comparisons;
