Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19733395AF8
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691120; cv=none; b=GOvy79wWBzkGQ/rVlV/B5ZFNkrBULTLXh6i8x+8psnulwsCkMmGqkhFQJcNo+MTlsdislSMeuVpVWGqRej1fRbNek7pQLwJwrVQsbHGUMO3hiENktU1V2Hv5nRStlCOUEuYXJ3gtE+GFnNPtUJdpdsc2C2GHT+Ha5XeHgWOYZIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691120; c=relaxed/simple;
	bh=WUUkEMEvA19FYmLtsDORUWfphgjmXBpJg7EqzXdoMfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1ZePKiQI9bTrGOd52AfCDjfYXKOkqyDwhfoGawNSnom0XT1rGZJnOOgD594BHUtuwOJRVbWzIG6keV+72DwqLpNlhXY2OOHpa4kSCq4U1yjHIl/XAeObcAGJYprsuC7OXWhBBQfs7A/AWBFOJNYryOn9dZ4cm9CH6zEoBbU+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=Fa5V2/cK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="Fa5V2/cK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b3e03939so19983385e9.1
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691114; x=1781295914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I18Z0EZ3Uv5pZYKg3l8UJFVgnd08sgch6n5ay0lQ6mg=;
        b=Fa5V2/cKFO7lyT2mR6F11xRLuLAIDbkJK6lnWMc2DDkXX7+vE4U3J9O78PqfTNta3W
         hasaDDITi91obD3181lriAi0r6rNcZWCc7OjUEgXsdyRxjYYmjPMkzD5DHB9XqhRNrGr
         OD31jzLOTDoWhfSNqCGP4mVsaU9JjdtW9iQ4kNkpk5PYapcGaouWO5+s7z8vtYvdVosD
         B3I5x8d/Wxl/Eb5g0bNxXqHp3KcD0S5d9euH2PiWyYB+HCD9Vn1jxv6TbImOM1vF53lm
         c/UnIVg8ho/YbThAmRy4rOxZZJBwzDn4vK5MBMvsqGOgBK6nYcRmbIwZRwJDKboPVAz6
         F2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691114; x=1781295914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I18Z0EZ3Uv5pZYKg3l8UJFVgnd08sgch6n5ay0lQ6mg=;
        b=D5LgNMlYQ3Y6nmpG53LtkCs4+iERBizz1b/4uK6Ru3Pz6Sxoy13naqF/KTmqT4i8Zv
         Re1AvhuuGzof9B8eqrtm7MIfjcYrhet6ER3Vv8DhejiUTo3kTH8+AZCB0Xa91+OcLSAU
         FdBaiWKEgSsNbBwO3wX9ywETyBgcD2dRIFo+ViHuIToHMGF6EUQbyrErBkzs3aENclBV
         L5NsXwZfuKWDZQEzRodp5lqFmYtfg1eGN1jCVXEmD43BNuUyUys544IBwO1TEYR+t86k
         bC0TTCpMeLO+rZiX3aicxKuf5VNmuIpX+nIrjUtmgDvlJofWhDtX3QP0yFaUVfjQSLDe
         6SYg==
X-Gm-Message-State: AOJu0YwnNsUlC+RhhQ/mc1xJETUQZpk41nrcR+pmnL8Z9XOpTMZ7Gekq
	o+OLeu/ITlFy8ca9AhIu2cfqafilguDeMbVI59JZMIDQE5+IIzoJxe8azX7CbEytdsEZ1RjEFXI
	md17NObzE
X-Gm-Gg: Acq92OEIa/9ODp9pw+nq5FX3HwQxdsYfG6rKAIz5eBfLgE9QL3rKsODRD4b2N6G6FBs
	Ff8qnhsBHyIWmAnyNvQBmUKVD9HtpoELPD+ZMogu3CUAxqaVPXob2P+DLBXHm6yzeOhW0prcCd4
	h4nyqsRFayxZ3TJrWZ2D0N8VM1LM2nDVn3tAXKFm10yHxs+eykuM0w7HltwMXC3g8IBQ0+F/K6J
	34lfV0M1MA1fCDm8guMZN5yHYXnZwjvGZQXHunbaZZvuN2f4xgRLxbv3GTAefhmvHp4nF9ie77d
	Xiu4u9z6vuvE3ASKX8td7PRBGUMKToc18zZG4v8y88kuVfu1r6Ir4kAbjfmEdTuPoDHan/eSiK6
	9kG8falxI6dlv2/RSfRsxqoB56JErat6XIViqxfZjMwrpfypEIAreHtrTzx3CtoRyeelHJ+ZAlY
	9GDeaGdFkeqTLqG0RckTHxoOFd5d6zxpnFFRiDLt3/YEhFInA9UNzBhG33bkBcZmnVk8ad7KqOS
	GAxZIhSqzViJcHAmGv1jsPPbHMV4AREL6z8ATcgEzYQfYieO+I+5vKMEs8m
X-Received: by 2002:a05:600c:6388:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-490c2d1412emr69803005e9.14.1780691114221;
        Fri, 05 Jun 2026 13:25:14 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:13 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 1/7] SPSLR pinpoint plugin source
Date: Fri,  5 Jun 2026 22:25:05 +0200
Message-ID: <20260605202511.79272-2-yjn@yjn-systems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605202511.79272-1-yjn@yjn-systems.com>
References: <20260605202511.79272-1-yjn@yjn-systems.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: York Jasper Niebuhr <yjn@yjn-systems.com>
---
 tools/spslr/src/pinpoint/final/final.h        |  13 +
 .../src/pinpoint/final/on_finish_unit.cpp     | 190 ++++++++
 tools/spslr/src/pinpoint/pinpoint.cpp         | 128 ++++++
 tools/spslr/src/pinpoint/pinpoint_config.h    |   9 +
 tools/spslr/src/pinpoint/pinpoint_error.h     |  27 ++
 .../spslr/src/pinpoint/safegcc/safe-attribs.h |   8 +
 .../src/pinpoint/safegcc/safe-diagnostic.h    |   9 +
 .../src/pinpoint/safegcc/safe-gcc-plugin.h    |   6 +
 .../spslr/src/pinpoint/safegcc/safe-gimple.h  |  13 +
 tools/spslr/src/pinpoint/safegcc/safe-input.h |   9 +
 .../src/pinpoint/safegcc/safe-langhooks.h     |   8 +
 tools/spslr/src/pinpoint/safegcc/safe-md5.h   |   8 +
 .../spslr/src/pinpoint/safegcc/safe-output.h  |   8 +
 .../pinpoint/safegcc/safe-plugin-version.h    |   8 +
 tools/spslr/src/pinpoint/safegcc/safe-rtl.h   |  17 +
 tools/spslr/src/pinpoint/safegcc/safe-tree.h  |   9 +
 .../src/pinpoint/stage0/on_finish_decl.cpp    | 216 +++++++++
 .../src/pinpoint/stage0/on_finish_type.cpp    |  16 +
 .../stage0/on_preserve_component_ref.cpp      |  58 +++
 .../stage0/on_register_attributes.cpp         |  52 +++
 .../src/pinpoint/stage0/on_start_unit.cpp     |  19 +
 .../pinpoint/stage0/separate_offset_pass.cpp  | 315 ++++++++++++++
 tools/spslr/src/pinpoint/stage0/separator.cpp | 117 +++++
 tools/spslr/src/pinpoint/stage0/stage0.h      | 103 +++++
 tools/spslr/src/pinpoint/stage0/target.cpp    | 411 ++++++++++++++++++
 .../src/pinpoint/stage1/asm_offset_pass.cpp   | 133 ++++++
 tools/spslr/src/pinpoint/stage1/stage1.h      |  11 +
 .../pinpoint/stage2/rtl_pin_lower_pass.cpp    | 283 ++++++++++++
 tools/spslr/src/pinpoint/stage2/stage2.h      |  22 +
 29 files changed, 2226 insertions(+)
 create mode 100644 tools/spslr/src/pinpoint/final/final.h
 create mode 100644 tools/spslr/src/pinpoint/final/on_finish_unit.cpp
 create mode 100644 tools/spslr/src/pinpoint/pinpoint.cpp
 create mode 100644 tools/spslr/src/pinpoint/pinpoint_config.h
 create mode 100644 tools/spslr/src/pinpoint/pinpoint_error.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-attribs.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-diagnostic.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-gcc-plugin.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-gimple.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-input.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-langhooks.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-md5.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-output.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-plugin-version.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-rtl.h
 create mode 100644 tools/spslr/src/pinpoint/safegcc/safe-tree.h
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_finish_decl.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_finish_type.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_preserve_component_ref.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_register_attributes.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/on_start_unit.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/separate_offset_pass.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/separator.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage0/stage0.h
 create mode 100644 tools/spslr/src/pinpoint/stage0/target.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage1/asm_offset_pass.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage1/stage1.h
 create mode 100644 tools/spslr/src/pinpoint/stage2/rtl_pin_lower_pass.cpp
 create mode 100644 tools/spslr/src/pinpoint/stage2/stage2.h

