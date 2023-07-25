#!/bin/sh
###################
# INPUT VARIABLES #
###################
APIC_INST_NAME='apim-demo'
APIC_NAMESPACE='cp4i-apic'
LDAP_UR_NAME='techcon-ldap'
LDAP_USERS=(poe3)

######################
# SET APIC VARIABLES #
######################
APIC_USER_REALM="provider/${LDAP_UR_NAME}"
APIC_USER_CATALOG='sandbox'
APIC_PORTAL_TYPE='drupal'
#APIC_MGMT_SERVER=$(oc get route "apis-minim-6a15c82d-platform-api" -n $APIC_NAMESPACE -o jsonpath="{.spec.host}")

APIC_MGMT_SERVER=$(oc get route "${APIC_INST_NAME}-mgmt-platform-api" -n $APIC_NAMESPACE -o jsonpath="{.spec.host}")

######################################
# UPDATE CATALOG(S) TO ENABLE PORTAL #
######################################
for LDAP_USER in "${LDAP_USERS[@]}"
do
    APIC_USER_ORG="${LDAP_USER}-porg"
    echo "Enter login credentials for user" $LDAP_USER
    #read PWD
PWD='poeuser!'
    #If password is the same for all user IDs, then password can be coded here.
    echo "Login to APIC with LDAP User..."
    apic login --server $APIC_MGMT_SERVER --realm $APIC_USER_REALM -u $LDAP_USER -p $PWD
    echo "Getting Poratl URL..."
    APIC_PORTAL_URL=$(apic portal-services:list --server $APIC_MGMT_SERVER --scope org --org $APIC_USER_ORG | awk '{print $2}')
    echo "Getting Catalog Settings..."
    apic catalog-settings:get --server $APIC_MGMT_SERVER --org $APIC_USER_ORG --catalog $APIC_USER_CATALOG --format json
    echo "Updating Catalog Settings File..."
    jq --arg PORTAL_URL $APIC_PORTAL_URL \
        --arg APIC_PORTAL_TYPE $APIC_PORTAL_TYPE \
        '.portal.type= $APIC_PORTAL_TYPE |
        .portal.portal_service_url=$PORTAL_URL |
        del(.created_at, .updated_at)' \
        catalog-setting.json > catalog-setting-updated.json
    echo "Enabling Portal in Catalog..."
    apic catalog-settings:update --server $APIC_MGMT_SERVER --org $APIC_USER_ORG --catalog $APIC_USER_CATALOG catalog-setting-updated.json
    rm -f catalog-setting.json
    rm -f catalog-setting-updated.json
done
