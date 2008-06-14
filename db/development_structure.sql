CREATE TABLE `barracks` (
  `id` int(11) NOT NULL auto_increment,
  `camp_id` int(11) default NULL,
  `code` varchar(6) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_barracks_on_camp_id_and_code` (`camp_id`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `camps` (
  `id` int(11) NOT NULL auto_increment,
  `code` varchar(6) default NULL,
  `name` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_camps_on_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL auto_increment,
  `barrack_id` int(11) default NULL,
  `code` varchar(6) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `index_rooms_on_barrack_id_and_code` (`barrack_id`,`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `schema_info` (
  `version` int(11) default NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `schema_info` (version) VALUES (3)