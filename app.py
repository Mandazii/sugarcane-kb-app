import streamlit as st
import subprocess

st.title("Sugarcane KB Isabelle Query")

# --- Predefined queries ---
predefined_queries = {
    "Check Red Rot Disease": 'theorem red_rot_detected: "has_disease Red_Rot"',
    "Check Red Rot Treatment": 'theorem red_rot_treated: "treats Thiophanate_Methyl Red_Rot"',
    "Check Smut Disease": 'theorem smut_detected: "has_disease Smut"',
    "Check Smut Treatment": 'theorem smut_treated: "treats Propiconazole Smut"',
}

# --- Let user select a query ---
selected_query_name = st.selectbox("Select a query to run:", list(predefined_queries.keys()))
query_to_run = predefined_queries[selected_query_name]

if st.button("Run Query"):
    st.info(f"Running query: {selected_query_name}")

    # Optionally: Build Isabelle KB first (skip if already built)
    # Note: On Windows, you must use the CLI Isabelle path, not GUI exe
    # Example:
    # build_result = subprocess.run(
    #     ["C:\\Users\\Mandazii\\Desktop\\Isabelle2025\\bin\\isabelle.exe", "build", "-d", ".", "sugarcane_kb"],
    #     capture_output=True,
    #     text=True
    # )
    # st.text_area("Build Output", build_result.stdout + build_result.stderr, height=200)

    # Run the selected Isabelle console command
    # Replace 'isabelle' with full path to CLI if needed
    console_result = subprocess.run(
        ["isabelle", "console", "-e", query_to_run],
        capture_output=True,
        text=True
    )
    st.text_area("Query Result", console_result.stdout + console_result.stderr, height=300)
