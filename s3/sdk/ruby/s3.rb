# Set requirements

require 'aws-sdk-s3'  # AWS SDK for Ruby to interact with Amazon S3.
require 'pry'         # Pry for debugging (optional, can be removed if not used).
require 'securerandom' # SecureRandom to generate unique random values.
require 'fileutils'  #FIle management including creating directories and managing file paths

# Assign value to the variable 'bucket_name' which is defined by the 'BUCKET_NAME' environment variable.
bucket_name = ENV['BUCKET_NAME']  
region = 'us-east-1'  # Set the AWS region to 'us-east-1'.

# Create a client for interacting with the S3 service.
client = Aws::S3::Client.new(region: region)
    
# Create the bucket using client
client.create_bucket({
  bucket: bucket_name
})

#Optional debugging
# binding.pry

# Create the tmp directory if it doesn't exist
FileUtils.mkdir_p('./tmp')

# Generate a random number of files (between 1 and 6) to be created, and then print the number.
number_of_files = 1 + rand(6)  # Generates a random integer between 1 and 6.
puts "number_of_files: #{number_of_files}"  # Output the number of files to be created.

# Create 'number_of_files' and perform the following steps for each file.
number_of_files.times.each do |i|
  puts "i: #{i}"  # Output the current file index.
  filename = "file_#{i}.text"  # Define the filename using the current index.
  output_path = "./tmp/#{filename}"  # Define the path where the file will be saved locally.

  # Create a new file locally at the specified output path, and write a unique random UUID into it.
  File.open(output_path, "w") do |f|  # Ensure the output path is specified correctly.
    f.write(SecureRandom.uuid)  # Write a unique UUID to the file.
  end

  # Read the file in binary mode and upload it to the specified S3 bucket.
  File.open(output_path, 'rb') do |f|  # Open the file for reading in binary mode.
    # Upload the file to the S3 bucket. Ensure that the 'client.put_object' syntax is correct.
    client.put_object(
      bucket: bucket_name,  # Specify the bucket name.
      key: filename,        # Use the file name as the S3 key.
      body: f               # Upload the file contents.
    )
  end
end
