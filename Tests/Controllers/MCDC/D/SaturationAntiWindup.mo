within Tests.Controllers.MCDC.D;
model SaturationAntiWindup "D: saturation outputs and anti-windup on"
  extends Base(useSAT=true, AntiWindup=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>D: saturation outputs and anti-windup on. Configuration: <code>useSAT=true, AntiWindup=true</code>.</p>
<p>MC/DC role: pairs with AntiWindup for useSAT, and with Saturation for AntiWindup (satHI and satLOW both occur).</p>
</html>"));
end SaturationAntiWindup;
