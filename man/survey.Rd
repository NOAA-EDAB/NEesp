% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{survey}
\alias{survey}
\title{NEFSC Bottom Trawl Data}
\format{
A data frame with 3937953 rows and 27 variables:
\describe{

\item{\code{CRUISE6}}{character Cruise ID}
\item{\code{STATION}}{character Station ID}
\item{\code{STRATUM}}{character Stratum}
\item{\code{TOW}}{character Tow ID}
\item{\code{SVSPP}}{character Northeast Resource Surveys Species code}
\item{\code{CATCHSEX}}{character Species-specific numeric sex code}
\item{\code{SVVESSEL}}{character Vessel ID}
\item{\code{YEAR}}{double Year}
\item{\code{SEASON}}{character Season}
\item{\code{LAT}}{double Latitude}
\item{\code{LON}}{double Longitude}
\item{\code{EST_TOWDATE}}{double Date with estimated time}
\item{\code{DEPTH}}{double Depth}
\item{\code{SURFTEMP}}{double Surface water temperature}
\item{\code{SURFSALIN}}{double Surface salinity}
\item{\code{BOTTEMP}}{double Bottom water temperature}
\item{\code{BOTSALIN}}{double Bottom salinity}
\item{\code{ABUNDANCE}}{double Abundance (number of fish caught on a single tow; redundant for rows with the same CRUISE6, STATION, and TOW)}
\item{\code{BIOMASS}}{double Biomass (biomass caught on a single tow; redundant for rows with the same SVSPP, CRUISE6, STATION, and TOW)}
\item{\code{LENGTH}}{double Length}
\item{\code{NUMLEN}}{double Number of fish at the specified length (redundant for rows with the same SVSPP, CRUISE6, STATION, TOW, and LENGTH)}
\item{\code{Species}}{character Species common name}
\item{\code{spst}}{character Species and strata}
\item{\code{stock_area}}{character Stock region}
\item{\code{Region}}{character Stock region}
\item{\code{date}}{character Date}
\item{\code{fish_id}}{character Unique fish ID}
}
}
\source{
Oracle query of \code{svdbs} using the \code{survdat} package.
}
\usage{
survey
}
\description{
DATASET_DESCRIPTION
}
\details{
\itemize{
\item Function call: survdat::get_survdat_data(channel = channel, filterByYear = NA, all.season = TRUE, shg.check = T, conversion.factor = T, use.SAD = F, getBio = FALSE, getLengths = T)
\item Pull date: Wed Mar 03 10:56:23 2021
}
}
\keyword{datasets}
