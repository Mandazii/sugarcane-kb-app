theory sugarcane_kb
  imports Main
begin

(* ============================================================ *)
(* TYPES *)
(* ============================================================ *)

datatype disease =
  Red_Rot | Smut | Wilt | Sett_Rot | Ratoon_Stunting_Disease |
  Grassy_Shoot | Mosaic | Yellow_Leaf_Disease | Pokkah_Boeng |
  Leaf_Fleck | Rust_Brown | Eye_Spot | Brown_Spot | Yellow_Spot |
  Brown_Stripe | Ring_Spot | Leaf_Scald | Leaf_Blast |
  Curvularia_Leaf_Spot | Rust_Orange

datatype symptom =
  Reddened_Areas_White_Patches |
  Hollow_Cavity_Grey_Mycelium |
  Excessive_Tillering_Lanky |
  Black_Whip |
  Yellowish_Foliage |
  Stunted_Growth |
  Narrow_Leaves |
  Mosaic_Pattern |
  Orange_Pustules |
  Premature_Leaf_Drying |
  Leaf_Yellowing |
  Eye_Shaped_Spots

datatype pest =
  Colletotrichum_Falcatum |
  Sporisorium_Scitamineum |
  Fusarium_Sacchari |
  Ceratocystis_Paradoxa |
  Sugarcane_Mosaic_Virus |
  Sugarcane_Yellow_Leaf_Virus |
  Leaf_Hopper |
  Whitefly |
  Mealybug |
  Stalk_Borer

datatype pesticide =
  Thiophanate_Methyl |
  Carbendazim |
  Propiconazole |
  Mancozeb |
  Chlorpyrifos |
  Imidacloprid |
  Thiamethoxam |
  Organic_Pest_Controller

(* ============================================================ *)
(* PREDICATES *)
(* ============================================================ *)

consts
  has_symptom :: "disease \<Rightarrow> symptom \<Rightarrow> bool"
  caused_by   :: "pest \<Rightarrow> disease \<Rightarrow> bool"
  controls    :: "pesticide \<Rightarrow> pest \<Rightarrow> bool"
  has_disease :: "disease \<Rightarrow> bool"
  treats      :: "pesticide \<Rightarrow> disease \<Rightarrow> bool"

(* ============================================================ *)
(* FACTS (AXIOMS) *)
(* ============================================================ *)

axiomatization where
  (* Symptoms *)
  s1: "has_symptom Red_Rot Reddened_Areas_White_Patches" and
  s2: "has_symptom Red_Rot Hollow_Cavity_Grey_Mycelium" and
  s3: "has_symptom Smut Black_Whip" and
  s4: "has_symptom Smut Excessive_Tillering_Lanky" and
  s5: "has_symptom Mosaic Mosaic_Pattern" and
  s6: "has_symptom Rust_Orange Orange_Pustules" and
  s7: "has_symptom Rust_Orange Premature_Leaf_Drying" and
  s8: "has_symptom Eye_Spot Eye_Shaped_Spots" and

  (* Pest–Disease relationships *)
  c1: "caused_by Colletotrichum_Falcatum Red_Rot" and
  c2: "caused_by Sporisorium_Scitamineum Smut" and
  c3: "caused_by Sugarcane_Mosaic_Virus Mosaic" and
  c4: "caused_by Sugarcane_Yellow_Leaf_Virus Yellow_Leaf_Disease" and
  c5: "caused_by Leaf_Hopper Eye_Spot" and

  (* Pesticide–Pest relationships *)
  p1: "controls Thiophanate_Methyl Colletotrichum_Falcatum" and
  p2: "controls Carbendazim Colletotrichum_Falcatum" and
  p3: "controls Propiconazole Sporisorium_Scitamineum" and
  p4: "controls Imidacloprid Leaf_Hopper" and
  p5: "controls Thiamethoxam Leaf_Hopper"

(* ============================================================ *)
(* RULES (LOGICAL IMPLICATIONS) *)
(* ============================================================ *)

axiomatization where
  (* Disease inference from symptoms *)
  r1: "(has_symptom Red_Rot Reddened_Areas_White_Patches
        \<and> has_symptom Red_Rot Hollow_Cavity_Grey_Mycelium)
        \<longrightarrow> has_disease Red_Rot" and

  r2: "(has_symptom Smut Black_Whip
        \<and> has_symptom Smut Excessive_Tillering_Lanky)
        \<longrightarrow> has_disease Smut" and

  (* Treatment rule *)
  r3: "\<lbrakk> caused_by P D ; controls C P \<rbrakk> \<Longrightarrow> treats C D"

(* ============================================================ *)
(* FORWARD CHAINING (DERIVED FACT) *)
(* ============================================================ *)

theorem red_rot_detected:
  "has_disease Red_Rot"
  using s1 s2 r1
  by auto

(* ============================================================ *)
(* BACKWARD CHAINING (GOAL-DRIVEN PROOF) *)
(* ============================================================ *)

theorem red_rot_treated:
  "treats Thiophanate_Methyl Red_Rot"
proof -
  have "caused_by Colletotrichum_Falcatum Red_Rot" using c1 .
  have "controls Thiophanate_Methyl Colletotrichum_Falcatum" using p1 .
  thus ?thesis using r3 by auto
qed

end
