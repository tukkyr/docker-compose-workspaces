import cdk = require('@aws-cdk/core');
import certmgr = require('@aws-cdk/aws-certificatemanager')
import route53 = require('@aws-cdk/aws-route53')

export class CdkStack extends cdk.Stack {
  constructor(scope: cdk.Construct, id: string, props?: cdk.StackProps) {
    super(scope, id, props);

    // The code that defines your stack goes here
    const hostzone = new route53.PublicHostedZone(this, "HostedZone", {
      zoneName: 'exsample.com'
    })

    const cert = new certmgr.DnsValidatedCertificate(this, 'TestCertificate', {
      domainName: 'exsample.com',
      hostedZone: hostzone
    })
  }
}
