import streamlit as st
import subprocess

st.title("Sugarcane KB Isabelle Query")

# User input
query = st.text_input("Enter a statement or theorem to check:")

if st.button("Run Query"):
    # Build Isabelle KB first (optional if already built)
    build_result = subprocess.run(
        ["isabelle", "build", "-d", ".", "sugarcane_kb"],
        capture_output=True,
        text=True
    )
    st.text_area("Build Output", build_result.stdout + build_result.stderr, height=200)

    # Now run an Isabelle console command (example)
    console_result = subprocess.run(
        ["isabelle", "console", "-e", query],
        capture_output=True,
        text=True
    )
    st.text_area("Query Result", console_result.stdout + console_result.stderr, height=300)
