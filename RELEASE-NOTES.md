## Version 2.0.0 (2023-12-09)

### Added
- Enrollment Table: Join table between the Presentation and User tables
- Documentation: Description of the newly added module.
- Additional Testing: Additional testing has been added in order to validate components.

### Changed
- Forms: UI updates to forms to use bootstrap modules for buttons.
- Flashing: Flashing has been redesigned on multiple pages to give the user useful information. 

### Fixed
- Teacher-Deletion: Teachers can not delete other teachers nor themselves.
- Blank Forms: Certain models now can't have blank information.Users must have a username, email, and role. Evaluations must have all the scores and foreign keys. Presentations must have all form information inputted. 

### Removed
- User foreign key in Presentation table: Column was removed due to the join table, Enrollment, that was added to the project. 