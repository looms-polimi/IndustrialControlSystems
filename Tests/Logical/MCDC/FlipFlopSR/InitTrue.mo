within Tests.Logical.MCDC.FlipFlopSR;
model InitTrue "FlipFlopSR: initial output true"
  extends Base(q_start=true);
  annotation (experiment(StopTime=8.5, Interval=0.005, Tolerance=1e-6), Documentation(info="<html>
<p>FlipFlopSR: initial output true. Configuration: <code>q_start=true</code>.</p>
<p>MC/DC role: pairs with Base for q_start (output true until the first edge).</p>
</html>"));
end InitTrue;
