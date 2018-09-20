-- Filename: advinow_mirth_inbound_document_schema_modification_v20180918.sql

-- MEDICATIONS SECTION

-- Table: "Mirth_Inbound".document_medication

DROP TABLE IF EXISTS "Mirth_Inbound".document_medication CASCADE;

CREATE TABLE "Mirth_Inbound".document_medication
(
  recordid serial NOT NULL,
  document_medication_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  medication_template_id_root character varying(100) NOT NULL,
  medication_manumaterial_class_code character varying(30),
  medication_manumaterial_determiner_code character varying(30),
  medication_manumaterial_code_uuid character varying(255),
  medication_manumaterial_code_text_reference character varying(100),
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
  inserted_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_medication_pkey PRIMARY KEY (document_medication_uuid),
  CONSTRAINT document_author_uuid_fkey FOREIGN KEY (document_author_uuid)
      REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_instruction_uuid_fkey FOREIGN KEY (document_medication_instruction_uuid)
      REFERENCES "Mirth_Inbound".document_medication_instruction (document_medication_instruction_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_method_consumable_med_tran_codes_uuid_fkey FOREIGN KEY (document_medication_method_consumable_med_tran_codes_uuid)
      REFERENCES "Mirth_Inbound".document_medication_method_consumable_med_tran_codes (document_medication_method_consumable_med_tran_codes_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_method_consumable_medication_uuid_fkey FOREIGN KEY (document_medication_method_consumable_medication_uuid)
      REFERENCES "Mirth_Inbound".document_medication_method_consumable_medication (document_medication_method_consumable_medication_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_method_uuid_fkey FOREIGN KEY (document_medication_method_uuid)
      REFERENCES "Mirth_Inbound".document_medication_method (document_medication_method_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medication_supply_uuid_fkey FOREIGN KEY (document_medication_supply_uuid)
      REFERENCES "Mirth_Inbound".document_medication_supply (document_medication_supply_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_html_uuid_fkey FOREIGN KEY (medication_html_uuid)
      REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_manumaterial_code_uuid_fkey FOREIGN KEY (medication_manumaterial_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_status_code_uuid_fkey FOREIGN KEY (medication_status_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT medication_status_value_code_uuid_fkey FOREIGN KEY (medication_status_value_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_medication
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_medication TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_medication TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_medication TO postgres;


-- Table: "Mirth_Inbound".document_medications

DROP TABLE IF EXISTS "Mirth_Inbound".document_medications CASCADE;

CREATE TABLE "Mirth_Inbound".document_medications
(
  recordid serial NOT NULL,
  document_medications_uuid character varying(255) NOT NULL,
  document_medication_uuid character varying(255) NOT NULL,
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_medications_uuid_pkey PRIMARY KEY (document_medications_uuid),
  CONSTRAINT document_medication_uuid_fkey FOREIGN KEY (document_medication_uuid)
	  REFERENCES "Mirth_Inbound".document_medication (document_medication_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- FUNCTIONAL STATUS SECTION

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
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_functional_status_pkey PRIMARY KEY (document_functional_status_uuid),
  CONSTRAINT document_functional_status_observations_uuid_fkey FOREIGN KEY (document_functional_status_observations_uuid)
      REFERENCES "Mirth_Inbound".document_functional_status_observations (document_functional_status_observations_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT functional_status_code_uuid_fkey FOREIGN KEY (functional_status_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT functional_status_html_fkey FOREIGN KEY (functional_status_html_uuid)
      REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- Table: "Mirth_Inbound".document_functional_statuses

DROP TABLE IF EXISTS "Mirth_Inbound".document_functional_statuses CASCADE;

CREATE TABLE "Mirth_Inbound".document_functional_statuses
(
  recordid serial NOT NULL,
  document_functional_statuses_uuid character varying(255) NOT NULL,
  functional_status_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_functional_statuses_uuid_pkey PRIMARY KEY (document_functional_statuses_uuid),
  CONSTRAINT functional_status_uuid_fkey FOREIGN KEY (functional_status_uuid)
	  REFERENCES "Mirth_Inbound".document_functional_status (document_functional_status_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_functional_statuses
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_functional_statuses TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_functional_statuses TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_statuses TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_functional_statuses TO postgres;

-- ALLERGIES SECTION

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
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_observation_reaction_pkey PRIMARY KEY (document_allergy_observation_reaction_uuid),
  CONSTRAINT allergy_observation_reaction_code_uuid_fkey FOREIGN KEY (allergy_observation_reaction_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT allergy_observation_reaction_value_code_uuid_fkey FOREIGN KEY (allergy_observation_reaction_value_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- Table: "Mirth_Inbound".document_allergy_observation_reactions

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy_observation_reactions CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy_observation_reactions
(
  recordid serial NOT NULL,
  document_allergy_observation_reactions_uuid character varying(255) NOT NULL,
  document_allergy_observation_reaction_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_observation_reactions_uuid_pkey PRIMARY KEY (document_allergy_observation_reactions_uuid),
  CONSTRAINT document_allergy_observation_reaction_uuid_fkey FOREIGN KEY (document_allergy_observation_reaction_uuid)
	  REFERENCES "Mirth_Inbound".document_allergy_observation_reaction (document_allergy_observation_reaction_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergy_observation_reactions
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergy_observation_reactions TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergy_observation_reactions TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observation_reactions TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observation_reactions TO postgres;

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
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_observation_pkey PRIMARY KEY (document_allergy_observation_uuid),
  CONSTRAINT allergy_observation_code_uuid_fkey FOREIGN KEY (allergy_observation_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT allergy_observation_type_code_uuid_fkey FOREIGN KEY (allergy_observation_type_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_allergy_observation_reaction_uuid_fkey FOREIGN KEY (document_allergy_observation_reaction_uuid)
      REFERENCES "Mirth_Inbound".document_allergy_observation_reaction (document_allergy_observation_reaction_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_allergy_reaction_severity_uuid_fkey FOREIGN KEY (document_allergy_reaction_severity_uuid)
      REFERENCES "Mirth_Inbound".document_allergy_reaction_severity (document_allergy_reaction_severity_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- Table: "Mirth_Inbound".document_allergy_observations

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy_observations CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy_observations
(
  recordid serial NOT NULL,
  document_allergy_observations_uuid character varying(255) NOT NULL,
  document_allergy_observation_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_observations_uuid_pkey PRIMARY KEY (document_allergy_observations_uuid),
  CONSTRAINT document_allergy_observation_uuid_fkey FOREIGN KEY (document_allergy_observation_uuid)
	  REFERENCES "Mirth_Inbound".document_allergy_observation (document_allergy_observation_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergy_observations
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergy_observations TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergy_observations TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observations TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergy_observations TO postgres;

-- Table: "Mirth_Inbound".document_allergy_substance

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergy_substance CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergy_substance
(
  recordid serial NOT NULL,
  document_allergy_substance_uuid character varying(255) NOT NULL,
  allergy_substance_type_code character varying(30),
  allergy_substance_role_class_code character varying(30),
  allergy_substance_entity_class_code character varying(30),
  allergy_substance_entity_code_uuid character varying(255),
  allergy_substance_entity_text_reference character varying(100),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(), 
  CONSTRAINT document_allergy_substance_pkey PRIMARY KEY (document_allergy_substance_uuid),
  CONSTRAINT allergy_substance_entity_code_uuid_fkey FOREIGN KEY (allergy_substance_entity_code_uuid)
	  REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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
  document_author_uuid character varying(255),
  allergy_html_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergy_pkey PRIMARY KEY (document_allergy_uuid),
  CONSTRAINT document_allergy_observation_uuid_fkey FOREIGN KEY (document_allergy_observation_uuid)
      REFERENCES "Mirth_Inbound".document_allergy_observation (document_allergy_observation_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_html_uuid_fkey FOREIGN KEY (allergy_html_uuid)
      REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_author_uuid_fkey FOREIGN KEY (document_author_uuid)
      REFERENCES "Mirth_Inbound".document_author (document_author_uuid) MATCH SIMPLE
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

-- Table: "Mirth_Inbound".document_allergies

DROP TABLE IF EXISTS "Mirth_Inbound".document_allergies CASCADE;

CREATE TABLE "Mirth_Inbound".document_allergies
(
  recordid serial NOT NULL,
  document_allergies_uuid character varying(255) NOT NULL,
  document_allergy_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_allergies_uuid_pkey PRIMARY KEY (document_allergies_uuid),
  CONSTRAINT document_allergy_uuid_fkey FOREIGN KEY (document_allergy_uuid)
	  REFERENCES "Mirth_Inbound".document_allergy (document_allergy_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_allergies
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_allergies TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_allergies TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergies TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_allergies TO postgres;

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
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_family_history_observation_pkey PRIMARY KEY (document_family_history_observation_uuid),
  CONSTRAINT family_history_observation_code_uuid_fkey FOREIGN KEY (family_history_observation_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT family_history_observation_value_code_uuid_fkey FOREIGN KEY (family_history_observation_value_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- Table: "Mirth_Inbound".document_family_history_observations

DROP TABLE IF EXISTS "Mirth_Inbound".document_family_history_observations CASCADE;

CREATE TABLE "Mirth_Inbound".document_family_history_observations
(
  recordid serial NOT NULL,
  document_family_history_observations_uuid character varying(255) NOT NULL,
  document_family_history_observation_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_family_history_observations_uuid_pkey PRIMARY KEY (document_family_history_observations_uuid),
  CONSTRAINT document_family_history_observation_uuid_fkey FOREIGN KEY (document_family_history_observation_uuid)
	  REFERENCES "Mirth_Inbound".document_family_history_observation (document_family_history_observation_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_family_history_observations
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_family_history_observations TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_family_history_observations TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_observations TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_observations TO postgres;

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
  family_history_relatedSubject_class_code character varying(25),
  family_history_relatedSubject_code_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_family_history_subject_pkey PRIMARY KEY (document_family_history_subject_uuid),
  CONSTRAINT family_history_subject_gender_code_uuid_fkey FOREIGN KEY (family_history_subject_gender_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT family_history_relatedSubject_code_uuid_fkey FOREIGN KEY (family_history_relatedSubject_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- Table: "Mirth_Inbound".document_family_history_organizer

DROP TABLE IF EXISTS "Mirth_Inbound".document_family_history_organizer CASCADE;

CREATE TABLE "Mirth_Inbound".document_family_history_organizer
(
  recordid serial NOT NULL,
  document_family_history_organizer_uuid character varying(255) NOT NULL,
  family_history_organizer_template_id_root character varying(100),
  family_history_organizer_template_id_extension character varying(50),
  family_history_organizer_template_id_assigningauthorityname character varying(100),
  family_history_organizer_status_code character varying(30),
  family_history_subject_class_code character varying(30),
  family_history_subject_uuid character varying(255),
  family_history_subject_text_reference character varying(30),
  document_family_history_observations_uuid character varying(255) NOT NULL,
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_family_history_organizer_pkey PRIMARY KEY (document_family_history_organizer_uuid),
  CONSTRAINT family_history_subject_uuid_fkey FOREIGN KEY (family_history_subject_uuid)
      REFERENCES "Mirth_Inbound".document_family_history_subject (document_family_history_subject_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_family_history_observations_uuid_fkey FOREIGN KEY (document_family_history_observations_uuid)
      REFERENCES "Mirth_Inbound".document_family_history_observations (document_family_history_observations_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_family_history_organizer
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_family_history_organizer TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_family_history_organizer TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_organizer TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_organizer TO postgres;

-- Table: "Mirth_Inbound".document_family_history_organizers

DROP TABLE IF EXISTS "Mirth_Inbound".document_family_history_organizers CASCADE;

CREATE TABLE "Mirth_Inbound".document_family_history_organizers
(
  recordid serial NOT NULL,
  document_family_history_organizers_uuid character varying(255) NOT NULL,
  document_family_history_organizer_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_family_history_organizers_uuid_pkey PRIMARY KEY (document_family_history_organizers_uuid),
  CONSTRAINT document_family_history_organizer_uuid_fkey FOREIGN KEY (document_family_history_organizer_uuid)
	  REFERENCES "Mirth_Inbound".document_family_history_organizer (document_family_history_organizer_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_family_history_organizers
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_family_history_organizers TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_family_history_organizers TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_organizers TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_family_history_organizers TO postgres;

-- Table: "Mirth_Inbound".document_family_history

DROP TABLE IF EXISTS "Mirth_Inbound".document_family_history CASCADE;

CREATE TABLE "Mirth_Inbound".document_family_history
(
  recordid serial NOT NULL,
  document_family_history_uuid character varying(255) NOT NULL,
  family_history_template_id_root character varying(100),
  family_history_template_id_extension character varying(50),
  family_history_template_id_assigningauthorityname character varying(100),
  family_history_code_uuid character varying(255),
  family_history_organizers_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_family_history_pkey PRIMARY KEY (document_family_history_uuid),
  CONSTRAINT family_history_code_uuid_fkey FOREIGN KEY (family_history_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT family_history_organizers_uuid_fkey FOREIGN KEY (family_history_organizers_uuid)
      REFERENCES "Mirth_Inbound".document_family_history_organizers (document_family_history_organizers_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encounter_pkey PRIMARY KEY (document_encounter_uuid),
  CONSTRAINT encounter_activity_uuid_fkey FOREIGN KEY (encounter_activity_uuid)
      REFERENCES "Mirth_Inbound".document_encounter_activity (document_encounter_activity_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_code_uuid_fkey FOREIGN KEY (encounter_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_dischargedisposition_code_uuid_fkey FOREIGN KEY (encounter_dischargedisposition_code_uuid)
      REFERENCES "Mirth_Inbound".document_code (document_code_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_healthcare_facility_uuid_fkey FOREIGN KEY (encounter_healthcare_facility_uuid)
      REFERENCES "Mirth_Inbound".document_represented_organization (document_represented_organization_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_html_uuid_fkey FOREIGN KEY (encounter_html_uuid)
      REFERENCES "Mirth_Inbound".document_html (document_html_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_participant_uuid_fkey FOREIGN KEY (encounter_participant_uuid)
      REFERENCES "Mirth_Inbound".document_participant (document_participant_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT encounter_performer_uuid_fkey FOREIGN KEY (encounter_performer_uuid)
      REFERENCES "Mirth_Inbound".document_performer (document_performer_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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

-- Table: "Mirth_Inbound".document_encounters

DROP TABLE IF EXISTS "Mirth_Inbound".document_encounters CASCADE;

CREATE TABLE "Mirth_Inbound".document_encounters
(
  recordid serial NOT NULL,
  document_encounters_uuid character varying(255) NOT NULL,
  document_encounter_uuid character varying(255),
  record_status integer,
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_encounters_uuid_pkey PRIMARY KEY (document_encounters_uuid),
  CONSTRAINT document_encounter_uuid_fkey FOREIGN KEY (document_encounter_uuid)
	  REFERENCES "Mirth_Inbound".document_encounter (document_encounter_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE "Mirth_Inbound".document_encounters
  OWNER TO mirth_inbound_owner;
GRANT ALL ON TABLE "Mirth_Inbound".document_encounters TO mirth_inbound_owner;
GRANT SELECT ON TABLE "Mirth_Inbound".document_encounters TO readaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounters TO writeaccess;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE "Mirth_Inbound".document_encounters TO postgres;

-- Table: "Mirth_Inbound".document_components

DROP TABLE IF EXISTS "Mirth_Inbound".document_components CASCADE;

CREATE TABLE "Mirth_Inbound".document_components
(
  recordid serial NOT NULL,
  document_components_uuid character varying(255) NOT NULL,
  document_id_root character varying(100) NOT NULL,
  document_id_extension character varying(30) NOT NULL,
  document_allergies_uuid character varying(255),
  document_assessment_plan_uuid character varying(255),
  document_encounters_uuid character varying(255),
  document_family_history_uuid character varying(255),
  document_functional_statuses_uuid character varying(255),
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
  inserted_datetime timestamp with time zone,
  modified_datetime timestamp with time zone DEFAULT now(),
  CONSTRAINT document_components_pkey PRIMARY KEY (document_components_uuid),
  CONSTRAINT document_allergies_uuid_fkey FOREIGN KEY (document_allergies_uuid)
      REFERENCES "Mirth_Inbound".document_allergies (document_allergies_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_encounters_uuid_fkey FOREIGN KEY (document_encounters_uuid)
      REFERENCES "Mirth_Inbound".document_encounters (document_encounters_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_family_history_uuid_fkey FOREIGN KEY (document_family_history_uuid)
      REFERENCES "Mirth_Inbound".document_family_history (document_family_history_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_functional_statuses_uuid_fkey FOREIGN KEY (document_functional_statuses_uuid)
      REFERENCES "Mirth_Inbound".document_functional_statuses (document_functional_statuses_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_immunization_uuid_fkey FOREIGN KEY (document_immunization_uuid)
      REFERENCES "Mirth_Inbound".document_immunization (document_immunization_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_medications_uuid_fkey FOREIGN KEY (document_medications_uuid)
      REFERENCES "Mirth_Inbound".document_medications (document_medications_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_problem_uuid_fkey FOREIGN KEY (document_problem_uuid)
      REFERENCES "Mirth_Inbound".document_problem (document_problem_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_procedure_uuid_fkey FOREIGN KEY (document_procedure_uuid)
      REFERENCES "Mirth_Inbound".document_procedure (document_procedure_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_results_uuid_fkey FOREIGN KEY (document_results_uuid)
      REFERENCES "Mirth_Inbound".document_results (document_results_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT document_vital_signs_uuid_fkey FOREIGN KEY (document_vital_signs_uuid)
      REFERENCES "Mirth_Inbound".document_vital_signs (document_vital_signs_uuid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
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
