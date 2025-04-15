<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Patient - Hospital Management System</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header">
                        <h3 class="text-center">Add New Patient</h3>
                    </div>
                    <div class="card-body">
                        <% 
                            String error = (String) request.getAttribute("error");
                            if(error != null) {
                        %>
                            <div class="alert alert-danger" role="alert">
                                <%= error %>
                            </div>
                        <% } %>

                        <form action="Admin" method="post">
                            <input type="hidden" name="action" value="addPatient">
                            
                            <div class="form-group">
                                <label for="name">Full Name</label>
                                <input type="text" class="form-control" id="name" name="name" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" class="form-control" id="email" name="email" required>
                            </div>

                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" class="form-control" id="password" name="password" required>
                            </div>

                            <div class="form-group">
                                <label for="age">Age</label>
                                <input type="number" class="form-control" id="age" name="age" 
                                       min="0" max="150" required>
                            </div>

                            <div class="form-group">
                                <label>Gender</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" 
                                           id="male" value="male" required>
                                    <label class="form-check-label" for="male">Male</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" 
                                           id="female" value="female">
                                    <label class="form-check-label" for="female">Female</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="gender" 
                                           id="other" value="other">
                                    <label class="form-check-label" for="other">Other</label>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="phoneNumber">Phone Number</label>
                                <input type="tel" class="form-control" id="phoneNumber" name="phoneNumber" 
                                       pattern="[0-9]{10}" title="Please enter valid 10-digit phone number" required>
                            </div>

                            <div class="form-group">
                                <label for="address">Address</label>
                                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            </div>

                            <div class="form-group">
                                <label for="bloodGroup">Blood Group</label>
                                <select class="form-control" id="bloodGroup" name="bloodGroup" required>
                                    <option value="">Select Blood Group</option>
                                    <option value="A+">A+</option>
                                    <option value="A-">A-</option>
                                    <option value="B+">B+</option>
                                    <option value="B-">B-</option>
                                    <option value="O+">O+</option>
                                    <option value="O-">O-</option>
                                    <option value="AB+">AB+</option>
                                    <option value="AB-">AB-</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="medicalHistory">Medical History</label>
                                <textarea class="form-control" id="medicalHistory" name="medicalHistory" 
                                          rows="4"></textarea>
                            </div>

                            <div class="form-group">
                                <label for="emergencyContact">Emergency Contact Number</label>
                                <input type="tel" class="form-control" id="emergencyContact" 
                                       name="emergencyContact" pattern="[0-9]{10}" required>
                            </div>

                            <div class="form-group">
                                <label for="allergies">Allergies (if any)</label>
                                <input type="text" class="form-control" id="allergies" name="allergies">
                            </div>

                            <div class="form-row mt-4">
                                <div class="col">
                                    <button type="submit" class="btn btn-primary btn-block">Add Patient</button>
                                </div>
                                <div class="col">
                                    <a href="Admin?action=viewPatients" class="btn btn-secondary btn-block">Cancel</a>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const phoneNumber = document.getElementById('phoneNumber').value;
            const emergencyContact = document.getElementById('emergencyContact').value;
            const age = document.getElementById('age').value;

            // Password validation
            if(password.length < 6) {
                alert('Password must be at least 6 characters long');
                e.preventDefault();
                return;
            }

            // Phone number validation
            if(!/^\d{10}$/.test(phoneNumber)) {
                alert('Please enter a valid 10-digit phone number');
                e.preventDefault();
                return;
            }

            // Emergency contact validation
            if(!/^\d{10}$/.test(emergencyContact)) {
                alert('Please enter a valid 10-digit emergency contact number');
                e.preventDefault();
                return;
            }

            // Age validation
            if(age < 0 || age > 150) {
                alert('Please enter a valid age');
                e.preventDefault();
                return;
            }

            // Ensure emergency contact is different from patient's contact
            if(phoneNumber === emergencyContact) {
                alert('Emergency contact should be different from patient\'s contact number');
                e.preventDefault();
                return;
            }
        });
    </script>
</body>
</html>