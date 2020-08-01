#!/usr/bin/env python3

# https://github.com/ido-ran/google-photos-api-python-quickstart
# https://developers.google.com/photos/library/reference/rest/v1/mediaItems
# https://console.cloud.google.com/apis/credentials


import os
import pickle
import json
from googleapiclient.discovery import build
from google.auth.transport.requests import Request
from google_auth_oauthlib.flow import InstalledAppFlow
import google_auth_httplib2  # This gotta be installed for build() to work

# Setup the Photo v1 API
SCOPES = ['https://www.googleapis.com/auth/photoslibrary.readonly']
creds = None
if(os.path.exists("token.pickle")):
    with open("token.pickle", "rb") as tokenFile:
        creds = pickle.load(tokenFile)
if not creds or not creds.valid:
    if (creds and creds.expired and creds.refresh_token):
        creds.refresh(Request())
    else:
        flow = InstalledAppFlow.from_client_secrets_file(
            'client_secret.json', SCOPES)
        creds = flow.run_local_server(port=0)
    with open("token.pickle", "wb") as tokenFile:
        pickle.dump(creds, tokenFile)
service = build('photoslibrary', 'v1', credentials=creds)

# Call the Photo v1 API
nextPageToken = ''
while nextPageToken is not None:
    d = {}
    d["pageSize"] = 100
    d["pageToken"] = nextPageToken
    results = service.mediaItems().list(
        pageSize=100, pageToken=nextPageToken).execute()
    items = results.get('mediaItems', [])
    nextPageToken = results.get('nextPageToken', None)
    for item in items:
        print(f"{item['filename']} {item['mimeType']} '{item.get('description', '- -')}'"
              f" {item['mediaMetadata']['creationTime']}\nURL: {item['productUrl']}")
    print("")
