## Intro

A package that automatically convert Likert scales to numeric. It comes with an internal .json file that contains different popular mappings, but can also take custom mappings. 
Functions in this package can convert a single column, multiple column with a single mapping or multiple columns with multiple mappings. 

## Package installation 

To install the package `devtools::install_github("D-Anastasios/convert.likert")`

## Example use:
# convert the likert scales

data = combined_data

# get the names of the columns that we want to convert

# PGSI
PGSI_names = data %>% dplyr::select(contains("PGSI")) %>% names()

# GMQ
Gmq_names = data %>% dplyr::select(contains("GMQ")) %>% names()

# GRCS
Grcs_names = data %>% dplyr::select(contains("GRCS")) %>% names()

# gambling habits
Gambling_habits_names = data %>% dplyr::select(contains("_gambling_habits")) %>% names()

# bis bas
Bis_bas_names = data %>% dplyr::select(contains("BIS_BAS")) %>% names()

# UPPS 
Upps_names = data %>% dplyr::select(contains("UPPS")) %>% names()

# ADHD
Adhd_names = data %>% dplyr::select(contains("ADHD")) %>% names()

# TAS
Tas_names = data %>% dplyr::select(contains("TAS_Q")) %>% names()


# SHAPS
Shaps_names = data %>% dplyr::select(contains("SHAPS")) %>% names()

# AMI
Ami_names = data %>% dplyr::select(contains("AMI")) %>% names()

# OCI
Oci_names = data %>% dplyr::select(contains("OCI_")) %>% names()

# STICSA
Sticsa_names = data %>% dplyr::select(contains("STICSA")) %>% names()



variable_mapping_list = list(
    frequency_PGSI = PGSI_names,
    frequency_GMQ = Gmq_names,
    agreement_GRCS = Grcs_names,
    frequency_gambling_habits = Gambling_habits_names,
    true_bisbas = Bis_bas_names,
    agreement_upps = Upps_names,
    frequency_ADHD = Adhd_names,
    agreement_TAS = Tas_names,
    agreement_Snaith_RSE = Shaps_names,
    true_AMI = Ami_names,
    frequency_OCI = Oci_names,
    agreement_STICSA = Sticsa_names
)

data_converted = transform_likert_multiple(data, variable_mapping_list)

