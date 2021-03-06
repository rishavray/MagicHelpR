#' Download Arabidopsis MAGIC genotypes
#'
#' This function downloads SNP genotypes for 1254 SNPs typed with GoldenGate
#' technology and reported in Kover et. al (2009). Files are downloaded from
#' http://mtweb.cs.ucl.ac.uk/mus/www/magic/
#'
#' @param save_dir directory to save all files.
#' @param tidy whether or not to "tidy" the retrieved files.
#' This will call the `tidyArabMagic()` function. Default: TRUE
#' @param example_data logical. Whether or not to download an example phenotype 
#' data.
#'
#' @return files are downloaded to a directory of choice.
#'
#' @rdname downloadArabMagic
#' @export
#'
#' @examples
#' \dontrun{
#' downloadArabMagic("~/temp/magic_snp_1k")
#' }
downloadArabMagic <- function(save_dir, tidy = TRUE, example_data = FALSE){

  save_dir <- path.expand(save_dir)

  # Create the directory if it doesn't exist
  if(!dir.exists(save_dir)){
    message("Target directory does not exist. It will be created.\n")
    dir.create(save_dir)
  }

  # Genotype files
  magic_server <- "http://mtweb.cs.ucl.ac.uk/mus/www/magic/"
  geno_magic <- "magic.15012010.tar.gz"

  # Download the files
  message("Downloading genotype files from: ",
          file.path(magic_server, geno_magic))

  download.file(file.path(magic_server, geno_magic),
                file.path(save_dir, geno_magic),
                quiet = TRUE)

  # Untar the MAGIC genotypes
  untar(file.path(save_dir, geno_magic), exdir = save_dir)

  # Tidy the files if requested
  if(tidy) message("Tidying files..."); tidyArabMagic(save_dir)

  # Download example phenotype data if required
  if(example_data){
    pheno_magic <- file.path(magic_server, "MAGIC.phenotype.example.12102015.txt")
    message("Downloading example phenotype data from: ", pheno_magic)

    download.file(pheno_magic,
                  file.path(save_dir, "magic_phenotype_example.txt"),
                  quiet = TRUE)
  }
}


