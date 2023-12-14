#' @rdname get_meta
#' @title Get Metadata
#' @description Get metadata from an s3 object
#' @param path Path of the object in the s3 storage.
#' @template bucket
#' @details Get tags from an s3 object
#' @return A dictionary of metadata pairs
get_meta <- function(path, bucket) {
    headers <- head_object(path, bucket, use_http = F)
    fields <- attributes(headers)
    meta <- list()
    for (i in seq(1,length(fields))){
        value <- fields[i]
        name <- names(value)
        if (startsWith(name, "x-amz-meta-"))
             meta[name] = value
    }
    return(meta)
}