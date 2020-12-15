CREATE TABLE `PERMIT_HOLDERS`
(
 `OwnerID`   integer NOT NULL AUTO_INCREMENT ,
 `Owner`     varchar(45) NOT NULL COMMENT 'Owner is a single column (instead of First, Last) because some permits are owned by businesses rather than individuals' ,
 `Telephone` varchar(10) NOT NULL ,
 `Address`   varchar(45) NOT NULL ,
 `City`      varchar(45) NOT NULL ,
 `State`     varchar(45) NOT NULL ,
 `Zip`       varchar(45) NOT NULL ,

PRIMARY KEY (`OwnerID`)
) COMMENT='This table stores information regarding individual permits (except for PSCs). It can be automatically generated using a script that imports a sector roster downloaded from the SIMM as well as a list of all permits present in the region requested from NOAA';

CREATE TABLE `SECTORS`
(
 `SectorID`     varchar(45) NOT NULL COMMENT 'Made up sector ID, should be kept consistent year to year if the sector still exists' ,
 `SectorName`   varchar(45) NOT NULL COMMENT 'Sector name as recorded by NOAA' ,
 `ManagerFirst` varchar(45) NOT NULL COMMENT 'Sector Manager first name' ,
 `ManagerLast`  varchar(45) NOT NULL COMMENT 'Sector manager last name' ,
 `Street`       varchar(45) NOT NULL COMMENT 'Sector street address' ,
 `City`         varchar(45) NOT NULL COMMENT 'City where sector address is located' ,
 `Zip`          varchar(45) NOT NULL COMMENT 'Zip where sector address is located' ,
 `State`        varchar(2) NOT NULL COMMENT 'two letter state abbreviation where sector address is located' ,
 `Telephone`    varchar(10) NOT NULL ,
 `Email`        varchar(45) NOT NULL ,

PRIMARY KEY (`SectorID`)
) COMMENT='Sector managers handle transactions from one sector to another as well as within their own sector. This table is manually built at the beginning of each fishing year from the list of active sectors and managers found at 
https://www.fisheries.noaa.gov/new-england-mid-atlantic/commercial-fishing/sector-manager-contact-information
The above link works as of 2020-04-29. The support table file should be named "sectors.csv"';

CREATE TABLE `STAFF`
(
 `StaffID`    integer NOT NULL AUTO_INCREMENT ,
 `StaffFirst` varchar(45) NOT NULL ,
 `StaffLast`  varchar(45) NOT NULL ,
 `Email`      varchar(45) NOT NULL ,
 `Telephone`  varchar(10) NOT NULL ,
 `Role`       set('readonly','admin') NOT NULL ,

PRIMARY KEY (`StaffID`)
) COMMENT='This table stores information for all staff who assist in managing the organization''s quota. This table should be manually created during software initialization through prompting and may be edited over the course of the season.';

CREATE TABLE `STOCKS`
(
 `StockIDNumber`  integer NOT NULL AUTO_INCREMENT ,
 `ScientificName` varchar(45) NOT NULL COMMENT 'Genus and species' ,
 `StockArea`      varchar(45) NOT NULL COMMENT 'Stock area boundaries are defined by NOAA. If there is only one stock for a given species (i.e., the species is panmictic), the value in this column should be "All".' ,
 `StockID`        varchar(45) NOT NULL COMMENT 'Used for ACE transfer reporting in the SIMM' ,
 `Stock`          varchar(45) NOT NULL COMMENT 'Used for ACE allocation reporting in the SIMM' ,
 `QuickBooks`     varchar(45) NOT NULL COMMENT 'Internal tracking codes used by the CCCFA accounting staff' ,
 `Abbreviation`   varchar(45) NOT NULL COMMENT 'Code used for tracking internal to MOON' ,
 `CommonName1`    varchar(45) NOT NULL ,
 `CommonName2`    varchar(45) NOT NULL ,
 `eVTR_Species`   varchar(45) NOT NULL COMMENT 'Species code as reported in Electronic Vessel Trip Reports (eVTRs).' ,
 `EM_Species`     varchar(45) NOT NULL COMMENT 'as reported by Teem.Fish (an electronic monitoring vendor under contract for FY 2019-2020)' ,
 `Dealer_Species` varchar(45) NOT NULL COMMENT 'As reported in dealer data' ,
 `SIMM` varchar(45) COMMENT 'As labeled in the SIMM sector roster',
PRIMARY KEY (`StockIDNumber`)
) COMMENT='This supporting table is compiled manually as new data streams are ingested or existing data streams are reconfigured. It allows for all transactions to be recorded using a universal identifier for a given stock. The supporting file for this table should be named "stocks.csv"';

