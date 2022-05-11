
# Convert a Jupyter Notebook into a R studio script ----------------------------

# ├ Generate Paths and detect Jupyter files ------------------------------------

dir_files <- dir(here::here("SDG_related_indicators", "SDG_indicators"), 
                 pattern = ".ipynb",
                 full.names = TRUE)

# ├ Loop through each file and generate respective Rmd file --------------------

for (file in dir_files) {
  
  # Set-up paths and file names
  
  st_fullpath_noname <- dirname(file)
  st_fullpath_nosufx <- sub('\\.ipynb$', '', file)
  st_file_wno_suffix <- sub('\\.ipynb$', '', basename(file))
  
  spt_file_full_rmd = paste0(st_fullpath_nosufx, '.Rmd')
  
  # Show created paths and file names, for sanity
  
  print(paste0('st_fullpath_noname:', st_fullpath_noname))
  print(paste0('spt_file:', file))
  print(paste0('spt_file_full_rmd:', spt_file_full_rmd))
  
  # Convert from IPYNB to RMD
  file_nb_rmd = rmarkdown:::convert_ipynb(file)
  st_nb_rmd = xfun::file_string(file_nb_rmd)
  
  # Save RMD
  fileConn <- file(spt_file_full_rmd)
  writeLines(st_nb_rmd, fileConn)
  close(fileConn)
  
}
