# Databricks notebook source
# Use secrets DBUtil to get Snowflake credentials.
user = dbutils.secrets.get("snowflake", "user")
password = dbutils.secrets.get("snowflake", "password")

# snowflake connection options
options = {
  "sfUrl": "wt07783.west-europe.azure.snowflakecomputing.com",
  "sfUser": user,
  "sfPassword": password,
  "sfDatabase": "RESTAURANT",
  "sfSchema": "PUBLIC",
  "sfWarehouse": "COMPUTE_WH"
}

# COMMAND ----------

# Read the data written by the previous cell back.
df = spark.read \
  .format("snowflake") \
  .options(**options) \
  .option("dbtable", "CUSTOMERS") \
  .load()

display(df)