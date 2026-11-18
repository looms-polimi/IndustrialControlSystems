within Tests.Controllers.MCDC.PD;
model SampledSaturationAntiWindup "PD: saturation outputs and anti-windup on, sampled (Ts = 0.05)"
  extends Base(useSAT=true, AntiWindup=true, Ts=0.05);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PD: saturation outputs and anti-windup on, sampled (Ts = 0.05). Configuration: <code>useSAT=true, AntiWindup=true, Ts=0.05</code>.</p>
<p>MC/DC role: pairs with SampledAntiWindup for useSAT, and with Saturation for AntiWindup (satHI and satLOW both occur).</p>
</html>"));
end SampledSaturationAntiWindup;
