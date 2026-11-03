within IndustrialControlSystems.Logical.Comparisons;
package IntegerType "Integer numbers comparisons"
  extends Modelica.Icons.Package;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains sampled-data relational operator blocks that compare two integer-valued
  signals. Available operators include equal (==), not-equal (!=), greater-than (&gt;),
  less-than (&lt;), greater-than-or-equal (&gt;=), and less-than-or-equal (&lt;=). Each block
  reads its two integer inputs at every sampling step and produces a Boolean output reflecting
  the result of the comparison.
  </p>
  </HTML>", revisions="<html>
</html>"));
end IntegerType;
