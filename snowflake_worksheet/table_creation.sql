CREATE OR REPLACE TABLE "CUSTOMERS" (
  akeed_customer_id STRING,
  gender STRING,
  dob INT,
  status INT,
  verified INT,
  language STRING,
  created_at DATETIME,
  updated_at DATETIME,
  age INT,
  
  PRIMARY KEY (akeed_customer_id)
)
STAGE_FILE_FORMAT = ( TYPE = 'csv' FIELD_DELIMITER= ','  SKIP_HEADER= 1 FIELD_OPTIONALLY_ENCLOSED_BY= '"');


CREATE OR REPLACE TABLE "LOCATIONS" (
  customer_id STRING,
  location_number INT,
  location_type STRING,
  Latitude FLOAT,
  longitude FLOAT,
  FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(akeed_customer_id)
)
STAGE_FILE_FORMAT = ( TYPE = 'csv' FIELD_DELIMITER= ','  SKIP_HEADER= 1 FIELD_OPTIONALLY_ENCLOSED_BY= '"');


CREATE OR REPLACE TABLE "VENDORS" (
  id INT,
  authentication_id INT,
  latitude FLOAT,
  longitude FLOAT,
  vendor_category_en STRING,
  vendor_category_id INT,
  delivery_charge FLOAT,
  serving_distance FLOAT,
  is_open INT,
  OpeningTime STRING,
  OpeningTime2 STRING,
  prepration_time INT,
  commission INT,
  is_akeed_delivering STRING,
  discount_percentage INT,
  status INT,
  verified INT,
  rank INT,
  language	STRING,
  vendor_rating FLOAT,
  sunday_from_time1 TIME,
  sunday_to_time1 TIME,
  sunday_from_time2 TIME,
  sunday_to_time2 TIME,
  monday_from_time1 TIME,
  monday_to_time1 TIME,
  monday_from_time2 TIME,
  monday_to_time2 TIME,
  tuesday_from_time1 TIME,
  tuesday_to_time1 TIME,
  tuesday_from_time2 TIME,
  tuesday_to_time2 TIME,
  wednesday_from_time1 TIME,
  wednesday_to_time1 TIME,
  wednesday_from_time2 TIME,
  wednesday_to_time2 TIME,
  thursday_from_time1 TIME,
  thursday_to_time1 TIME,
  thursday_from_time2 TIME,
  thursday_to_time2 TIME,
  friday_from_time1 TIME,
  friday_to_time1 TIME,
  friday_from_time2 TIME,
  friday_to_time2 TIME,
  saturday_from_time1 TIME,
  saturday_to_time1 TIME,
  saturday_from_time2 TIME,
  saturday_to_time2 TIME,
  primary_tags STRING,
  open_close_flags INT,
  vendor_tag STRING,
  vendor_tag_name STRING,
  one_click_vendor STRING,
  country_id INT,
  city_id INT,
  created_at DATETIME,
  updated_at DATETIME,
  device_type INT,
  display_orders INT,
  
  PRIMARY KEY(id),
  UNIQUE (id)
)
STAGE_FILE_FORMAT = ( TYPE = 'csv' FIELD_DELIMITER= ','  SKIP_HEADER= 1 FIELD_OPTIONALLY_ENCLOSED_BY= '"');


CREATE OR REPLACE TABLE "ORDERS" (
  akeed_order_id STRING,
  customer_id STRING,
  item_count INT,
  grand_total FLOAT,
  payment_mode INT,
  promo_code STRING,
  vendor_discount_amount FLOAT,
  promo_code_discount_percentage FLOAT,
  is_favorite STRING,
  is_rated STRING,
  vendor_rating FLOAT,
  driver_rating FLOAT,
  deliverydistance FLOAT,
  preparationtime FLOAT,
  delivery_time DATETIME,
  order_accepted_time DATETIME,
  driver_accepted_time DATETIME,
  ready_for_pickup_time DATETIME,
  picked_up_time DATETIME,
  delivered_time DATETIME,
  delivery_date DATETIME,
  vendor_id INT,
  created_at DATETIME,
  LOCATION_NUMBER INT,
  LOCATION_TYPE STRING,
  
  PRIMARY KEY (akeed_order_id),
  UNIQUE (akeed_order_id),
  FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(akeed_customer_id),
  FOREIGN KEY (vendor_id) REFERENCES VENDORS(id)
)
STAGE_FILE_FORMAT = ( TYPE = 'csv' FIELD_DELIMITER= ','  SKIP_HEADER= 1 FIELD_OPTIONALLY_ENCLOSED_BY= '"' NULL_IF = '0000-00-00 00:00:00');


CREATE OR REPLACE TABLE "FULL" (
  customer_id STRING,
  gender STRING,
  status_x INT,
  verified_x INT,
  created_at_x DATETIME,
  updated_at_x DATETIME,
  location_number INT,
  location_type STRING,
  latitude_x FLOAT,
  longitude_x FLOAT,
  
  FOREIGN KEY (customer_id) REFERENCES CUSTOMERS(akeed_customer_id)
)
STAGE_FILE_FORMAT = ( TYPE = 'csv' FIELD_DELIMITER= ','  SKIP_HEADER= 1 FIELD_OPTIONALLY_ENCLOSED_BY= '"' NULL_IF = '0000-00-00 00:00:00');