% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/tailored_report_functions.R
\name{plot_corr_only}
\alias{plot_corr_only}
\title{Plot stock-time, indicator-time, and stock-indicator correlations}
\usage{
plot_corr_only(data, title = "", lag = 0, species = "species", mode = "")
}
\arguments{
\item{data}{A data frame containing stock and indicator time series. Data from a spreadsheet outputted by a \code{NEespShiny} or \code{NEesp} regression report. Must pre-process with \code{NEesp::prep_data}, or do your own pre-processing.}

\item{title}{Optional. Title for the suite of plots. Defaults to blank.}

\item{lag}{The number of years by which the stock-indicator correlation was lagged. Required to correct the stock time series. Defaults to 0.}

\item{species}{The species name to add to plots. Defaults to "species".}

\item{mode}{If set to "shiny", plots will be displayed but no other functionality will be triggered (ex, saving figures or showing a report card)}
}
\value{
3 ggplots arranged with \code{ggpubr::ggarrange}
}
\description{
This function plots stock-time, indicator-time, and stock-indicator correlations.
}
