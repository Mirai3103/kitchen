/*
    This function is called when "Login" button clicked.
*/
function validateLogin() {
    // Get the values that user enters in the form
    var userNameElement = document.getElementById("username");
    var passwordElement = document.getElementById("password");

    // variable to check valid input
    var status = false;

    var message = "Please fill all mandatory fields";

    // Reset border color for inputs
    setBorderColor(userNameElement);
    setBorderColor(passwordElement);

    // Validate username
    var username = userNameElement.value;
    if (username == "") {
        message = "Username cannot be empty";
        userNameElement.style.borderColor = "red";
    }

    // Validate password
    var password = passwordElement.value;
    if (password == "") {
        message = "Password cannot be empty";
        passwordElement.style.borderColor = "red";
    }

    // Check if both inputs are valid
    if (userNameElement.style.borderColor == "green" && passwordElement.style.borderColor == "green") {
        message = "";
        status = true;
    }

    // Display error message if validation fails
    document.getElementById("usernameError").innerHTML = message;
    document.getElementById("passwordError").innerHTML = message;

    // If valid, submit the form
    if (status) {
        document.forms["frm-login"].submit();
    }
}

/*
    Change border color of an element based on its value.
*/
function setBorderColor(element) {
    if (element.value == "") {
        element.style.borderColor = "red";
    } else {
        element.style.borderColor = "green";
    }
}
