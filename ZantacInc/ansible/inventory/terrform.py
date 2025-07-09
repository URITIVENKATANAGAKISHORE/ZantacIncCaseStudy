#!/usr/bin/env python3
import json
import subprocess
import sys
import os

def get_terraform_output():
    try:
        # Adjust the path below if your terraform directory is elsewhere
        tf_dir = os.path.abspath(os.path.join(os.path.dirname(__file__), '../../terraform'))
        output = subprocess.check_output([
            "terraform", "output", "-json"
        ], cwd=tf_dir)
        return json.loads(output)
    except Exception as e:
        print(json.dumps({"_meta": {"hostvars": {}}}))
        sys.exit(1)

def main():
    tf_output = get_terraform_output()
    # Try AWS ALB DNS name
    hosts = []
    if "alb_dns_name" in tf_output:
        alb = tf_output["alb_dns_name"]["value"]
        if isinstance(alb, str):
            hosts = [alb]
        elif isinstance(alb, list):
            hosts = alb
    # Try Azure public IP output
    elif "public_ip" in tf_output:
        pubip = tf_output["public_ip"]["value"]
        if isinstance(pubip, str):
            hosts = [pubip]
        elif isinstance(pubip, list):
            hosts = pubip
    # Fallback to legacy output
    elif "web_server_public_ip" in tf_output:
        web_ips = tf_output["web_server_public_ip"]["value"]
        if isinstance(web_ips, str):
            hosts = [web_ips]
        elif isinstance(web_ips, list):
            hosts = web_ips

    inventory = {
        "all": {
            "hosts": hosts,
            "vars": {}
        },
        "_meta": {
            "hostvars": {ip: {} for ip in hosts}
        }
    }
    print(json.dumps(inventory))

if __name__ == "__main__":
    main()
