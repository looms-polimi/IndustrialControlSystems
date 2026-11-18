within Tests.Controllers.MCDC.PI;
model InitFromFBstart "PI: reset state initialised from FBstart = 0.4"
  extends Base(initFromFBstart=true);
  annotation (experiment(StopTime=40, Interval=0.01, Tolerance=1e-6), Documentation(info="<html>
<p>PI: reset state initialised from FBstart = 0.4. Configuration: <code>initFromFBstart=true</code>.</p>
<p>MC/DC role: pairs with Base for initFromFBstart (output starts at FBstart and keeps it as an offset).</p>
</html>"));
end InitFromFBstart;
