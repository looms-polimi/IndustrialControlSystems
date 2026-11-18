within Tests.Controllers.MCDC.PD;
model Saturation "PD: saturation outputs on, anti-windup off"
  extends Base(useSAT=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PD: saturation outputs on, anti-windup off. Configuration: <code>useSAT=true</code>.</p>
<p>MC/DC role: pairs with SaturationAntiWindup for AntiWindup in `CS >= CSmax and AntiWindup` (satHI/satLOW stay false).</p>
</html>"));
end Saturation;
