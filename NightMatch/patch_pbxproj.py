#!/usr/bin/env python3
"""
Patches NightMatch/NightMatch.xcodeproj/project.pbxproj to:
 1. Add QalculateWrapper.cpp and QalculateBridge.mm to PBXFileReference + Sources build phase
 2. Add NightMatch-Bridging-Header.h to PBXFileReference
 3. Add libqalculate, libgmp, libmpfr, libxml2custom xcframeworks to:
      PBXFileReference, PBXGroup (NightMatch), PBXFrameworksBuildPhase
 4. Set SWIFT_OBJC_BRIDGING_HEADER, CLANG_CXX_LANGUAGE_STANDARD (c++17),
    HEADER_SEARCH_PATHS, LIBRARY_SEARCH_PATHS, OTHER_LDFLAGS
    on DA076E412C22B0E500F7A2C1 (Debug) and DA076E422C22B0E500F7A2C1 (Release)
"""

import re, sys, os

PBXPROJ = os.path.join(os.path.dirname(os.path.abspath(__file__)),
    "NightMatch.xcodeproj/project.pbxproj")

XCFW_DIR = "/Users/I325639/a_libqalculate/out/xcframeworks"

# ── IDs (stable, hand-picked, won't conflict with existing 24-hex IDs) ────────
IDS = {
    # file refs
    "QalculateWrapper_cpp_ref":  "CC000001CF000000000000A1",
    "QalculateBridge_mm_ref":    "CC000002CF000000000000A1",
    "BridgingHeader_ref":        "CC000003CF000000000000A1",
    "libqalculate_xcfw_ref":     "CC000004CF000000000000A1",
    "libgmp_xcfw_ref":           "CC000005CF000000000000A1",
    "libmpfr_xcfw_ref":          "CC000006CF000000000000A1",
    "libxml2_xcfw_ref":          "CC000007CF000000000000A1",
    # build file entries
    "QalculateWrapper_cpp_bf":   "CC000008CF000000000000A1",
    "QalculateBridge_mm_bf":     "CC000009CF000000000000A1",
    "libqalculate_xcfw_bf":      "CC00000ACF000000000000A1",
    "libgmp_xcfw_bf":            "CC00000BCF000000000000A1",
    "libmpfr_xcfw_bf":           "CC00000CCF000000000000A1",
    "libxml2_xcfw_bf":           "CC00000DCF000000000000A1",
    # group for cpp files
    "cpp_group":                 "CC00000ECF000000000000A1",
}

with open(PBXPROJ, "r") as f:
    src = f.read()

# Guard against double-patching
if "CC000001CF000000000000A1" in src:
    print("project.pbxproj already patched — skipping.")
    sys.exit(0)

# ── 1. PBXBuildFile entries ────────────────────────────────────────────────────
build_file_entries = f"""
\t\t{IDS['QalculateWrapper_cpp_bf']} /* QalculateWrapper.cpp in Sources */ = {{isa = PBXBuildFile; fileRef = {IDS['QalculateWrapper_cpp_ref']} /* QalculateWrapper.cpp */; }};
\t\t{IDS['QalculateBridge_mm_bf']} /* QalculateBridge.mm in Sources */ = {{isa = PBXBuildFile; fileRef = {IDS['QalculateBridge_mm_ref']} /* QalculateBridge.mm */; }};
\t\t{IDS['libqalculate_xcfw_bf']} /* libqalculate.xcframework in Frameworks */ = {{isa = PBXBuildFile; fileRef = {IDS['libqalculate_xcfw_ref']} /* libqalculate.xcframework */; }};
\t\t{IDS['libgmp_xcfw_bf']} /* libgmp.xcframework in Frameworks */ = {{isa = PBXBuildFile; fileRef = {IDS['libgmp_xcfw_ref']} /* libgmp.xcframework */; }};
\t\t{IDS['libmpfr_xcfw_bf']} /* libmpfr.xcframework in Frameworks */ = {{isa = PBXBuildFile; fileRef = {IDS['libmpfr_xcfw_ref']} /* libmpfr.xcframework */; }};
\t\t{IDS['libxml2_xcfw_bf']} /* libxml2custom.xcframework in Frameworks */ = {{isa = PBXBuildFile; fileRef = {IDS['libxml2_xcfw_ref']} /* libxml2custom.xcframework */; }};"""

