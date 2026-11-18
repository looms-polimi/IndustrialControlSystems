within Tests.Logical.MCDC.Xor;
model TwoInputs "Xor: two inputs"
  extends Base(n=2);
  annotation (experiment(StopTime=8.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>Xor: two inputs. Configuration: <code>n=2</code>.</p>
<p>MC/DC role: pairs with Base for the loop over inputs 3..n (not entered with two inputs).</p>
</html>"));
end TwoInputs;
