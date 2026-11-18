within Tests.Utilities;
function near "true if |actual - expected| <= tol*(1 + |expected|)"
  extends Modelica.Icons.Function;
  input Real actual "Value under test";
  input Real expected "Expected value";
  input Real tol = 1e-10 "Mixed absolute/relative tolerance";
  output Boolean ok "true if actual is within tolerance of expected";
algorithm
  ok := abs(actual - expected) <= tol*(1 + abs(expected));
  annotation (Documentation(info="<html>
<p>Comparison used by function tests: the tolerance is absolute for |expected| &lt; 1 and
relative above.</p>
</html>"));
end near;
