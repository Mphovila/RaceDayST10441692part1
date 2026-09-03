RaceDay API Endpoint Plan
The RaceDay API will be used to manage users, events, race categories, enrolments, results and routes.

Authentication
The authentication part will allow users to create an account and log in. The registration endpoint will be **POST `/api/auth/register`**, where the user enters their name, email, password and phone number. The login endpoint will be **POST `/api/auth/login`**, where the user enters their email and password.

User Profile
Users will be able to view and update their profile. **GET `/api/users/profile`** will show the logged-in user's details, while **PUT `/api/users/profile`** will allow them to update their information.

Events
The events section will allow users to view upcoming races. **GET `/api/events`** will show all upcoming events and **GET `/api/events/{id}`** will show a specific event. Organisers will be able to create, update and delete events using **POST, PUT and DELETE** endpoints.

Categories
Each event can have different race categories. Users can view these categories, while organisers can add, update or delete them. The categories will include details such as the distance, entry fee and maximum number of participants.

Enrolments
Participants will use the enrolment endpoints to enter races and view their enrolments. They will also be able to cancel an enrolment. Organisers will be able to see the participants registered for their events.

Results
Organisers will record race results using the results endpoints. This will include the participant's finish time, position and result status. Participants will be able to view their own results.

Routes
The routes section will contain information about the race route, such as the starting point, ending point, distance and description. Organisers will be able to add and update routes, while users will be able to view them.
