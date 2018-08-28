-- Table: "Mirth_Inbound".document_code

DROP TABLE IF EXISTS "Mirth_Inbound".document_code CASCADE;

CREATE TABLE "Mirth_Inbound".document_code
(
  recordid serial NOT NULL,
  document_code_uuid character varying(255) NOT NULL,
  document_code character varying(100),
  document_code_display_name character varying(255),
  document_code_system_oid character varying(255),
  document_code_system_name character varying(255),
  document_code_original_text character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_code_pkey PRIMARY KEY (document_code_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_code
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_code TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_code TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_code TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_code TO postgres;

-- Table: "Mirth_Inbound".document_html

DROP TABLE IF EXISTS "Mirth_Inbound".document_html CASCADE;

CREATE TABLE "Mirth_Inbound".document_html
(
  recordid serial NOT NULL,
  document_html_uuid character varying(255) NOT NULL,
  text_html text,
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_html_pkey PRIMARY KEY (document_html_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_html
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_html TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_html TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_html TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_html TO postgres;


-- Table: "Mirth_Inbound".document_address

DROP TABLE IF EXISTS "Mirth_Inbound".document_address CASCADE;

CREATE TABLE "Mirth_Inbound".document_address
(
  recordid serial NOT NULL,
  document_address_uuid character varying(255) NOT NULL,
  address_use character varying(25),
  address_streetaddress character varying(255),
  address_city character varying(100),
  address_state character varying(50),
  address_postal_code character varying(30),
  address_country character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_address_pkey PRIMARY KEY (document_address_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_address
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_address TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_address TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_address TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_address TO postgres;

-- Table: "Mirth_Inbound".document_allergy

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy
(
  recordid serial NOT NULL,
  document_allergy_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  allergy_id_root character varying(255),
  allergy_code_uuid character varying(255),
  allergy_status_code character varying(30),
  allergy_effectivetime_low timestamp with time zone,
  allergy_effectivetime_high timestamp with time zone,
  document_allergy_observation_uuid character varying(255),
  allergy_html_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_pkey PRIMARY KEY (document_allergy_uuid),
  CONSTRAINT document_html_uuid_fkey FOREIGN KEY (allergy_html_uuid)
      REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_allergy_observation_uuid_fkey FOREIGN KEY (document_allergy_observation_uuid)
      REFERENCES "Mirth_Inbound".document_allergy_observation (document_allergy_observation_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergy
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergy TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergy TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy TO postgres;

-- Table: "Mirth_Inbound".document_allergy_observation

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy_observation CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy_observation
(
  recordid serial NOT NULL,
  document_allergy_observation_uuid character varying(255) NOT NULL,
  allergy_observation_class_code character varying(30),
  allergy_observation_mood_code character varying(30),
  allergy_observation_negationind boolean,
  allergy_observation_template_id_root character varying(100),
  allergy_observation_template_id_assigningauthorityname character varying(100),
  allergy_observation_code_uuid character varying(255),
  allergy_observation_code_text_reference character varying(100),
  allergy_observation_status_code character varying(30),
  allergy_observation_effectivetime_low timestamp with time zone,
  allergy_observation_effectivetime_high timestamp with time zone,
  allergy_observation_type_code_uuid character varying(255),
  allergy_observation_type_text_reference character varying(255),
  document_allergy_substance_uuid character varying(255),
  document_allergy_observation_reaction_uuid character varying(255),
  document_allergy_reaction_severity_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_observation_pkey PRIMARY KEY (document_allergy_observation_uuid),
  CONSTRAINT allergy_observation_code_uuid_fkey FOREIGN KEY (allergy_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT allergy_observation_type_code_uuid_fkey FOREIGN KEY (allergy_observation_type_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_allergy_substance_uuid_fkey FOREIGN KEY (document_allergy_substance_uuid) REFERENCES "Mirth_Inbound".document_allergy_substance (document_allergy_substance_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_allergy_observation_reaction_uuid_fkey FOREIGN KEY (document_allergy_observation_reaction_uuid) REFERENCES "Mirth_Inbound".document_allergy_observation_reaction (document_allergy_observation_reaction_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_allergy_reaction_severity_uuid_fkey FOREIGN KEY (document_allergy_reaction_severity_uuid) REFERENCES "Mirth_Inbound".document_allergy_reaction_severity (document_allergy_reaction_severity_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergy_observation
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergy_observation TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergy_observation TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observation TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observation TO postgres;

-- Table: "Mirth_Inbound".document_allergy_observation_reaction

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy_observation_reaction CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy_observation_reaction
(
  recordid serial NOT NULL,
  document_allergy_observation_reaction_uuid character varying(255) NOT NULL,
  allergy_observation_reaction_class_code character varying(30),
  allergy_observation_reaction_mode_code character varying(30),
  allergy_observation_reaction_template_id_root character varying(100),
  allergy_observation_reaction_template_id_assigningauthorityname character varying(100),
  allergy_observation_reaction_id_root character(100),
  allergy_observation_reaction_code_uuid character varying(255),
  allergy_observation_reaction_text_reference character varying(100),
  allergy_observation_reaction_status_code character varying(30),
  allergy_observation_reaction_effectivetime_low timestamp with time zone,
  allergy_observation_reaction_effectivetime_high timestamp with time zone,
  allergy_observation_reaction_value_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_observation_reaction_pkey PRIMARY KEY (document_allergy_observation_reaction_uuid),
  CONSTRAINT allergy_observation_reaction_code_uuid_fkey FOREIGN KEY (allergy_observation_reaction_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT allergy_observation_reaction_value_code_uuid_fkey FOREIGN KEY (allergy_observation_reaction_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergy_observation_reaction
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergy_observation_reaction TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergy_observation_reaction TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observation_reaction TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observation_reaction TO postgres;

-- Table: "Mirth_Inbound".document_allergy_reaction_severity

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy_reaction_severity CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy_reaction_severity
(
  recordid serial NOT NULL,
  document_allergy_reaction_severity_uuid character varying(255) NOT NULL,
  allergy_reaction_severity_class_code character varying(30),
  allergy_reaction_severity_mode_code character varying(30),
  allergy_reaction_severity_template_id_root character varying(100),
  allergy_reaction_severity_template_id_assigningauthorityname character varying(100),
  allergy_reaction_severity_code_uuid character varying(255),
  allergy_reaction_severity_status_code character varying(30),
  allergy_reaction_severity_effectivetime_low timestamp with time zone,
  allergy_reaction_severity_effectivetime_high timestamp with time zone,
  allergy_reaction_severity_value_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_reaction_severity_pkey PRIMARY KEY (document_allergy_reaction_severity_uuid),
  CONSTRAINT allergy_reaction_severity_code_uuid_fkey FOREIGN KEY (allergy_reaction_severity_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT allergy_reaction_severity_value_code_uuid_fkey FOREIGN KEY (allergy_reaction_severity_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergy_reaction_severity
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergy_reaction_severity TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergy_reaction_severity TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_reaction_severity TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_reaction_severity TO postgres;

-- Table: "Mirth_Inbound".document_allergy_substance

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy_substance CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy_substance
(
  recordid serial NOT NULL,
  document_allergy_substance_uuid character varying(255) NOT NULL,
  allergy_substance_type_code character varying(30),
  allergy_substance_role_class_code character varying(30),
  allergy_substance_entity_class_code character varying(30),
  allergy_substance_entity_code character varying(50),
  allergy_substance_entity_displayname character varying(100),
  allergy_substance_entity_codesystem character varying(100),
  allergy_substance_entity_codesystemname character varying(100),
  allergy_substance_entity_text_reference character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_substance_pkey PRIMARY KEY (document_allergy_substance_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergy_substance
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergy_substance TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergy_substance TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_substance TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_substance TO postgres;

-- Table: "Mirth_Inbound".document_assigned_author

DROP TABLE IF EXISTS "Mirth_Inbound".document_assigned_author CASCADE;

CREATE TABLE "Mirth_Inbound".document_assigned_author
(
  recordid serial NOT NULL,
  document_assigned_author_uuid character varying(255) NOT NULL,
  author_class_code character varying(50),
  author_id_root character varying(100),
  author_id_extension character varying(50),
  document_address_uuid character varying(255),
  document_assigned_person_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  document_telecom_uuid character varying(255),
  CONSTRAINT document_assigned_author_pkey PRIMARY KEY (document_assigned_author_uuid),
  CONSTRAINT document_address_uuid_fkey FOREIGN KEY (document_address_uuid) REFERENCES "Mirth_Inbound".document_address (document_address_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_assigned_person_uuid_fkey FOREIGN KEY (document_assigned_person_uuid) REFERENCES "Mirth_Inbound".document_assigned_person (document_assigned_person_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_telecom_uuid_fkey FOREIGN KEY (document_telecom_uuid) REFERENCES "Mirth_Inbound".document_telecom (document_telecom_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_assigned_author
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_assigned_author TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_assigned_author TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_assigned_author TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_assigned_author TO postgres;

-- Table: "Mirth_Inbound".document_assigned_entity

DROP TABLE IF EXISTS "Mirth_Inbound".document_assigned_entity CASCADE;

CREATE TABLE "Mirth_Inbound".document_assigned_entity
(
  recordid serial NOT NULL,
  document_assigned_entity_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  assigned_entity_classcode character varying(20),
  assigned_entity_id_root character varying(100),
  assigned_entity_id_extension character varying(50),
  assigned_entity_id_assigningauthorityname character varying(100),
  assigned_entity_code_uuid character varying(255),
  assigned_entity_address_uuid character varying(255),
  assigned_entity_telecom_uuid character varying(255),
  document_represented_organization_uuid character varying(255),
  assigned_person_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_assigned_entity_pkey PRIMARY KEY (document_assigned_entity_uuid),
  CONSTRAINT assigned_entity_code_uuid_fkey FOREIGN KEY (assigned_entity_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT assigned_entity_address_uuid_fkey FOREIGN KEY (assigned_entity_address_uuid) REFERENCES "Mirth_Inbound".document_address (document_address_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT assigned_entity_telecom_uuid_fkey FOREIGN KEY (assigned_entity_telecom_uuid) REFERENCES "Mirth_Inbound".document_telecom (document_telecom_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_represented_organization_uuid_fkey FOREIGN KEY (document_represented_organization_uuid) REFERENCES "Mirth_Inbound".document_represented_organization (document_represented_organization_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT assigned_person_uuid_fkey FOREIGN KEY (assigned_person_uuid) REFERENCES "Mirth_Inbound".document_assigned_person (document_assigned_person_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_assigned_entity
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_assigned_entity TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_assigned_entity TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_assigned_entity TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_assigned_entity TO postgres;

-- Table: "Mirth_Inbound".document_assigned_person

DROP TABLE IF EXISTS "Mirth_Inbound".document_assigned_person CASCADE;

CREATE TABLE "Mirth_Inbound".document_assigned_person
(
  recordid serial NOT NULL,
  document_assigned_person_uuid character varying(255) NOT NULL,
  document_assigned_author_uuid character varying(255),
  person_class_code character varying(50),
  person_determiner_code character varying(50),
  person_id_root character varying(100),
  person_id_extension character varying(50),
  person_id_assigningauthorityname character varying(255),
  person_family_name character varying(100),
  person_given_name character varying(100),
  person_middle_name character varying(100),
  person_suffix_name character varying(50),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_assigned_person_pkey PRIMARY KEY (document_assigned_person_uuid),
  CONSTRAINT document_assigned_author_uuid_fkey FOREIGN KEY (document_assigned_author_uuid) REFERENCES "Mirth_Inbound".document_assigned_author (document_assigned_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_assigned_person
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_assigned_person TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_assigned_person TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_assigned_person TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_assigned_person TO postgres;

-- Table: "Mirth_Inbound".document_author

DROP TABLE IF EXISTS "Mirth_Inbound".document_author CASCADE;

CREATE TABLE "Mirth_Inbound".document_author
(
  recordid serial NOT NULL,
  document_author_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  author_time timestamp with time zone,
  assigned_author_uuid character varying(255),
  author_type_code character varying(50),
  author_function_code character varying(50),
  author_context_control_code character varying(50),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_author_pkey PRIMARY KEY (document_author_uuid),
  CONSTRAINT assigned_author_uuid_fkey FOREIGN KEY (assigned_author_uuid) REFERENCES "Mirth_Inbound".document_assigned_author (document_assigned_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_author
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_author TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_author TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_author TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_author TO postgres;

-- Table: "Mirth_Inbound".document_components

DROP TABLE IF EXISTS "Mirth_Inbound".document_components CASCADE;

CREATE TABLE "Mirth_Inbound".document_components
(
  recordid serial NOT NULL,
  document_components_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  document_allergy_uuid character varying(255),
  document_assessment_plan_uuid character varying(255),
  document_encounter_uuid character varying(255),
  document_family_history_uuid character varying(255),
  document_functional_status_uuid character varying(255),
  document_immunization_uuid character varying(255),
  document_instructions_uuid character varying(255),
  document_medications_uuid character varying(255),
  document_payers_uuid character varying(255),
  document_plan_of_care_uuid character varying(255),
  document_problem_uuid character varying(255),
  document_procedure_uuid character varying(255),
  document_referrals_uuid character varying(255),
  document_results_uuid character varying(255),
  document_social_history_uuid character varying(255),
  document_vital_signs_uuid character varying(255),
  data_direction character varying(3),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_components_pkey PRIMARY KEY (document_components_uuid),
  CONSTRAINT document_allergy_uuid_fkey FOREIGN KEY (document_allergy_uuid) REFERENCES "Mirth_Inbound".document_allergy (document_allergy_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_encounter_uuid_fkey FOREIGN KEY (document_encounter_uuid) REFERENCES "Mirth_Inbound".document_encounter (document_encounter_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_family_history_uuid_fkey FOREIGN KEY (document_family_history_uuid) REFERENCES "Mirth_Inbound".document_family_history (document_family_history_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_functional_status_uuid_fkey FOREIGN KEY (document_functional_status_uuid) REFERENCES "Mirth_Inbound".document_functional_status (document_functional_status_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_immunization_uuid_fkey FOREIGN KEY (document_immunization_uuid) REFERENCES "Mirth_Inbound".document_immunization (document_immunization_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medications_uuid_fkey FOREIGN KEY (document_medications_uuid) REFERENCES "Mirth_Inbound".document_medications (document_medications_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_problem_uuid_fkey FOREIGN KEY (document_problem_uuid) REFERENCES "Mirth_Inbound".document_problem (document_problem_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_procedure_uuid_fkey FOREIGN KEY (document_procedure_uuid) REFERENCES "Mirth_Inbound".document_procedure (document_procedure_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_results_uuid_fkey FOREIGN KEY (document_results_uuid) REFERENCES "Mirth_Inbound".document_results (document_results_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_vital_signs_uuid_fkey FOREIGN KEY (document_vital_signs_uuid) REFERENCES "Mirth_Inbound".document_vital_signs (document_vital_signs_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_components
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_components TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_components TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_components TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_components TO postgres;

-- Table: "Mirth_Inbound".document_custodian

DROP TABLE IF EXISTS "Mirth_Inbound".document_custodian CASCADE;

CREATE TABLE "Mirth_Inbound".document_custodian
(
  recordid serial NOT NULL,
  document_custodian_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  document_represented_organization_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_custodian_pkey PRIMARY KEY (document_custodian_uuid),
    CONSTRAINT document_represented_organization_uuid_fkey FOREIGN KEY (document_represented_organization_uuid) REFERENCES "Mirth_Inbound".document_represented_organization (document_represented_organization_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_custodian
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_custodian TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_custodian TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_custodian TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_custodian TO postgres;

-- Table: "Mirth_Inbound".document_encompassing_encounter

DROP TABLE IF EXISTS "Mirth_Inbound".document_encompassing_encounter CASCADE;

CREATE TABLE "Mirth_Inbound".document_encompassing_encounter
(
  recordid serial NOT NULL,
  document_encompassing_encounter_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  encompassing_encounter_id_root character varying(50),
  encompassing_encounter_id_extension character varying(100),
  encompassing_encounter_id_assigningauthorityname character varying(100),
  encompassing_encounter_effectivetime_low timestamp with time zone,
  encompassing_encounter_effectivetime_high timestamp with time zone,
  document_assigned_entity_uuid character varying(255),
  encompassing_encounter_dischargedisposition_code_uuid character varying(255),
  encompassing_encounter_dischargedisposition_text character varying(100),
  encompassing_encounter_participant_uuid character varying(255),
  encompassing_encounter_healthcare_facility_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encompassing_encounter_pkey PRIMARY KEY (document_encompassing_encounter_uuid),
  CONSTRAINT document_assigned_entity_uuid_fkey FOREIGN KEY (document_assigned_entity_uuid) REFERENCES "Mirth_Inbound".document_assigned_entity (document_assigned_entity_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encompassing_encounter_dischargedisposition_code_uuid_fkey FOREIGN KEY (encompassing_encounter_dischargedisposition_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encompassing_encounter_participant_uuid_fkey FOREIGN KEY (encompassing_encounter_participant_uuid) REFERENCES "Mirth_Inbound".document_encounter_participant (document_encounter_participant_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encompassing_encounter_healthcare_facility_uuid_fkey FOREIGN KEY (encompassing_encounter_healthcare_facility_uuid) REFERENCES "Mirth_Inbound".document_represented_organization (document_represented_organization_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_encompassing_encounter
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_encompassing_encounter TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_encompassing_encounter TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encompassing_encounter TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encompassing_encounter TO postgres;

-- Table: "Mirth_Inbound".document_encounter

DROP TABLE IF EXISTS "Mirth_Inbound".document_encounter CASCADE;

CREATE TABLE "Mirth_Inbound".document_encounter
(
  recordid serial NOT NULL,
  document_encounter_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  encounter_class_code character varying(30),
  encounter_mood_code character varying(30),
  encounter_template_id_root character varying(255),
  encounter_id_root character varying(100),
  encounter_id_extension character varying(50),
  encounter_id_assigningauthorityname character varying(255),
  encounter_code_uuid character varying(255),
  encounter_code_original_text character varying(100),
  encounter_effectivetime_low timestamp with time zone,
  encounter_effectivetime_high timestamp with time zone,
  encounter_dischargedisposition_code_uuid character varying(255),
  encounter_dischargedisposition_text character varying(100),
  encounter_dischargedisposition_text_reference character varying(50),
  encounter_performer_uuid character varying(255),
  encounter_participant_uuid character varying(255),
  encounter_healthcare_facility_uuid character varying(255),
  encounter_activity_uuid character varying(255),
  encounter_html_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encounter_pkey PRIMARY KEY (document_encounter_uuid),
  CONSTRAINT encounter_code_uuid_fkey FOREIGN KEY (encounter_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_dischargedisposition_code_uuid_fkey FOREIGN KEY (encounter_dischargedisposition_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_performer_uuid_fkey FOREIGN KEY (encounter_performer_uuid) REFERENCES "Mirth_Inbound".document_performer (document_performer_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_participant_uuid_fkey FOREIGN KEY (encounter_participant_uuid) REFERENCES "Mirth_Inbound".document_participant (document_participant_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_healthcare_facility_uuid_fkey FOREIGN KEY (encounter_healthcare_facility_uuid) REFERENCES "Mirth_Inbound".document_represented_organization (document_represented_organization_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_activity_uuid_fkey FOREIGN KEY (encounter_activity_uuid) REFERENCES "Mirth_Inbound".document_encounter_activity (document_encounter_activity_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_html_uuid_fkey FOREIGN KEY (encounter_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_encounter
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_encounter TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_encounter TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter TO postgres;

-- Table: "Mirth_Inbound".document_encounter_activity

DROP TABLE IF EXISTS "Mirth_Inbound".document_encounter_activity CASCADE;

CREATE TABLE "Mirth_Inbound".document_encounter_activity
(
  recordid serial NOT NULL,
  document_encounter_activity_uuid character varying(255) NOT NULL,
  encounter_activity_class_code character varying(50),
  encounter_activity_mood_code character varying(50),
  encounter_activity_template_id_root character varying(100) NOT NULL,
  encounter_activity_template_id_assigningauthorityname character varying(100),
  encounter_activity_effectivetime timestamp with time zone,
  encounter_activity_diagnosis_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encounter_activity_pkey PRIMARY KEY (document_encounter_activity_uuid),
  CONSTRAINT encounter_activity_diagnosis_uuid_fkey FOREIGN KEY (encounter_activity_diagnosis_uuid) REFERENCES "Mirth_Inbound".document_encounter_activity_diagnosis (document_encounter_activity_diagnosis_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_encounter_activity
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_encounter_activity TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_encounter_activity TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_activity TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_activity TO postgres;

-- Table: "Mirth_Inbound".document_encounter_activity_diagnosis

DROP TABLE IF EXISTS "Mirth_Inbound".document_encounter_activity_diagnosis CASCADE;

CREATE TABLE "Mirth_Inbound".document_encounter_activity_diagnosis
(
  recordid serial NOT NULL,
  document_encounter_activity_diagnosis_uuid character varying(255) NOT NULL,
  encounter_activity_diagnosis_template_id_root character varying(100),
  encounter_activity_diagnosis_template_id_assigningauthorityname character varying(100),
  encounter_activity_diagnosis_code_type character varying(10),
  encounter_activity_diagnosis_code_uuid character varying(255),
  document_encounter_activity_diagnosis_observation_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encounter_activity_diagnosis_pkey PRIMARY KEY (document_encounter_activity_diagnosis_uuid),
  CONSTRAINT encounter_activity_diagnosis_code_uuid_fkey FOREIGN KEY (encounter_activity_diagnosis_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_encounter_activity_diagnosis
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis TO postgres;

-- Table: "Mirth_Inbound".document_encounter_activity_diagnosis_observation

DROP TABLE IF EXISTS "Mirth_Inbound".document_encounter_activity_diagnosis_observation CASCADE;

CREATE TABLE "Mirth_Inbound".document_encounter_activity_diagnosis_observation
(
  recordid serial NOT NULL,
  document_encounter_activity_diagnosis_observation_uuid character varying(255) NOT NULL,
  encounter_activity_diagnosis_observation_class_code character varying(50),
  encounter_activity_diagnosis_observation_mood_code character varying(50),
  encounter_activity_diagnosis_observation_template_id_root character varying(100),
  encounter_activity_diagnosis_observation_template_id_aaname character varying(100),
  encounter_activity_diagnosis_observation_code_uuid character varying(255),
  encounter_activity_diagnosis_observation_text_reference character varying(100),
  encounter_activity_diagnosis_observation_status_code character varying(50),
  encounter_activity_diagnosis_observation_value_type character varying(10),
  encounter_activity_diagnosis_observation_value_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encounter_activity_diagnosis_observation_pkey PRIMARY KEY (document_encounter_activity_diagnosis_observation_uuid),
  CONSTRAINT encounter_activity_diagnosis_observation_code_uuid_fkey FOREIGN KEY (encounter_activity_diagnosis_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_activity_diagnosis_observation_value_code_uuid_fkey FOREIGN KEY (encounter_activity_diagnosis_observation_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_encounter_activity_diagnosis_observation
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis_observation TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis_observation TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis_observation TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_activity_diagnosis_observation TO postgres;

-- Table: "Mirth_Inbound".document_encounter_participant

DROP TABLE IF EXISTS "Mirth_Inbound".document_encounter_participant CASCADE;

CREATE TABLE "Mirth_Inbound".document_encounter_participant
(
  recordid serial NOT NULL,
  document_encounter_participant_uuid character varying(255) NOT NULL,
  encounter_participant_type_code character varying(30),
  encounter_participant_time_low timestamp with time zone,
  encounter_participant_time_high timestamp with time zone,
  document_assigned_entity_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encounter_participant_pkey PRIMARY KEY (document_encounter_participant_uuid),
  CONSTRAINT encounter_participant_type_code_fkey FOREIGN KEY (encounter_participant_type_code) REFERENCES "Mirth_Inbound".document_participant (document_participant_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_assigned_entity_uuid_fkey FOREIGN KEY (document_assigned_entity_uuid) REFERENCES "Mirth_Inbound".document_assigned_entity (document_assigned_entity_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_encounter_participant
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_encounter_participant TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_encounter_participant TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_participant TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounter_participant TO postgres;

-- Table: "Mirth_Inbound".document_family_history

DROP TABLE IF EXISTS "Mirth_Inbound".document_family_history CASCADE;

CREATE TABLE "Mirth_Inbound".document_family_history
(
  recordid serial NOT NULL,
  document_family_history_uuid character varying(255) NOT NULL,
  family_history_template_id_root character varying(100),
  family_history_template_id_extension character varying(50),
  family_history_template_id_assigningauthorityname character varying(100),
  family_history_status_code character varying(30),
  family_history_relatedsubject_class_code character varying(30),
  family_history_relatedsubject_code_uuid character varying(255),
  family_history_relatedsubject_code_text_reference character varying(30),
  document_family_history_subject_uuid character varying(255) NOT NULL,
  document_family_history_observation_uuid character varying(255) NOT NULL,
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_family_history_pkey PRIMARY KEY (document_family_history_uuid),
  CONSTRAINT family_history_relatedsubject_code_uuid_fkey FOREIGN KEY (family_history_relatedsubject_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_family_history_subject_uuid_fkey FOREIGN KEY (document_family_history_subject_uuid) REFERENCES "Mirth_Inbound".document_family_history_subject (document_family_history_subject_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_family_history_observation_uuid_fkey FOREIGN KEY (document_family_history_observation_uuid) REFERENCES "Mirth_Inbound".document_family_history_observation (document_family_history_observation_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_family_history
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_family_history TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_family_history TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history TO postgres;

-- Table: "Mirth_Inbound".document_family_history_observation

DROP TABLE IF EXISTS "Mirth_Inbound".document_family_history_observation CASCADE;

CREATE TABLE "Mirth_Inbound".document_family_history_observation
(
  recordid serial NOT NULL,
  document_family_history_observation_uuid character varying(255) NOT NULL,
  family_history_observation_template_id_root character varying(100),
  family_history_observation_template_id_extension character varying(50),
  family_history_observation_id_root character varying(100),
  family_history_observation_code_uuid character varying(255),
  family_history_observation_status_code character varying(30),
  family_history_observation_effectivetime_low timestamp with time zone,
  family_history_observation_effectivetime_high timestamp with time zone,
  family_history_observation_value_code_uuid character varying(255),
  family_history_observation_value_text_reference character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_family_history_observation_pkey PRIMARY KEY (document_family_history_observation_uuid),
  CONSTRAINT family_history_observation_code_uuid_fkey FOREIGN KEY (family_history_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT family_history_observation_value_code_uuid_fkey FOREIGN KEY (family_history_observation_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_family_history_observation
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_family_history_observation TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_family_history_observation TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_observation TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_observation TO postgres;

-- Table: "Mirth_Inbound".document_family_history_subject

DROP TABLE IF EXISTS "Mirth_Inbound".document_family_history_subject CASCADE;

CREATE TABLE "Mirth_Inbound".document_family_history_subject
(
  recordid serial NOT NULL,
  document_family_history_subject_uuid character varying(255) NOT NULL,
  family_history_subject_id_root character varying(100),
  family_history_subject_id_extension character varying(50),
  family_history_subject_name character varying(100),
  family_history_subject_name_given character varying(100),
  family_history_subject_name_family character varying(100),
  family_history_subject_gender_code_uuid character varying(255),
  family_history_subject_birthtime character varying(25),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_family_history_subject_pkey PRIMARY KEY (document_family_history_subject_uuid),
  CONSTRAINT family_history_subject_gender_code_uuid_fkey FOREIGN KEY (family_history_subject_gender_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_family_history_subject
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_family_history_subject TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_family_history_subject TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_subject TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_subject TO postgres;

-- Table: "Mirth_Inbound".document_functional_status

DROP TABLE IF EXISTS "Mirth_Inbound".document_functional_status CASCADE;

CREATE TABLE "Mirth_Inbound".document_functional_status
(
  recordid serial NOT NULL,
  document_functional_status_uuid character varying(255) NOT NULL,
  functional_status_code_uuid character varying(255),
  functional_status_title character varying(100),
  functional_status_text character varying(255),
  document_functional_status_observations_uuid character varying(255) NOT NULL,
  functional_status_html_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_functional_status_pkey PRIMARY KEY (document_functional_status_uuid),
  CONSTRAINT functional_status_code_uuid_fkey FOREIGN KEY (functional_status_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_functional_status_observations_uuid_fkey FOREIGN KEY (document_functional_status_observations_uuid) REFERENCES "Mirth_Inbound".document_functional_status_observations (document_functional_status_observations_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT functional_status_html_fkey FOREIGN KEY (functional_status_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_functional_status
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_functional_status TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_functional_status TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status TO postgres;

-- Table: "Mirth_Inbound".document_functional_status_characteristic

DROP TABLE IF EXISTS "Mirth_Inbound".document_functional_status_characteristic CASCADE;

CREATE TABLE "Mirth_Inbound".document_functional_status_characteristic
(
  recordid serial NOT NULL,
  document_functional_status_characteristic_uuid character varying(255) NOT NULL,
  functional_status_observation_template_id_root character varying(255),
  functional_status_observation_code_uuid character varying(255),
  functional_status_observation_status_code character varying(30),
  functional_status_observation_status_value_code character varying(255),
  functional_status_observation_status_value_text_reference character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_functional_status_characteristic_pkey PRIMARY KEY (document_functional_status_characteristic_uuid),
  CONSTRAINT functional_status_observation_code_uuid_fkey FOREIGN KEY (functional_status_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT functional_status_observation_status_value_code_fkey FOREIGN KEY (functional_status_observation_status_value_code) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_functional_status_characteristic
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_functional_status_characteristic TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_functional_status_characteristic TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status_characteristic TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status_characteristic TO postgres;

-- Table: "Mirth_Inbound".document_functional_status_observation

DROP TABLE IF EXISTS "Mirth_Inbound".document_functional_status_observation CASCADE;

CREATE TABLE "Mirth_Inbound".document_functional_status_observation
(
  recordid serial NOT NULL,
  document_functional_status_observation_uuid character varying(255) NOT NULL,
  functional_status_observation_template_id_root character varying(100) NOT NULL,
  functional_status_observation_code_uuid character varying(255),
  functional_status_observation_code_text_reference character varying(100),
  functional_status_observation_status_code character varying(30),
  functional_status_observation_effective_time_low timestamp with time zone,
  functional_status_observation_effective_time_high timestamp with time zone,
  functional_status_observation_value_type character varying(20),
  functional_status_observation_value_unit character varying(20),
  functional_status_observation_value_value character varying(50),
  functional_status_observation_value_code_uuid character varying(255),
  functional_status_observation_interpretative_code_uuid character varying(255),
  functional_status_observation_method_code_uuid character varying(255),
  functional_status_observation_targetsite_code_uuid character varying(255),
  document_author_uuid character varying(255),
  functional_status_observation_reference_range_text character varying(255),
  functional_status_observation_reference_range_value_type character varying(20),
  functional_status_observation_reference_range_value_low character varying(20),
  functional_status_observation_reference_range_value_low_unit character varying(20),
  functional_status_observation_reference_range_value_high character varying(20),
  functional_status_observation_reference_range_value_high_unit character varying(20),
  functional_status_observation_ref_range_interpret_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_functional_status_observation_pkey PRIMARY KEY (document_functional_status_observation_uuid),
  CONSTRAINT functional_status_observation_code_uuid_fkey FOREIGN KEY (functional_status_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT functional_status_observation_value_code_uuid_fkey FOREIGN KEY (functional_status_observation_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT functional_status_observation_interpretative_code_uuid_fkey FOREIGN KEY (functional_status_observation_interpretative_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_author_uuid_fkey FOREIGN KEY (document_author_uuid) REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT functional_status_observation_ref_range_intepret_code_uuid_fkey FOREIGN KEY (functional_status_observation_ref_range_interpret_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_functional_status_observation
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_functional_status_observation TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_functional_status_observation TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status_observation TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status_observation TO postgres;

-- Table: "Mirth_Inbound".document_functional_status_observations

DROP TABLE IF EXISTS "Mirth_Inbound".document_functional_status_observations CASCADE;

CREATE TABLE "Mirth_Inbound".document_functional_status_observations
(
  recordid serial NOT NULL,
  document_functional_status_observations_uuid character varying(255) NOT NULL,
  document_functional_status_observation_uuid character varying(255),
  document_functional_status_characteristic_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_functional_status_observations_pkey PRIMARY KEY (document_functional_status_observations_uuid),
  CONSTRAINT document_functional_status_observation_uuid_fkey FOREIGN KEY (document_functional_status_observation_uuid) REFERENCES "Mirth_Inbound".document_functional_status_observation (document_functional_status_observation_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_functional_status_characteristic_uuid_fkey FOREIGN KEY (document_functional_status_characteristic_uuid) REFERENCES "Mirth_Inbound".document_functional_status_characteristic (document_functional_status_characteristic_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_functional_status_observations
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_functional_status_observations TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_functional_status_observations TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status_observations TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_status_observations TO postgres;

-- Table: "Mirth_Inbound".document_header

DROP TABLE "Mirth_Inbound".document_header;

CREATE TABLE "Mirth_Inbound".document_header
(
  recordid serial NOT NULL,
  document_header_uuid character varying(255) NOT NULL,
  document_typeid_root character varying(100),
  document_typeid_extension character varying(100),
  document_templateid_root character varying(100) NOT NULL,
  document_id_root character varying(100),
  document_id_extension character varying(30),
  document_code_code_uuid character varying(255),
  document_title_title character varying(100),
  document_effectivetime_value character varying(20),
  document_confidentialitycode_uuid character varying(255),
  document_languagecode_uuid character varying(255),
  patient_demographics_uuid character varying(255),
  patient_author_uuid character varying(255),
  patient_custodian_uuid character varying(255),
  patient_serviceevents_uuid character varying(255),
  document_encompassingencounter_uuid character varying(255),
  document_components_uuid character varying(255),
  data_direction character varying(3),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_header_pkey PRIMARY KEY (recordid),
  CONSTRAINT document_code_code_uuid_fkey FOREIGN KEY (document_code_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_confidentiality_code_uuid_fkey FOREIGN KEY (document_confidentialitycode_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_language_code_uuid_fkey FOREIGN KEY (document_languagecode_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_author_uuid_fkey FOREIGN KEY (patient_author_uuid) REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_custodian_uuid_fkey FOREIGN KEY (patient_custodian_uuid) REFERENCES "Mirth_Inbound".document_custodian (document_custodian_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_serviceevents_uuid_fkey FOREIGN KEY (patient_serviceevents_uuid) REFERENCES "Mirth_Inbound".document_service_event (document_service_event_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_encompassingencounter_uuid_fkey FOREIGN KEY (document_encompassingencounter_uuid) REFERENCES "Mirth_Inbound".document_encompassing_encounter (document_encompassing_encounter_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_components_uuid_fkey FOREIGN KEY (document_components_uuid) REFERENCES "Mirth_Inbound".document_components (document_components_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_header
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_header TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_header TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_header TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_header TO postgres;


-- Table: "Mirth_Inbound".document_healthcare_facility
/*
DROP TABLE IF EXISTS "Mirth_Inbound".document_healthcare_facility CASCADE;

CREATE TABLE "Mirth_Inbound".document_healthcare_facility
(
  recordid serial NOT NULL,
  document_healthcare_facility_uuid character varying(255) NOT NULL,
  healthcare_facility_classcode character varying(30),
  healthcare_facility_id_root character varying(100),
  healthcare_facility_id_extension character varying(50),
  location_classcode character varying(30),
  location_code_uuid character varying(255),
  location_name character varying(100),
  document_address_uuid character varying(255),
  document_telecom_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_healthcare_facility_pkey PRIMARY KEY (document_healthcare_facility_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_healthcare_facility
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_healthcare_facility TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_healthcare_facility TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_healthcare_facility TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_healthcare_facility TO postgres;
*/

-- Table: "Mirth_Inbound".document_immunization

DROP TABLE IF EXISTS "Mirth_Inbound".document_immunization CASCADE;

CREATE TABLE "Mirth_Inbound".document_immunization
(
  recordid serial NOT NULL,
  document_immunization_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  immunization_substanceadministration_class_code character varying(30),
  immunization_substanceadministration_mood_code character varying(30),
  immunization_substanceadministration_root character varying(30),
  immunization_substanceadministration_negationind character varying(30),
  immunization_template_id_root character varying(100),
  immunization_text character varying(100),
  immunization_text_reference character varying(100),
  immunization_status_code character varying(30),
  immunization_effectivetime_type character varying(30),
  immunization_effectivetime timestamp with time zone,
  immunization_route_code_uuid character varying(255),
  immunization_dosequantity_value character varying(10),
  immunization_dosequantity_unit character varying(10),
  immunization_medication_information_uuid character varying(255),
  immunization_medication_material_code_uuid character varying(255),
  immunization_html_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_immunization_pkey PRIMARY KEY (document_immunization_uuid),
  CONSTRAINT immunization_route_code_uuid_fkey FOREIGN KEY (immunization_route_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT immunization_medication_information_uuid_fkey FOREIGN KEY (immunization_medication_information_uuid) REFERENCES "Mirth_Inbound".document_immunization_medication_info (document_immunization_medication_info_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT immunization_html_uuid_fkey FOREIGN KEY (immunization_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT immunization_medication_material_code_uuid_fkey FOREIGN KEY (immunization_medication_material_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_immunization
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_immunization TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_immunization TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_immunization TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_immunization TO postgres;

-- Table: "Mirth_Inbound".document_immunization_instruction

DROP TABLE IF EXISTS "Mirth_Inbound".document_immunization_instruction CASCADE;

CREATE TABLE "Mirth_Inbound".document_immunization_instruction
(
  recordid serial NOT NULL,
  document_immunization_instruction_uuid character varying(255) NOT NULL,
  immunization_instruction_act_class_code character varying(30),
  immunization_instruction_act_mood_code character varying(30),
  immunization_instruction_template_id_root character varying(100),
  immunization_instruction_code_uuid character varying(100),
  immunization_instruction_text character varying(255),
  immunization_instruction_text_reference character varying(100),
  immunization_instruction_status_code character varying(30),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_immunization_instruction_pkey PRIMARY KEY (document_immunization_instruction_uuid),
  CONSTRAINT immunization_instruction_code_uuid_fkey FOREIGN KEY (immunization_instruction_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_immunization_instruction
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_immunization_instruction TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_immunization_instruction TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_immunization_instruction TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_immunization_instruction TO postgres;

-- Table: "Mirth_Inbound".document_immunization_medication_info

DROP TABLE IF EXISTS "Mirth_Inbound".document_immunization_medication_info CASCADE;

CREATE TABLE "Mirth_Inbound".document_immunization_medication_info
(
  recordid serial NOT NULL,
  document_immunization_medication_info_uuid character varying(255) NOT NULL,
  immunization_medication_info_template_id_root character varying(100),
  immunization_medication_material_code_uuid character varying(255),
  immunization_medication_material_code_text character varying(100),
  immunization_medication_material_translation_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_immunization_medication_info_pkey PRIMARY KEY (document_immunization_medication_info_uuid),
  CONSTRAINT immunization_medication_material_code_uuid_fkey FOREIGN KEY (immunization_medication_material_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT immunization_medication_material_translation_code_uuid_fkey FOREIGN KEY (immunization_medication_material_translation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_immunization_medication_info
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_immunization_medication_info TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_immunization_medication_info TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_immunization_medication_info TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_immunization_medication_info TO postgres;

-- Table: "Mirth_Inbound".document_medication_instruction

DROP TABLE IF EXISTS "Mirth_Inbound".document_medication_instruction CASCADE;

CREATE TABLE "Mirth_Inbound".document_medication_instruction
(
  recordid serial NOT NULL,
  document_medication_instruction_uuid character varying(255) NOT NULL,
  medication_instruction_template_id_root character varying(100),
  medication_instruction_code_type character varying(30),
  medication_instruction_code_uuid character varying(255),
  medication_instruction_text_reference character varying(100),
  medication_instruction_text text,
  medication_instruction_status_code character varying(30),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_medication_instruction_pkey PRIMARY KEY (document_medication_instruction_uuid),
  CONSTRAINT medication_instruction_code_uuid_fkey FOREIGN KEY (medication_instruction_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medication_instruction
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medication_instruction TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medication_instruction TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_instruction TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_instruction TO postgres;

-- Table: "Mirth_Inbound".document_medication_method

DROP TABLE IF EXISTS "Mirth_Inbound".document_medication_method CASCADE;

CREATE TABLE "Mirth_Inbound".document_medication_method
(
  recordid serial NOT NULL,
  document_medication_method_uuid character varying(255) NOT NULL,
  medication_method_template_id_root character varying(100) NOT NULL,
  medication_method_text_reference character varying(30),
  medication_method_statuscode character varying(30),
  medication_method_effectivetime_type character varying(20),
  medication_method_effectivetime_low timestamp with time zone,
  medication_method_effectivetime_high timestamp with time zone,
  medication_method_routecode_code_uuid character varying(255),
  medication_method_routecode_text character varying(255),
  medication_method_dosequantity_value character varying(10),
  medication_method_dosequantity_unit character varying(20),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_medication_method_pkey PRIMARY KEY (document_medication_method_uuid),
  CONSTRAINT medication_method_routecode_code_uuid_fkey FOREIGN KEY (medication_method_routecode_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medication_method
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medication_method TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medication_method TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method TO postgres;

-- Table: "Mirth_Inbound".document_medication_method_consumable_med_tran_code

DROP TABLE IF EXISTS "Mirth_Inbound".document_medication_method_consumable_med_tran_code CASCADE;

CREATE TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_code
(
  recordid serial NOT NULL,
  document_medication_method_consumable_med_tran_code_uuid character varying(255) NOT NULL,
  translation_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_medication_method_consumable_med_tran_code_pkey PRIMARY KEY (document_medication_method_consumable_med_tran_code_uuid),
  CONSTRAINT translation_code_uuid_fkey FOREIGN KEY (translation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_code
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_code TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_code TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_code TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_code TO postgres;

-- Table: "Mirth_Inbound".document_medication_method_consumable_med_tran_codes

DROP TABLE IF EXISTS "Mirth_Inbound".document_medication_method_consumable_med_tran_codes CASCADE;

CREATE TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_codes
(
  recordid serial NOT NULL,
  document_medication_method_consumable_med_tran_codes_uuid character varying(255) NOT NULL,
  document_medication_method_consumable_med_tran_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_medication_method_consumable_med_tran_codes_pkey PRIMARY KEY (document_medication_method_consumable_med_tran_codes_uuid),
  CONSTRAINT document_medication_method_consumable_med_tran_code_uuid_fkey FOREIGN KEY (document_medication_method_consumable_med_tran_code_uuid) REFERENCES "Mirth_Inbound".document_medication_method_consumable_med_tran_code (document_medication_method_consumable_med_tran_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_codes
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_codes TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_codes TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_codes TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method_consumable_med_tran_codes TO postgres;

-- Table: "Mirth_Inbound".document_medication_method_consumable_medication

DROP TABLE IF EXISTS "Mirth_Inbound".document_medication_method_consumable_medication CASCADE;

CREATE TABLE "Mirth_Inbound".document_medication_method_consumable_medication
(
  recordid serial NOT NULL,
  document_medication_method_consumable_medication_uuid character varying(255) NOT NULL,
  medication_method_consumable_medication_template_id_root character varying(100) NOT NULL,
  medication_method_consumable_medication_class_code character varying(30),
  medication_method_consumable_medication_determiner_code character varying(30),
  medication_method_consumable_medication_code_uuid character varying(255),
  medication_method_consumable_medication_code_text_reference character varying(100),
  medication_method_consumable_medication_tran_codes_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_medication_method_consumable_medication_pkey PRIMARY KEY (document_medication_method_consumable_medication_uuid),
  CONSTRAINT medication_method_consumable_medication_code_uuid_fkey FOREIGN KEY (medication_method_consumable_medication_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_method_consumable_medication_tran_codes_uuid_fkey FOREIGN KEY (medication_method_consumable_medication_tran_codes_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medication_method_consumable_medication
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medication_method_consumable_medication TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medication_method_consumable_medication TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method_consumable_medication TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_method_consumable_medication TO postgres;

-- Table: "Mirth_Inbound".document_medication_supply

DROP TABLE IF EXISTS "Mirth_Inbound".document_medication_supply CASCADE;

CREATE TABLE "Mirth_Inbound".document_medication_supply
(
  recordid serial NOT NULL,
  document_medication_supply_uuid character varying(255) NOT NULL,
  medication_supply_template_id_root character varying(100),
  medication_supply_status_code character varying(30),
  medication_supply_effectivetime_type character varying(20),
  medication_supply_effectivetime_low timestamp with time zone,
  medication_supply_effectivetime_high timestamp with time zone,
  medication_supply_repeatnumber_value integer,
  medication_supply_quantity_value integer,
  medication_supply_quantity_unit character varying(20),
  medication_supply_quantity_translation_value integer,
  medication_supply_quantity_translation_text character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_medication_supply_pkey PRIMARY KEY (document_medication_supply_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medication_supply
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medication_supply TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medication_supply TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_supply TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication_supply TO postgres;

-- Table: "Mirth_Inbound".document_medications

DROP TABLE IF EXISTS "Mirth_Inbound".document_medications CASCADE;

CREATE TABLE "Mirth_Inbound".document_medications
(
  recordid serial NOT NULL,
  document_medications_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  medications_template_id_root character varying(100) NOT NULL,
  medications_manumaterial_class_code character varying(30),
  medications_manumaterial_determiner_code character varying(30),
  medications_manumaterial_code_uuid character varying(255),
  medications_manumaterial_code_text_reference character varying(100),
  document_medication_method_consumable_med_tran_codes_uuid character varying(255),
  document_medication_method_uuid character varying(255),
  document_medication_method_consumable_medication_uuid character varying(255),
  document_author_uuid character varying(255),
  medication_status_template_id_root character varying(100),
  medication_status_code_uuid character varying(255),
  medication_status_status_code character varying(30),
  medication_status_value_type character varying(30),
  medication_status_value_code_uuid character varying(255),
  medication_status_value_text character varying(100),
  document_medication_supply_uuid character varying(255),
  document_medication_instruction_uuid character varying(255),
  medication_html_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  CONSTRAINT document_medications_pkey PRIMARY KEY (document_medications_uuid),
  CONSTRAINT medications_manumaterial_code_uuid_fkey FOREIGN KEY (medications_manumaterial_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_method_consumable_med_tran_codes_uuid_fkey FOREIGN KEY (document_medication_method_consumable_med_tran_codes_uuid) REFERENCES "Mirth_Inbound".document_medication_method_consumable_med_tran_codes (document_medication_method_consumable_med_tran_codes_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_method_uuid_fkey FOREIGN KEY (document_medication_method_uuid) REFERENCES "Mirth_Inbound".document_medication_method  (document_medication_method_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_method_consumable_medication_uuid_fkey FOREIGN KEY (document_medication_method_consumable_medication_uuid) REFERENCES "Mirth_Inbound".document_medication_method_consumable_medication (document_medication_method_consumable_medication_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_author_uuid_fkey FOREIGN KEY (document_author_uuid) REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_status_code_uuid_fkey FOREIGN KEY (medication_status_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_status_value_code_uuid_fkey FOREIGN KEY (medication_status_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_supply_uuid_fkey FOREIGN KEY (document_medication_supply_uuid) REFERENCES "Mirth_Inbound".document_medication_supply (document_medication_supply_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_instruction_uuid_fkey FOREIGN KEY (document_medication_instruction_uuid) REFERENCES "Mirth_Inbound".document_medication_instruction (document_medication_instruction_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_html_uuid_fkey FOREIGN KEY (medication_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medications
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medications TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medications TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medications TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medications TO postgres;

-- Table: "Mirth_Inbound".document_participant

DROP TABLE IF EXISTS "Mirth_Inbound".document_participant CASCADE;

CREATE TABLE "Mirth_Inbound".document_participant
(
  recordid serial NOT NULL,
  document_participant_uuid character varying(255) NOT NULL,
  participant_type_code character varying(30),
  participant_role_class_code character varying(30),
  participant_role_template_id_root character varying(100),
  participant_role_template_id_extension character varying(50),
  participant_role_template_id_assigningauthorityname character varying(255),
  participant_role_id_root character varying(100),
  participant_role_id_extension character varying(50),
  participant_role_code_uuid character varying(255),
  participant_playing_entity_class_code character varying(30),
  participant_playing_entity_name character varying(100),
  participant_playing_entity_name_family character varying(100),
  participant_playing_entity_name_given character varying(100),
  participant_role_address_uuid character varying(255),
  participant_role_telecom_uuid character varying(255),
  participant_role_playing_device_code_uuid character varying(255),
  participant_role_scoping_entity_id character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_participant_pkey PRIMARY KEY (document_participant_uuid),
  CONSTRAINT participant_role_code_uuid_fkey FOREIGN KEY (participant_role_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT participant_role_address_uuid_fkey FOREIGN KEY (participant_role_address_uuid) REFERENCES "Mirth_Inbound".document_address (document_address_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT participant_role_telecom_uuid_fkey FOREIGN KEY (participant_role_telecom_uuid) REFERENCES "Mirth_Inbound".document_telecom (document_telecom_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT participant_role_playing_device_code_uuid_fkey FOREIGN KEY (participant_role_playing_device_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_participant
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_participant TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_participant TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_participant TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_participant TO postgres;

-- Table: "Mirth_Inbound".document_patient_demographics

DROP TABLE IF EXISTS "Mirth_Inbound".document_patient_demographics CASCADE;

CREATE TABLE "Mirth_Inbound".document_patient_demographics
(
  recordid serial NOT NULL,
  document_patient_demographics_uuid character varying(255) NOT NULL,
  patient_identifiers_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  patient_name_use character varying(5),
  patient_family character varying(100),
  patient_given character varying(100),
  patient_dob character varying(25),
  patient_gender_code_uuid character varying(255),
  patient_gender_text character varying(50),
  patient_race_code_uuid character varying(255),
  patient_race_code_text character varying(50),
  patient_lang_code_uuid character varying(255),
  patient_lang_code_text character varying(50),
  patient_martial_status_code_uuid character varying(255),
  patient_martial_status_code_text character varying(50),
  patient_religiousaffiliation_code_uuid character varying(255),
  patient_religiousaffiliation_code_text character varying(50),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_patient_demographics_pkey PRIMARY KEY (document_patient_demographics_uuid),
  CONSTRAINT patient_identifier_uuid_fkey FOREIGN KEY (patient_identifiers_uuid) REFERENCES "Mirth_Inbound".document_patient_identifiers (document_patient_identifiers_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_gender_code_uuid_fkey FOREIGN KEY (patient_gender_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_race_code_uuid_fkey FOREIGN KEY (patient_race_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_lang_code_uuid_fkey FOREIGN KEY (patient_lang_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_martial_status_code_uuid_fkey FOREIGN KEY (patient_martial_status_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT patient_religiousaffiliation_code_uuid_fkey FOREIGN KEY (patient_religiousaffiliation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_patient_demographics
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_patient_demographics TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_patient_demographics TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_patient_demographics TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_patient_demographics TO postgres;

-- Table: "Mirth_Inbound".document_patient_identifier

DROP TABLE IF EXISTS "Mirth_Inbound".document_patient_identifier CASCADE;

CREATE TABLE "Mirth_Inbound".document_patient_identifier
(
  recordid serial NOT NULL,
  document_patient_identifier_uuid character varying(255) NOT NULL,
  patient_id_extension character varying(50) NOT NULL,
  patient_id_root character varying(100) NOT NULL,
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT patient_identifier_pkey PRIMARY KEY (document_patient_identifier_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_patient_identifier
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_patient_identifier TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_patient_identifier TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_patient_identifier TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_patient_identifier TO postgres;

-- Table: "Mirth_Inbound".document_patient_identifiers

DROP TABLE IF EXISTS "Mirth_Inbound".document_patient_identifiers CASCADE;

CREATE TABLE "Mirth_Inbound".document_patient_identifiers
(
  recordid serial NOT NULL,
  document_patient_identifiers_uuid character varying(255) NOT NULL,
  patient_identifier_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT patient_identifiers_pkey PRIMARY KEY (document_patient_identifiers_uuid),
  CONSTRAINT document_patient_identifier_uuid_fkey FOREIGN KEY (patient_identifier_uuid) REFERENCES "Mirth_Inbound".document_patient_identifier (document_patient_identifier_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_patient_identifiers
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_patient_identifiers TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_patient_identifiers TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_patient_identifiers TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_patient_identifiers TO postgres;

-- Table: "Mirth_Inbound".document_performer

DROP TABLE IF EXISTS "Mirth_Inbound".document_performer CASCADE;

CREATE TABLE "Mirth_Inbound".document_performer
(
  recordid serial NOT NULL,
  document_performer_uuid character varying(255) NOT NULL,
  performer_type_code character varying(30),
  performer_template_id_root character varying(100),
  performer_template_id_extension character varying(50),
  performer_template_id_assigningauthorityname character varying(100),
  performer_function_code_uuid character varying(255),
  document_assigned_entity_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_performer_pkey PRIMARY KEY (document_performer_uuid),
  CONSTRAINT performer_function_code_uuid_fkey FOREIGN KEY (performer_function_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_assigned_entity_uuid_fkey FOREIGN KEY (document_assigned_entity_uuid) REFERENCES "Mirth_Inbound".document_assigned_entity (document_assigned_entity_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_performer
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_performer TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_performer TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_performer TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_performer TO postgres;

-- Table: "Mirth_Inbound".document_problem

DROP TABLE IF EXISTS "Mirth_Inbound".document_problem CASCADE;

CREATE TABLE "Mirth_Inbound".document_problem
(
  recordid serial NOT NULL,
  document_problem_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  problem_section_template_id_root character varying(100),
  problem_section_code_uuid character varying(255),
  problem_section_title character varying(100),
  problem_section_html_uuid character varying(255),
  problem_section_concern_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_problem_pkey PRIMARY KEY (document_problem_uuid),
  CONSTRAINT problem_section_code_uuid_fkey FOREIGN KEY (problem_section_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT problem_section_html_uuid_fkey FOREIGN KEY (problem_section_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT problem_section_concern_uuid_fkey FOREIGN KEY (problem_section_concern_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_problem
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_problem TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_problem TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem TO postgres;

-- Table: "Mirth_Inbound".document_problem_concern

DROP TABLE IF EXISTS "Mirth_Inbound".document_problem_concern CASCADE;

CREATE TABLE "Mirth_Inbound".document_problem_concern
(
  recordid serial NOT NULL,
  document_problem_concern_uuid character varying(255) NOT NULL,
  problem_concern_class_code character varying(30),
  problem_concern_mood_code character varying(30),
  problem_concern_template_id_root character varying(100),
  problem_concern_template_id_assigningauthorityname character varying(255),
  problem_concern_code_uuid character varying(255),
  problem_concern_status_code character varying(30),
  problem_concern_effectivetime_low timestamp with time zone,
  problem_concern_effectivetime_high timestamp with time zone,
  problem_concern_observation_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_problem_concern_pkey PRIMARY KEY (document_problem_concern_uuid),
  CONSTRAINT problem_concern_code_uuid_fkey FOREIGN KEY (problem_concern_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT problem_concern_observation_uuid_fkey FOREIGN KEY (problem_concern_observation_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_problem_concern
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_problem_concern TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_problem_concern TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_concern TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_concern TO postgres;

-- Table: "Mirth_Inbound".document_problem_observation

DROP TABLE IF EXISTS "Mirth_Inbound".document_problem_observation CASCADE;

CREATE TABLE "Mirth_Inbound".document_problem_observation
(
  recordid serial NOT NULL,
  document_problem_observation_uuid character varying(255) NOT NULL,
  problem_observation_class_code character varying(30),
  problem_observation_mood_code character varying(30),
  problem_observation_template_id_root character varying(100),
  problem_observation_template_id_assigningauthorityname character varying(100),
  problem_observation_code_uuid character varying(255),
  problem_observation_text character varying(255),
  problem_observation_text_reference character varying(100),
  problem_observation_status_code character varying(30),
  problem_observation_effectivetime_low timestamp with time zone,
  problem_observation_effectivetime_high timestamp with time zone,
  problem_observation_value_type character varying(30),
  problem_observation_value_code_uuid character varying(255),
  problem_observation_value_text character varying(255),
  problem_observation_value_text_reference character varying(100),
  problem_observation_status_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_problem_observation_pkey PRIMARY KEY (document_problem_observation_uuid),
  CONSTRAINT problem_observation_code_uuid_fkey FOREIGN KEY (problem_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT problem_observation_value_code_uuid_fkey FOREIGN KEY (problem_observation_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT problem_observation_status_uuid_fkey FOREIGN KEY (problem_observation_status_uuid) REFERENCES "Mirth_Inbound".document_problem_observation_status (document_problem_observation_status_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_problem_observation
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_problem_observation TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_problem_observation TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_observation TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_observation TO postgres;

-- Table: "Mirth_Inbound".document_problem_observation_health_status

DROP TABLE IF EXISTS "Mirth_Inbound".document_problem_observation_health_status CASCADE;

CREATE TABLE "Mirth_Inbound".document_problem_observation_health_status
(
  recordid serial NOT NULL,
  document_problem_observation_health_status_uuid character varying(255) NOT NULL,
  problem_observation_health_status_class_code character varying(30),
  problem_observation_health_status_mood_code character varying(30),
  problem_observation_health_status_template_id_root character varying(100),
  problem_observation_health_status_code_uuid character varying(255),
  problem_observation_health_status_status_code character varying(30),
  problem_observation_health_status_effectivetime_low timestamp with time zone,
  problem_observation_health_status_effectivetime_high timestamp with time zone,
  problem_observation_health_status_value_type character varying(30),
  problem_observation_health_status_value_code_uuid character varying(30),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_problem_observation_health_status_pkey PRIMARY KEY (document_problem_observation_health_status_uuid),
  CONSTRAINT problem_observation_health_status_code_uuid_fkey FOREIGN KEY (problem_observation_health_status_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_problem_observation_health_status
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_problem_observation_health_status TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_problem_observation_health_status TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_observation_health_status TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_observation_health_status TO postgres;

-- Table: "Mirth_Inbound".document_problem_observation_status

DROP TABLE IF EXISTS "Mirth_Inbound".document_problem_observation_status CASCADE;

CREATE TABLE "Mirth_Inbound".document_problem_observation_status
(
  recordid serial NOT NULL,
  document_problem_observation_status_uuid character varying(255) NOT NULL,
  problem_observation_status_class_code character varying(30),
  problem_observation_status_mood_code character varying(30),
  problem_observation_status_template_id_root character varying(100),
  problem_observation_status_code_uuid character varying(255),
  problem_observation_status_status_code character varying(30),
  problem_observation_status_effectivetime_low timestamp with time zone,
  problem_observation_status_effectivetime_high timestamp with time zone,
  problem_observation_status_value_type character varying(30),
  problem_observation_status_value_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_problem_observation_status_pkey PRIMARY KEY (document_problem_observation_status_uuid),
  CONSTRAINT problem_observation_status_code_uuid_fkey FOREIGN KEY (problem_observation_status_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT problem_observation_status_value_code_uuid_fkey FOREIGN KEY (problem_observation_status_value_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_problem_observation_status
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_problem_observation_status TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_problem_observation_status TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_observation_status TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_problem_observation_status TO postgres;

-- Table: "Mirth_Inbound".document_procedure

DROP TABLE IF EXISTS "Mirth_Inbound".document_procedure CASCADE;

CREATE TABLE "Mirth_Inbound".document_procedure
(
  recordid serial NOT NULL,
  document_procedure_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  procedure_class_code character varying(30),
  procedure_mood_code character varying(30),
  procedure_template_id_root character varying(100),
  procedure_code_uuid character varying(255),
  procedure_code_text character varying(255),
  procedure_code_text_reference character varying(100),
  procedure_code_translation_code_uuid character varying(255),
  procedure_status_code character varying(30),
  procedure_effectivetime timestamp with time zone,
  procedure_method_code_uuid character varying(255),
  procedure_target_site_code_uuid character varying(255),
  procedure_specimen_uuid character varying(255),
  procedure_performer_uuid character varying(255),
  procedure_participant_uuid character varying(255),
  procedure_html_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_procedure_pkey PRIMARY KEY (document_procedure_uuid),
  CONSTRAINT procedure_code_uuid_fkey FOREIGN KEY (procedure_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT procedure_code_translation_code_uuid_fkey FOREIGN KEY (procedure_code_translation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT procedure_method_code_uuid_fkey FOREIGN KEY (procedure_method_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT procedure_target_site_code_uuid_fkey FOREIGN KEY (procedure_target_site_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT procedure_specimen_uuid_fkey FOREIGN KEY (procedure_specimen_uuid) REFERENCES "Mirth_Inbound".document_procedure_specimen (document_procedure_specimen_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT procedure_performer_uuid_fkey FOREIGN KEY (procedure_performer_uuid) REFERENCES "Mirth_Inbound".document_performer (document_performer_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT procedure_participant_uuid_fkey FOREIGN KEY (procedure_participant_uuid) REFERENCES "Mirth_Inbound".document_participant (document_participant_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT procedure_html_uuid_fkey FOREIGN KEY (procedure_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_procedure
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_procedure TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_procedure TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_procedure TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_procedure TO postgres;

-- Table: "Mirth_Inbound".document_procedure_specimen

DROP TABLE IF EXISTS "Mirth_Inbound".document_procedure_specimen CASCADE;

CREATE TABLE "Mirth_Inbound".document_procedure_specimen
(
  recordid serial NOT NULL,
  document_procedure_specimen_uuid character varying(255) NOT NULL,
  specimen_type_code character varying(30),
  specimen_role_class_code character varying(30),
  specimen_role_entity_code_uuid character varying(255),
  specimen_role_entity_text character varying(255),
  specimen_role_entity_text_reference character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_procedure_specimen_pkey PRIMARY KEY (document_procedure_specimen_uuid),
  CONSTRAINT specimen_role_entity_code_uuid_fkey FOREIGN KEY (specimen_role_entity_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_procedure_specimen
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_procedure_specimen TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_procedure_specimen TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_procedure_specimen TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_procedure_specimen TO postgres;

-- Table: "Mirth_Inbound".document_represented_organization

DROP TABLE IF EXISTS "Mirth_Inbound".document_represented_organization CASCADE;

CREATE TABLE "Mirth_Inbound".document_represented_organization
(
  recordid serial NOT NULL,
  document_represented_organization_uuid character varying(255) NOT NULL,
  represented_organization_classcode character varying(50),
  represented_organization_determinercode character varying(50),
  represented_organization_id_root character varying(100),
  represented_organization_id_extension character varying(50),
  represented_organization_id_assigningauthorityname character varying(100),
  represented_organization_name character varying(255),
  location_code_uuid character varying(255),
  document_telecom_uuid character varying(255),
  document_address_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_represented_organization_pkey PRIMARY KEY (document_represented_organization_uuid),
  CONSTRAINT location_code_uuid_fkey FOREIGN KEY (location_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_telecom_uuid_fkey FOREIGN KEY (document_telecom_uuid) REFERENCES "Mirth_Inbound".document_telecom (document_telecom_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_address_uuid_fkey FOREIGN KEY (document_address_uuid) REFERENCES "Mirth_Inbound".document_address (document_address_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_represented_organization
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_represented_organization TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_represented_organization TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_represented_organization TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_represented_organization TO postgres;

-- Table: "Mirth_Inbound".document_results

DROP TABLE IF EXISTS "Mirth_Inbound".document_results CASCADE;

CREATE TABLE "Mirth_Inbound".document_results
(
  recordid serial NOT NULL,
  document_results_uuid character varying(255),
  document_id_root character varying(100),
  document_id_extension character varying(30),
  results_section_template_id_root character varying(255),
  results_section_code_uuid character varying(255),
  results_section_title character varying(255),
  results_section_html_uuid character varying(255),
  results_section_organizer_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_results_pkey PRIMARY KEY (document_results_uuid),
  CONSTRAINT results_section_code_uuid_fkey FOREIGN KEY (results_section_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT results_section_html_uuid_fkey FOREIGN KEY (results_section_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT results_section_organizer_uuid_fkey FOREIGN KEY (results_section_organizer_uuid) REFERENCES "Mirth_Inbound".document_results_organizer (document_results_organizer_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_results
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_results TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_results TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_results TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_results TO postgres;

-- Table: "Mirth_Inbound".document_results_observation

DROP TABLE IF EXISTS "Mirth_Inbound".document_results_observation CASCADE;

CREATE TABLE "Mirth_Inbound".document_results_observation
(
  recordid serial NOT NULL,
  document_results_observation_uuid character varying(255) NOT NULL,
  results_observation_class_code character varying(30),
  results_observation_mood_code character varying(30),
  results_observation_template_id_root character varying(100),
  results_observation_template_id_assigningauthorityname character varying(255),
  results_observation_code_uuid character varying(255),
  results_observation_text character varying(255),
  results_observation_text_reference character varying(100),
  results_observation_status_code character varying(30),
  results_observation_effectivetime timestamp with time zone,
  results_observation_value_type character varying(30),
  results_observation_value character varying(30),
  results_observation_value_unit character varying(30),
  results_observation_value_translation_value character varying(30),
  results_observation_value_translation_unit character varying(30),
  results_observation_interpretation_code_uuid character varying(255),
  results_observation_interpretation_text character varying(100),
  results_observation_author_uuid character varying(255),
  results_observation_reference_range_type_code character varying(30),
  results_observation_reference_range_text character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_results_observation_pkey PRIMARY KEY (document_results_observation_uuid),
  CONSTRAINT results_observation_code_uuid_fkey FOREIGN KEY (results_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT results_observation_interpretation_code_uuid_fkey FOREIGN KEY (results_observation_interpretation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT results_observation_author_uuid_fkey FOREIGN KEY (results_observation_author_uuid) REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_results_observation
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_results_observation TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_results_observation TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_results_observation TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_results_observation TO postgres;

-- Table: "Mirth_Inbound".document_results_organizer

DROP TABLE IF EXISTS "Mirth_Inbound".document_results_organizer CASCADE;

CREATE TABLE "Mirth_Inbound".document_results_organizer
(
  recordid serial NOT NULL,
  document_results_organizer_uuid character varying(255) NOT NULL,
  results_organizer_class_code character varying(30),
  results_organizer_mood_code character varying(30),
  results_organizer_template_id_root character varying(100),
  results_organizer_template_id_assigningauthorityname character varying(255),
  results_organizer_code_uuid character varying(255),
  results_organizer_status_code character varying(30),
  results_observation_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_results_organizer_pkey PRIMARY KEY (document_results_organizer_uuid),
  CONSTRAINT results_organizer_code_uuid_fkey FOREIGN KEY (results_organizer_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT results_observation_uuid_fkey FOREIGN KEY (results_observation_uuid) REFERENCES "Mirth_Inbound".document_results_observation (document_results_observation_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_results_organizer
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_results_organizer TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_results_organizer TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_results_organizer TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_results_organizer TO postgres;

-- Table: "Mirth_Inbound".document_service_event

DROP TABLE IF EXISTS "Mirth_Inbound".document_service_event CASCADE;

CREATE TABLE "Mirth_Inbound".document_service_event
(
  recordid serial NOT NULL,
  document_service_event_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  service_event_class_code character varying(30),
  service_event_mood_code character varying(30),
  service_event_effectivetime_low timestamp with time zone,
  service_event_effectivetime_high timestamp with time zone,
  document_performer_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_service_event_pkey PRIMARY KEY (document_service_event_uuid),
  CONSTRAINT document_performer_uuid_fkey FOREIGN KEY (document_performer_uuid) REFERENCES "Mirth_Inbound".document_performer (document_performer_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_service_event
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_service_event TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_service_event TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_service_event TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_service_event TO postgres;

-- Table: "Mirth_Inbound".document_telecom

DROP TABLE IF EXISTS "Mirth_Inbound".document_telecom CASCADE;

CREATE TABLE "Mirth_Inbound".document_telecom
(
  recordid serial NOT NULL,
  document_telecom_uuid character varying(255) NOT NULL,
  telecom_use character varying(25),
  telecom_value character varying(50),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_telecom_pkey PRIMARY KEY (document_telecom_uuid)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_telecom
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_telecom TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_telecom TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_telecom TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_telecom TO postgres;

-- Table: "Mirth_Inbound".document_translation_codes

DROP TABLE IF EXISTS "Mirth_Inbound".document_translation_codes CASCADE; 

CREATE TABLE "Mirth_Inbound".document_translation_codes
(
  recordid serial NOT NULL,
  document_translation_codes_uuid character varying(255) NOT NULL,
  procedure_translation_code_uuid character varying(255) NOT NULL,
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_translation_codes_pkey PRIMARY KEY (document_translation_codes_uuid),
  CONSTRAINT procedure_translation_code_uuid_fkey FOREIGN KEY (procedure_translation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_translation_codes
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_translation_codes TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_translation_codes TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_translation_codes TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_translation_codes TO postgres;

-- Table: "Mirth_Inbound".document_vital_signs

DROP TABLE IF EXISTS "Mirth_Inbound".document_vital_signs CASCADE;

CREATE TABLE "Mirth_Inbound".document_vital_signs
(
  recordid serial NOT NULL,
  document_vital_signs_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  vital_signs_template_id_root character varying(100),
  vital_signs_template_id_assigningauthorityname character varying(100),
  vital_signs_code_uuid character varying(255),
  vital_signs_html_uuid character varying(255),
  vital_signs_organizer_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_vital_signs_pkey PRIMARY KEY (document_vital_signs_uuid),
  CONSTRAINT vital_signs_code_uuid_fkey FOREIGN KEY (vital_signs_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT vital_signs_html_uuid_fkey FOREIGN KEY (vital_signs_html_uuid) REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT vital_signs_organizer_uuid_fkey FOREIGN KEY (vital_signs_organizer_uuid) REFERENCES "Mirth_Inbound".document_vital_signs_organizer (document_vital_signs_organizer_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_vital_signs
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_vital_signs TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_vital_signs TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_vital_signs TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_vital_signs TO postgres;

-- Table: "Mirth_Inbound".document_vital_signs_observation

DROP TABLE IF EXISTS "Mirth_Inbound".document_vital_signs_observation CASCADE;

CREATE TABLE "Mirth_Inbound".document_vital_signs_observation
(
  recordid serial NOT NULL,
  document_vital_signs_observation_uuid character varying(255) NOT NULL,
  vital_signs_observation_class_code character varying(30),
  vital_signs_observation_mood_code character varying(30),
  vital_signs_observation_template_id_root character varying(100),
  vital_signs_observation_code_uuid character varying(255),
  vital_signs_observation_text character varying(255),
  vital_signs_observation_text_reference character varying(100),
  vital_signs_observation_status_code character varying(30),
  vital_signs_observation_effectivetime timestamp with time zone,
  vital_signs_observation_value_type character varying(30),
  vital_signs_observation_value character varying(30),
  vital_signs_observation_value_unit character varying(30),
  vital_signs_observation_author_uuid character varying(255),
  vital_signs_observation_intepretation_code_uuid character varying(225),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_vital_signs_observation_pkey PRIMARY KEY (document_vital_signs_observation_uuid),
  CONSTRAINT vital_signs_observation_code_uuid_fkey FOREIGN KEY (vital_signs_observation_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT vital_signs_observation_author_uuid_fkey FOREIGN KEY (vital_signs_observation_author_uuid) REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT vital_signs_observation_intepretation_code_uuid_fkey FOREIGN KEY (vital_signs_observation_intepretation_code_uuid) REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_vital_signs_observation
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_vital_signs_observation TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_vital_signs_observation TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_vital_signs_observation TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_vital_signs_observation TO postgres;

-- Table: "Mirth_Inbound".document_vital_signs_organizer

DROP TABLE IF EXISTS "Mirth_Inbound".document_vital_signs_organizer CASCADE;

CREATE TABLE "Mirth_Inbound".document_vital_signs_organizer
(
  recordid serial NOT NULL,
  document_vital_signs_organizer_uuid character varying(255) NOT NULL,
  vital_signs_organizer_class_code character varying(30),
  vital_signs_organizer_mood_code character varying(30),
  vital_signs_organizer_template_id_root character varying(100),
  vital_signs_organizer_code_uuid character varying(255),
  vital_signs_organizer_status_code character varying(30),
  vital_signs_organizer_effectivetime timestamp with time zone,
  vital_signs_observation_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_vital_signs_organizer_pkey PRIMARY KEY (document_vital_signs_organizer_uuid),
  CONSTRAINT vital_signs_organizer_code_uuid_fkey FOREIGN KEY (vital_signs_organizer_code_uuid) REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT vital_signs_observation_uuid_fkey FOREIGN KEY (vital_signs_observation_uuid) REFERENCES "Mirth_Inbound".document_vital_signs_organizer (document_vital_signs_organizer_uuid) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_vital_signs_organizer
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_vital_signs_organizer TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_vital_signs_organizer TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_vital_signs_organizer TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_vital_signs_organizer TO postgres;
