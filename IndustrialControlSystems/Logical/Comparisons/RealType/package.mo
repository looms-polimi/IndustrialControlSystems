within IndustrialControlSystems.Logical.Comparisons;
package RealType "Real numbers comparisons"
  extends Modelica.Icons.Package;


annotation (Documentation(info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains sampled-data relational operator blocks that compare two real-valued
  signals. Available operators include equal (==), not-equal (!=), greater-than (&gt;),
  less-than (&lt;), greater-than-or-equal (&gt;=), and less-than-or-equal (&lt;=). Because
  exact equality of real numbers is numerically fragile, a tolerance parameter <em>eps</em>
  is provided so that two values are considered equal when their absolute difference is less
  than <em>eps</em>.
  </p>
  </HTML>", revisions="<html>
</html>"));
end RealType;
