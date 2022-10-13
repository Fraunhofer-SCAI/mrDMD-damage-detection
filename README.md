# mrDMD-damage-detection
Workflow on generating simulated sensor signals to investigate damage detection in a wind turbine gearbox. This workflow is described, developed and implemented in ["Multi-resolution Dynamic Mode Decomposition for Damage Detection in Wind Turbine Gearboxes"](https://arxiv.org/abs/2110.04103). For additional details on the workflow settings see [1] and [2].


### Download

Download the repository from your terminal by typing:

$ git clone https://github.com/Fraunhofer-SCAI/mrDMD-damage-detection.git

### Files

- Workflow_code: MATLAB code to produce acceleration signals simulating the gearbox vibration response under steady wind conditions. To run required rhs.mat and Backlash.mat.


- rhs: right-hand-side of ODE numerically solved in Workflow.mat.


- Backlash: Backlash function.

### Including wind turbulence
This Workflow allows for the inclusion of wind turbulence into the generated signals. To include wind turbulence is required the shaft torque signal of a gearbox system under the influence of wind turbulence. Such torque signal can be simulated using the FAST code [3], as done in [2].


### Contact 

 email [climaco@ins.uni-bonn.de](mailto:climaco@ins.uni-bonn.de) for questions about code.


### References

[1] Kahraman, A. and Singh, R. (1991). Interactions between time-varying mesh stiffness and clearance non-linearities in a geared system. Journal of Sound and Vibration, 146(1):135-156.

[2] Antoniadou, I., Manson, G., Staszewski, W., Barszcz, T., and Worden, K. (2015). A time-frequency analysis approach for condition monitoring of a wind turbine gearbox under varying load conditions. Mechanical Systems and Signal Processing, 64-65:188-216.

[3] Jonkman, J.M.; Buhl Jr., M.L. (2005). FAST User's Guide. NREL/EL-500-29798. Golden, CO: National Renewable Energy Laboratory




### Funding

The MATLAB code has been generated as part of the project MADESI, which has been granted by the BMBF within their announcement “Richtlinie zur Förderung von Forschungsvorhaben zur automatisierten Analyse von Daten mittels Maschinellen Lernens.”




