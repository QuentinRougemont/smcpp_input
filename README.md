# smcpp_input  
small scripts to prepare smcpp files  


# Purpose 

 * converting vcf file into smcpp input 
 * running smcpp

This is basically the same as the main smcpp but the function are encapsulated   
into bash scripts to run on my local server    

## Dependencies  

smc++ available [here](https://github.com/popgenmethods/smcpp) to infer population size change and split time  
the software depends on python, anaconda and other libraries documented on the smcpp page  

## Major Steps 

   * **_1 vcf conversion_**
		run script `01_scripts/00_vcf_to_smcc_jSFS.sh` to produce smcpp input  
		requirement: an indexed vcffile
		
   * **_2 estimates population size change through time_**  
		run script `01_scripts/01_smcc_cv.sh` that will use the [cv](https://github.com/popgenmethods/smcpp) function to estimates population size change.
		You need to provide a mutation rate for the focal species.
		
   * **_3 ploting_**
		This only requires the plot command, an example can be find in:  
		`01_scripts/03_plotting_size_change.sh`  
		
   * **_4 pop split_**  
		run script `01_scripts/04_pairwise.sfs.sh` to create pairwise sfs  
		then run script `01_scripts/05_plot_split.sh` to create the plot  
		If you want units to be in generation you must provide a generation time (in Years).		
  

## To do 

* add all the scripts 
* document their use


