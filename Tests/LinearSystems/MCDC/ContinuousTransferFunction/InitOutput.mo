within Tests.LinearSystems.MCDC.ContinuousTransferFunction;
model InitOutput "ContinuousTransferFunction: output initialised to y_start = 0.5"
  extends Base(initOutput=true);
  annotation (experiment(StopTime=10, Interval=0.005, Tolerance=1e-8), Documentation(info="<html>
<p>ContinuousTransferFunction: output initialised to y_start = 0.5. Configuration: <code>initOutput=true</code>.</p>
<p>MC/DC role: pairs with Base for initOutput.</p>
</html>"));
end InitOutput;
