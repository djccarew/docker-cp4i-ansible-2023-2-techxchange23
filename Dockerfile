FROM --platform=linux/amd64  quay.io/clouddragons/openshift-ansible-base:4.10.59
# Additional packages needed for python-ldap 
RUN microdnf install -y gcc python3-devel openldap-devel jq
RUN pip3 install python-ldap
RUN ansible-galaxy collection install community.general
COPY apic-slim /usr/local/bin/
RUN chmod +x /usr/local/bin/apic-slim
COPY cloudctl /usr/local/bin/
RUN chmod +x /usr/local/bin/cloudctl
COPY ./ansible/ /ansible/
