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

# Architecture & Implementation Decisions

## General
- This repo is API-only. The frontend lives in a separate repo.
- All endpoints are namespaced under `/api/v1/`.
- Authentication uses JWT tokens via the `devise-jwt` gem. The FE receives a token on sign-in and sends it as a Bearer token on subsequent requests.

## User Model
- `role` enum: `parent` or `child`.
- Fields: `name` (string), `age` (integer), `parent_id` (self-referential FK — child users belong to a parent user).
- Only parent users have an email address; children authenticate with a username/name + password.

## Chore Recurrence (Phase 3)
- Recurrence is stored directly on the `Chore` model using two fields:
  - `recurrence_type` enum: `none`, `daily`, `weekly`, `monthly`
  - `recurrence_days_of_week` integer array: used for weekly recurrence (e.g. [1, 3] = Monday, Wednesday)
- There is no auto-generation of chore instances. Completion is tracked via a separate `chore_completions` table (one record per child per date a chore was completed).
- Incomplete chores are implied by the absence of a `chore_completion` record for a given date, rather than being explicitly created.

## Calendar Endpoint (Phase 3/4)
- The API handles recurrence expansion server-side. The FE does not need to calculate occurrences.
- A weekly calendar endpoint (`GET /api/v1/chores/week?start_date=YYYY-MM-DD`) returns pre-computed chore occurrences for the requested week, each with a `completed` boolean derived from `chore_completions` records.

# Future Enhancements
- Implementing a notification system to remind users of upcoming chores and deadlines.