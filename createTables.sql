CREATE TABLE USER(
        UserID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        FirstName VarChar(30) NOT NULL,
        LastName VarChar(30) NOT NULL,
        Email VarChar(50) NOT NULL,
        PhoneNumber VarChar(12) NOT NULL,
        Password VarChar(30) NOT NULL,
	IsAtRisk BOOL NOT NULL,
	IsVolunteer BOOL NOT NULL,
        IsRepresentative BOOL NOT NULL
);

CREATE TABLE ORGANIZATION(
	OrganizationID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Name VarChar(30) NOT NULL,
	HQAddress VarChar(50) NOT NULL,
	PhoneNumber VarChar(12) NOT NULL,
	Hours VarChar(200) NOT NULL, 
	Keywords VarChar(500) NOT NULL 
);

CREATE TABLE REPRESENTATIVE(
	UserID INT NOT NULL, 
	OrganizationID INT NOT NULL,
	VerificationStatus BOOL NOT NULL,
	PRIMARY KEY(UserID, OrganizationID),
        CONSTRAINT REP_USER_FK FOREIGN KEY(UserID)
                REFERENCES USER(UserID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION,
        CONSTRAINT REP_ORGANIZATION_FK FOREIGN KEY(OrganizationID)
                REFERENCES ORGANIZATION(OrganizationID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION
);

CREATE TABLE PROGRAM(
	ProgramID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Name VarChar(30) NOT NULL,
	Description VarChar(200) NOT NULL,
	Keywords VarChar(500) NOT NULL 
);

CREATE TABLE LOCALITY(
	LocalityID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	OrganizationID INT NOT NULL,
	ProgramID INT NOT NULL,
	Address VarChar(50) NOT NULL,
	PhoneNumber VarChar(12) NOT NULL,
	Hours VarChar(200) NOT NULL, 
	Keywords VarChar(200) NOT NULL, 
        CONSTRAINT LOC_ORGANIZATION_FK FOREIGN KEY(OrganizationID)
                REFERENCES ORGANIZATION(OrganizationID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION,
        CONSTRAINT LOC_PROGRAM_FK FOREIGN KEY(ProgramID)
                REFERENCES PROGRAM(ProgramID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION
);

CREATE TABLE PAGE(
	PageID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	OrganizationID INT NOT NULL,
	ProgramID INT NOT NULL,
	LocalityID INT NOT NULL,
	AvgRating FLOAT(3) NOT NULL, 
	AcceptsWho VarChar(50) NOT NULL, 
	ProvidesTransportation BOOL NOT NULL,
	Keywords VarChar(500) NOT NULL, 
	LastUpdate DATETIME NOT NULL,
        CONSTRAINT PAGE_ORGANIZATION_FK FOREIGN KEY(OrganizationID)
                REFERENCES ORGANIZATION(OrganizationID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION,
        CONSTRAINT PAGE_PROGRAM_FK FOREIGN KEY(ProgramID)
                REFERENCES PROGRAM(ProgramID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION,
        CONSTRAINT PAGE_LOCALITY_FK FOREIGN KEY(LocalityID)
                REFERENCES LOCALITY(LocalityID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION
);

CREATE TABLE FORUM(
	ForumID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	TimeStamp DATETIME NOT NULL,
	Comment VARCHAR(100) NOT NULL,
	PageID INT NOT NULL,
        CONSTRAINT FOR_PAGE_FK FOREIGN KEY(PageID)
                REFERENCES PAGE(PageID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION
);

CREATE TABLE RATINGS(
	RatingID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	NumStars INT NOT NULL,
	PageID INT NOT NULL,
	CONSTRAINT RAT_PAGE_FK FOREIGN KEY(PageID)
                REFERENCES PAGE(PageID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION
);

CREATE TABLE STATUS(
	StatusID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Status BOOL NOT NULL,
	NumUpVotes INT NOT NULL,
	NumDownVotes INT NOT NULL,
	PageID INT NOT NULL,
	CONSTRAINT STA_PAGE_FK FOREIGN KEY(PageID)
                REFERENCES PAGE(PageID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION
);

CREATE TABLE USAGE_METRICS(
	MetricID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	PageID INT NOT NULL,
	AvgTimeSpent INT NOT NULL,
	NumClicks INT NOT NULL,
	NumForums INT NOT NULL,
	NumRatings INT NOT NULL,
	KeywordsMatched INT NOT NULL,
	CONSTRAINT MET_PAGE_FK FOREIGN KEY(PageID)
                REFERENCES PAGE(PageID)
                ON UPDATE CASCADE
                ON DELETE NO ACTION
);