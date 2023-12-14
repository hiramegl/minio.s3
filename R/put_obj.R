#' @rdname put_obj
#' @title Put Object
#' @description Puts an Object into an S3 storage
#' @param object A character string containing the name the object should have in S3 (i.e., its "object key"). If missing, the filename is used.
#' @template bucket
#' @param file A character string containing the filename (or full path) of the file you want to upload to S3. Alternatively, an raw vector containing the file can be passed directly, in which case \code{object} needs to be specified explicitly.
#' @param meta A dictionary of metadata pairs
#' @details Puts an object into an S3 storage with metadata
#' @return If successful, \code{TRUE}
put_obj <- function(object, bucket, file, meta) {
    if (missing(meta))
        list()
    awsMeta <- list()
    for (i in seq(1,length(meta))){
      value <- meta[i]
      newMeta <- paste0('x-amz-meta-', names(value))
      awsMeta[newMeta] = value
    }
    r <- s3HTTP(
        verb = "PUT", 
        bucket = bucket,
        path = paste0('/', file),
        headers = awsMeta,
        request_body = object,
        write_disk = NULL,
        accelerate = FALSE,
        dualstack = FALSE,
        parse_response = TRUE, 
        check_region = FALSE,
        url_style = c("path", "virtual"),
        base_url = Sys.getenv("AWS_S3_ENDPOINT"),
        verbose = FALSE,
        region = "", 
        key = Sys.getenv("AWS_ACCESS_KEY_ID"), 
        secret = Sys.getenv("AWS_SECRET_ACCESS_KEY"), 
        session_token = NULL,
        use_https = FALSE)
    return(TRUE)
}