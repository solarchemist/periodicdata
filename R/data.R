#' @name periodicdata
#' @title Properties of the chemical elements
#' @description Tibble with many physical and chemical properties of the elements.
#' @docType data
#' @keywords datasets
#' @usage data(periodicdata)
#' @format A tibble with 118 rows (the chemical elements) and 80 variables:
#' \describe{
#'   \item{\code{Adiabatic_Index}}{character Adiabatic index, also known as the heat capacit...}
#'   \item{\code{Atomic_Number}}{integer Atomic number}
#'   \item{\code{Atomic_Radius}}{double Atomic radius}
#'   \item{\code{Atomic_Weight}}{double Atomic weight of the longest-lived isotope.}
#'   \item{\code{Autoignition_Point}}{double Autoignition point}
#'   \item{\code{Block}}{character Block}
#'   \item{\code{Boiling_Point}}{double Boiling point at STP}
#'   \item{\code{Brinell_Hardness}}{double Brinell hardness}
#'   \item{\code{Bulk_Modulus}}{double Bulk modulus}
#'   \item{\code{CAS_Number}}{character CAS registry number}
#'   \item{\code{CID_Number}}{character CID number}
#'   \item{\code{Colour}}{character Colour at STP}
#'   \item{\code{Conventional_Atomic_Weight}}{double Standard atomic weight abridged to four signifi...}
#'   \item{\code{Covalent_Radius}}{double Covalent radius}
#'   \item{\code{Critical_Pressure}}{double Critical pressure}
#'   \item{\code{Critical_Temperature}}{double Critical temperature}
#'   \item{\code{Curie_Temperature}}{integer Curie temperature}
#'   \item{\code{DOT_Hazard_Class}}{character US DOT hazard class}
#'   \item{\code{DOT_Numbers}}{character US DOT number}
#'   \item{\code{Decay_Mode}}{character Decay mode}
#'   \item{\code{Density}}{double Density at STP}
#'   \item{\code{Density_Liquid}}{integer Density in the liquid state}
#'   \item{\code{Electrical_Conductivity}}{double Electrical conductivity}
#'   \item{\code{Electrical_Resistivity}}{double Electrical resistivity}
#'   \item{\code{Electrical_Type}}{character Electrical type}
#'   \item{\code{Electron_Affinity}}{double Electron affinity}
#'   \item{\code{Electron_Configuration}}{character Electron configuration}
#'   \item{\code{Electronegativity}}{double Electronegativity (Pauling)}
#'   \item{\code{Element_Descriptions}}{character Element descriptions from the Debian dict-eleme...}
#'   \item{\code{Gas_Phase_Configuration}}{character Configuration in gas phase}
#'   \item{\code{Gmelin_Number}}{character Gmelin number}
#'   \item{\code{Group}}{integer Group assignments per the IUPAC periodic table.}
#'   \item{\code{Group_Left_Step}}{integer Group assignments per the left step periodic ta...}
#'   \item{\code{Half_Life}}{double Half-life}
#'   \item{\code{Heat_of_Combustion}}{integer Heat of combustion}
#'   \item{\code{Heat_of_Fusion}}{double Heat of fusion}
#'   \item{\code{Heat_of_Vapourization}}{double Heat of vapourization}
#'   \item{\code{Lifetime}}{double Lifetime}
#'   \item{\code{Magnetic_Susceptibility_Volume}}{double Magnetic susceptibility by volume}
#'   \item{\code{Magnetic_Type}}{character Magnetic type}
#'   \item{\code{Melting_Point}}{double Melting point at STP}
#'   \item{\code{Mohs_Hardness}}{double Mohs hardness}
#'   \item{\code{Molar_Volume}}{double Molar volume}
#'   \item{\code{Name}}{character Name}
#'   \item{\code{Natural_Occurrence}}{character Natural occurrence of the elements, whether pri...}
#'   \item{\code{Neel_Point}}{double Neel point}
#'   \item{\code{Neutron_Cross_Section}}{double Neutron cross section}
#'   \item{\code{Neutron_Mass_Absorption}}{double Neutron mass absorption}
#'   \item{\code{Percent_in_Earths_Crust}}{double Percent in Earth's crust}
#'   \item{\code{Percent_in_Humans}}{double Percent in the human body}
#'   \item{\code{Percent_in_Meteorites}}{double Percent in meteorites}
#'   \item{\code{Percent_in_Oceans}}{double Percent in the Earth's oceans}
#'   \item{\code{Percent_in_Sun}}{double Percent in the Sun}
#'   \item{\code{Percent_in_Universe}}{double Percent in the Universe}
#'   \item{\code{Period}}{integer Period assignments per the IUPAC periodic table.}
#'   \item{\code{Period_Left_Step}}{integer Period assignments per the left step periodic t...}
#'   \item{\code{Phase}}{character Phase at STP}
#'   \item{\code{Poisson_Ratio}}{double Poisson's ratio}
#'   \item{\code{Price_2010}}{double Price in 2010}
#'   \item{\code{Production_2010}}{double Global primary production in 2010}
#'   \item{\code{Quantum_Numbers}}{character Quantum numbers}
#'   \item{\code{RTECS_Number}}{character RTECS number}
#'   \item{\code{Refractive_Index}}{double Refractive index}
#'   \item{\code{Series}}{character Series per the IUPAC periodic table.}
#'   \item{\code{Shear_Modulus}}{double Shear modulus}
#'   \item{\code{Space_Group_Name}}{character Space group name}
#'   \item{\code{Space_Group_Name_LaTeX}}{character Space group name}
#'   \item{\code{Space_Group_Number}}{integer Space group number}
#'   \item{\code{Specific_Heat_Capacity}}{double The specific heat capacity, or the isobaric mas...}
#'   \item{\code{Speed_of_Sound}}{double Speed of sound}
#'   \item{\code{Standard_Atomic_Weight}}{character Standard atomic weight, or more correctly, stan...}
#'   \item{\code{Superconducting_Point}}{double Superconducting point}
#'   \item{\code{Symbol}}{character Symbol}
#'   \item{\code{Thermal_Conductivity}}{double Thermal conductivity}
#'   \item{\code{Thermal_Expansion}}{double Thermal expansion}
#'   \item{\code{Valence}}{integer Valence electrons}
#'   \item{\code{Van_der_Waals_Radius}}{double Corresponds well to published vdW radii in lite...}
#'   \item{\code{Vickers_Hardness}}{double Vickers hardness}
#'   \item{\code{XKCD_Four_Elements}}{character Reproduction of XKCD #2975 published 2024-08-21.}
#'   \item{\code{Young_Modulus}}{double Young's modulus}
#' }
#' @source \url{https://periodictable.com/Properties/A/AdiabaticIndex.an.html}
#' @source \url{https://en.wikipedia.org/wiki/Heat_capacity_ratio}
#' @source \url{https://en.wikipedia.org/wiki/Atomic_number}
#' @source \url{https://doi.org/10.1063/1.1712084}
#' @source \url{https://www.britannica.com/science/atomic-weight}
#' @source \url{https://en.wikipedia.org/wiki/Brinell_hardness_test}
#' @source \url{https://en.wikipedia.org/wiki/Hardnesses_of_the_elements_(data_page)}
#' @source \url{https://en.wikipedia.org/wiki/CAS_Registry_Number}
#' @source \url{https://doi.org/10.1021/acs.jchemed.6b00510}
#' @source \url{https://en.wikipedia.org/wiki/Critical_points_of_the_elements_(data_page)}
#' @source \url{https://en.wikipedia.org/wiki/Curie_temperature}
#' @source \url{https://en.wikipedia.org/wiki/Dangerous_goods#United_States}
#' @source \url{https://periodictable.com/Properties/A/Density.html}
#' @source \url{https://periodictable.com/Properties/A/LiquidDensity.an.html}
#' @source \url{https://en.wikipedia.org/wiki/Electron_affinity_(data_page)}
#' @source \url{https://en.wikipedia.org/wiki/Electron_affinity}
#' @source \url{https://periodictable.com/Properties/A/Electronegativity.html}
#' @source \url{https://en.wikipedia.org/wiki/Electronegativity#Pauling_electronegativity}
#' @source \url{https://www.webelements.com/periodicity/eneg_pauling}
#' @source \url{https://packages.debian.org/sid/all/dict-elements}
#' @source \url{https://en.wikipedia.org/wiki/Template:Periodic_table_(left_step)}
#' @source \url{https://periodictable.com/Properties/A/Lifetime.html}
#' @source \url{https://en.wikipedia.org/wiki/Magnetic_susceptibility#Volume_susceptibility}
#' @source \url{https://en.wikipedia.org/wiki/Mohs_scale}
#' @source \url{https://en.wikipedia.org/wiki/Periodic_table#Structure}
#' @source \url{https://en.wikipedia.org/wiki/Primordial_nuclide}
#' @source \url{https://en.wikipedia.org/wiki/Trace_radioisotope}
#' @source \url{https://en.wikipedia.org/wiki/Synthetic_element}
#' @source \url{https://w.wiki/E9rs}
#' @source \url{https://doi.org/10.1039/C2RA20839C}
#' @source \url{https://en.wikipedia.org/wiki/Registry_of_Toxic_Effects_of_Chemical_Substances}
#' @source \url{https://periodictable.com/Properties/A/SpecificHeat.html}
#' @source \url{https://en.wikipedia.org/wiki/Table_of_specific_heat_capacities}
#' @source \url{https://material-properties.org/specific-heat-capacity-of-chemical-elements}
#' @source \url{https://www.engineersedge.com/heat_transfer/heat_capacity_of_the_elements_13260.htm}
#' @source \url{https://doi.org/10.1515/pac-2019-0603}
#' @source \url{https://doi.org/10.1515/pac-2016-0402}
#' @source \url{https://www.ciaaw.org/atomic-weights.htm}
#' @source \url{https://en.wikipedia.org/wiki/List_of_thermal_conductivities}
#' @source \url{https://xkcd.com/2975}
#' @source \url{https://www.explainxkcd.com/wiki/index.php/2975:_Classical_Periodic_Table}
"periodicdata"
