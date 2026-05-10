$mavenUrl = "https://archive.apache.org/dist/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip"
$mavenZip = "maven.zip"
$mavenDir = ".maven"

if (-Not (Test-Path -Path $mavenDir)) {
    Write-Host "Downloading Maven..."
    Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip
    Write-Host "Extracting Maven..."
    Expand-Archive -Path $mavenZip -DestinationPath $mavenDir -Force
    Remove-Item -Path $mavenZip -Force
}

$mvnCmd = ".\$mavenDir\apache-maven-3.9.9\bin\mvn.cmd"
Write-Host "Running application via Jetty Maven Plugin..."
& $mvnCmd clean jetty:run
