
get_spack_python  <- function(spack_root=Sys.getenv("SPACK_ROOT",unset=NA_character_)){
    if (is.na(spack_root)) {
        stop("Unable to detect SPACK_ROOT. pass spack_root or set SPACK_ROOT env var")
    }
    spack_py <- fs::path(spack_root, "bin/spack-python")
    if (fs::file_exists(spack_py)) {
        return(spack_py)
    }
}


##' @title Create spack spec from a string
##'
##'
##' @param spec string to convert to spack spec
##' @return Spack spec object
##' @export
spack_spec <- function(spec) {

}

spack_root_python  <- function(spack_root=Sys.getenv("SPACK_ROOT",unset=NA_character_)){
    if (is.na(spack_root)) {
        stop("Unable to detect SPACK_ROOT. pass spack_root or set SPACK_ROOT env var")
    }
    return(fs::path(spack_root, "lib","spack"))
}

externals <- function() {

    extm <- fs::dir_ls(fs::path(spack_root_python(), "external"),type="directory")
    extf <- fs::dir_ls(fs::path(spack_root_python(), "external"),type="file")
    extf <- extf[stringr::str_starts(fs::path_file(extf), "_", negate = TRUE)]
    ext <- reticulate::import_from_path("external", path = spack_root_python())
    extm <- extm[stringr::str_starts(fs::path_file(extm), "_", negate = TRUE)]
    extmods <- purrr::map(extm, ~ reticulate::import_from_path(fs::path_file(.x), path = fs::path_dir(.x)))
    extfmods <- purrr::map(extf, ~ reticulate::import_from_path(
        fs::path_ext_remove(fs::path_file(.x)),
        path = fs::path_dir(.x)
    ))
}

##' @title Create Spack version object
##'
##'
##' @param version string representing a version object
##' @return Spack version object
##' @export
spack_version <- function(version) {
    ext <- reticulate::import_from_path("external",path=spack_root_python())

    llnl <- reticulate::import_from_path("llnl",path=spack_root_python())
    sp <- reticulate::import_from_path("spack",path=spack_root_python())
    sv <- reticulate::import_from_path("version.Version", path = fs::path(spack_root_python()))
    sc <- reticulate::py_config()
}



spack_python<- function(){

    pp <- reticulate::use_python(get_spack_python())
    ppp <- reticulate:::python_config(spack_python_path)
}
spack_find <- function() {

}


create_github_package <- function(repo, ...) {
    meta <- remotes:::parse_git_repo(repo)
    remote <- remotes::github_remote(repo,...)
    package_name <- remotes:::remote_package_name(remote)
    local_sha <- remotes:::local_sha(package_name)
    remote_sha <- remotes:::remote_sha(remote, local_sha)
    res <- remotes::remote_download(remote)
    source <- source_pkg(bundle, subdir = remote$subdir)
    update_submodules(source, remote$subdir, quiet)
    add_metadata(source, remote_metadata(remote, bundle, source,
        remote_sha))
    clear_description_md5(source)
}


create_package <- function(package) {

}
