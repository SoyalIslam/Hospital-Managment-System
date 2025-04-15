# Create the root directory structure
$basePath = "HospitalManagementSystem"

# Create directories
$directories = @(
    "$basePath/src/main/java/com/hospital/management/system",
    "$basePath/src/main/webapp",
    "$basePath/src/main/webapp/WEB-INF"
)

foreach ($dir in $directories) {
    if (!(Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
    }
}

# Create Java files
$javaFiles = @(
    "$basePath/src/main/java/com/hospital/management/system/HMS.java",
    "$basePath/src/main/java/com/hospital/management/system/Patient.java",
    "$basePath/src/main/java/com/hospital/management/system/Doctor.java",
    "$basePath/src/main/java/com/hospital/management/system/Appointment.java"
)

foreach ($file in $javaFiles) {
    if (!(Test-Path $file)) {
        New-Item -ItemType File -Path $file -Force
    }
}

# Create JSP files
$jspFiles = @(
    "$basePath/src/main/webapp/index.jsp",
    "$basePath/src/main/webapp/login.jsp",
    "$basePath/src/main/webapp/admin.jsp",
    "$basePath/src/main/webapp/doctor.jsp",
    "$basePath/src/main/webapp/patient.jsp",
    "$basePath/src/main/webapp/appointment.jsp"
)

foreach ($file in $jspFiles) {
    if (!(Test-Path $file)) {
        New-Item -ItemType File -Path $file -Force
    }
}

# Create web.xml
New-Item -ItemType File -Path "$basePath/src/main/webapp/WEB-INF/web.xml" -Force

# Create pom.xml
New-Item -ItemType File -Path "$basePath/pom.xml" -Force

Write-Host "Directory structure created successfully!"