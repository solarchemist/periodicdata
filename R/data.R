#' @name values
#' @title Elemental properties
#' @description This dataframe contains the value of each property,
#'     that is, the quantity or the unitless value in case the property is unitless.
#'     Units are listed in the sister dataframe "units"
#' @docType data
#' @format A data frame with 118 rows and 82 variables:
#' \describe{
#'   \item{Name}{}
#'   \item{Symbol}{}
#'   \item{Atomic_Number}{}
#'   \item{Atomic_Weight}{}
#'   \item{Density}{}
#'   \item{Melting_Point}{}
#'   \item{Boiling_Point}{}
#'   \item{Phase}{}
#'   \item{Absolute_Melting_Point}{}
#'   \item{Absolute_Boiling_Point}{}
#'   \item{Critical_Pressure}{}
#'   \item{Critical_Temperature}{}
#'   \item{Heat_of_Fusion}{}
#'   \item{Heat_of_Vaporization}{}
#'   \item{Specific_Heat}{}
#'   \item{Adiabatic_Index}{}
#'   \item{Neel_Point}{}
#'   \item{Thermal_Conductivity}{}
#'   \item{Thermal_Expansion}{}
#'   \item{Density_Liquid}{}
#'   \item{Molar_Volume}{}
#'   \item{Brinell_Hardness}{}
#'   \item{Mohs_Hardness}{}
#'   \item{Vickers_Hardness}{}
#'   \item{Bulk_Modulus}{}
#'   \item{Shear_Modulus}{}
#'   \item{Young_Modulus}{}
#'   \item{Poisson_Ratio}{}
#'   \item{Refractive_Index}{}
#'   \item{Speed_of_Sound}{}
#'   \item{Valence}{}
#'   \item{Electronegativity}{}
#'   \item{ElectronAffinity}{}
#'   \item{DOT_Hazard_Class}{}
#'   \item{DOT_Numbers}{}
#'   \item{RTECS_Number}{}
#'   \item{Alternate_Names}{}
#'   \item{Block}{}
#'   \item{Group}{}
#'   \item{Period}{}
#'   \item{Series}{}
#'   \item{Electron_Configuration}{}
#'   \item{Color}{}
#'   \item{Gas_phase}{}
#'   \item{CAS_Number}{}
#'   \item{CID_Number}{}
#'   \item{Electrical_Type}{}
#'   \item{Electrical_Conductivity}{}
#'   \item{Resistivity}{}
#'   \item{Superconducting_Point}{}
#'   \item{Magnetic_Type}{}
#'   \item{Curie_Point}{}
#'   \item{Mass_Magnetic_Susceptibility}{}
#'   \item{Molar_Magnetic_Susceptibility}{}
#'   \item{Volume_Magnetic_Susceptibility}{}
#'   \item{Percent_in_Universe}{}
#'   \item{Percent_in_Sun}{}
#'   \item{Percent_in_Meteorites}{}
#'   \item{Percent_in_Earths_Crust}{}
#'   \item{Percent_in_Oceans}{}
#'   \item{Percent_in_Humans}{}
#'   \item{Atomic_Radius}{}
#'   \item{Covalent_Radius}{}
#'   \item{Van_der_Waals_Radius}{}
#'   \item{Space_Group_Name}{}
#'   \item{Space_Group_Number}{}
#'   \item{HalfLife}{}
#'   \item{Lifetime}{}
#'   \item{Decay_Mode}{}
#'   \item{Quantum_Numbers}{}
#'   \item{Neutron_Cross_Section}{}
#'   \item{Neutron_Mass_Absorption}{}
#'   \item{Autoignition_Point}{}
#'   \item{Flashpoint}{}
#'   \item{Heat_of_Combustion}{}
#'   \item{Gmelin_Number}{}
#'   \item{IUPAC_Period}{}
#'   \item{IUPAC_Group}{}
#'   \item{IUPAC_Number}{}
#'   \item{IUPAC_Series}{}
#' }
#' @source \url{https://periodictable.com/}
#' @source \url{https://reference.wolfram.com/language/note/ElementDataSourceInformation.html}
#' @source \url{https://webbook.nist.gov/chemistry/}
#' @source \url{https://www.webelements.com/}
#' @source \url{https://www.nist.gov/pml/atomic-weights-and-isotopic-compositions-relative-atomic-masses}
#' @source \url{https://environmentalchemistry.com/yogi/periodic/}
#' @source \url{http://amdc.in2p3.fr/web/nubase_en.html}
"values"


