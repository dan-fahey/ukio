#! /usr/bin/env Rscript

library(tidyverse)
library(tidyxl)
library(unpivotr)
library(readxl)

xlsx <- "2015detailedioatsbb18.xlsx"

cells <-
  xlsx_cells(xlsx, include_blank_cells = FALSE)

formats <- xlsx_formats(xlsx)

sheets <- excel_sheets(xlsx)

iot_sheets <- sheets[2:10] %>%
  str_subset("Detailed Imports", negate = TRUE)

ukio_2015 <- cells %>%
  filter(sheet %in% iot_sheets, row >= 6) %>%
  nest(-sheet) %>%
  mutate(data = map(data,
                    ~ .x %>%
                      behead("W", iog_code) %>%
                      behead("W", product_description) %>%
                      behead("N", by_iog_code) %>%
                      behead("N", by_description))) %>%
  unnest(data) %>%
  select(sheet, row, col, iog_code, product_description, by_iog_code,
         by_description, matrix_value = numeric) %>%
  mutate_at(vars(contains("description")), str_trim)

write_csv(ukio_2015, "ukio_2015.csv")
