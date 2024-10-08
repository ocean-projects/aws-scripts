Import-Module AWS.Tools.S3
$region = "us-east-1"

function BucketExists {
    param ($bucketName)
    $bucket = Get-S3Bucket -BucketName $bucketName -ErrorAction SilentlyContinue
    return $null -ne $bucket
}

$bucketExists = $false
while (-not $bucketExists) {
    $bucketName = Read-Host -Prompt 'Enter the S3 bucket name'

    if (BucketExists $bucketName) {
        Write-Host "Bucket '$bucketName' already exists. Please choose another name."
    } else {
        Write-Host "Bucket doesn't exist. Creating bucket '$bucketName'..."
        New-S3Bucket -BucketName $bucketName -Region $region
        $bucketExists = $true
    }
}

Write-Host "AWS Region: $region"
Write-Host "S3 Bucket: $bucketName"

