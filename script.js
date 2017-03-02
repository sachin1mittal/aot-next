var awsIot = require('aws-iot-device-sdk');

var device = awsIot.device({
  keyPath: "certs/private.pem.key",
  certPath: "certs/certificate.pem.crt",
  caPath: "certs/root-CA.crt",
  clientId: 'AOTDEVICE-$(YOUR_DEVICE_SERIAL_NUMBER)' ,
  region: 'ap-southeast-1'
});

device
  .on('connect', function() {
    device.subscribe('$(YOUR_DEVICE_SERIAL_NUMBER)');
  });

device
  .on('message', function(topic, signal) {
     // You will get 'on'/'off' signal in this signal variable
  });

device
  .on('error', function(error) {
    // Handle Error
  });
