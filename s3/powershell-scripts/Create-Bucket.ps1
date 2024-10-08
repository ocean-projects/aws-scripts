Import-Module AWS.Tools.S3
$region = "us-east-1"

$bucketName = Read-Host -Prompt 'Enter the S3 bucket name'

function BucketExists {
    $bucket = Get-S3BUcket -BucketName $bucket -ErrorAction SilentlyContinue
    return $null -ne $bucket 
}

if (-not (BucketExists)) {
    Write-Host "Bucket doesn't exist"
    New-S3Bucket -BucketName $bucketName -Region $region
}
else {
    $bucketName = Read-Host -Prompt "Bucket exists. Choose another bucket name."
}

Write-Host 'AWS Region: $region'
Write-Host 'S3 Bucket: $bucketName'
