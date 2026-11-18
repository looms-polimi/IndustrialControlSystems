within Tests.LinearSystems.MCDC.DiscreteTransferFunction;
model InitSteadyOutput "DiscreteTransferFunction: initialised at steady output"
  extends Base(initSteadyOutput=true);
  annotation (experiment(StopTime=10, Interval=0.005, Tolerance=1e-8), Documentation(info="<html>
<p>DiscreteTransferFunction: initialised at steady output. Configuration: <code>initSteadyOutput=true</code>.</p>
<p>MC/DC role: pairs with Base for initSteadyOutput.</p>
</html>"));
end InitSteadyOutput;