src = src.replace(
    "/* End PBXBuildFile section */",
    build_file_entries + "\n\t\t/* End PBXBuildFile section */"
)

# ── 2. PBXFileReference entries ───────────────────────────────────────────────
file_ref_entries = f"""
\t\t{IDS['QalculateWrapper_cpp_ref']} /* QalculateWrapper.cpp */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.cpp.cpp; path = QalculateWrapper.cpp; sourceTree = "<group>"; }};
\t\t{IDS['QalculateBridge_mm_ref']} /* QalculateBridge.mm */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.cpp.objcpp; path = QalculateBridge.mm; sourceTree = "<group>"; }};
\t\t{IDS['BridgingHeader_ref']} /* NightMatch-Bridging-Header.h */ = {{isa = PBXFileReference; lastKnownFileType = sourcecode.c.h; path = "NightMatch-Bridging-Header.h"; sourceTree = "<group>"; }};
\t\t{IDS['libqalculate_xcfw_ref']} /* libqalculate.xcframework */ = {{isa = PBXFileReference; lastKnownFileType = wrapper.xcframework; name = libqalculate.xcframework; path = "{XCFW_DIR}/libqalculate.xcframework"; sourceTree = "<absolute>"; }};
\t\t{IDS['libgmp_xcfw_ref']} /* libgmp.xcframework */ = {{isa = PBXFileReference; lastKnownFileType = wrapper.xcframework; name = libgmp.xcframework; path = "{XCFW_DIR}/libgmp.xcframework"; sourceTree = "<absolute>"; }};
\t\t{IDS['libmpfr_xcfw_ref']} /* libmpfr.xcframework */ = {{isa = PBXFileReference; lastKnownFileType = wrapper.xcframework; name = libmpfr.xcframework; path = "{XCFW_DIR}/libmpfr.xcframework"; sourceTree = "<absolute>"; }};
\t\t{IDS['libxml2_xcfw_ref']} /* libxml2custom.xcframework */ = {{isa = PBXFileReference; lastKnownFileType = wrapper.xcframework; name = libxml2custom.xcframework; path = "{XCFW_DIR}/libxml2custom.xcframework"; sourceTree = "<absolute>"; }};"""

src = src.replace(
    "/* End PBXFileReference section */",
    file_ref_entries + "\n\t\t/* End PBXFileReference section */"
)

# ── 3. Add a "cpp" group inside NightMatch group ──────────────────────────────
cpp_group = f"""
\t\t{IDS['cpp_group']} /* cpp */ = {{
\t\t\tisa = PBXGroup;
\t\t\tchildren = (
\t\t\t\t{IDS['QalculateWrapper_cpp_ref']} /* QalculateWrapper.cpp */,
\t\t\t\t{IDS['QalculateBridge_mm_ref']} /* QalculateBridge.mm */,
\t\t\t\t{IDS['BridgingHeader_ref']} /* NightMatch-Bridging-Header.h */,
\t\t\t);
\t\t\tpath = cpp;
\t\t\tsourceTree = "<group>";
\t\t}};"""

src = src.replace(
    "/* End PBXGroup section */",
    cpp_group + "\n\t\t/* End PBXGroup section */"
)

# Add cpp group reference into NightMatch main group (before NightMatchApp.swift)
src = src.replace(
    "\t\t\t\tDA076E1F2C22B0DF00F7A2C1 /* NightMatchApp.swift */,",
    f"\t\t\t\t{IDS['cpp_group']} /* cpp */,\n\t\t\t\tDA076E1F2C22B0DF00F7A2C1 /* NightMatchApp.swift */,"
)

