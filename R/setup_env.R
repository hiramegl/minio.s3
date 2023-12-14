#' @rdname setup_env
#' @title Setup environment
#' @description Setup environment variables in order to connect to an s3 storage
#' @details Setup of AWS_ACCESS_KEY, AWS_SECRET_ACCESS_KEY, AWS_DEFAULT_REGION nad AWS_S3_ENDPOINT
setup_env <- function() {
    key <- Sys.getenv("JUPYTERLAB_S3_ACCESS_KEY_ID")
    secret <- Sys.getenv("JUPYTERLAB_S3_SECRET_ACCESS_KEY")
    endpoint <- Sys.getenv("JUPYTERLAB_S3_ENDPOINT")
    endpoint <- gsub("http://", "", endpoint)
    endpoint <- paste0(endpoint, ":80")
    Sys.setenv(
        "AWS_ACCESS_KEY_ID" = key,
        "AWS_SECRET_ACCESS_KEY" = secret,
        "AWS_DEFAULT_REGION" = "",
        "AWS_S3_ENDPOINT" = endpoint)
}