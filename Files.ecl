IMPORT ML_Core;

EXPORT Files := MODULE
EXPORT Prefix := '~dcamper::data_detector::bloom_input_new::';
EXPORT Layout := RECORD
  STRING value;
END;
EXPORT zipcode := DATASET(Prefix + 'zip_codes', Layout, THOR);
EXPORT lastname := DATASET(Prefix + 'person_last_names', Layout, THOR);
EXPORT firstname := DATASET(Prefix + 'person_first_names', Layout, THOR);
EXPORT street := DATASET(Prefix + 'street_names', Layout, THOR);
EXPORT middlename := DATASET(Prefix + 'person_middle_names', Layout, THOR);
l_test := RECORD
  STRING value;
  STRING source;
END;
EXPORT testRecs := DATASET(Prefix + 'sample_data::from_bloom_sources', l_test, THOR);
END;