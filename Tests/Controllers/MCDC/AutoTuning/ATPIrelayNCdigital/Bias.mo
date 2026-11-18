within Tests.Controllers.MCDC.AutoTuning.ATPIrelayNCdigital;
model Bias "AutoTuning.ATPIrelayNCdigital: bias input on"
  extends Base(useBIAS=true);
  annotation (experiment(StopTime=260, Interval=0.05, Tolerance=1e-6), Documentation(info="<html>
<p>AutoTuning.ATPIrelayNCdigital: bias input on. Configuration: <code>useBIAS=true</code>.</p>
<p>MC/DC role: pairs with Base for useBIAS (output = reference + bias).</p>
</html>"));
end Bias;
