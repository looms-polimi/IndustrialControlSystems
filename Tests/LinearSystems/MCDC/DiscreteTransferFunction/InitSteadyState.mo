within Tests.LinearSystems.MCDC.DiscreteTransferFunction;
model InitSteadyState "DiscreteTransferFunction: initialised at steady state"
  extends Base(initSteadyState=true);
  annotation (experiment(StopTime=10, Interval=0.005, Tolerance=1e-8), Documentation(info="<html>
<p>DiscreteTransferFunction: initialised at steady state. Configuration: <code>initSteadyState=true</code>.</p>
<p>MC/DC role: pairs with Base for initSteadyState.</p>
</html>"));
end InitSteadyState;
