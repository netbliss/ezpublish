UPDATE ezsite_data SET value='3.6.0alpha1' WHERE name='ezpublish-version';
UPDATE ezsite_data SET value='1' WHERE name='ezpublish-release';

CREATE TABLE eztipafriend_request (
  email_receiver varchar(100) NOT NULL default '',
  created integer NOT NULL default '0',
  KEY created (created),
  KEY email_receiver (email_receiver)
) TYPE=MyISAM;

ALTER TABLE ezrss_export_item ADD subnodes INT(11) UNSIGNED DEFAULT '0' NOT NULL;

ALTER TABLE ezrss_export ADD number_of_objects INT(11) UNSIGNED DEFAULT '0' NOT NULL;
-- Old behaviour of RSS was that it fed 5 items
UPDATE ezrss_export SET number_of_objects='5';

ALTER TABLE ezrss_export ADD main_node_only INT(11) UNSIGNED DEFAULT '1' NOT NULL;
-- Old behaviour of RSS was that all nodes have been shown,
-- i.e. including those besides the main node
UPDATE ezrss_export SET main_node_only='0';

ALTER TABLE ezcontentobject_link ADD contentclassattribute_id INT(11) UNSIGNED DEFAULT '0' NOT NULL;
CREATE INDEX ezco_link_to_co_id ON ezcontentobject_link ( to_contentobject_id );
CREATE INDEX ezco_link_from     ON ezcontentobject_link ( from_contentobject_id,
                                                          from_contentobject_version,
                                                          contentclassattribute_id );

DROP TABLE ezsubtree_expiry;