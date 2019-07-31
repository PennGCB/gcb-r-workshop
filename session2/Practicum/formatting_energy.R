library(dplyr)
library(ggplot2)
library(forcats)
energy = read.csv("/Users/amycampbell/Desktop/gcb_R_workshop_19/gcb-r-workshop/session2/Practicum/properties_reported_2017.csv", sep = ',', stringsAsFactors=TRUE)
colnames(energy)
# https://www.opendataphilly.org/
# "This dataset contains annual building and performance data for those properties required to report.
# Property data is pulled from the Office of Property Assessment. 
# Energy and water data is self-reported by building owners using the EPA Portfolio Manager tool. 
# This data will be updated annually."
energy$property_type_updated = energy$primary_prop_type_epa_calc
energy <- energy %>% group_by(property_type_updated) %>% mutate(property_type = case_when(
        grepl("Mall", property_type_updated) | grepl("Supercenter", property_type_updated) | grepl("Store", property_type_updated) | grepl("Sales",property_type_updated) | grepl("Restaurant", property_type_updated) | grepl("Repair", property_type_updated) ~ "Retail", 
        grepl("Therapy", property_type_updated) | grepl("Medical",property_type_updated) | grepl("Care", property_type_updated) | grepl( "Hospital", property_type_updated) | grepl("Surgical",property_type_updated) ~ "Medical",
        grepl("Office", property_type_updated) ~ "Office",
        grepl("School", property_type_updated) | grepl("Education", property_type_updated) | grepl("College", property_type_updated) ~ "Education",
        grepl("Residen", property_type_updated) | grepl("Housing", property_type_updated) ~ "Residential", 
        grepl("Warehouse", property_type_updated) | grepl("Storage", property_type_updated) | grepl("Parking", property_type_updated) | grepl("Distribution", property_type_updated) ~ "Storage/Parking",
        grepl("Water", property_type_updated) | grepl("Utility", property_type_updated) | grepl("Plant", property_type_updated) | grepl("Public", property_type_updated) ~ "Utilities",
        grepl("Art", property_type_updated) | grepl("Bar", property_type_updated) | grepl("Fitness", property_type_updated) | grepl("Convention", property_type_updated) | grepl("Library", property_type_updated) | grepl ("Theater", property_type_updated) | grepl("Worship", property_type_updated) | grepl("Stadium", property_type_updated) | grepl("Social", property_type_updated) ~ "Community/Recreation",
        grepl("Courthouse", property_type_updated) | grepl("Prison", property_type_updated) | grepl("Police", property_name) ~ "Law Enforcement"
        ))
  
  #  grepl("Courthouse", property_type_updated) 
  
#        grepl(property_type_updated, "Office") ~ "Office",
energy <- energy %>% filter(!is.na(property_type))
energy_mod = energy[c("electricity_use_kbtu",
                      "postal_code",
                      "water_use_all_kgal",
                      "property_type",
                      "total_floor_area_bld_pk_ft2",
                      "property_name", "year_built",
                      "fuel_oil_o2_use_kbtu",
                      "natural_gas_use_kbtu", 
                      "total_ghg_emissions_mtco2e")]
colnames(energy_mod)= c("electricity",
                        "postal_code",
                        "water_use",
                        "property_type",
                        "squarefootage",
                        "property_name", "year_built",
                        "fuel_oil",
                        "natural_gas", 
                        "greenhouse_emissions")
# greenhouse_emissions -- total greenhouse gas emissions in MtCO2e
# electricity -- total reported electricity usage (kbtu)
# natural_gas -- total natural gas usage (kbtu)
# fuel_oil 

# 10 most common zipcodes in the data 
tencommon = names(sort(table(energy_mod$postal_code))[69:78])
energy_mod = energy_mod %>% filter(postal_code %in% tencommon) 
#energy_mod = energy_mod %>% filter(!is.na(water_use))
write.csv(energy_mod, file="city_energy_data.csv")