# ── 4. Frameworks build phase: add xcframeworks ───────────────────────────────
# Target NightMatch's frameworks phase = DA076E192C22B0DF00F7A2C1
src = src.replace(
    "\t\t\t\tDA2072242CCF829000E02D44 /* LaTeXSwiftUI in Frameworks */,",
    f"\t\t\t\tDA2072242CCF829000E02D44 /* LaTeXSwiftUI in Frameworks */,\n\t\t\t\t{IDS['libqalculate_xcfw_bf']} /* libqalculate.xcframework in Frameworks */,\n\t\t\t\t{IDS['libgmp_xcfw_bf']} /* libgmp.xcframework in Frameworks */,\n\t\t\t\t{IDS['libmpfr_xcfw_bf']} /* libmpfr.xcframework in Frameworks */,\n\t\t\t\t{IDS['libxml2_xcfw_bf']} /* libxml2custom.xcframework in Frameworks */,"
)

# ── 5. Sources build phase: add .cpp and .mm ─────────────────────────────────
# Insert before the closing of DA076E182C22B0DF00F7A2C1 sources
src = src.replace(
    "\t\t\t\tBBAA00212CF0000000000001 /* CustomSumView.swift in Sources */,\n\t\t\t);\n\t\t\trunOnlyForDeploymentPostprocessing = 0;\n\t\t};\n\t\tDA076E282C22B0E500F7A2C1",
    f"\t\t\t\tBBAA00212CF0000000000001 /* CustomSumView.swift in Sources */,\n\t\t\t\t{IDS['QalculateWrapper_cpp_bf']} /* QalculateWrapper.cpp in Sources */,\n\t\t\t\t{IDS['QalculateBridge_mm_bf']} /* QalculateBridge.mm in Sources */,\n\t\t\t);\n\t\t\trunOnlyForDeploymentPostprocessing = 0;\n\t\t}};\n\t\tDA076E282C22B0E500F7A2C1"
)

# ── 6. Build settings for NightMatch Debug and Release configs ────────────────
PROJ_ROOT = "/Users/I325639/jack/notes/github/t991ios/NightMatch"
BRIDGING_HDR = "NightMatch/NightMatch-Bridging-Header.h"

new_settings = f"""
\t\t\t\tSWIFT_OBJC_BRIDGING_HEADER = "{BRIDGING_HDR}";
\t\t\t\tCLANG_CXX_LANGUAGE_STANDARD = "c++17";
\t\t\t\tHEADER_SEARCH_PATHS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"$(SRCROOT)/NightMatch/cpp",
\t\t\t\t\t"{XCFW_DIR}/libqalculate.xcframework/ios-arm64/Headers",
\t\t\t\t\t"{XCFW_DIR}/libgmp.xcframework/ios-arm64/Headers",
\t\t\t\t\t"{XCFW_DIR}/libmpfr.xcframework/ios-arm64/Headers",
\t\t\t\t\t"{XCFW_DIR}/libxml2custom.xcframework/ios-arm64/Headers",
\t\t\t\t);
\t\t\t\tOTHER_LDFLAGS = (
\t\t\t\t\t"$(inherited)",
\t\t\t\t\t"-lstdc++",
\t\t\t\t);"""

# Inject into both DA076E412C22B0E500F7A2C1 (Debug) and DA076E422C22B0E500F7A2C1 (Release)
# We identify each by its unique content pattern and append before closing brace.
for cfg_id in ["DA076E412C22B0E500F7A2C1", "DA076E422C22B0E500F7A2C1"]:
    # Find the block and inject settings before the closing };
    # Pattern: the SWIFT_VERSION line unique in each block
    pattern = r'(' + re.escape(cfg_id) + r'.*?SWIFT_VERSION = 5\.0;)'
    def inject(m):
        return m.group(1) + new_settings
    src, n = re.subn(pattern, inject, src, count=1, flags=re.DOTALL)
    if n == 0:
        print(f"WARNING: could not find config {cfg_id}")

with open(PBXPROJ, "w") as f:
    f.write(src)

print("project.pbxproj patched successfully.")