CREATE TABLE `PERMITS`
(
 `MRI`          integer NOT NULL COMMENT 'The Moratorium Rights Identifier (MRI) is the only unique number associated with a permit' ,
 `PermitNumber` varchar(45) NOT NULL COMMENT 'Vessel permit number' ,
 `Vessel`       varchar(45) NOT NULL ,
 `HullID`       varchar(45) NOT NULL ,
 `HomePort`     varchar(45) NOT NULL ,
 `HomeState`    varchar(45) NOT NULL ,
 `Length`       varchar(45) NOT NULL COMMENT 'Vessel overall length (ft)' ,
 `Tons`         varchar(45) NOT NULL ,
 `HP`           integer NOT NULL COMMENT 'Vessel engine horsepower (or permit horsepower limit)' ,
 `Status`       set('cph','active') NOT NULL COMMENT 'Permit status
Active - attached to an active fishing vessel
CPH - lease-only' ,
 `OwnerID`      integer NOT NULL ,
 `SectorID`     varchar(45) NOT NULL ,
PRIMARY KEY (`MRI`),
KEY `fkIdx_234` (`OwnerID`),
CONSTRAINT `FK_234` FOREIGN KEY `fkIdx_234` (`OwnerID`) REFERENCES `PERMIT_HOLDERS` (`OwnerID`),
KEY `fkIdx_237` (`SectorID`),
CONSTRAINT `FK_237` FOREIGN KEY `fkIdx_237` (`SectorID`) REFERENCES `SECTORS` (`SectorID`)
) COMMENT='This table stores information regarding individual permits (except for PSCs). It can be automatically generated using a script that imports a sector roster downloaded from the SIMM as well as a list of all permits present in the region requested from NOAA';

CREATE TABLE `PSCS`
(
 `MRI`           integer NOT NULL ,
 `StockIDNumber` integer NOT NULL ,
 `PSC`           decimal(65,30) NOT NULL COMMENT 'Proportional Sector Contribution (PSC) is the proportion of the overall regional allocation that a permit is allowed for a specific stock' ,
KEY `fkIdx_222` (`MRI`),
CONSTRAINT `FK_222` FOREIGN KEY `fkIdx_222` (`MRI`) REFERENCES `PERMITS` (`MRI`),
KEY `fkIdx_225` (`StockIDNumber`),
CONSTRAINT `FK_225` FOREIGN KEY `fkIdx_225` (`StockIDNumber`) REFERENCES `STOCKS` (`StockIDNumber`)
);

CREATE TABLE `POTENTIAL_TRANSACTIONS`
(
 `TransactionNumber` integer NOT NULL AUTO_INCREMENT ,
 `Date`              datetime NOT NULL ,
 `Status`            set('pending','paid','rejected','refunded') NOT NULL ,
 `Notes`             longtext NULL ,
 `StockIDNumber`     integer NOT NULL ,
 `UnitPrice`         decimal(10,3) NOT NULL ,
 `Pounds`            integer NOT NULL ,
 `SectorFrom`        varchar(45) NOT NULL ,
 `SectorTo`          varchar(45) NOT NULL ,
 `OwnerFrom`         integer NULL ,
 `OwnerTo`           integer NULL ,
 `StaffID`           integer NOT NULL ,
 `Bundle`            tinyint NOT NULL COMMENT 'Is the transaction part of a bundle? 0 = No (FALSE) and 1 = Yes (TRUE)' ,
 `CheckNo`           integer NULL COMMENT 'Add a check number for easier bundle tracking' ,
 `MarketPrice`       decimal(10,3) COMMENT 'Current fair market value for documenting subsidies. Needs to be scripted to automatically read in from SHS listings',

PRIMARY KEY (`TransactionNumber`),
KEY `fkIdx_252` (`StockIDNumber`),
CONSTRAINT `FK_252` FOREIGN KEY `fkIdx_252` (`StockIDNumber`) REFERENCES `STOCKS` (`StockIDNumber`),
KEY `fkIdx_260` (`SectorFrom`),
CONSTRAINT `FK_260` FOREIGN KEY `fkIdx_260` (`SectorFrom`) REFERENCES `SECTORS` (`SectorID`),
KEY `fkIdx_263` (`SectorTo`),
CONSTRAINT `FK_263` FOREIGN KEY `fkIdx_263` (`SectorTo`) REFERENCES `SECTORS` (`SectorID`),
KEY `fkIdx_266` (`OwnerFrom`),
CONSTRAINT `FK_266` FOREIGN KEY `fkIdx_266` (`OwnerFrom`) REFERENCES `PERMIT_HOLDERS` (`OwnerID`),
KEY `fkIdx_269` (`OwnerTo`),
CONSTRAINT `FK_269` FOREIGN KEY `fkIdx_269` (`OwnerTo`) REFERENCES `PERMIT_HOLDERS` (`OwnerID`),
KEY `fkIdx_273` (`StaffID`),
CONSTRAINT `FK_273` FOREIGN KEY `fkIdx_273` (`StaffID`) REFERENCES `STAFF` (`StaffID`)
);

CREATE TABLE `SECTOR_LEDGER`
(
 `LedgerNumber`      integer NOT NULL AUTO_INCREMENT ,
 `TransactionNumber` integer NOT NULL ,
 `OwnerID`           integer NOT NULL ,
 `Action`            set('initialize','out','in') NOT NULL ,

PRIMARY KEY (`LedgerNumber`),
KEY `fkIdx_276` (`TransactionNumber`),
CONSTRAINT `FK_276` FOREIGN KEY `fkIdx_276` (`TransactionNumber`) REFERENCES `POTENTIAL_TRANSACTIONS` (`TransactionNumber`),
KEY `fkIdx_282` (`OwnerID`),
CONSTRAINT `FK_282` FOREIGN KEY `fkIdx_282` (`OwnerID`) REFERENCES `PERMIT_HOLDERS` (`OwnerID`)
);
