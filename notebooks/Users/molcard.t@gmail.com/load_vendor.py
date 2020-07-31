# Databricks notebook source
# File storage session parameters

appID = dbutils.secrets.get("datastorage", "app_id")
secret = dbutils.secrets.get("datastorage", "secret")
tenantID = dbutils.secrets.get("datastorage", "tenant_id")

# Configure file storage session

spark.conf.set("fs.azure.account.auth.type", "OAuth")
spark.conf.set("fs.azure.account.oauth.provider.type", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider")
spark.conf.set("fs.azure.account.oauth2.client.id", appID)
spark.conf.set("fs.azure.account.oauth2.client.secret", secret)
spark.conf.set("fs.azure.account.oauth2.client.endpoint", "https://login.microsoftonline.com/" + tenantID + "/oauth2/token")
spark.conf.set("fs.azure.createRemoteFileSystemDuringInitialization", "true")

# COMMAND ----------

# Get Snowflake credentials.
user = dbutils.secrets.get("snowflake", "user")
password = dbutils.secrets.get("snowflake", "password")

# Snowflake connection options
sf_options = {
  "sfUrl": "wt07783.west-europe.azure.snowflakecomputing.com",
  "sfUser": user,
  "sfPassword": password,
  "sfDatabase": "RESTAURANT",
  "sfSchema": "PUBLIC",
  "sfWarehouse": "COMPUTE_WH"
}

# COMMAND ----------

# Storage parameters
storageAccountName = "restaurantaccount"
fileSystemName = "restaurant"

# File parameters
path = "raw_data/vendors"
file = "vendors.csv"

# Table parameters
table_name = "VENDORS"

# COMMAND ----------

# Read file on the file storage

df = spark.read.csv("abfss://" + fileSystemName + "@" + storageAccountName + ".dfs.core.windows.net/{path}/{file}".format(path=path, file=file), header=True)
df.show()

# COMMAND ----------

from pyspark.sql.functions import col, unix_timestamp

for col_name in ["created_at", "updated_at"]:
  df = df.withColumn(
      col_name,
      unix_timestamp(col(col_name), "yyyy-MM-dd HH:mm:ss").cast("timestamp")
  )

df.printSchema()

# COMMAND ----------

df.select("thursday_to_time2").show()

# COMMAND ----------

# Load Data Frame into table

df.write \
  .format("snowflake") \
  .options(**sf_options) \
  .option("dbtable", table_name) \
  .mode("append") \
  .save()