diff --git a/tools/spslr/src/pinpoint/final/final.h b/tools/spslr/src/pinpoint/final/final.h
new file mode 100644
index 000000000000..11c8af5dd17d
--- /dev/null
+++ b/tools/spslr/src/pinpoint/final/final.h
@@ -0,0 +1,13 @@
+#pragma once
+
+void on_finish_unit(void *plugin_data, void *user_data);
+
+void set_output_file(const char *path);
+bool has_output_file();
+const char *get_output_file();
+
+bool init_src_file();
+const char *get_src_file();
+
+bool init_cu_hash();
+const char *get_cu_hash();
diff --git a/tools/spslr/src/pinpoint/final/on_finish_unit.cpp b/tools/spslr/src/pinpoint/final/on_finish_unit.cpp
new file mode 100644
index 000000000000..754921da9dc5
--- /dev/null
+++ b/tools/spslr/src/pinpoint/final/on_finish_unit.cpp
@@ -0,0 +1,190 @@
+#include <final.h>
+#include <stage0.h>
+#include <stage2.h>
+#include <string>
+#include <filesystem>
+#include <fstream>
+#include <unordered_set>
+
+#include <safe-input.h>
+#include <safe-output.h>
+#include <safe-md5.h>
+#include <pinpoint_config.h>
+#include <pinpoint_error.h>
+
+/*
+ * Finish-unit emits the per-compilation-unit `.spslr` metadata consumed by
+ * patchcompile.
+ *
+ * Only information that survived all earlier filtering should be dumped here:
+ * target layouts, data pins for static objects, and stage2 instruction pins
+ * whose immediates exist in the final object.
+ */
+
+static bool output_file_known = false;
+static std::string src_file, output_file, cu_hash;
+
+void set_output_file(const char *path)
+{
+	namespace fs = std::filesystem;
+
+	if (!path) {
+		output_file_known = false;
+		return;
+	}
+
+	output_file = fs::weakly_canonical(path).generic_string();
+	output_file_known = true;
+}
+
+bool has_output_file()
+{
+	return output_file_known;
+}
+
+const char *get_output_file()
+{
+	return output_file_known ? output_file.c_str() : nullptr;
+}
+
+bool init_src_file()
+{
+	namespace fs = std::filesystem;
+
+	if (!main_input_filename)
+		return false;
+
+	src_file = fs::weakly_canonical(fs::absolute(main_input_filename))
+			   .generic_string();
+	return true;
+}
+
+const char *get_src_file()
+{
+	return src_file.c_str();
+}
+
+bool init_cu_hash()
+{
+	if (!has_output_file())
+		return false;
+
+	unsigned char md5_digest[16];
+	const char *s = get_output_file();
+	md5_buffer(s, strlen(s), md5_digest);
+
+	char md5_digest_hex[33] = {};
+	for (int i = 0; i < 16; i++)
+		sprintf(md5_digest_hex + i * 2, "%02x", md5_digest[i]);
+
+	cu_hash = std::string{ md5_digest_hex };
+	return true;
+}
+
+const char *get_cu_hash()
+{
+	return cu_hash.c_str();
+}
+
+static void emit_dpin_alias_labels()
+{
+	for (const DataPin &dpin : DataPin::all()) {
+		if (dpin.pin_symbol.empty() || dpin.symbol.empty())
+			pinpoint_fatal(
+				"emit_dpin_alias_labels got incomplete data pin");
+
+		fprintf(asm_out_file, ".globl %s\n", dpin.pin_symbol.c_str());
+		fprintf(asm_out_file, ".set %s, %s\n", dpin.pin_symbol.c_str(),
+			dpin.symbol.c_str());
+	}
+}
+
+static std::ofstream open_spslr_output_file()
+{
+	namespace fs = std::filesystem;
+
+	fs::path meta_path{ get_output_file() };
+	fs::create_directories(meta_path.parent_path());
+
+	pinpoint_debug(
+		"dumping metadata for source file '%s' (CU hash: %s) to '%s'",
+		get_src_file(), get_cu_hash(), get_output_file());
+
+	std::ofstream out(meta_path);
+	if (!out)
+		pinpoint_fatal(
+			"open_spslr_output_file failed to open spslr dump file");
+
+	return std::move(out);
+}
+
+void on_finish_unit(void *plugin_data, void *user_data)
+{
+	std::string cu_uid = get_cu_hash();
+
+	// Emit globally unique data pin label for each static object to be randomized
+
+	emit_dpin_alias_labels();
+
+	// Dump all accumulated data to spslr file
+
+	std::ofstream out = open_spslr_output_file();
+
+	// Header associates data with compilation unit
+
+	out << "SPSLR " << get_src_file() << " " << cu_uid << std::endl;
+
+	// Construct set of all targets that are used by at least 1 ipin or dpin
+
+	std::unordered_set<UID> used_targets;
+
+	for (const DataPin &dpin : DataPin::all()) {
+		for (const DataPin::Component &c : dpin.components)
+			used_targets.insert(c.target);
+	}
+
+	for (const auto &[uid, ipin] : s2_pins())
+		used_targets.insert(ipin.target);
+
+	// Dump all USED target structs
+
+	for (const auto &[uid, target] : TargetType::all()) {
+		if (used_targets.find(uid) == used_targets.end())
+			continue;
+
+		// target <name> <local uid> <size> <field count>
+		out << "target " << target.name() << " " << uid << " "
+		    << target.size() << " " << target.fields().size()
+		    << std::endl;
+
+		if (!target.has_fields())
+			pinpoint_fatal(
+				"on_finish_unit encountered incomplete target type");
+
+		for (const auto &[off, field] : target.fields()) {
+			// f <offset> <size> <alignment> <flags>
+			out << "f " << field.offset << " " << field.size << " "
+			    << field.alignment << " " << field.flags
+			    << std::endl;
+		}
+	}
+
+	// Dump all data pins
+
+	for (const DataPin &dpin : DataPin::all()) {
+		for (const DataPin::Component &c : dpin.components) {
+			// dpin <symbol> <offset> <level> <target uid>
+			out << "dpin " << " " << dpin.pin_symbol << " "
+			    << c.offset << " " << c.level << " " << c.target
+			    << std::endl;
+		}
+	}
+
+	// Dump all instruction pins
+
+	for (const auto &[uid, ipin] : s2_pins()) {
+		// ipin <symbol> <target uid> <field offset> <immediate size>
+		out << "ipin " << ipin.symbol << " " << ipin.target << " "
+		    << ipin.offset << " " << ipin.imm_size << std::endl;
+	}
+}
diff --git a/tools/spslr/src/pinpoint/pinpoint.cpp b/tools/spslr/src/pinpoint/pinpoint.cpp
new file mode 100644
index 000000000000..13b77840c834
--- /dev/null
+++ b/tools/spslr/src/pinpoint/pinpoint.cpp
@@ -0,0 +1,128 @@
+#include <safe-gcc-plugin.h>
+#include <safe-plugin-version.h>
+#include <filesystem>
+#include <string>
+
+#include <stage0.h>
+#include <stage1.h>
+#include <stage2.h>
+#include <final.h>
+
+#include <pinpoint_error.h>
+
+int plugin_is_GPL_compatible;
+
+bool pinpoint_verbose_enabled;
+
+static const char *srcroot = nullptr;
+static const char *metadir = nullptr;
+static std::string computed_output_file; /* Must remain alive */
+
+static void set_legacy_output_file(void)
+{
+	if (has_output_file())
+		return;
+
+	if (!srcroot || !metadir)
+		return;
+
+	std::filesystem::path src = main_input_filename;
+	std::filesystem::path root = srcroot;
+
+	std::filesystem::path rel = std::filesystem::relative(src, root);
+	std::filesystem::path out = std::filesystem::path(metadir) / rel;
+
+	out += ".spslr";
+
+	computed_output_file = out.string();
+	set_output_file(computed_output_file.c_str());
+}
+
+int plugin_init(struct plugin_name_args *plugin_info,
+		struct plugin_gcc_version *version)
+{
+	if (!plugin_default_version_check(version, &gcc_version)) {
+		plugin_print_early_error(
+			"incompatible GCC/plugin versions: plugin built for GCC %s, loaded by GCC %s",
+			gcc_version.basever, version->basever);
+		return 1;
+	}
+
+	pinpoint_verbose_enabled = false;
+
+	for (int i = 0; i < plugin_info->argc; ++i) {
+		if (!strcmp(plugin_info->argv[i].key, "out")) {
+			set_output_file(plugin_info->argv[i].value);
+		} else if (!strcmp(plugin_info->argv[i].key, "metadir")) {
+			metadir = plugin_info->argv[i].value;
+		} else if (!strcmp(plugin_info->argv[i].key, "srcroot")) {
+			srcroot = plugin_info->argv[i].value;
+		} else if (!strcmp(plugin_info->argv[i].key, "verbose")) {
+			pinpoint_verbose_enabled = true;
+		}
+	}
+
+	set_legacy_output_file();
+
+	if (!has_output_file()) {
+		plugin_print_early_error(
+			"missing output file argument: use either out=<file> or metadir=<dir> plus srcroot=<dir>");
+		return 1;
+	}
+
+	/*
+	 * Pinpoint runs as a staged GCC plugin because no single GCC IR level has
+	 * all information SPSLR needs.
+	 *
+	 * Stage 0 runs while COMPONENT_REF trees are built or still available and records
+	 * which structure field offsets are randomization-sensitive.
+	 *
+	 * Stage 1 replaces synthetic separator calls with asm markers so GCC keeps
+	 * the offset value as a real data dependency through later optimization.
+	 *
+	 * Stage 2 runs on final RTL and lowers those markers into concrete architecture-specific
+	 * instructions whose immediate operands are labeled for runtime patching.
+	 *
+	 * The final callback emits the collected metadata for patchcompile.
+	 */
+
+	register_callback(plugin_info->base_name, PLUGIN_START_UNIT,
+			  on_start_unit, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_ATTRIBUTES,
+			  on_register_attributes, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_TYPE,
+			  on_finish_type, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_BUILD_COMPONENT_REF,
+			  on_preserve_component_ref, NULL);
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_DECL,
+			  on_finish_decl, NULL);
+
+	struct register_pass_info separate_offset_pass_info;
+	separate_offset_pass_info.pass = new separate_offset_pass(nullptr);
+	separate_offset_pass_info.ref_pass_instance_number = 1;
+	separate_offset_pass_info.reference_pass_name = "cfg";
+	separate_offset_pass_info.pos_op = PASS_POS_INSERT_AFTER;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &separate_offset_pass_info);
+
+	struct register_pass_info asm_offset_pass_info;
+	asm_offset_pass_info.pass = new asm_offset_pass(nullptr);
+	asm_offset_pass_info.ref_pass_instance_number = 1;
+	asm_offset_pass_info.reference_pass_name = "separate_offset";
+	asm_offset_pass_info.pos_op = PASS_POS_INSERT_AFTER;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &asm_offset_pass_info);
+
+	struct register_pass_info rtl_pin_lower_pass_info;
+	rtl_pin_lower_pass_info.pass = new rtl_pin_lower_pass(nullptr);
+	rtl_pin_lower_pass_info.ref_pass_instance_number = 1;
+	rtl_pin_lower_pass_info.reference_pass_name = "final";
+	rtl_pin_lower_pass_info.pos_op = PASS_POS_INSERT_BEFORE;
+	register_callback(plugin_info->base_name, PLUGIN_PASS_MANAGER_SETUP,
+			  nullptr, &rtl_pin_lower_pass_info);
+
+	register_callback(plugin_info->base_name, PLUGIN_FINISH_UNIT,
+			  on_finish_unit, NULL);
+
+	return 0;
+}
diff --git a/tools/spslr/src/pinpoint/pinpoint_config.h b/tools/spslr/src/pinpoint/pinpoint_config.h
new file mode 100644
index 000000000000..0d590e30e21d
--- /dev/null
+++ b/tools/spslr/src/pinpoint/pinpoint_config.h
@@ -0,0 +1,9 @@
+#pragma once
+
+#define SPSLR_ATTRIBUTE "spslr"
+#define SPSLR_FIELD_FIXED_ATTRIBUTE "spslr_field_fixed"
+#define SPSLR_PINPOINT_STAGE0_SEPARATOR "__spslr_offsetof"
+#define SPSLR_PINFILE_EXTENSION ".spslr"
+#define SPSLR_PINPOINT_STAGE2_PIN \
+	"__spslr_ipin_" /* suffixed with "<cuhash>_<uid>" */
+#define SPSLR_PINPOINT_DPIN "__spslr_dpin_" /* suffixed with "<cuhash>_<uid>" */
diff --git a/tools/spslr/src/pinpoint/pinpoint_error.h b/tools/spslr/src/pinpoint/pinpoint_error.h
new file mode 100644
index 000000000000..3c8c994effc2
--- /dev/null
+++ b/tools/spslr/src/pinpoint/pinpoint_error.h
@@ -0,0 +1,27 @@
+#pragma once
+
+#include <cstdio>
+#include <safe-diagnostic.h>
+
+extern bool pinpoint_verbose_enabled;
+
+#define plugin_print_early_error(fmt, ...)                                \
+	do {                                                              \
+		std::fprintf(stderr, "[spslr::pinpoint] error: " fmt "\n", \
+			     ##__VA_ARGS__);                              \
+	} while (0)
+
+#define pinpoint_debug_loc(loc, fmt, ...)                                      \
+	do {                                                                   \
+		if (pinpoint_verbose_enabled)                                  \
+			inform((loc), "[spslr::pinpoint] " fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#define pinpoint_debug(fmt, ...) \
+	pinpoint_debug_loc(UNKNOWN_LOCATION, fmt, ##__VA_ARGS__)
+
+#define pinpoint_fatal_loc(loc, fmt, ...) \
+	fatal_error((loc), "[spslr::pinpoint] " fmt, ##__VA_ARGS__)
+
+#define pinpoint_fatal(fmt, ...) \
+	pinpoint_fatal_loc(UNKNOWN_LOCATION, fmt, ##__VA_ARGS__)
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-attribs.h b/tools/spslr/src/pinpoint/safegcc/safe-attribs.h
new file mode 100644
index 000000000000..0881abc2598d
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-attribs.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_ATTRIBS_H
+#define SAFEGCC_ATTRIBS_H
+
+#include <attribs.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-diagnostic.h b/tools/spslr/src/pinpoint/safegcc/safe-diagnostic.h
new file mode 100644
index 000000000000..3577020c880b
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-diagnostic.h
@@ -0,0 +1,9 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_DIAGNOSTIC_H
+#define SAFEGCC_DIAGNOSTIC_H
+
+#include <diagnostic.h>
+#include <diagnostic-core.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-gcc-plugin.h b/tools/spslr/src/pinpoint/safegcc/safe-gcc-plugin.h
new file mode 100644
index 000000000000..fcd111636a1c
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-gcc-plugin.h
@@ -0,0 +1,6 @@
+#ifndef SAFEGCC_GCC_PLUGIN_H
+#define SAFEGCC_GCC_PLUGIN_H
+
+#include <gcc-plugin.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-gimple.h b/tools/spslr/src/pinpoint/safegcc/safe-gimple.h
new file mode 100644
index 000000000000..20d7edd8eb5c
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-gimple.h
@@ -0,0 +1,13 @@
+#include <safe-gcc-plugin.h>
+#include <safe-tree.h>
+
+#ifndef SAFEGCC_GIMPLE_H
+#define SAFEGCC_GIMPLE_H
+
+#include <gimple.h>
+#include <gimplify.h>
+#include <gimple-iterator.h>
+#include <gimple-pretty-print.h>
+#include <ssa.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-input.h b/tools/spslr/src/pinpoint/safegcc/safe-input.h
new file mode 100644
index 000000000000..fe24435830fe
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-input.h
@@ -0,0 +1,9 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_INPUT_H
+#define SAFEGCC_INPUT_H
+
+#include <input.h>
+#include <libiberty.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-langhooks.h b/tools/spslr/src/pinpoint/safegcc/safe-langhooks.h
new file mode 100644
index 000000000000..3fbea6ccb579
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-langhooks.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_LANGHOOKS_H
+#define SAFEGCC_LANGHOOKS_H
+
+#include <langhooks.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-md5.h b/tools/spslr/src/pinpoint/safegcc/safe-md5.h
new file mode 100644
index 000000000000..8341cb193467
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-md5.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_MD5_H
+#define SAFEGCC_MD5_H
+
+#include <md5.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-output.h b/tools/spslr/src/pinpoint/safegcc/safe-output.h
new file mode 100644
index 000000000000..5da7fec494be
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-output.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_OUTPUT_H
+#define SAFEGCC_OUTPUT_H
+
+#include <output.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-plugin-version.h b/tools/spslr/src/pinpoint/safegcc/safe-plugin-version.h
new file mode 100644
index 000000000000..e43a1689da8c
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-plugin-version.h
@@ -0,0 +1,8 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_PLUGIN_VERSION_H
+#define SAFEGCC_PLUGIN_VERSION_H
+
+#include <plugin-version.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-rtl.h b/tools/spslr/src/pinpoint/safegcc/safe-rtl.h
new file mode 100644
index 000000000000..f89decdb1d18
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-rtl.h
@@ -0,0 +1,17 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_RTL_H
+#define SAFEGCC_RTL_H
+
+#include <rtl.h>
+#include <rtl-iter.h>
+#include <memmodel.h>
+#include <emit-rtl.h>
+#include <function.h>
+#include <expr.h>
+#include <hard-reg-set.h>
+
+#undef toupper
+#undef tolower
+
+#endif
diff --git a/tools/spslr/src/pinpoint/safegcc/safe-tree.h b/tools/spslr/src/pinpoint/safegcc/safe-tree.h
new file mode 100644
index 000000000000..b2c0625bb1aa
--- /dev/null
+++ b/tools/spslr/src/pinpoint/safegcc/safe-tree.h
@@ -0,0 +1,9 @@
+#include <safe-gcc-plugin.h>
+
+#ifndef SAFEGCC_TREE_H
+#define SAFEGCC_TREE_H
+
+#include <tree.h>
+#include <tree-pass.h>
+
+#endif
diff --git a/tools/spslr/src/pinpoint/stage0/on_finish_decl.cpp b/tools/spslr/src/pinpoint/stage0/on_finish_decl.cpp
new file mode 100644
index 000000000000..871ba5da070d
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/on_finish_decl.cpp
@@ -0,0 +1,216 @@
+#include <stage0.h>
+#include <final.h>
+
+#include <unordered_set>
+#include <string>
+
+#include <pinpoint_error.h>
+#include <pinpoint_config.h>
+
+static UID next_dpin_uid = 0;
+static std::list<DataPin> pins;
+static std::unordered_set<std::string> seen_dpin_symbols;
+
+void DataPin::reset()
+{
+	pins.clear();
+	next_dpin_uid = 0;
+}
+
+const std::list<DataPin> &DataPin::all()
+{
+	return pins;
+}
+
+static std::string make_dpin_symbol()
+{
+	return std::string(SPSLR_PINPOINT_DPIN) + std::string(get_cu_hash()) +
+	       "_" + std::to_string(next_dpin_uid++);
+}
+
+static std::list<DataPin::Component>
+compile_datapin_record_components(tree type);
+static std::list<DataPin::Component>
+compile_datapin_array_components(tree type);
+
+/*
+ * Build the list of randomized objects contained in a static object.
+ *
+ * A dpin may describe the object itself, nested target structs, arrays of
+ * targets, or targets embedded inside non-target containers. The level field
+ * records nesting depth so patchcompile/runtime can patch inner objects before
+ * their containing objects.
+ */
+
+static std::list<DataPin::Component> compile_datapin_components(tree type)
+{
+	std::list<DataPin::Component> components;
+
+	const TargetType *relevant = TargetType::find(type);
+	if (relevant) {
+		components.push_back(DataPin::Component{
+			.offset = 0, .level = 0, .target = relevant->uid() });
+	}
+
+	std::list<DataPin::Component> sub_components;
+	if (TREE_CODE(type) == RECORD_TYPE) {
+		sub_components = compile_datapin_record_components(type);
+	} else if (TREE_CODE(type) == ARRAY_TYPE) {
+		sub_components = compile_datapin_array_components(type);
+	}
+
+	for (const DataPin::Component &sc : sub_components) {
+		components.push_back(DataPin::Component{ .offset = sc.offset,
+							 .level = sc.level + 1,
+							 .target = sc.target });
+	}
+
+	// Note -> should probably make sure that randomized structs are never used in unions!
+	return components;
+}
+
+std::list<DataPin::Component> compile_datapin_record_components(tree type)
+{
+	std::list<DataPin::Component> components;
+
+	if (TREE_CODE(type) != RECORD_TYPE)
+		return components;
+
+	if (!COMPLETE_TYPE_P(type))
+		return components;
+
+	for (tree field = TYPE_FIELDS(type); field; field = TREE_CHAIN(field)) {
+		if (TREE_CODE(field) != FIELD_DECL)
+			continue;
+
+		std::size_t field_offset;
+		bool field_bitfield;
+
+		if (!field_info(field, &field_offset, nullptr, nullptr,
+				&field_bitfield)) {
+			// pinpoint_fatal("compile_datapin_record_components failed to get field info");
+			continue; // NOTE -> Happens e.g. on trailing arrays of dynamic size (allowed only in non-target structs)
+		}
+
+		if (field_bitfield)
+			continue;
+
+		tree field_type = TREE_TYPE(field);
+
+		std::list<DataPin::Component> field_components =
+			compile_datapin_components(field_type);
+		for (const DataPin::Component &fc : field_components) {
+			components.push_back(DataPin::Component{
+				.offset = field_offset + fc.offset,
+				.level = fc.level,
+				.target = fc.target });
+		}
+	}
+
+	return components;
+}
+
+std::list<DataPin::Component> compile_datapin_array_components(tree type)
+{
+	std::list<DataPin::Component> components;
+
+	if (TREE_CODE(type) != ARRAY_TYPE)
+		return components;
+
+	tree elem_type = TREE_TYPE(type);
+	if (!elem_type)
+		return components;
+
+	std::list<DataPin::Component> elem_components =
+		compile_datapin_components(elem_type);
+	if (elem_components.empty())
+		return components;
+
+	tree domain = TYPE_DOMAIN(type);
+	if (!domain)
+		pinpoint_fatal(
+			"compile_datapin_array_components failed to get domain for relevant element type");
+
+	tree min_t = TYPE_MIN_VALUE(domain);
+	tree max_t = TYPE_MAX_VALUE(domain);
+	if (!min_t || !max_t || TREE_CODE(min_t) != INTEGER_CST ||
+	    TREE_CODE(max_t) != INTEGER_CST)
+		pinpoint_fatal(
+			"compile_datapin_array_components failed to get array dimensions for relevant element type");
+
+	HOST_WIDE_INT min_i = tree_to_shwi(min_t);
+	HOST_WIDE_INT max_i = tree_to_shwi(max_t);
+
+	tree elem_size_t = TYPE_SIZE_UNIT(elem_type);
+	if (!elem_size_t || TREE_CODE(elem_size_t) != INTEGER_CST)
+		pinpoint_fatal(
+			"compile_datapin_array_components failed to get constant element size for relevant element type");
+
+	std::size_t elem_size = tree_to_uhwi(elem_size_t);
+
+	for (HOST_WIDE_INT i = min_i; i <= max_i; ++i) {
+		std::size_t element_offset =
+			(std::size_t)(i - min_i) * elem_size;
+
+		for (const DataPin::Component &ec : elem_components) {
+			components.push_back(DataPin::Component{
+				.offset = element_offset + ec.offset,
+				.level = ec.level,
+				.target = ec.target });
+		}
+	}
+
+	return components;
+}
+
+static bool compile_datapin(tree type, DataPin &pin)
+{
+	pin.components = compile_datapin_components(type);
+	return !pin.components.empty();
+}
+
+static void on_static_var(tree var)
+{
+	tree type = TREE_TYPE(var);
+	if (!type)
+		return;
+
+	tree symbol_tree = DECL_ASSEMBLER_NAME(var);
+	const char *symbol;
+	if (!symbol_tree || !(symbol = IDENTIFIER_POINTER(symbol_tree)))
+		pinpoint_fatal(
+			"on_static_var failed to get symbol of static variable");
+
+	std::string sym{ symbol };
+
+	/*
+	 * Multiple VAR_DECLs can name the same emitted object, for example through
+	 * export or alias machinery. Emit at most one dpin per assembler symbol.
+	 */
+	if (!seen_dpin_symbols.insert(sym).second)
+		return;
+
+	DataPin pin;
+	if (!compile_datapin(type, pin))
+		return;
+
+	DECL_PRESERVE_P(var) = 1;
+	// pin.global = static_cast<bool>(TREE_PUBLIC(var));
+
+	pin.symbol = sym;
+	pin.pin_symbol = make_dpin_symbol();
+	pins.emplace_back(std::move(pin));
+}
+
+void on_finish_decl(void *plugin_data, void *user_data)
+{
+	tree decl = (tree)plugin_data;
+
+	if (TREE_CODE(decl) != VAR_DECL)
+		return;
+
+	if (!TREE_STATIC(decl) || DECL_EXTERNAL(decl))
+		return;
+
+	on_static_var(decl);
+}
diff --git a/tools/spslr/src/pinpoint/stage0/on_finish_type.cpp b/tools/spslr/src/pinpoint/stage0/on_finish_type.cpp
new file mode 100644
index 000000000000..f2459be7242c
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/on_finish_type.cpp
@@ -0,0 +1,16 @@
+#include <stage0.h>
+#include <pinpoint_error.h>
+
+void on_finish_type(void *plugin_data, void *user_data)
+{
+	tree t = (tree)plugin_data;
+
+	TargetType *type = TargetType::find_mutable(t);
+	if (!type)
+		return;
+
+	if (!type->fetch_fields())
+		pinpoint_fatal(
+			"on_finish_type failed to fetch fields of target \"%s\"",
+			type->name().c_str());
+}
diff --git a/tools/spslr/src/pinpoint/stage0/on_preserve_component_ref.cpp b/tools/spslr/src/pinpoint/stage0/on_preserve_component_ref.cpp
new file mode 100644
index 000000000000..f02d49fbe218
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/on_preserve_component_ref.cpp
@@ -0,0 +1,58 @@
+#include <stage0.h>
+#include <pinpoint_error.h>
+
+/*
+ * Preserve an early COMPONENT_REF before GCC folds it into a plain constant
+ * offset.
+ *
+ * The custom GCC hook calls this while the frontend still knows that an
+ * expression is "base.field". We rewrite it into pointer arithmetic whose
+ * offset comes from a synthetic separator call:
+ *
+ *     base.field  ->  *(typeof(field) *)((char *)&base + separator(target, off))
+ *
+ * Later passes replace the separator with an instruction pin.
+ */
+
+static tree ast_separate_offset(tree ref, UID target, std::size_t offset)
+{
+	tree separator = make_stage0_ast_separator(target, offset);
+	if (!separator)
+		pinpoint_fatal(
+			"ast_separate_offset failed to generate AST separator for target %u at offset %u",
+			(unsigned)target, (unsigned)offset);
+
+	tree base = TREE_OPERAND(ref, 0);
+
+	// ADDR_EXPR can never be a valid base, but such trees can happen during parsing before checks
+	if (TREE_CODE(base) == ADDR_EXPR)
+		pinpoint_fatal(
+			"ast_separate_offset encountered ADDR_EXPR as COMPONENT_REF base");
+
+	tree base_ptr = build_fold_addr_expr(base);
+
+	tree field_type = TREE_TYPE(
+		ref); // Type of COMPONENT_REF is type of the accessed field
+	tree field_ptr_type = build_pointer_type(field_type);
+	tree field_ptr =
+		build2(POINTER_PLUS_EXPR, field_ptr_type, base_ptr, separator);
+
+	tree field_ref = build1(INDIRECT_REF, field_type, field_ptr);
+	return field_ref;
+}
+
+void on_preserve_component_ref(void *plugin_data, void *user_data)
+{
+	tree *ref = (tree *)plugin_data;
+	if (!ref)
+		return;
+
+	UID target;
+	std::size_t offset;
+	if (!TargetType::reference(*ref, target, offset))
+		return;
+
+	tree separated = ast_separate_offset(*ref, target, offset);
+	if (separated)
+		*ref = separated;
+}
diff --git a/tools/spslr/src/pinpoint/stage0/on_register_attributes.cpp b/tools/spslr/src/pinpoint/stage0/on_register_attributes.cpp
new file mode 100644
index 000000000000..7720d18022e3
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/on_register_attributes.cpp
@@ -0,0 +1,52 @@
+#include <stage0.h>
+#include <pinpoint_config.h>
+#include <cstdio>
+
+static tree log_new_target(tree *node, tree name, tree args, int flags,
+			   bool *no_add_attrs)
+{
+	if (node)
+		TargetType::add(*node);
+
+	return NULL_TREE;
+}
+
+static tree check_field_fixed_attribute(tree *node, tree name, tree args,
+					int flags, bool *no_add_attrs)
+{
+	if (!node || !*node || TREE_CODE(*node) != FIELD_DECL) {
+		*no_add_attrs = true;
+		fprintf(stderr,
+			"%qs attribute only applies to struct/union fields",
+			SPSLR_FIELD_FIXED_ATTRIBUTE);
+	}
+	return NULL_TREE;
+}
+
+/*
+ * __attribute__((spslr)) marks a record type as a randomization target.
+ * The attribute only registers the type here; fields are fetched later once
+ * GCC has completed the type.
+ */
+
+static struct attribute_spec spslr_attribute = {
+	SPSLR_ATTRIBUTE, 0, 0, false, false, false, false, log_new_target, NULL
+};
+
+/*
+ * __attribute__((spslr_field_fixed)) marks a field as layout-sensitive.
+ * Fixed fields remain part of the target, but are treated as dangerous so
+ * instruction/data pins are not generated for offsets that would become
+ * ambiguous after randomization.
+ */
+
+static struct attribute_spec spslr_fixed_field_attribute = {
+	SPSLR_FIELD_FIXED_ATTRIBUTE, 0,	  0, false, false, false, false,
+	check_field_fixed_attribute, NULL
+};
+
+void on_register_attributes(void *plugin_data, void *user_data)
+{
+	register_attribute(&spslr_attribute);
+	register_attribute(&spslr_fixed_field_attribute);
+}
diff --git a/tools/spslr/src/pinpoint/stage0/on_start_unit.cpp b/tools/spslr/src/pinpoint/stage0/on_start_unit.cpp
new file mode 100644
index 000000000000..a677557b330d
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/on_start_unit.cpp
@@ -0,0 +1,19 @@
+#include <stage0.h>
+#include <stage1.h>
+#include <stage2.h>
+#include <final.h>
+
+#include <pinpoint_error.h>
+
+void on_start_unit(void *plugin_data, void *user_data)
+{
+	TargetType::reset();
+	DataPin::reset();
+	s2_pins_reset();
+
+	if (!init_src_file())
+		pinpoint_fatal("failed to get source file name");
+
+	if (!init_cu_hash())
+		pinpoint_fatal("failed to initialize CU hash");
+}
diff --git a/tools/spslr/src/pinpoint/stage0/separate_offset_pass.cpp b/tools/spslr/src/pinpoint/stage0/separate_offset_pass.cpp
new file mode 100644
index 000000000000..6c9236705a6b
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/separate_offset_pass.cpp
@@ -0,0 +1,315 @@
+#include <stage0.h>
+#include <functional>
+#include <list>
+
+#include <pinpoint_error.h>
+
+/*
+ * AccessChain flattens nested COMPONENT_REF / ARRAY_REF expressions from
+ * outer base to inner access.
+ *
+ * This lets the pass rebuild the expression one step at a time while replacing
+ * only SPSLR-relevant field offsets with separator calls. Non-target offsets
+ * stay as ordinary constant pointer arithmetic.
+ */
+
+struct AccessChain {
+	struct Step {
+		enum Kind { STEP_COMPONENT, STEP_ARRAY } kind = STEP_COMPONENT;
+
+		tree t = NULL_TREE;
+
+		/* COMPONENT_REF data */
+		bool relevant = false;
+		UID target = UID_INVALID;
+		std::size_t offset = 0;
+	};
+
+	bool relevant = false;
+	std::list<Step> steps;
+	tree base = NULL_TREE;
+};
+
+static tree walk_tree_contains_component_ref(tree *tp, int *walk_subtrees,
+					     void *data)
+{
+	int *found_flag = (int *)data;
+
+	if (!tp || !*tp)
+		return NULL_TREE;
+
+	if (TREE_CODE(*tp) == COMPONENT_REF)
+		*found_flag = 1;
+
+	return NULL_TREE;
+}
+
+static bool tree_contains_component_ref(tree ref)
+{
+	int found_flag = 0;
+	walk_tree(&ref, walk_tree_contains_component_ref, &found_flag, NULL);
+	return found_flag != 0;
+}
+
+static bool access_chain(tree ref, AccessChain &chain)
+{
+	if (!ref)
+		return false;
+
+	switch (TREE_CODE(ref)) {
+	case COMPONENT_REF: {
+		AccessChain::Step step;
+		step.kind = AccessChain::Step::STEP_COMPONENT;
+		step.t = ref;
+		step.relevant =
+			TargetType::reference(ref, step.target, step.offset);
+		if (step.relevant)
+			chain.relevant = true;
+		chain.steps.push_front(step);
+		return access_chain(TREE_OPERAND(ref, 0), chain);
+	}
+
+	case ARRAY_REF:
+	case ARRAY_RANGE_REF: {
+		AccessChain::Step step;
+		step.kind = AccessChain::Step::STEP_ARRAY;
+		step.t = ref;
+		chain.steps.push_front(step);
+		return access_chain(TREE_OPERAND(ref, 0), chain);
+	}
+
+	default:
+		if (tree_contains_component_ref(ref))
+			return false;
+		chain.base = ref;
+		return true;
+	}
+}
+
+/*
+ * Rewrite a relevant field-access chain into explicit pointer arithmetic.
+ *
+ * The resulting MEM_REF has offset zero; all interesting byte offsets have
+ * either become separator calls or fixed constants. This makes the later asm
+ * marker pass independent of GCC's original COMPONENT_REF tree shape.
+ */
+
+static tree separate_offset_chain_maybe(tree ref, gimple_stmt_iterator *gsi)
+{
+	AccessChain chain;
+	if (!access_chain(ref, chain)) {
+		pinpoint_fatal(
+			"separate_offset_chain_maybe encountered invalid access chain: top=%s base=%s",
+			get_tree_code_name(TREE_CODE(ref)),
+			TREE_OPERAND(ref, 0) ? get_tree_code_name(TREE_CODE(
+						       TREE_OPERAND(ref, 0))) :
+					       "<null>");
+	}
+
+	if (!chain.relevant)
+		return NULL_TREE;
+
+	tree cur_expr = chain.base;
+
+	// NOTE -> Could fold into single call here (needs to track what offsets contribute, +irrelevant combined)
+
+	for (const AccessChain::Step &step : chain.steps) {
+		if (step.kind == AccessChain::Step::STEP_COMPONENT) {
+			if (TREE_CODE(cur_expr) == ADDR_EXPR)
+				pinpoint_fatal(
+					"separate_offset_chain_maybe encountered ADDR_EXPR as base of COMPONENT_REF");
+
+			tree cur_ptr = build_fold_addr_expr(cur_expr);
+
+			tree field_ptr_type =
+				build_pointer_type(TREE_TYPE(step.t));
+			tree field_ptr;
+
+			if (step.relevant) {
+				tree return_tmp =
+					create_tmp_var(size_type_node, NULL);
+				gimple *call_stmt = make_stage0_gimple_separator(
+					return_tmp, step.target, step.offset);
+				if (!call_stmt)
+					pinpoint_fatal(
+						"separate_offset_chain_maybe failed to make gimple separator");
+
+				gsi_insert_before(gsi, call_stmt,
+						  GSI_SAME_STMT);
+				field_ptr = build2(POINTER_PLUS_EXPR,
+						   field_ptr_type, cur_ptr,
+						   return_tmp);
+			} else {
+				tree field_decl = TREE_OPERAND(step.t, 1);
+
+				std::size_t field_offset;
+				bool field_bitfield;
+				if (!field_info(field_decl, &field_offset,
+						nullptr, nullptr,
+						&field_bitfield))
+					pinpoint_fatal(
+						"separate_offset_chain_maybe failed to get field info of non-target access");
+				if (field_bitfield)
+					pinpoint_fatal(
+						"separate_offset_chain_maybe encountered bitfield access in relevant COMPONENT_REF chain");
+
+				field_ptr = build2(POINTER_PLUS_EXPR,
+						   field_ptr_type, cur_ptr,
+						   build_int_cst(sizetype,
+								 field_offset));
+			}
+
+			tree ptr_tmp = create_tmp_var(field_ptr_type, NULL);
+			gimple *ptr_assign =
+				gimple_build_assign(ptr_tmp, field_ptr);
+			gsi_insert_before(gsi, ptr_assign, GSI_SAME_STMT);
+
+			// Dereference constructed pointer expression
+
+			tree offset0 = fold_convert(TREE_TYPE(ptr_tmp),
+						    build_int_cst(sizetype, 0));
+			cur_expr = build2(MEM_REF, TREE_TYPE(step.t), ptr_tmp,
+					  offset0);
+			continue;
+		}
+
+		if (step.kind == AccessChain::Step::STEP_ARRAY) {
+			tree idx = TREE_OPERAND(step.t, 1);
+			tree low = TREE_OPERAND(step.t, 2);
+			tree elts = TREE_OPERAND(step.t, 3);
+
+			cur_expr = build4(TREE_CODE(step.t), TREE_TYPE(step.t),
+					  cur_expr, idx, low, elts);
+			continue;
+		}
+	}
+
+	return cur_expr;
+}
+
+static void dispatch_separation_maybe(const std::list<tree *> &path,
+				      gimple_stmt_iterator *gsi,
+				      unsigned &cancel_levels)
+{
+	if (path.empty() || !gsi)
+		return;
+
+	tree ref = *path.back();
+	if (!ref || TREE_CODE(ref) != COMPONENT_REF)
+		return;
+
+	cancel_levels = 1;
+
+	tree instrumented_ref = separate_offset_chain_maybe(ref, gsi);
+	if (!instrumented_ref)
+		return;
+
+	gimple_set_modified(gsi_stmt(*gsi), true);
+	*path.back() = instrumented_ref;
+
+	// At this point, instrumented_ref is a MEM_REF node (off=0). A wrapping ADDR_EXPR cancels it out.
+
+	if (path.size() < 2)
+		return;
+
+	tree *parent = *(++path.rbegin());
+
+	if (TREE_CODE(*parent) == ADDR_EXPR) {
+		// Note -> the base of the MEM_REF is expected to have the same type as the ADDR_EXPR
+		*parent = TREE_OPERAND(instrumented_ref, 0);
+		cancel_levels++;
+	}
+}
+
+static const pass_data separate_offset_pass_data = {
+	GIMPLE_PASS, "separate_offset", OPTGROUP_NONE, TV_NONE, 0, 0, 0,
+	0,	     TODO_update_ssa
+};
+
+separate_offset_pass::separate_offset_pass(gcc::context *ctxt)
+	: gimple_opt_pass(separate_offset_pass_data, ctxt)
+{
+}
+
+struct TreeWalkData {
+	std::list<tree *> path;
+	gimple_stmt_iterator *gsi;
+	unsigned cancel_levels;
+	std::function<void(const std::list<tree *> &, gimple_stmt_iterator *,
+			   unsigned &)>
+		callback;
+};
+
+static tree walk_tree_level(tree *tp, int *walk_subtrees, void *data)
+{
+	TreeWalkData *twd = (TreeWalkData *)data;
+	if (!twd)
+		return NULL_TREE;
+
+	if (!twd->path.empty() && twd->path.back() == tp)
+		return NULL_TREE; // root of this level
+
+	if (walk_subtrees)
+		*walk_subtrees = 0;
+
+	twd->cancel_levels = 0;
+	twd->path.push_back(tp);
+
+	twd->callback(twd->path, twd->gsi, twd->cancel_levels);
+
+	if (twd->cancel_levels == 0)
+		walk_tree(tp, walk_tree_level, data, NULL);
+
+	twd->path.pop_back();
+
+	if (twd->cancel_levels > 0)
+		twd->cancel_levels--;
+
+	// Cancel current level if there are still cancel_levels due
+	return twd->cancel_levels == 0 ? NULL_TREE : *tp;
+}
+
+static bool
+walk_gimple_stmt(gimple_stmt_iterator *gsi,
+		 std::function<void(const std::list<tree *> &,
+				    gimple_stmt_iterator *, unsigned &)>
+			 callback)
+{
+	if (!gsi || gsi_end_p(*gsi) || !callback)
+		return false;
+
+	gimple *stmt = gsi_stmt(*gsi);
+
+	for (int i = 0; i < gimple_num_ops(stmt); i++) {
+		tree *op = gimple_op_ptr(stmt, i);
+		if (!op || !*op)
+			continue;
+
+		TreeWalkData twd;
+		twd.gsi = gsi;
+		twd.callback = callback;
+
+		walk_tree_level(op, NULL, &twd);
+	}
+
+	return true;
+}
+
+unsigned int separate_offset_pass::execute(function *fn)
+{
+	if (!fn)
+		return 0;
+
+	basic_block bb;
+	FOR_EACH_BB_FN(bb, fn)
+	{
+		for (gimple_stmt_iterator gsi = gsi_start_bb(bb);
+		     !gsi_end_p(gsi); gsi_next(&gsi)) {
+			if (!walk_gimple_stmt(&gsi, dispatch_separation_maybe))
+				pinpoint_fatal(
+					"separate_offset pass failed to walk gimple statement");
+		}
+	}
+
+	return 0;
+}
diff --git a/tools/spslr/src/pinpoint/stage0/separator.cpp b/tools/spslr/src/pinpoint/stage0/separator.cpp
new file mode 100644
index 000000000000..91f7838cf4e8
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/separator.cpp
@@ -0,0 +1,117 @@
+#include <stage0.h>
+#include <pinpoint_config.h>
+#include <pinpoint_error.h>
+
+static tree separator_decl = NULL_TREE;
+
+/*
+ * Stage0 separators are compiler-internal marker calls, not runtime calls.
+ *
+ * They carry two constants: target UID and original field offset. The call is
+ * declared pure/no-vops so GCC treats it as having no memory side effects; a
+ * later pinpoint pass must remove every separator before code generation.
+ */
+
+static tree make_separator_decl()
+{
+	if (separator_decl)
+		return separator_decl;
+
+	tree args = tree_cons(NULL_TREE, sizetype,
+			      tree_cons(NULL_TREE, sizetype, NULL_TREE));
+	tree type = build_function_type(sizetype, args);
+
+	tree tmp_decl = build_fn_decl(SPSLR_PINPOINT_STAGE0_SEPARATOR, type);
+	if (!tmp_decl)
+		return NULL_TREE;
+
+	DECL_EXTERNAL(tmp_decl) = 1;
+	TREE_PUBLIC(tmp_decl) = 1;
+	DECL_ARTIFICIAL(tmp_decl) = 1;
+
+	/* Prevent VOP problems later when removing calls (VOPs mark memory
+	   side-effects, which these calls have none of anyways */
+	DECL_PURE_P(tmp_decl) = 1;
+	DECL_IS_NOVOPS(tmp_decl) = 1;
+
+	return (separator_decl = tmp_decl);
+}
+
+tree make_stage0_ast_separator(UID target, std::size_t offset)
+{
+	tree decl = make_separator_decl();
+	if (!decl)
+		return NULL_TREE;
+
+	tree arg0 = size_int(target);
+	tree arg1 = size_int(offset);
+
+	if (!arg0 || !arg1)
+		return NULL_TREE;
+
+	return build_call_expr(decl, 2, arg0, arg1);
+}
+
+gimple *make_stage0_gimple_separator(tree lhs, UID target, std::size_t offset)
+{
+	if (!lhs)
+		return nullptr;
+
+	tree decl = make_separator_decl();
+	if (!decl)
+		return nullptr;
+
+	tree arg0 = size_int(target);
+	tree arg1 = size_int(offset);
+
+	if (!arg0 || !arg1)
+		return nullptr;
+
+	gimple *call = gimple_build_call(decl, 2, arg0, arg1);
+	if (!call)
+		return nullptr;
+
+	gimple_call_set_lhs(call, lhs);
+	return call;
+}
+
+static bool decl_is_separator(tree fndecl)
+{
+	if (!fndecl)
+		return false;
+
+	tree name_tree = DECL_NAME(fndecl);
+	if (!name_tree)
+		return false;
+
+	const char *name = IDENTIFIER_POINTER(name_tree);
+	if (!name)
+		return false;
+
+	return strcmp(name, SPSLR_PINPOINT_STAGE0_SEPARATOR) == 0;
+}
+
+bool is_stage0_separator(gimple *stmt, UID &target, std::size_t &offset)
+{
+	if (!stmt || !is_gimple_call(stmt))
+		return false;
+
+	tree fndecl = gimple_call_fndecl(stmt);
+	if (!decl_is_separator(fndecl))
+		return false;
+
+	tree arg0 = gimple_call_arg(stmt, 0);
+	tree arg1 = gimple_call_arg(stmt, 1);
+
+	if (!arg0 || TREE_CODE(arg0) != INTEGER_CST)
+		pinpoint_fatal(
+			"is_state0_separator failed to get target UID from separator");
+
+	if (!arg1 || TREE_CODE(arg1) != INTEGER_CST)
+		pinpoint_fatal(
+			"is_state0_separator failed to get field offset from separator");
+
+	target = static_cast<UID>(tree_to_uhwi(arg0));
+	offset = static_cast<std::size_t>(tree_to_uhwi(arg1));
+	return true;
+}
diff --git a/tools/spslr/src/pinpoint/stage0/stage0.h b/tools/spslr/src/pinpoint/stage0/stage0.h
new file mode 100644
index 000000000000..e9fb9447b4d0
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/stage0.h
@@ -0,0 +1,103 @@
+#pragma once
+#include <cstddef>
+#include <map>
+#include <unordered_map>
+#include <string>
+#include <list>
+#include <limits>
+
+#include <safe-tree.h>
+#include <safe-gimple.h>
+
+using UID = std::size_t;
+constexpr UID UID_INVALID = std::numeric_limits<UID>::max();
+
+class TargetType {
+    public:
+	struct Field {
+		static constexpr std::size_t FLAG_DANGEROUS = 1;
+
+		std::size_t offset;
+		std::size_t size;
+		std::size_t alignment;
+		std::size_t flags;
+	};
+
+    private:
+	static constexpr std::size_t FLAG_MAIN_VARIANT = 1;
+	static constexpr std::size_t FLAG_FIELDS = 2;
+
+	UID m_uid;
+	std::size_t m_flags;
+	tree m_main_variant;
+	std::size_t m_size;
+
+	// Fields are identified by their offsets
+	std::map<std::size_t, Field> m_fields;
+
+    public:
+	TargetType(const TargetType &other) = default;
+	TargetType &operator=(const TargetType &other) = default;
+	TargetType(TargetType &&other) = default;
+	TargetType &operator=(TargetType &&other) = default;
+
+	TargetType(tree t); // Does NOT fetch fields
+	~TargetType();
+
+	bool valid() const;
+	bool has_fields() const;
+	const std::map<std::size_t, Field> &fields() const;
+	std::string name() const;
+	const Field *field(std::size_t off, bool exact = true) const;
+	UID uid() const;
+	std::size_t size() const;
+
+	static void add(tree t);
+	static std::size_t count();
+	static const TargetType *find(tree t); // O(n)
+	static const TargetType *find(UID uid); // O(1)
+	static bool reference(tree ref, UID &target, std::size_t &offset);
+	static const std::unordered_map<UID, TargetType> &all();
+	static void reset();
+
+    private:
+	friend void on_finish_type(void *, void *);
+	bool fetch_fields(bool redo = false);
+	static TargetType *find_mutable(tree t);
+};
+
+bool field_info(tree field_decl, std::size_t *offset, std::size_t *size,
+		std::size_t *alignment, bool *bitfield);
+
+/* Stage 0 offsetof separators are function calls, such as:
+   SPSLR_PINPOINT_STAGE0_SEPARATOR(target, member offset) */
+
+tree make_stage0_ast_separator(UID target, std::size_t offset);
+gimple *make_stage0_gimple_separator(tree lhs, UID target, std::size_t offset);
+bool is_stage0_separator(gimple *stmt, UID &target, std::size_t &offset);
+
+struct DataPin {
+	struct Component {
+		std::size_t offset;
+		std::size_t level;
+		UID target;
+	};
+
+	std::string symbol; // potentially local object symbol
+	std::string pin_symbol; // global alias symbol
+	std::list<Component> components;
+
+	static void reset();
+	static const std::list<DataPin> &all();
+};
+
+void on_register_attributes(void *plugin_data, void *user_data);
+void on_finish_type(void *plugin_data, void *user_data);
+void on_preserve_component_ref(void *plugin_data, void *user_data);
+void on_finish_decl(void *plugin_data, void *user_data);
+void on_start_unit(void *plugin_data, void *user_data);
+
+struct separate_offset_pass : gimple_opt_pass {
+	separate_offset_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
diff --git a/tools/spslr/src/pinpoint/stage0/target.cpp b/tools/spslr/src/pinpoint/stage0/target.cpp
new file mode 100644
index 000000000000..7e40abf184f7
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage0/target.cpp
@@ -0,0 +1,411 @@
+#include <stage0.h>
+#include <functional>
+
+#include <safe-langhooks.h>
+#include <safe-attribs.h>
+
+#include <pinpoint_config.h>
+
+/*
+ * TargetType is the compiler-side model of an SPSLR-randomized record type.
+ *
+ * A target is keyed by GCC's main record variant, not by spelling alone, so
+ * typedefs and compatible variants resolve to the same SPSLR target. The UID
+ * is local to this compilation unit; patchcompile later merges compatible
+ * targets across objects.
+ */
+
+static UID next_uid = 0;
+static std::unordered_map<UID, TargetType> targets;
+
+static tree get_record_main_variant(tree t)
+{
+	if (!t || TREE_CODE(t) != RECORD_TYPE)
+		return NULL_TREE;
+
+	return TYPE_MAIN_VARIANT(t);
+}
+
+TargetType::TargetType(tree t)
+	: m_uid{ UID_INVALID }
+	, m_flags{ 0 }
+	, m_size{ 0 }
+{
+	if (!(m_main_variant = get_record_main_variant(t)))
+		return;
+
+	m_flags |= FLAG_MAIN_VARIANT;
+}
+
+TargetType::~TargetType()
+{
+}
+
+bool TargetType::valid() const
+{
+	return (m_flags & FLAG_MAIN_VARIANT) != 0;
+}
+
+bool TargetType::has_fields() const
+{
+	return (m_flags & FLAG_FIELDS) != 0;
+}
+
+const std::map<std::size_t, TargetType::Field> &TargetType::fields() const
+{
+	return m_fields;
+}
+
+std::string TargetType::name() const
+{
+	const char *error_name = "<error>";
+	const char *anonymous_name = "<anonymous>";
+
+	if (!valid())
+		return { error_name };
+
+	tree name_tree = TYPE_NAME(m_main_variant);
+	if (!name_tree)
+		return { anonymous_name };
+
+	if (TREE_CODE(name_tree) == TYPE_DECL && DECL_NAME(name_tree))
+		return { IDENTIFIER_POINTER(DECL_NAME(name_tree)) };
+	else if (TREE_CODE(name_tree) == IDENTIFIER_NODE)
+		return { IDENTIFIER_POINTER(name_tree) };
+
+	return { anonymous_name };
+}
+
+const TargetType::Field *TargetType::field(std::size_t off, bool exact) const
+{
+	if (!valid() || !(m_flags & FLAG_FIELDS))
+		return nullptr;
+
+	auto it = m_fields.upper_bound(off); // Next element
+	if (it == m_fields.begin())
+		return nullptr;
+
+	--it; // Element of interest
+
+	const TargetType::Field &maybe = it->second;
+
+	if (off >= maybe.offset + maybe.size)
+		return nullptr;
+
+	if (exact && maybe.offset != off)
+		return nullptr;
+
+	return &maybe;
+}
+
+UID TargetType::uid() const
+{
+	return m_uid;
+}
+
+std::size_t TargetType::size() const
+{
+	if (!valid() || !(m_flags & FLAG_FIELDS))
+		return 0;
+
+	return m_size;
+}
+
+void TargetType::add(tree t)
+{
+	if (find(t) != nullptr)
+		return;
+
+	TargetType tmp{ t };
+	if (!tmp.valid())
+		return;
+
+	tmp.m_uid = next_uid++;
+	targets.emplace(tmp.m_uid, tmp);
+}
+
+std::size_t TargetType::count()
+{
+	return targets.size();
+}
+
+const TargetType *TargetType::find(tree t)
+{
+	tree main_variant = get_record_main_variant(t);
+	if (!main_variant)
+		return nullptr;
+
+	for (const auto &[uid, target] : targets) {
+		if (lang_hooks.types_compatible_p(main_variant,
+						  target.m_main_variant))
+			return &target;
+	}
+
+	return nullptr;
+}
+
+TargetType *TargetType::find_mutable(tree t)
+{
+	tree main_variant = get_record_main_variant(t);
+	if (!main_variant)
+		return nullptr;
+
+	for (auto &[uid, target] : targets) {
+		if (lang_hooks.types_compatible_p(main_variant,
+						  target.m_main_variant))
+			return &target;
+	}
+
+	return nullptr;
+}
+
+const TargetType *TargetType::find(UID uid)
+{
+	auto it = targets.find(uid);
+	if (it == targets.end())
+		return nullptr;
+
+	return &it->second;
+}
+
+/*
+ * Convert GCC's byte + bit field layout into the byte-oriented layout model
+ * used by SPSLR metadata.
+ *
+ * Bitfields and sub-byte/overlapping storage are marked dangerous because the
+ * current runtime randomizer can only move independently addressable byte ranges.
+ */
+
+bool field_info(tree field_decl, std::size_t *offset, std::size_t *size,
+		std::size_t *alignment, bool *bitfield)
+{
+	if (!field_decl || TREE_CODE(field_decl) != FIELD_DECL)
+		return false;
+
+	tree field_off_t = DECL_FIELD_OFFSET(field_decl);
+	if (!field_off_t || TREE_CODE(field_off_t) != INTEGER_CST)
+		return false;
+
+	tree field_bit_off_t = DECL_FIELD_BIT_OFFSET(field_decl);
+	if (!field_bit_off_t || TREE_CODE(field_bit_off_t) != INTEGER_CST)
+		return false;
+
+	tree field_size_t = DECL_SIZE(field_decl);
+	if (!field_size_t || TREE_CODE(field_size_t) != INTEGER_CST)
+		return false;
+
+	HOST_WIDE_INT tmp_byte_offset = tree_to_uhwi(field_off_t);
+	HOST_WIDE_INT tmp_bit_offset = tree_to_uhwi(field_bit_off_t);
+	HOST_WIDE_INT tmp_bit_size = tree_to_uhwi(field_size_t);
+
+	HOST_WIDE_INT bit_offset_bytes = tmp_bit_offset / 8;
+	tmp_byte_offset += bit_offset_bytes;
+	tmp_bit_offset -= bit_offset_bytes * 8;
+
+	bool tmp_bitfield = (DECL_BIT_FIELD_TYPE(field_decl) != NULL_TREE);
+	tmp_bitfield |= !(tmp_bit_size % 8 == 0 && tmp_bit_offset == 0);
+
+	tmp_bit_size += tmp_bit_offset;
+
+	HOST_WIDE_INT tmp_bit_overhang = tmp_bit_size % 8;
+	if (tmp_bit_overhang != 0)
+		tmp_bit_size += (8 - tmp_bit_overhang);
+
+	HOST_WIDE_INT tmp_align_bits = DECL_ALIGN(field_decl);
+	if (tmp_align_bits <= 0 && TREE_TYPE(field_decl))
+		tmp_align_bits = TYPE_ALIGN(TREE_TYPE(field_decl));
+	if (tmp_align_bits <= 0)
+		tmp_align_bits = BITS_PER_UNIT;
+
+	std::size_t tmp_alignment = static_cast<std::size_t>(
+		(tmp_align_bits + BITS_PER_UNIT - 1) / BITS_PER_UNIT);
+	if (tmp_alignment == 0)
+		tmp_alignment = 1;
+
+	if (offset)
+		*offset = static_cast<std::size_t>(tmp_byte_offset);
+
+	if (size)
+		*size = static_cast<std::size_t>(tmp_bit_size / 8);
+
+	if (alignment)
+		*alignment = tmp_alignment;
+
+	if (bitfield)
+		*bitfield = tmp_bitfield;
+
+	return true;
+}
+
+bool TargetType::reference(tree ref, UID &target, std::size_t &offset)
+{
+	if (!ref || TREE_CODE(ref) != COMPONENT_REF)
+		return false;
+
+	tree base = TREE_OPERAND(ref, 0);
+	if (!base)
+		return false;
+
+	tree base_type = TREE_TYPE(base);
+	if (!base_type)
+		return false;
+
+	const TargetType *base_target = TargetType::find(base_type);
+	if (!base_target)
+		return false;
+
+	target = base_target->uid();
+
+	tree field_decl = TREE_OPERAND(ref, 1);
+
+	if (!field_info(field_decl, &offset, nullptr, nullptr, nullptr))
+		return false;
+
+	const Field *f = base_target->field(offset, false);
+	if (!f || (f->flags & Field::FLAG_DANGEROUS))
+		return false;
+
+	return true;
+}
+
+const std::unordered_map<UID, TargetType> &TargetType::all()
+{
+	return targets;
+}
+
+void TargetType::reset()
+{
+	targets.clear();
+	next_uid = 0;
+}
+
+static bool
+foreach_record_field(tree t,
+		     std::function<bool(const TargetType::Field &)> callback)
+{
+	if (!t || TREE_CODE(t) != RECORD_TYPE)
+		return false;
+
+	if (!COMPLETE_TYPE_P(t))
+		return false;
+
+	for (tree field_decl = TYPE_FIELDS(t); field_decl;
+	     field_decl = DECL_CHAIN(field_decl)) {
+		if (TREE_CODE(field_decl) != FIELD_DECL)
+			continue;
+
+		TargetType::Field field;
+		bool is_bitfield;
+
+		if (!field_info(field_decl, &field.offset, &field.size,
+				&field.alignment, &is_bitfield))
+			return false;
+
+		tree attrs = DECL_ATTRIBUTES(field_decl);
+		bool is_fixed = lookup_attribute(SPSLR_FIELD_FIXED_ATTRIBUTE,
+						 attrs) != NULL_TREE;
+
+		field.flags = ((is_fixed || is_bitfield) ?
+				       TargetType::Field::FLAG_DANGEROUS :
+				       0);
+
+		if (!callback(field))
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Merge overlapping fields into one dangerous region.
+ *
+ * GCC can expose fields that overlap through bitfields, zero-sized members,
+ * padding-sensitive constructs, or frontend-specific layout artifacts. SPSLR
+ * keeps the containing byte range fixed rather than pretending those pieces
+ * can be randomized independently.
+ */
+
+static bool field_map_add(std::map<std::size_t, TargetType::Field> &map,
+			  const TargetType::Field &field)
+{
+	TargetType::Field tmp_field;
+	tmp_field.offset = field.offset;
+	tmp_field.size = (field.size == 0 ? 1 : field.size);
+	tmp_field.alignment = (field.alignment == 0 ? 1 : field.alignment);
+	tmp_field.flags =
+		(field.size == 0 ? TargetType::Field::FLAG_DANGEROUS : 0) |
+		field.flags;
+
+	// Overlaps are dangerous -> remove and integrate into member
+	auto overlap_end = map.lower_bound(tmp_field.offset + tmp_field.size);
+	for (auto it = std::make_reverse_iterator(overlap_end);
+	     it != map.rend();) {
+		const TargetType::Field &existing_field = it->second;
+
+		if (existing_field.offset + existing_field.size <=
+		    tmp_field.offset)
+			break;
+
+		auto combined_end = std::max<decltype(tmp_field.offset)>(
+			tmp_field.offset + tmp_field.size,
+			existing_field.offset + existing_field.size);
+
+		auto combined_offset = std::min<decltype(tmp_field.offset)>(
+			tmp_field.offset, existing_field.offset);
+		auto combined_size = combined_end - combined_offset;
+
+		tmp_field.flags |= (existing_field.flags |
+				    TargetType::Field::FLAG_DANGEROUS);
+		tmp_field.offset = combined_offset;
+		tmp_field.alignment =
+			std::min(tmp_field.alignment, existing_field.alignment);
+		tmp_field.size = combined_size;
+
+		// Erase overlapping member
+		auto tmp_forward = std::prev(it.base());
+		tmp_forward = map.erase(tmp_forward);
+		it = std::make_reverse_iterator(tmp_forward);
+	}
+
+	map.emplace(tmp_field.offset, tmp_field);
+	return true;
+}
+
+bool TargetType::fetch_fields(bool redo)
+{
+	if (!valid())
+		return false;
+
+	if ((m_flags & FLAG_FIELDS) != 0 && !redo)
+		return true;
+
+	m_flags &= ~FLAG_FIELDS;
+	m_fields.clear();
+
+	std::map<std::size_t, Field> tmp_fields;
+
+	auto per_field_callback = [&tmp_fields](const Field &field) -> bool {
+		return field_map_add(tmp_fields, field);
+	};
+
+	if (!foreach_record_field(m_main_variant, per_field_callback))
+		return false;
+
+	// Get struct size
+
+	tree size_tree = TYPE_SIZE(m_main_variant);
+	if (!size_tree || TREE_CODE(size_tree) != INTEGER_CST)
+		return false;
+
+	HOST_WIDE_INT size_bits = tree_to_uhwi(size_tree);
+	if (size_bits < 0 || size_bits % 8 != 0)
+		return false;
+
+	m_size = static_cast<std::size_t>(size_bits / 8);
+
+	// Everything done
+
+	m_fields = std::move(tmp_fields);
+	m_flags |= FLAG_FIELDS;
+	return true;
+}
diff --git a/tools/spslr/src/pinpoint/stage1/asm_offset_pass.cpp b/tools/spslr/src/pinpoint/stage1/asm_offset_pass.cpp
new file mode 100644
index 000000000000..e11f377ffb7d
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage1/asm_offset_pass.cpp
@@ -0,0 +1,133 @@
+#include <stage1.h>
+#include <unordered_map>
+
+#include <pinpoint_error.h>
+#include <pinpoint_config.h>
+
+/*
+ * Stage1 marker asm is a carrier for target/offset constants.
+ *
+ * It intentionally does not contain final machine code yet. GCC still needs
+ * freedom to allocate the destination register, and stage2 later observes the
+ * final RTL register choice before emitting bytes with a labeled immediate.
+ */
+
+const char *s1_ipin_marker = "/*spslr_s1_ipin_marker*/";
+
+static tree make_asm_operand(const char *constraint_text, tree operand_tree)
+{
+	tree constraint_str =
+		build_string(strlen(constraint_text) + 1, constraint_text);
+	tree inner_list = build_tree_list(integer_zero_node, constraint_str);
+	tree outer_list = build_tree_list(inner_list, operand_tree);
+	return outer_list;
+}
+
+static gimple *make_stage1_pin(tree lhs, UID target, std::size_t offset)
+{
+	if (!lhs)
+		return nullptr;
+
+	const char *asm_str =
+		s1_ipin_marker; // Asm is inserted at a later stage
+
+	tree arg0 = build_int_cst(size_type_node, target);
+	tree arg1 = build_int_cst(size_type_node, offset);
+
+	vec<tree, va_gc> *outputs = NULL;
+	vec<tree, va_gc> *inputs = NULL;
+
+	vec_safe_push(outputs, make_asm_operand("=r", lhs));
+	vec_safe_push(inputs, make_asm_operand("i", arg0));
+	vec_safe_push(inputs, make_asm_operand("i", arg1));
+
+	gasm *new_gasm = gimple_build_asm_vec(ggc_strdup(asm_str), inputs,
+					      outputs, NULL, NULL);
+	if (!new_gasm)
+		return nullptr;
+
+	/*
+	 * Non-volatile is intentional: unused field-offset computations should die
+	 * normally. Only offsets that survive optimization become instruction pins.
+	 */
+	gimple_asm_set_volatile(new_gasm, false);
+
+	return new_gasm;
+}
+
+/*
+ * gsi_replace() changes the statement, but SSA names that were defined by the
+ * separator call still point at the old def statement. Retarget those SSA defs
+ * so later GCC passes see the asm marker as the producer of the offset value.
+ */
+
+static void pin_update_ssa_def(function *fn, gimple *old_def, gimple *new_def)
+{
+	if (!fn || !old_def)
+		return;
+
+	// Stage 0 separator call was definition statement of temporary variable
+
+	unsigned i;
+	tree name;
+	FOR_EACH_SSA_NAME(i, name, fn)
+	{
+		if (!name)
+			continue;
+
+		if (SSA_NAME_DEF_STMT(name) != old_def)
+			continue;
+
+		SSA_NAME_DEF_STMT(name) = new_def;
+	}
+}
+
+static void pin_assemble_maybe(function *fn, gimple_stmt_iterator *gsi)
+{
+	if (!gsi)
+		return;
+
+	gimple *stmt = gsi_stmt(*gsi);
+	if (!stmt)
+		return;
+
+	UID target;
+	std::size_t offset;
+
+	if (!is_stage0_separator(stmt, target, offset))
+		return;
+
+	gimple *replacement =
+		make_stage1_pin(gimple_call_lhs(stmt), target, offset);
+	if (!replacement)
+		pinpoint_fatal();
+
+	gsi_replace(gsi, replacement, true);
+	pin_update_ssa_def(fn, stmt, replacement);
+}
+
+static const pass_data asm_offset_pass_data = {
+	GIMPLE_PASS, "asm_offset",   OPTGROUP_NONE, TV_NONE, 0, 0, 0,
+	0,	     TODO_update_ssa
+};
+
+asm_offset_pass::asm_offset_pass(gcc::context *ctxt)
+	: gimple_opt_pass(asm_offset_pass_data, ctxt)
+{
+}
+
+unsigned int asm_offset_pass::execute(function *fn)
+{
+	if (!fn)
+		return 0;
+
+	basic_block bb;
+	FOR_EACH_BB_FN(bb, fn)
+	{
+		for (gimple_stmt_iterator gsi = gsi_start_bb(bb);
+		     !gsi_end_p(gsi); gsi_next(&gsi))
+			pin_assemble_maybe(fn, &gsi);
+	}
+
+	return 0;
+}
diff --git a/tools/spslr/src/pinpoint/stage1/stage1.h b/tools/spslr/src/pinpoint/stage1/stage1.h
new file mode 100644
index 000000000000..976bf8b36918
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage1/stage1.h
@@ -0,0 +1,11 @@
+#pragma once
+
+#include <stage0.h>
+#include <safe-gimple.h>
+
+extern const char *s1_ipin_marker;
+
+struct asm_offset_pass : gimple_opt_pass {
+	asm_offset_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
diff --git a/tools/spslr/src/pinpoint/stage2/rtl_pin_lower_pass.cpp b/tools/spslr/src/pinpoint/stage2/rtl_pin_lower_pass.cpp
new file mode 100644
index 000000000000..e7e92c8ef514
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage2/rtl_pin_lower_pass.cpp
@@ -0,0 +1,283 @@
+#include <stage2.h>
+#include <stage1.h>
+#include <final.h>
+#include <pinpoint_config.h>
+#include <pinpoint_error.h>
+
+#include <safe-rtl.h>
+
+#include <unordered_map>
+#include <string>
+#include <cstring>
+#include <cstdio>
+
+static UID next_stage2_pin_uid = 0;
+static std::unordered_map<UID, S2InstructionPin> pins;
+
+const std::unordered_map<UID, S2InstructionPin> &s2_pins()
+{
+	return pins;
+}
+
+void s2_pins_reset()
+{
+	pins.clear();
+	next_stage2_pin_uid = 0;
+}
+
+/*
+ * Stage2 pins are the bridge from compiler metadata to runtime patching:
+ * target + original offset describe what to compute, while symbol points at
+ * the immediate bytes that must be rewritten.
+ */
+
+UID s2_pin_allocate(const S2InstructionPin &pin)
+{
+	UID uid = next_stage2_pin_uid++;
+	pins.emplace(uid, pin);
+	return uid;
+}
+
+static bool read_marker_inputs(rtx src, UID &target, std::size_t &offset)
+{
+	rtx in0 = ASM_OPERANDS_INPUT(src, 0);
+	rtx in1 = ASM_OPERANDS_INPUT(src, 1);
+
+	if (!CONST_INT_P(in0) || !CONST_INT_P(in1))
+		return false;
+
+	target = (UID)INTVAL(in0);
+	offset = (std::size_t)INTVAL(in1);
+	return true;
+}
+
+static bool extract_set_from_pat(rtx pat, rtx &set_out)
+{
+	if (!pat)
+		return false;
+
+	if (GET_CODE(pat) == SET) {
+		set_out = pat;
+		return true;
+	}
+
+	if (GET_CODE(pat) == PARALLEL) {
+		int len = XVECLEN(pat, 0);
+		for (int i = 0; i < len; ++i) {
+			rtx elem = XVECEXP(pat, 0, i);
+			if (elem && GET_CODE(elem) == SET) {
+				set_out = elem;
+				return true;
+			}
+		}
+	}
+
+	return false;
+}
+
+static bool get_regno_from_dest(rtx dest, unsigned &regno)
+{
+	if (!dest)
+		return false;
+
+	if (REG_P(dest)) {
+		regno = REGNO(dest);
+		return true;
+	}
+
+	if (GET_CODE(dest) == SUBREG) {
+		rtx inner = SUBREG_REG(dest);
+		if (inner && REG_P(inner)) {
+			regno = REGNO(inner);
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * Recognize the RTL form of a stage1 marker.
+ *
+ * At this point GCC has selected the destination register. That register
+ * choice determines the exact x86_64 encoding we must emit so the immediate
+ * operand can be labeled and patched later.
+ */
+
+static bool is_stage1_marker_insn(rtx_insn *insn, rtx &set_rtx, rtx &asm_src,
+				  UID &target, std::size_t &offset,
+				  unsigned &regno)
+{
+	if (!insn || !INSN_P(insn))
+		return false;
+
+	rtx pat = PATTERN(insn);
+	if (!extract_set_from_pat(pat, set_rtx))
+		return false;
+
+	rtx dest = SET_DEST(set_rtx);
+	rtx src = SET_SRC(set_rtx);
+
+	if (!src || GET_CODE(src) != ASM_OPERANDS)
+		return false;
+
+	const char *templ = ASM_OPERANDS_TEMPLATE(src);
+	if (!templ)
+		return false;
+
+	/* safer than exact strcmp */
+	if (!std::strstr(templ, s1_ipin_marker))
+		return false;
+
+	if (!read_marker_inputs(src, target, offset))
+		return false;
+
+	if (!get_regno_from_dest(dest, regno))
+		return false;
+
+	asm_src = src;
+	return true;
+}
+
+static const pass_data rtl_pin_lower_pass_data = {
+	RTL_PASS, /* type */
+	"spslr_rtl_pin_lower", /* name */
+	OPTGROUP_NONE, /* optinfo_flags */
+	TV_NONE, /* tv_id */
+	PROP_rtl, /* properties_required */
+	0, /* properties_provided */
+	0, /* properties_destroyed */
+	0, /* todo_flags_start */
+	0 /* todo_flags_finish */
+};
+
+struct EncodedReg {
+	unsigned rex;
+	unsigned modrm;
+};
+
+/*
+ * Encode "mov imm32, r64" for the hard register selected by GCC.
+ *
+ * The immediate is deliberately four bytes: the final asm labels exactly that
+ * immediate field, and runtime selfpatch overwrites those bytes with the
+ * randomized offset value.
+ */
+static bool x86_64_encode_mov_imm32_to_reg(unsigned regno, EncodedReg &out)
+{
+	if (!HARD_REGISTER_NUM_P(regno))
+		return false;
+
+	const char *name = reg_names[regno];
+	if (!name)
+		return false;
+
+	struct RegMapEntry {
+		const char *name;
+		unsigned rex;
+		unsigned rm;
+	};
+
+	static const RegMapEntry regmap[] = {
+		{ "ax", 0x48, 0 },  { "cx", 0x48, 1 },	{ "dx", 0x48, 2 },
+		{ "bx", 0x48, 3 },  { "sp", 0x48, 4 },	{ "bp", 0x48, 5 },
+		{ "si", 0x48, 6 },  { "di", 0x48, 7 },
+
+		{ "r8", 0x49, 0 },  { "r9", 0x49, 1 },	{ "r10", 0x49, 2 },
+		{ "r11", 0x49, 3 }, { "r12", 0x49, 4 }, { "r13", 0x49, 5 },
+		{ "r14", 0x49, 6 }, { "r15", 0x49, 7 },
+	};
+
+	for (const auto &e : regmap) {
+		if (std::strcmp(name, e.name) == 0) {
+			out.rex = e.rex;
+			out.modrm = 0xC0 | e.rm; /* mod=11, /0, rm=e.rm */
+			return true;
+		}
+	}
+
+	return false;
+}
+
+/*
+ * Emit the final instruction bytes manually so the immediate operand can be
+ * exposed as an object symbol.
+ *
+ * The symbol does not denote executable code as a callable function; it denotes
+ * the four-byte immediate field inside the instruction stream.
+ */
+
+static std::string make_final_x86_64_asm(const std::string &sym,
+					 const EncodedReg &enc, std::size_t imm)
+{
+	char buf[512];
+	std::snprintf(buf, sizeof(buf),
+		      ".globl %s\n"
+		      ".hidden %s\n"
+		      ".byte 0x%02x, 0xC7, 0x%02x\n"
+		      "%s:\n"
+		      ".type %s, @object\n"
+		      ".size %s, 4\n"
+		      ".long %zu",
+		      sym.c_str(), sym.c_str(), enc.rex, enc.modrm, sym.c_str(),
+		      sym.c_str(), sym.c_str(), imm);
+	return std::string(buf);
+}
+
+static bool lower_stage1_marker_insn(rtx_insn *insn)
+{
+	rtx set_rtx = nullptr;
+	rtx asm_src = nullptr;
+	UID target = 0;
+	std::size_t offset = 0;
+	unsigned regno = 0;
+
+	if (!is_stage1_marker_insn(insn, set_rtx, asm_src, target, offset,
+				   regno))
+		return false;
+
+	EncodedReg enc{};
+	if (!x86_64_encode_mov_imm32_to_reg(regno, enc)) {
+		pinpoint_fatal(
+			"stage2: unsupported hard register for ipin lowering: regno=%u",
+			(unsigned)regno);
+		return false;
+	}
+
+	S2InstructionPin pin;
+	pin.target = target;
+	pin.offset = offset;
+	pin.imm_size = 4;
+
+	UID pin_uid = s2_pin_allocate(pin);
+
+	auto it = pins.find(pin_uid);
+	if (it == pins.end())
+		pinpoint_fatal("stage2: internal error after s2_pin_allocate");
+
+	it->second.symbol = std::string(SPSLR_PINPOINT_STAGE2_PIN) +
+			    std::string(get_cu_hash()) + "_" +
+			    std::to_string(pin_uid);
+
+	std::string final_asm =
+		make_final_x86_64_asm(it->second.symbol, enc, offset);
+
+	ASM_OPERANDS_TEMPLATE(asm_src) = ggc_strdup(final_asm.c_str());
+	return true;
+}
+
+rtl_pin_lower_pass::rtl_pin_lower_pass(gcc::context *ctxt)
+	: rtl_opt_pass(rtl_pin_lower_pass_data, ctxt)
+{
+}
+
+unsigned int rtl_pin_lower_pass::execute(function *fn)
+{
+	(void)fn;
+
+	for (rtx_insn *insn = get_insns(); insn; insn = NEXT_INSN(insn)) {
+		(void)lower_stage1_marker_insn(insn);
+	}
+
+	return 0;
+}
diff --git a/tools/spslr/src/pinpoint/stage2/stage2.h b/tools/spslr/src/pinpoint/stage2/stage2.h
new file mode 100644
index 000000000000..5ae1c2b5626f
--- /dev/null
+++ b/tools/spslr/src/pinpoint/stage2/stage2.h
@@ -0,0 +1,22 @@
+#pragma once
+
+#include <stage0.h>
+#include <safe-rtl.h>
+#include <unordered_map>
+#include <string>
+
+struct S2InstructionPin {
+	UID target;
+	std::size_t offset;
+	std::size_t imm_size;
+	std::string symbol;
+};
+
+const std::unordered_map<UID, S2InstructionPin> &s2_pins();
+void s2_pins_reset();
+UID s2_pin_allocate(const S2InstructionPin &pin);
+
+struct rtl_pin_lower_pass : rtl_opt_pass {
+	rtl_pin_lower_pass(gcc::context *ctxt);
+	unsigned int execute(function *fn) override;
+};
-- 
2.43.0

