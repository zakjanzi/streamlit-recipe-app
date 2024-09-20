"""
app.py: A recipe app built with streamlit.
"""

import streamlit as st
from dotenv import load_dotenv
import os
import requests

st.write(''' # Recipe App''')

# Load environment variables from .env file
load_dotenv()

# Get API key from environment variables
api_key = os.getenv('API_KEY')

# Check if API key is loaded correctly
if not api_key:
    st.error("API key not found")
else:
    api_endpoint = f"https://api.spoonacular.com/recipes/complexSearch?apiKey={api_key}"  # Include search query here

    headers = {
        "Content-Type": "application/json"
    } 



    if st.text_input('Search for a recipe', placeholder="Enter text"):  # Trigger search on text input
        payload = {"query": st.session_state.get("search_query", "")}  # Use session state for query
        response = requests.get(api_endpoint, params=payload, headers=headers)

        if response.status_code == 200:
            results = response.json()
            # Process the results and display them in Streamlit
            st.write(results)
        else:
            st.error(f"Error: {response.status_code} {response.reason}")