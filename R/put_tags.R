# function to put object tags
#' @rdname put_tags
#' @title Put Tags
#' @description Puts tags in an s3 object
#' @param path Path of the object in the s3 storage.
#' @template bucket
#' @param tags A dictionary of tag pairs
#' @details Puts tags into an s3 object
#' @return If successful, \code{TRUE}
put_tags <- function(path, bucket, tags) {
    tags_char <- character(length(tags))
    for (i in seq_along(tags)) {
        tags_char[i] <- paste0("<Tag><Key>", names(tags)[i], "</Key><Value>", unname(tags[[i]]), "</Value></Tag>")
    }
    request_body <- paste0("<Tagging><TagSet>", paste0(tags_char, collapse = ""), "</TagSet></Tagging>")
    tmpfile <- tempfile()
    on.exit(unlink(tmpfile))
    cat(request_body, file = tmpfile)
    md <- base64enc::base64encode(digest::digest(file = tmpfile, raw = TRUE))
    r <- s3HTTP(
        verb = "PUT", 
        bucket = bucket,
        path = path,
        query = list(tagging = ""),
        request_body = tmpfile,
        headers = list(`Content-Length` = file.size(tmpfile), `Content-MD5` = md),
        write_disk = NULL,
        accelerate = FALSE,
        dualstack = FALSE,
        parse_response = TRUE, 
        check_region = FALSE,
        url_style = c("path", "virtual"),
        base_url = Sys.getenv("AWS_S3_ENDPOINT"),
        verbose = FALSE,
        region = Sys.getenv("AWS_DEFAULT_REGION"), 
        key = Sys.getenv("AWS_ACCESS_KEY_ID"), 
        secret = Sys.getenv("AWS_SECRET_ACCESS_KEY"), 
        session_token = NULL,
        use_https = FALSE)
    return(TRUE)
}