#' @rdname get_tags
#' @title Get Tags
#' @description Get tags of an s3 object
#' @param path Path of the object in the s3 storage.
#' @template bucket
#' @details Get tags from an s3 object
#' @return A dictionary of tag pairs
get_tags <- function(path, bucket) {
    r <- s3HTTP(
        verb = "GET", 
        bucket = bucket,
        path = path,
        query = list(tagging = ""),
        headers = list(), 
        request_body = "",
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
    return(r)
}