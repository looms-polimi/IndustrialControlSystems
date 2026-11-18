within Tests.LinearSystems.MCDC.ContinuousTransferFunction;
model ScaledDenominator "ContinuousTransferFunction: 2/(4s + 2), the same system as Base"
  extends Base(num={2}, den={4, 2});
  annotation (experiment(StopTime=10, Interval=0.005, Tolerance=1e-8), Documentation(info="<html>
<p>ContinuousTransferFunction: 2/(4s + 2), the same system as Base. Configuration: <code>num={2}, den={4, 2}</code>.</p>
<p>MC/DC role: not an MC/DC pair: checks that the coefficient of the state in the denominator is used (Base has 1 there).</p>
</html>"));
end ScaledDenominator;
