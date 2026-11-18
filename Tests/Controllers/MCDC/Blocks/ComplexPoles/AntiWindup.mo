within Tests.Controllers.MCDC.Blocks.ComplexPoles;
model AntiWindup "Blocks.ComplexPoles: anti-windup on"
  extends Base(AntiWindup=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>Blocks.ComplexPoles: anti-windup on. Configuration: <code>AntiWindup=true</code>.</p>
<p>MC/DC role: pairs with Base for AntiWindup (limits held, recovery after the set-point reversal vs. the output leaving the limits).</p>
</html>"));
end AntiWindup;
