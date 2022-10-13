# mrDMD-damage-detection
Workflow for simulating sensor signals to investigate methods for damage detection in a wind turbine gearbox. This workflow is described and implemented in ["Multi-resolution Dynamic Mode Decomposition for Damage Detection in Wind Turbine Gearboxes"](https://arxiv.org/abs/2110.04103), where it is used for analysing several damage detection methods. For additional details on the mechinal engineering settings of the workflow see [1] and [2].


### Download

Download the repository, e.g. from your terminal by typing:

$ git clone https://github.com/Fraunhofer-SCAI/mrDMD-damage-detection.git

### Files

- Workflow_code: MATLAB code to produce acceleration signals simulating the gearbox vibration response under steady wind conditions. To run rhs.mat and Backlash.mat are required.


- rhs: right-hand-side of ODE numerically solved in Workflow.mat.


- Backlash: Backlash function.

### Including wind turbulence
The workflow allows for the inclusion of wind turbulence into the generation of the signals. To include wind turbulence one needs the shaft torque signal of a gearbox system under the influence of wind turbulence. Such torque signal can be simulated using the FAST code [3], as done in [2].

### Example Data
The simulated data with and without wind turbulence as used in ["Multi-resolution Dynamic Mode Decomposition for Damage Detection in Wind Turbine Gearboxes"](https://arxiv.org/abs/2110.04103) is available at 
[https://fordatis.fraunhofer.de/handle/fordatis/262](https://fordatis.fraunhofer.de/handle/fordatis/262).

### Contact 

 email [climaco@ins.uni-bonn.de](mailto:climaco@ins.uni-bonn.de) for questions about code.


### References

[1] Kahraman, A. and Singh, R. (1991). Interactions between time-varying mesh stiffness and clearance non-linearities in a geared system. Journal of Sound and Vibration, 146(1):135-156.

[2] Antoniadou, I., Manson, G., Staszewski, W., Barszcz, T., and Worden, K. (2015). A time-frequency analysis approach for condition monitoring of a wind turbine gearbox under varying load conditions. Mechanical Systems and Signal Processing, 64-65:188-216.

[3] Jonkman, J.M., Buhl Jr., M.L. (2005). FAST User's Guide. NREL/EL-500-29798. Golden, CO: National Renewable Energy Laboratory

[4] Climaco, P., Garcke, J. and Iza-Teran, R. (2022). Multi-resolution Dynamic Mode Decomposition for damage detection in wind turbine gearboxes. Data-Centric Engineering. accepted. A preprint is available at https://arxiv.org/abs/2110.04103.



### Funding

The MATLAB code has been developed inside the project MADESI. The work was supported by the German Federal Ministry of Education and Research (BMBF; project
”MADESI“ FKZ 01IS18043A).


