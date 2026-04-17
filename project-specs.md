# Overview
This project is a web application chore chart application built using Ruby on Rails. The application allows users to create accounts, add chores, assign chores to users, and track the completion of chores. The application is designed to be simple and user-friendly, making it easy for parents to manage their household chores and for children to keep track of their responsibilities.

# Features
- [ ] Phase 1: User Authentication
  - Parent users can create an account and log in to the application.
  - Users can log out of the application.
- [ ] Phase 2: User Management
  - Parent users can create and manage child user accounts.
  - Parent users can view a list of all associated child users in the system.
  - Child users can log in to the application using their own credentials.
- [ ] Phase 3: Chore Management
  - Parent users can create, edit, and delete chores.
  - Parent users can assign chores to specific child users and set due dates as well as recurring schedules.
  - Child users can view their assigned chores and mark them as completed.
- [ ] Phase 4: Chore Tracking
  - Parent users can get a list of all chores, including their completion status and assigned users.
  - Parent users can view a history of completed chores for each child user.
- [ ] Phase 5: User profile management
  - Users (both parents and children) can update their profile information, including their name, age and password.
  - Parent users can view and manage the profiles of their associated child users.
  - Parent users can also manage their email in addition to their password.
- [ ] Phase 6: Gamified PFP (Profile Picture) System
  - Users can earn points for completing chores, which can be used to unlock new profile pictures.
  - Parent users can set up a reward system where children can redeem points for rewards or privileges.
  - Users can view their current points and available profile pictures in their profile settings.
  - Phase 6 will be more thoroughly specified and implemented after the core functionality of the application is complete and stable.

# Technologies Used
- Ruby on Rails for the backend and server-side logic.
- SQLite for the database.
- HTML, CSS, and JavaScript for the frontend and user interface.
- Devise gem for user authentication and management.
- RSpec for testing the application.

# Future Enhancements
- Implementing a notification system to remind users of upcoming chores and deadlines.