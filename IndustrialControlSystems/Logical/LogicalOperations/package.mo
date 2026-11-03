within IndustrialControlSystems.Logical;
package LogicalOperations "This package contains a list of typical boolean operations: NOT, AND, OR, ... and logic blocks as Flip Flop."
  extends Modelica.Icons.Package;


  annotation (Documentation(
info="
  <HTML>
  <h4>Description</h4>
  <p>
  This package contains sampled-data models of basic and customisable Boolean logic elements.
  All blocks accept a configurable number of inputs and a sampling time parameter <em>Ts</em>;
  setting <em>Ts = 0</em> makes the block operate in continuous time. Available blocks include:
  </p>
  <ul>
  <li><b>And</b> &mdash; n-input logical AND gate.</li>
  <li><b>Or</b> &mdash; n-input logical OR gate.</li>
  <li><b>Not</b> &mdash; element-wise logical NOT.</li>
  <li><b>Xor</b> &mdash; n-input logical XOR gate (chained pairwise).</li>
  <li><b>FlipFlopSR</b> &mdash; SR (Set-Reset) flip-flop with complementary outputs Q and
  not-Q.</li>
  </ul>
  </HTML>", revisions="<html>
</html>"));
end LogicalOperations;
