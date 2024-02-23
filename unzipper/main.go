package unzipper

import (
	"fmt"
	"os"

	"github.com/aws/aws-sdk-go/aws/credentials"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3/s3manager"
)

var filename = "file_name.zip"
var myBucket = "myBucket"
var myKey = "file_name.zip"
var accessKey = ""
var accessSecret = ""

func main() {
	var awsConfig *aws.Config
	if accessKey == "" || accessSecret == "" {
		//load default credentials
		awsConfig = &aws.Config{
			Region: aws.String("us-east-2"),
		}
	} else {
		awsConfig = &aws.Config{
			Region:      aws.String("us-east-2"),
			Credentials: credentials.NewStaticCredentials(accessKey, accessSecret, ""),
		}
	}

	// The session the S3 Uploader will use
	sess := session.Must(session.NewSession(awsConfig))

	// Create an uploader with the session and default options
	//uploader := s3manager.NewUploader(sess)

	// Create an uploader with the session and custom options
	uploader := s3manager.NewUploader(sess, func(u *s3manager.Uploader) {
		u.PartSize = 5 * 1024 * 1024 // The minimum/default allowed part size is 5MB
		u.Concurrency = 2            // default is 5
	})

	//open the file
	f, err := os.Open(filename)
	if err != nil {
		fmt.Printf("failed to open file %q, %v", filename, err)
		return
	}
	//defer f.Close()

	// Upload the file to S3.
	result, err := uploader.Upload(&s3manager.UploadInput{
		Bucket: aws.String(myBucket),
		Key:    aws.String(myKey),
		Body:   f,
	})

	//in case it fails to upload
	if err != nil {
		fmt.Printf("failed to upload file, %v", err)
		return
	}
	fmt.Printf("file uploaded to, %s\n", result.Location)
}
