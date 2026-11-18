within Tests.Controllers.MCDC.D;
model Bias "D: bias input on"
  extends Base(useBIAS=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>D: bias input on. Configuration: <code>useBIAS=true</code>.</p>
<p>MC/DC role: pairs with Base for useBIAS (output = reference + bias).</p>
</html>"));
end Bias;
