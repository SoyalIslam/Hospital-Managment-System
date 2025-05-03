function validateLogin() {
    var email = document.forms[0]["email"].value;
    var password = document.forms[0]["password"].value;
    if (email == "" || password == "") {
        alert("Email and password are required");
        return false;
    }
    return true;
}

function validateSignup() {
    var firstName = document.forms[0]["first_name"].value;
    var lastName = document.forms[0]["last_name"].value;
    var email = document.forms[0]["email"].value;
    var password = document.forms[0]["password"].value;
    if (firstName == "" || lastName == "" || email == "" || password == "") {
        alert("All fields are required");
        return false;
    }
    return true;
}