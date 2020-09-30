output "file_mimes" {
    value = [ for f in var.files : { file = f , mime = lookup( local.mimes , replace( f  , "/.*\\./", "") ) }  ]
}