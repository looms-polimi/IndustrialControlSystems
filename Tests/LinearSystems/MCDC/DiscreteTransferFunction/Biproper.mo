within Tests.LinearSystems.MCDC.DiscreteTransferFunction;
model Biproper "DiscreteTransferFunction: biproper (3s + 1)/(2s + 1)"
  extends Base(num={3, 1});
  annotation (experiment(StopTime=10, Interval=0.005, Tolerance=1e-8), Documentation(info="<html>
<p>DiscreteTransferFunction: biproper (3s + 1)/(2s + 1). Configuration: <code>num={3, 1}</code>.</p>
<p>MC/DC role: pairs with Base for `D == N`.</p>
</html>"));
end Biproper;