#' @name units
#' @title Corresponding units to elemental properties in "values" dataframe
#' @description This dataframe lists the units for each cell in the "values" dataframe
#' @docType data
#' @format A data frame with 118 rows and 82 variables:
#' \describe{
#'   \item{Name}{}
#'   \item{Symbol}{}
#'   \item{Atomic_Number}{}
#'   \item{Atomic_Weight}{}
#'   \item{Density}{}
#'   \item{Melting_Point}{}
#'   \item{Boiling_Point}{}
#'   \item{Phase}{}
#'   \item{Absolute_Melting_Point}{}
#'   \item{Absolute_Boiling_Point}{}
#'   \item{Critical_Pressure}{}
#'   \item{Critical_Temperature}{}
#'   \item{Heat_of_Fusion}{}
#'   \item{Heat_of_Vaporization}{}
#'   \item{Specific_Heat}{}
#'   \item{Adiabatic_Index}{}
#'   \item{Neel_Point}{}
#'   \item{Thermal_Conductivity}{}
#'   \item{Thermal_Expansion}{}
#'   \item{Density_Liquid}{}
#'   \item{Molar_Volume}{}
#'   \item{Brinell_Hardness}{}
#'   \item{Mohs_Hardness}{}
#'   \item{Vickers_Hardness}{}
#'   \item{Bulk_Modulus}{}
#'   \item{Shear_Modulus}{}
#'   \item{Young_Modulus}{}
#'   \item{Poisson_Ratio}{}
#'   \item{Refractive_Index}{}
#'   \item{Speed_of_Sound}{}
#'   \item{Valence}{}
#'   \item{Electronegativity}{}
#'   \item{ElectronAffinity}{}
#'   \item{DOT_Hazard_Class}{}
#'   \item{DOT_Numbers}{}
#'   \item{RTECS_Number}{}
#'   \item{Alternate_Names}{}
#'   \item{Block}{}
#'   \item{Group}{}
#'   \item{Period}{}
#'   \item{Series}{}
#'   \item{Electron_Configuration}{}
#'   \item{Color}{}
#'   \item{Gas_phase}{}
#'   \item{CAS_Number}{}
#'   \item{CID_Number}{}
#'   \item{Electrical_Type}{}
#'   \item{Electrical_Conductivity}{}
#'   \item{Resistivity}{}
#'   \item{Superconducting_Point}{}
#'   \item{Magnetic_Type}{}
#'   \item{Curie_Point}{}
#'   \item{Mass_Magnetic_Susceptibility}{}
#'   \item{Molar_Magnetic_Susceptibility}{}
#'   \item{Volume_Magnetic_Susceptibility}{}
#'   \item{Percent_in_Universe}{}
#'   \item{Percent_in_Sun}{}
#'   \item{Percent_in_Meteorites}{}
#'   \item{Percent_in_Earths_Crust}{}
#'   \item{Percent_in_Oceans}{}
#'   \item{Percent_in_Humans}{}
#'   \item{Atomic_Radius}{}
#'   \item{Covalent_Radius}{}
#'   \item{Van_der_Waals_Radius}{}
#'   \item{Space_Group_Name}{}
#'   \item{Space_Group_Number}{}
#'   \item{HalfLife}{}
#'   \item{Lifetime}{}
#'   \item{Decay_Mode}{}
#'   \item{Quantum_Numbers}{}
#'   \item{Neutron_Cross_Section}{}
#'   \item{Neutron_Mass_Absorption}{}
#'   \item{Autoignition_Point}{}
#'   \item{Flashpoint}{}
#'   \item{Heat_of_Combustion}{}
#'   \item{Gmelin_Number}{}
#'   \item{IUPAC_Period}{}
#'   \item{IUPAC_Group}{}
#'   \item{IUPAC_Number}{}
#' }
#' @source \url{https://periodictable.com/}
#' @source \url{https://reference.wolfram.com/language/note/ElementDataSourceInformation.html}
#' @source \url{https://webbook.nist.gov/chemistry/}
#' @source \url{https://www.webelements.com/}
#' @source \url{https://www.nist.gov/pml/atomic-weights-and-isotopic-compositions-relative-atomic-masses}
#' @source \url{https://environmentalchemistry.com/yogi/periodic/}
#' @source \url{http://amdc.in2p3.fr/web/nubase_en.html}
"units"
