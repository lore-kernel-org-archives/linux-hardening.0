Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A63C4163
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780691119; cv=none; b=u2XqghbncH50PlQz4h4Q1fpb4H3s0HqRL+IDCH3Py6hiU7J3WdmXwz21rhMN5rmjIqtLh8bf7kLiGcjdSqvFN9PQ3VaVGC4qPy1vFJ2CxxpjzAf5AzLMhNotoE+S9hIYK9LT02JZ0UvzdAnw8Gek6bCdAJX0lV5THE5Gt6UZbTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780691119; c=relaxed/simple;
	bh=4YSk+PqnU25/pd281fkWdVQzzfAQYrUqbX9mzDRWOdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATDbVLhFO3ZmCevkU+9hgc5wuwpg6+uaKMRWDxE+GQPA9//BLfO15xq5sZ8p85xFIOAObO4jCr2N3pVmbkbrqiV1sOVt+IjFQcS8W32Mp2ZeXD/D4OcUvjbVxum1NkDRBEcCqAqAvrA6Y/KExG+NCr8wAAeydOJ3PZ6Fgn/Jv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com; spf=none smtp.mailfrom=yjn-systems.com; dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b=EBQkPT+p; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yjn-systems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yjn-systems.com header.i=@yjn-systems.com header.b="EBQkPT+p"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490ac10e337so20558735e9.3
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 13:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yjn-systems.com; s=google; t=1780691115; x=1781295915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FoCleUktnCDbl+rOf99Ng5fBYGQTadNt2rDuxYPT2Hg=;
        b=EBQkPT+pPihoQ7tFSy55aamiVc6gLMTi1yKCykDqU1v6oyMfiITBTtEf7UCUqMEglT
         vOLJ08HmrMpzUYk9mNCdrpCfbbHGDZgF+mVGdvgIFpX6kqIZ09Dn920pH7FT1wEr0I29
         tIu8Vk9Jo/MoCeU3oHtgd4WxyYHd/Y3ENqG9nSxV1+Nuu2tymUj6jVJWfnrk1Llct9qh
         HyVOXNCDzf4orQA2G4ZbLN0f0rBSa2cc2JRpOhcFk+dKPwRJZbzKUXrD/5slTqiqJWtP
         sygN21Ihu2S9zhb786tdfPG7moAjGIbB/8GfZZUaUuOSlR8ITibauWarM4neMVvCe41K
         H4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780691115; x=1781295915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FoCleUktnCDbl+rOf99Ng5fBYGQTadNt2rDuxYPT2Hg=;
        b=HYH4/5nftvd8UTKnck9twCKljdvm8tOH4Jb1AktD3p6sG7KY1v+Tj/A9YHajpLmpTm
         IgTs0TCISuD9kRpyp/5Tk6DC/hNkXtKm6gAdO2NwLzlW/H+RPV+bclu/rx6ctveZPR/+
         7ocWVnV4j3reU62AwRcHIb/bTPFC4Hr+tQR/LeRsfK6HhyKw1nhEDOIFeOYmTtCqbibn
         hh8WPfhZOmIfVRWEKA04H9mILpGJtxxlP4TwoN/H1Njn+HQRZN5VY0S5BaEWXkq1/+6o
         WqFTTiq1ypRnYsa+hx5X+bYudQnPCISCE2o2LN+LQUAEHzDfVwL14AFuSKa398prx9sV
         0MSw==
X-Gm-Message-State: AOJu0YwbX9WbY+t2mZs4+QwQt74S5b7RXvDFibVRNqjY7Zl01kpXYRMk
	/Bfr10vMYNbxcxNgyEn2KidVFpEa/LQ7ss6LQ0ZPiC69jhmqApzXGnu8NYr6DheAYdMYQTKNR2r
	NNChk/ZDc
X-Gm-Gg: Acq92OGYAzM4PgMPGDTZQaxVhwydg2MWZB7xuLuHUEkTAVDSKqa0D5hmr0Ruuc9oFyB
	rZymUJscZ1imBJFKEQh5uopxBi3oKJnu6eolRiQ2iZIaxKYDYhf1NlJM7IT51rlv0Pcuf0t2QRQ
	C+TZ0f0AuBKsN/GoG7nJ8g+VwQFHp1kxx2xfGNSgkmoRQ3rGYuQj+vlpqLTUVgIt320AQAo657S
	g1HatTPQkZrdPKLDneJYyTqk9rhDcP5TxPsnwpZLNqpV9at8CKlgH/DCwV1i0+VlsZMfwHV1Acn
	exn2RlI3WrGm58d5chPuCFwBUxLdNJ7+TDJKQ0sSjYlkGcRaKFE5rC3NfnQmVG3C6yuXCKXVu6T
	bxTCDfhFwrk6RntRdLTUFDphZFqkBeT1dVGeBHUyijEFcYSr7qg/3dpO1xfSR5k0I7b1kL6Vlp9
	d6eaOfOiYDhgYxB12BckVMi90ANW472xa1wb3iIpnBXkob8zKkkMzX97oyiQkaexC9HiPLcBUpe
	FmmUON5usIY/CeqexyMlAoUAMyIeiRvq1j66XZqVG0PFyMMeqTkuWAUw2oG
X-Received: by 2002:a05:600c:450a:b0:490:c2a2:b1d3 with SMTP id 5b1f17b1804b1-490c2a2b3c6mr77856585e9.34.1780691114957;
        Fri, 05 Jun 2026 13:25:14 -0700 (PDT)
Received: from yjn-Zenbook-UX3404VA-UX3404VA.. (p200300dcbf13e6006c589ea22c400ee8.dip0.t-ipconnect.de. [2003:dc:bf13:e600:6c58:9ea2:2c40:ee8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3a87dasm168442995e9.7.2026.06.05.13.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:25:14 -0700 (PDT)
From: York Jasper Niebuhr <yjn@yjn-systems.com>
To: linux-hardening@vger.kernel.org
Cc: kees@kernel.org,
	franzen@sec.in.tum.de
Subject: [RFC 2/7] SPSLR patchcompile cli source
Date: Fri,  5 Jun 2026 22:25:06 +0200
Message-ID: <20260605202511.79272-3-yjn@yjn-systems.com>
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
 tools/spslr/src/patchcompile/accumulation.cpp | 529 ++++++++++++++++++
 tools/spslr/src/patchcompile/accumulation.h   |  78 +++
 tools/spslr/src/patchcompile/emit.cpp         | 451 +++++++++++++++
 tools/spslr/src/patchcompile/emit.h           |   4 +
 tools/spslr/src/patchcompile/patchcompile.cpp | 167 ++++++
 .../src/patchcompile/patchcompile_error.h     |  41 ++
 tools/spslr/src/patchcompile/spslr_list.h     |  13 +
 7 files changed, 1283 insertions(+)
 create mode 100644 tools/spslr/src/patchcompile/accumulation.cpp
 create mode 100644 tools/spslr/src/patchcompile/accumulation.h
 create mode 100644 tools/spslr/src/patchcompile/emit.cpp
 create mode 100644 tools/spslr/src/patchcompile/emit.h
 create mode 100644 tools/spslr/src/patchcompile/patchcompile.cpp
 create mode 100644 tools/spslr/src/patchcompile/patchcompile_error.h
 create mode 100644 tools/spslr/src/patchcompile/spslr_list.h

diff --git a/tools/spslr/src/patchcompile/accumulation.cpp b/tools/spslr/src/patchcompile/accumulation.cpp
new file mode 100644
index 000000000000..300c610a5286
--- /dev/null
+++ b/tools/spslr/src/patchcompile/accumulation.cpp
@@ -0,0 +1,529 @@
+#include "accumulation.h"
+
+#include <filesystem>
+#include <fstream>
+
+#include "patchcompile_error.h"
+
+namespace fs = std::filesystem;
+
+/*
+ * Accumulated metadata model.
+ *
+ * targets is indexed by global target UID. units is indexed by the per-CU UID
+ * symbol emitted by pinpoint and preserves each CU's local-to-global target map.
+ */
+static std::size_t next_global_target_uid = 0;
+std::unordered_map<std::size_t, TARGET> targets;
+std::unordered_map<std::string, CU> units;
+
+/*
+ * Decide whether two target layouts can share one runtime randomization.
+ *
+ * Same-named types from different compilation units are merged only if their
+ * byte layout is identical. If the layouts differ, they must get detached
+ * randomization state because one permutation could not safely describe both.
+ */
+static bool global_target_field_cmp(const TARGET &a, const TARGET &b)
+{
+	if (a.fields.size() != b.fields.size())
+		return false;
+
+	auto ita = a.fields.begin();
+	auto itb = b.fields.begin();
+
+	for (; ita != a.fields.end() && itb != b.fields.end(); ++ita, ++itb) {
+		const FIELD &fa = ita->second;
+		const FIELD &fb = itb->second;
+
+		if (fa.offset != fb.offset)
+			return false;
+		if (fa.size != fb.size)
+			return false;
+		if (fa.alignment != fb.alignment)
+			return false;
+		if (fa.flags != fb.flags)
+			return false;
+	}
+
+	return true;
+}
+
+static bool global_target_cmp(const TARGET &a, const TARGET &b)
+{
+	if (a.name != b.name)
+		return false;
+
+	if (a.size != b.size || !global_target_field_cmp(a, b)) {
+		patchcompile_warn(
+			"got different definitions of '%s' -> detached randomization",
+			a.name.c_str());
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * Intern a CU-local target into the global target table.
+ *
+ * The returned UID is stable for the rest of this patchcompile invocation and
+ * becomes the runtime target index used by emitted ipin/dpin descriptors.
+ */
+static std::size_t accumulate_global_target(TARGET &&target, bool &was_new)
+{
+	was_new = false;
+	for (const auto &[guid, gtarget] : targets) {
+		if (global_target_cmp(gtarget, target))
+			return guid;
+	}
+
+	was_new = true;
+
+	std::size_t guid = next_global_target_uid++;
+	targets.emplace(guid, std::move(target));
+	return guid;
+}
+
+/*
+ * pinpoint emits one textual `.spslr` file per compilation unit:
+ *
+ *   SPSLR <source-file> <cu-uid-symbol>
+ *
+ *   target <name> <local-target-uid> <sizeof(target)> <field-count>
+ *   f      <offset> <size> <alignment> <flags>
+ *
+ *   ipin   <immediate-symbol> <local-target-uid> <field-offset> <imm-size>
+ *   dpin   <object-symbol> <object-offset> <nesting-level> <local-target-uid>
+ *
+ * Target UIDs in this file are local to the originating CU. This parser keeps
+ * that local namespace inside CU::local_targets and resolves it to global UIDs
+ * only after all compatible targets have been merged.
+ */
+static bool accumulate_file(const fs::path &path, bool no_new_targets)
+{
+	std::ifstream infile(path);
+	if (!infile)
+		return false;
+
+	std::string err_file_cppstr = path.generic_string();
+	const char *err_file = err_file_cppstr.c_str();
+	std::size_t err_line = 1; // One header line
+
+	std::string hdr_line;
+	if (!std::getline(infile, hdr_line))
+		return false;
+
+	std::istringstream hdr_iss(hdr_line);
+
+	std::string hdr_magic, hdr_cu_file, hdr_cu_uid;
+
+	if (!(hdr_iss >> hdr_magic) || hdr_magic != "SPSLR")
+		return false;
+
+	if (!(hdr_iss >> hdr_cu_file) || !(hdr_iss >> hdr_cu_uid))
+		return false;
+
+	if (units.contains(hdr_cu_uid)) {
+		patchcompile_file_error(err_file, err_line,
+					"duplicate compilation unit UID '%s'",
+					hdr_cu_uid.c_str());
+		return false;
+	}
+
+	patchcompile_debug("parsing meta data from %s ...", err_file);
+
+	units.emplace(hdr_cu_uid, CU{});
+	CU &cu = units.at(hdr_cu_uid);
+
+	std::string line;
+	while (std::getline(infile, line)) {
+		err_line++;
+
+		if (line.empty())
+			continue;
+
+		std::istringstream iss(line);
+		std::string type;
+
+		if (!(iss >> type))
+			return false;
+
+		if (type == "target") {
+			std::size_t err_line_target_base = err_line;
+
+			TARGET target;
+
+			std::size_t local_uid, field_count;
+
+			if (!(iss >> target.name) || !(iss >> local_uid) ||
+			    !(iss >> target.size) || !(iss >> field_count)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"invalid target line: \"%s\"",
+					line.c_str());
+				return false;
+			}
+
+			if (cu.local_targets.contains(local_uid)) {
+				patchcompile_file_error(
+					err_file, err_line_target_base,
+					"local target uid %llu has already been claimed",
+					local_uid);
+				return false;
+			}
+
+			for (std::size_t i = 0; i < field_count; i++) {
+				err_line++;
+
+				std::string fline;
+				if (!std::getline(infile, fline)) {
+					patchcompile_file_error(
+						err_file, err_line,
+						"missing field declaration, expected %llu fields",
+						field_count);
+					return false;
+				}
+
+				std::istringstream fiss(fline);
+
+				std::string ftype;
+				if (!(fiss >> ftype) || ftype != "f") {
+					patchcompile_file_error(
+						err_file, err_line,
+						"invalid field declaration line: \"%s\"",
+						fline.c_str());
+					return false;
+				}
+
+				FIELD field;
+				if (!(fiss >> field.offset) ||
+				    !(fiss >> field.size) ||
+				    !(fiss >> field.alignment) ||
+				    !(fiss >> field.flags)) {
+					patchcompile_file_error(
+						err_file, err_line,
+						"invalid field declaration line: \"%s\"",
+						fline.c_str());
+					return false;
+				}
+
+				// Note -> could do sanity checks here
+
+				if (target.fields.contains(field.offset)) {
+					patchcompile_file_error(
+						err_file, err_line,
+						"duplicate field offset %llu",
+						field.offset);
+					return false;
+				}
+
+				target.fields.emplace(field.offset, field);
+			}
+
+			/*
+			 * Runtime metadata addresses fields by compact field index, not by byte offset.
+			 * The map is ordered by offset, so this assigns deterministic original-layout
+			 * indices.
+			 */
+			auto fit = target.fields.begin();
+			for (std::size_t i = 0; i < field_count; i++) {
+				fit->second.idx = i;
+				fit++;
+			}
+
+			bool was_new = false;
+			std::size_t global_target_uid =
+				accumulate_global_target(std::move(target),
+							 was_new);
+
+			if (no_new_targets && was_new) {
+				patchcompile_file_error(
+					err_file, err_line_target_base,
+					"encountered new target but --no-new-targets is set");
+				return false;
+			}
+
+			cu.local_targets.emplace(local_uid, global_target_uid);
+			continue;
+		} else if (type == "ipin") {
+			IPIN ipin;
+			if (!(iss >> ipin.symbol) ||
+			    !(iss >> ipin.local_target) ||
+			    !(iss >> ipin.field_offset) ||
+			    !(iss >> ipin.imm_size)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"invalid ipin declaration: \"%s\"",
+					line.c_str());
+				return false;
+			}
+
+			if (!cu.local_targets.contains(ipin.local_target)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"ipin references local target %llu which has not yet been parsed",
+					ipin.local_target);
+				return false;
+			}
+
+			/*
+			 * An instruction immediate has exactly one patch descriptor. Duplicate symbols
+			 * would mean two metadata records are trying to patch the same bytes.
+			 */
+			if (cu.ipins.contains(ipin.symbol)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"duplicate ipin for symbol '%s'",
+					ipin.symbol.c_str());
+				return false;
+			}
+
+			cu.ipins.emplace(ipin.symbol, ipin);
+			continue;
+		} else if (type == "dpin") {
+			std::string symbol;
+			DPIN::COMPONENT comp;
+
+			if (!(iss >> symbol) || !(iss >> comp.offset) ||
+			    !(iss >> comp.level) || !(iss >> comp.target)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"invalid dpin declaration: \"%s\"",
+					line.c_str());
+				return false;
+			}
+
+			/*
+			 * Dpins are grouped by linker symbol because one static object can contain
+			 * several randomized target instances. Emission later expands the components
+			 * into individual runtime dpin records in patch order.
+			 */
+			if (!cu.dpins.contains(symbol))
+				cu.dpins.emplace(symbol,
+						 DPIN{ .symbol = symbol });
+
+			DPIN &dpin = cu.dpins.at(symbol);
+
+			if (!cu.local_targets.contains(comp.target)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"dpin references local target %llu which has not yet been parsed",
+					comp.target);
+				return false;
+			}
+
+			dpin.components.push_back(comp);
+			continue;
+		} else {
+			patchcompile_file_error(
+				err_file, err_line,
+				"invalid meta data file line of type '%s': \"%s\"",
+				type.c_str(), line.c_str());
+			return false;
+		}
+	}
+
+	patchcompile_debug(
+		"metadata summary for CU %s (source %s): %zu targets, %zu ipins, %zu dpins",
+		hdr_cu_uid.c_str(), hdr_cu_file.c_str(),
+		cu.local_targets.size(), cu.ipins.size(), cu.dpins.size());
+
+	for (const auto &[local_uid, global_uid] : cu.local_targets) {
+		const TARGET &target = targets.at(global_uid);
+
+		patchcompile_debug(
+			"  target local=%zu global=%zu name=%s size=%zu fields=%zu",
+			local_uid, global_uid, target.name.c_str(), target.size,
+			target.fields.size());
+	}
+
+	return true;
+}
+
+bool accumulate(const std::vector<std::string> &spslr_files,
+		bool no_new_targets)
+{
+	for (const std::string &spslr_file : spslr_files) {
+		fs::path p{ spslr_file };
+
+		if (!fs::exists(p) || !fs::is_regular_file(p)) {
+			patchcompile_error(
+				"failed to open meta data file at %s",
+				spslr_file.c_str());
+			return false;
+		}
+
+		if (!accumulate_file(p, no_new_targets)) {
+			patchcompile_error(
+				"failed to parse meta data file at %s",
+				spslr_file.c_str());
+			return false;
+		}
+	}
+
+	return true;
+}
+
+/*
+ * Persist the executable's global target namespace.
+ *
+ * Module patchcompile loads this map so module metadata can refer to exactly
+ * the same target IDs and randomization state as the main executable.
+ */
+bool dump_target_map(const std::string &path)
+{
+	std::filesystem::path p{ path };
+	if (p.has_parent_path()) {
+		std::error_code ec;
+		std::filesystem::create_directories(p.parent_path(), ec);
+		if (ec) {
+			patchcompile_error(
+				"failed to create target map directory at %s: %s",
+				p.parent_path().generic_string().c_str(),
+				ec.message().c_str());
+			return false;
+		}
+	}
+
+	std::ofstream out(p);
+	if (!out)
+		return false;
+
+	out << "SPSLR_TARGETS 1\n";
+
+	for (const auto &[uid, t] : targets) {
+		out << "target " << t.name << " " << uid << " " << t.size << " "
+		    << t.fields.size() << "\n";
+
+		for (const auto &[off, f] : t.fields) {
+			(void)off;
+			out << "f " << f.offset << " " << f.size << " "
+			    << f.alignment << " " << f.flags << "\n";
+		}
+	}
+
+	return !!out;
+}
+
+/*
+ * Restore a previously emitted global target namespace.
+ *
+ * This is used for modules: they may reference existing randomized types, but
+ * --no-new-targets prevents them from silently introducing layouts unknown to
+ * the already-running executable.
+ */
+bool load_target_map(const std::string &path)
+{
+	std::ifstream in(path);
+	if (!in)
+		return false;
+
+	std::string err_file_cppstr = path;
+	const char *err_file = err_file_cppstr.c_str();
+	std::size_t err_line = 1; // Header is one line
+
+	std::string magic;
+	std::size_t version = 0;
+	if (!(in >> magic >> version) || magic != "SPSLR_TARGETS" ||
+	    version != 1) {
+		patchcompile_file_error(err_file, err_line,
+					"invalid target map header");
+		return false;
+	}
+
+	std::string line;
+	std::getline(in, line); // consume rest of header line
+
+	std::size_t max_uid = 0;
+	bool have_any = false;
+
+	while (std::getline(in, line)) {
+		err_line++;
+
+		if (line.empty())
+			continue;
+
+		std::istringstream iss(line);
+		std::string tag;
+		iss >> tag;
+
+		if (tag != "target") {
+			patchcompile_file_error(
+				err_file, err_line,
+				"target map file can only contain target and field entries");
+			return false;
+		}
+
+		TARGET t{};
+		std::size_t uid = 0;
+		std::size_t field_count = 0;
+
+		if (!(iss >> t.name >> uid >> t.size >> field_count)) {
+			patchcompile_file_error(
+				err_file, err_line,
+				"invalid target declaration: \"%s\"",
+				line.c_str());
+			return false;
+		}
+
+		std::size_t err_line_target_base = err_line;
+
+		for (std::size_t i = 0; i < field_count; ++i) {
+			err_line++;
+
+			std::string fline;
+			if (!std::getline(in, fline)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"missing field entry, expected %llu fields",
+					field_count);
+				return false;
+			}
+
+			std::istringstream fiss(fline);
+			std::string ftag;
+			FIELD f{};
+
+			if (!(fiss >> ftag) || ftag != "f" ||
+			    !(fiss >> f.offset >> f.size >> f.alignment >>
+			      f.flags)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"invalid field declaration: \"%s\"",
+					fline.c_str());
+				return false;
+			}
+
+			f.idx = i;
+			if (t.fields.contains(f.offset)) {
+				patchcompile_file_error(
+					err_file, err_line,
+					"duplicate field offset %llu",
+					f.offset);
+				return false;
+			}
+			t.fields.emplace(f.offset, f);
+		}
+
+		if (targets.contains(uid)) {
+			patchcompile_file_error(
+				err_file, err_line_target_base,
+				"target uid %llu has already been claimed",
+				uid);
+			return false;
+		}
+
+		targets.emplace(uid, std::move(t));
+
+		if (!have_any || uid > max_uid) {
+			max_uid = uid;
+			have_any = true;
+		}
+	}
+
+	if (have_any)
+		next_global_target_uid = (max_uid + 1);
+
+	return true;
+}
diff --git a/tools/spslr/src/patchcompile/accumulation.h b/tools/spslr/src/patchcompile/accumulation.h
new file mode 100644
index 000000000000..caa2615c628d
--- /dev/null
+++ b/tools/spslr/src/patchcompile/accumulation.h
@@ -0,0 +1,78 @@
+#pragma once
+#include <string>
+#include <cstddef>
+#include <unordered_map>
+#include <map>
+#include <list>
+#include <optional>
+#include <cstdint>
+#include <vector>
+
+/*
+ * Per-CU instruction pin parsed from pinpoint metadata.
+ *
+ * local_target is the target UID as seen by the originating compilation unit.
+ * patchcompile resolves it to a global target UID before emission.
+ */
+struct IPIN {
+	std::string symbol;
+	std::size_t local_target;
+	std::size_t field_offset;
+	std::size_t imm_size;
+};
+
+/*
+ * Per-CU data pin for one linker-visible object symbol.
+ *
+ * A single symbol may contain multiple randomized target instances, for example
+ * nested structs or array elements. Each component describes one such instance.
+ */
+struct DPIN {
+	struct COMPONENT {
+		std::size_t offset;
+
+		/*
+		 * Nesting depth within the containing object. Larger values are patched first
+		 * so embedded target objects are rewritten before their containers.
+		 */
+		std::size_t level;
+		std::size_t target; // local pin -> local target
+	};
+
+	std::string symbol;
+	std::list<COMPONENT> components;
+};
+
+struct FIELD {
+	std::size_t offset;
+	std::size_t size;
+	std::size_t alignment;
+	std::size_t flags;
+	std::size_t idx;
+};
+
+struct TARGET {
+	std::string name;
+	std::size_t size;
+	std::map<std::size_t, FIELD> fields;
+};
+
+/*
+ * Metadata collected from one `.spslr` file.
+ *
+ * local_targets maps the CU-local target namespace emitted by pinpoint to the
+ * global target namespace constructed by patchcompile.
+ */
+struct CU {
+	std::unordered_map<std::size_t, std::size_t> local_targets;
+	std::unordered_map<std::string, IPIN> ipins;
+	std::unordered_map<std::string, DPIN> dpins;
+};
+
+extern std::unordered_map<std::size_t, TARGET> targets;
+extern std::unordered_map<std::string, CU> units;
+
+bool accumulate(const std::vector<std::string> &spslr_files,
+		bool no_new_targets);
+bool dump_target_map(const std::string &path);
+bool load_target_map(const std::string &path);
diff --git a/tools/spslr/src/patchcompile/emit.cpp b/tools/spslr/src/patchcompile/emit.cpp
new file mode 100644
index 000000000000..1b6017c5dd0b
--- /dev/null
+++ b/tools/spslr/src/patchcompile/emit.cpp
@@ -0,0 +1,451 @@
+#include "emit.h"
+#include "accumulation.h"
+
+#include <spslr_list.h>
+
+#include <algorithm>
+#include <cstdint>
+#include <ostream>
+#include <unordered_map>
+#include <utility>
+#include <vector>
+
+namespace
+{
+
+/*
+ * These records mirror the C runtime descriptor layout emitted as assembly.
+ * Keep them in sync with selfpatch's .spslr reader structures and
+ * spslr_list.h opcode definitions.
+ */
+
+struct TARGET_REC {
+	uint32_t size;
+	uint32_t fieldcnt;
+	uint32_t fieldoff;
+};
+
+struct TARGET_FIELD_REC {
+	uint32_t offset;
+	uint32_t size;
+	uint32_t alignment;
+	uint32_t flags;
+};
+
+struct IPIN_REC {
+	std::string addr_sym;
+	uint32_t size;
+	uint32_t program;
+};
+
+struct IPIN_OP_REC {
+	uint32_t code;
+	uint32_t op0;
+	uint32_t op1;
+};
+
+struct DPIN_REC {
+	std::string addr_sym;
+	uint32_t target;
+};
+
+/*
+ * Identical "target field -> randomized offset" computations can share one
+ * ipin program. The runtime program is immutable descriptor data, so multiple
+ * instruction pins may point at the same program offset.
+ */
+
+struct PROGRAM_KEY {
+	uint32_t target;
+	uint32_t field;
+
+	bool operator==(const PROGRAM_KEY &other) const
+	{
+		return target == other.target && field == other.field;
+	}
+};
+
+struct PROGRAM_KEY_HASH {
+	std::size_t operator()(const PROGRAM_KEY &k) const
+	{
+		return (static_cast<std::size_t>(k.target) << 32) ^ k.field;
+	}
+};
+
+static bool emit_header(std::ostream &out);
+static bool emit_u32_object(std::ostream &out, const char *name,
+			    uint32_t value);
+static bool emit_targets(std::ostream &out,
+			 const std::vector<TARGET_REC> &targets);
+static bool emit_target_fields(std::ostream &out,
+			       const std::vector<TARGET_FIELD_REC> &fields);
+static bool emit_ipins(std::ostream &out, const std::vector<IPIN_REC> &ipins);
+static bool emit_ipin_ops(std::ostream &out,
+			  const std::vector<IPIN_OP_REC> &ops);
+static bool emit_dpins(std::ostream &out, const std::vector<DPIN_REC> &dpins);
+
+/*
+ * Build or reuse the tiny runtime program for one field-offset patch.
+ *
+ * Current ipin programs are simple:
+ *   1. add the randomized offset of field <field> in target <target>
+ *   2. patch the instruction immediate with the accumulated value
+ *
+ * The returned value is an index into spslr_ipin_ops[], not a byte address.
+ */
+
+static uint32_t intern_simple_ipin_program(
+	std::vector<IPIN_OP_REC> &ops,
+	std::unordered_map<PROGRAM_KEY, uint32_t, PROGRAM_KEY_HASH> &memo,
+	uint32_t target, uint32_t field)
+{
+	PROGRAM_KEY key{ target, field };
+
+	auto it = memo.find(key);
+	if (it != memo.end())
+		return it->second;
+
+	const uint32_t start = static_cast<uint32_t>(ops.size());
+
+	ops.push_back(IPIN_OP_REC{
+		.code = SPSLR_IPIN_OP_ADD_OFFSET,
+		.op0 = target,
+		.op1 = field,
+	});
+
+	ops.push_back(IPIN_OP_REC{
+		.code = SPSLR_IPIN_OP_PATCH,
+		.op0 = 0,
+		.op1 = 0,
+	});
+
+	memo.emplace(key, start);
+	return start;
+}
+
+/*
+ * Main executables carry complete SPSLR metadata in a read-only .spslr section.
+ * The runtime locates these exported symbols during selfpatch initialization.
+ */
+
+static bool emit_header(std::ostream &out)
+{
+	out << ".section .spslr,\"a\",@progbits\n";
+	out << ".balign 8\n";
+	return !!out;
+}
+
+/*
+ * Module metadata may contain relocations against module-local symbols.
+ * Put it in writable relocation-friendly storage so the loader can resolve
+ * those addresses without text/rodata relocation warnings.
+ */
+
+static bool emit_module_header(std::ostream &out)
+{
+	out << ".section .data.rel.ro.spslr,\"aw\",@progbits\n";
+	out << ".balign 8\n";
+	return !!out;
+}
+
+static bool emit_u32_object(std::ostream &out, const char *name, uint32_t value)
+{
+	out << ".globl " << name << "\n";
+	out << ".type " << name << ", @object\n";
+	out << ".balign 4\n";
+	out << name << ":\n";
+	out << "\t.long " << value << "\n";
+	out << ".size " << name << ", 4\n";
+	return !!out;
+}
+
+/*
+ * Emit the global target table. The target UID is the array index, so callers
+ * must provide a dense vector ordered by global UID.
+ */
+
+static bool emit_targets(std::ostream &out,
+			 const std::vector<TARGET_REC> &targets)
+{
+	if (!emit_u32_object(out, "spslr_target_cnt",
+			     static_cast<uint32_t>(targets.size())))
+		return false;
+
+	out << ".globl spslr_targets\n";
+	out << ".type spslr_targets, @object\n";
+	out << ".balign 4\n";
+	out << "spslr_targets:\n";
+
+	for (const TARGET_REC &t : targets) {
+		out << "\t.long " << t.size << "\n";
+		out << "\t.long " << t.fieldcnt << "\n";
+		out << "\t.long " << t.fieldoff << "\n";
+	}
+
+	out << ".size spslr_targets, .-spslr_targets\n";
+	return !!out;
+}
+
+/*
+ * Emit the flattened field table referenced by TARGET_REC::fieldoff.
+ * Fields are stored in original-layout order and later permuted by runtime.
+ */
+
+static bool emit_target_fields(std::ostream &out,
+			       const std::vector<TARGET_FIELD_REC> &fields)
+{
+	if (!emit_u32_object(out, "spslr_target_field_cnt",
+			     static_cast<uint32_t>(fields.size())))
+		return false;
+
+	out << ".globl spslr_target_fields\n";
+	out << ".type spslr_target_fields, @object\n";
+	out << ".balign 4\n";
+	out << "spslr_target_fields:\n";
+
+	for (const TARGET_FIELD_REC &f : fields) {
+		out << "\t.long " << f.offset << "\n";
+		out << "\t.long " << f.size << "\n";
+		out << "\t.long " << f.alignment << "\n";
+		out << "\t.long " << f.flags << "\n";
+	}
+
+	out << ".size spslr_target_fields, .-spslr_target_fields\n";
+	return !!out;
+}
+
+/*
+ * Emit instruction pins. addr_sym names the immediate bytes inside the final
+ * instruction stream; program indexes the spslr_ipin_ops interpreter program.
+ */
+
+static bool emit_ipins(std::ostream &out, const std::vector<IPIN_REC> &ipins)
+{
+	if (!emit_u32_object(out, "spslr_ipin_cnt",
+			     static_cast<uint32_t>(ipins.size())))
+		return false;
+
+	out << ".globl spslr_ipins\n";
+	out << ".type spslr_ipins, @object\n";
+	out << ".balign 8\n";
+	out << "spslr_ipins:\n";
+
+	for (const IPIN_REC &ip : ipins) {
+		out << "\t.quad " << ip.addr_sym << "\n";
+		out << "\t.long " << ip.size << "\n";
+		out << "\t.long " << ip.program << "\n";
+	}
+
+	out << ".size spslr_ipins, .-spslr_ipins\n";
+	return !!out;
+}
+
+/*
+ * Emit the bytecode-like ipin operation stream interpreted by selfpatch.
+ * Programs terminate with SPSLR_IPIN_OP_PATCH.
+ */
+
+static bool emit_ipin_ops(std::ostream &out,
+			  const std::vector<IPIN_OP_REC> &ops)
+{
+	if (!emit_u32_object(out, "spslr_ipin_op_cnt",
+			     static_cast<uint32_t>(ops.size())))
+		return false;
+
+	out << ".globl spslr_ipin_ops\n";
+	out << ".type spslr_ipin_ops, @object\n";
+	out << ".balign 4\n";
+	out << "spslr_ipin_ops:\n";
+
+	for (const IPIN_OP_REC &op : ops) {
+		out << "\t.long " << op.code << "\n";
+		out << "\t.long " << op.op0 << "\n";
+		out << "\t.long " << op.op1 << "\n";
+	}
+
+	out << ".size spslr_ipin_ops, .-spslr_ipin_ops\n";
+	return !!out;
+}
+
+/*
+ * Emit data pins. Each record names an already-existing object address that
+ * must be rewritten from original layout into randomized layout at startup.
+ */
+
+static bool emit_dpins(std::ostream &out, const std::vector<DPIN_REC> &dpins)
+{
+	if (!emit_u32_object(out, "spslr_dpin_cnt",
+			     static_cast<uint32_t>(dpins.size())))
+		return false;
+
+	out << ".globl spslr_dpins\n";
+	out << ".type spslr_dpins, @object\n";
+	out << ".balign 8\n";
+	out << "spslr_dpins:\n";
+
+	for (const DPIN_REC &dp : dpins) {
+		out << "\t.quad " << dp.addr_sym << "\n";
+		out << "\t.long " << dp.target << "\n";
+	}
+
+	out << ".size spslr_dpins, .-spslr_dpins\n";
+	return !!out;
+}
+
+}
+
+bool emit_patcher_program_asm(std::ostream &out, bool is_module)
+{
+	if (!is_module) {
+		if (!emit_header(out))
+			return false;
+	} else {
+		if (!emit_module_header(out))
+			return false;
+	}
+
+	/*
+	 * Runtime descriptors use dense array indexing, not maps. Therefore every
+	 * global target UID from 0 to targets.size()-1 must exist before emission.
+	 */
+	std::vector<TARGET_REC> target_recs(targets.size());
+	std::vector<TARGET_FIELD_REC> field_recs;
+
+	/*
+	 * Only the main executable emits the target layout table. Modules reuse the
+	 * executable's target map and contribute only their own ipins/dpins.
+	 */
+	if (!is_module) {
+		field_recs.reserve(64);
+
+		for (uint32_t uid = 0;
+		     uid < static_cast<uint32_t>(targets.size()); ++uid) {
+			if (!targets.contains(uid))
+				return false;
+
+			const TARGET &target = targets.at(uid);
+
+			TARGET_REC trec{};
+			trec.size = static_cast<uint32_t>(target.size);
+			trec.fieldoff =
+				static_cast<uint32_t>(field_recs.size());
+			trec.fieldcnt =
+				static_cast<uint32_t>(target.fields.size());
+
+			for (const auto &[off, field] : target.fields) {
+				(void)off;
+				field_recs.push_back(TARGET_FIELD_REC{
+					.offset = static_cast<uint32_t>(
+						field.offset),
+					.size = static_cast<uint32_t>(
+						field.size),
+					.alignment = static_cast<uint32_t>(
+						field.alignment),
+					.flags = static_cast<uint32_t>(
+						field.flags),
+				});
+			}
+
+			target_recs[uid] = trec;
+		}
+	}
+
+	std::vector<IPIN_REC> ipin_recs;
+	std::vector<IPIN_OP_REC> ipin_ops;
+	std::unordered_map<PROGRAM_KEY, uint32_t, PROGRAM_KEY_HASH> program_memo;
+
+	std::vector<DPIN_REC> dpin_recs;
+
+	for (const auto &[cu_uid, cu] : units) {
+		(void)cu_uid;
+
+		/*
+		 * Resolve each CU-local ipin to a global target and field index. Field offsets
+		 * from pinpoint are accepted only if they survived global target merging.
+		 */
+		for (const auto &[sym, ipin] : cu.ipins) {
+			const uint32_t global_target = static_cast<uint32_t>(
+				cu.local_targets.at(ipin.local_target));
+
+			if (!targets.contains(global_target))
+				return false;
+
+			const TARGET &target = targets.at(global_target);
+
+			if (!target.fields.contains(ipin.field_offset))
+				return false;
+
+			const FIELD &field =
+				target.fields.at(ipin.field_offset);
+
+			const uint32_t program = intern_simple_ipin_program(
+				ipin_ops, program_memo, global_target,
+				static_cast<uint32_t>(field.idx));
+
+			ipin_recs.push_back(IPIN_REC{
+				.addr_sym = ipin.symbol,
+				.size = static_cast<uint32_t>(ipin.imm_size),
+				.program = program,
+			});
+		}
+
+		for (const auto &[sym, dpin] : cu.dpins) {
+			std::vector<DPIN::COMPONENT> sorted_components(
+				dpin.components.begin(), dpin.components.end());
+
+			/*
+			 * Patch nested data from inside to outside.
+			 *
+			 * Rewriting an outer object may move the bytes containing an inner object.
+			 * Sorting by descending nesting level ensures inner target instances are
+			 * converted while their original addresses are still meaningful.
+			 */
+			std::sort(sorted_components.begin(),
+				  sorted_components.end(),
+				  [](const DPIN::COMPONENT &a,
+				     const DPIN::COMPONENT &b) {
+					  return a.level > b.level;
+				  });
+
+			for (const DPIN::COMPONENT &component :
+			     sorted_components) {
+				const uint32_t global_target =
+					static_cast<uint32_t>(
+						cu.local_targets.at(
+							component.target));
+
+				/*
+				 * A component offset turns one linker symbol into the address of an embedded
+				 * target instance inside that object.
+				 */
+				std::string addr = dpin.symbol;
+				if (component.offset != 0)
+					addr += " + " +
+						std::to_string(
+							component.offset);
+
+				dpin_recs.push_back(DPIN_REC{
+					.addr_sym = std::move(addr),
+					.target = global_target,
+				});
+			}
+		}
+	}
+
+	if (!is_module) {
+		if (!emit_targets(out, target_recs))
+			return false;
+		if (!emit_target_fields(out, field_recs))
+			return false;
+	}
+
+	if (!emit_ipins(out, ipin_recs))
+		return false;
+	if (!emit_ipin_ops(out, ipin_ops))
+		return false;
+	if (!emit_dpins(out, dpin_recs))
+		return false;
+
+	out << ".section .note.GNU-stack,\"\",@progbits\n";
+	return !!out;
+}
diff --git a/tools/spslr/src/patchcompile/emit.h b/tools/spslr/src/patchcompile/emit.h
new file mode 100644
index 000000000000..28f937852f5e
--- /dev/null
+++ b/tools/spslr/src/patchcompile/emit.h
@@ -0,0 +1,4 @@
+#pragma once
+#include <fstream>
+
+bool emit_patcher_program_asm(std::ostream &out, bool is_module);
diff --git a/tools/spslr/src/patchcompile/patchcompile.cpp b/tools/spslr/src/patchcompile/patchcompile.cpp
new file mode 100644
index 000000000000..6f5161206d87
--- /dev/null
+++ b/tools/spslr/src/patchcompile/patchcompile.cpp
@@ -0,0 +1,167 @@
+#include <string>
+#include <vector>
+#include <cstdint>
+#include <getopt.h>
+#include <filesystem>
+
+#include "accumulation.h"
+#include "emit.h"
+
+#include "patchcompile_error.h"
+
+bool patchcompile_verbose_enabled;
+
+/*
+ * spslr_patchcompile is the bridge between compiler metadata and runtime
+ * selfpatch descriptors.
+ *
+ * It consumes textual `.spslr` files emitted by pinpoint, merges compatible
+ * targets across compilation units, resolves CU-local target IDs to global
+ * runtime target IDs, and emits assembly defining the descriptor symbols read
+ * by selfpatch.
+ *
+ * For module builds, --load-targets imports the executable's target namespace
+ * and --no-new-targets ensures the module does not introduce randomization
+ * targets unknown to the already-running executable.
+ */
+
+struct OPTIONS {
+	std::string out_file;
+	std::string load_targets_file;
+	std::string dump_targets_file;
+	std::vector<std::string> spslr_files;
+	bool no_new_targets = false;
+	bool is_module = false;
+};
+
+int main(int argc, char **argv)
+{
+	static option long_options[] = {
+		{ "help", no_argument, 0, 0 },
+		{ "verbose", no_argument, 0, 0 },
+		{ "out", required_argument, 0, 0 },
+		{ "load-targets", required_argument, 0, 0 },
+		{ "dump-targets", required_argument, 0, 0 },
+		{ "no-new-targets", no_argument, 0, 0 },
+		{ "module", no_argument, 0, 0 },
+		{ 0, 0, 0, 0 }
+	};
+
+	OPTIONS opts{};
+	int option_index = 0;
+	int c;
+
+	patchcompile_verbose_enabled = false;
+
+	while ((c = getopt_long(argc, argv, "h:o:", long_options,
+				&option_index)) == 0) {
+		const option &opt = long_options[option_index];
+		std::string optname{ opt.name };
+
+		if (optname == "help") {
+			patchcompile_info(
+				"\nUsage:\n"
+				"  spslr_patchcompile --out=<file> [options] <file> ...\n\n"
+				"Options:\n"
+				"  --help\n"
+				"  --verbose\n"
+				"  --read-targets=<file>\n"
+				"  --emit-targets=<file>\n"
+				"  --no-new-targets\n"
+				"  --module\n");
+			return 0;
+		} else if (optname == "verbose") {
+			patchcompile_verbose_enabled = true;
+		} else if (optname == "out") {
+			opts.out_file = optarg;
+		} else if (optname == "load-targets") {
+			opts.load_targets_file = optarg;
+		} else if (optname == "dump-targets") {
+			opts.dump_targets_file = optarg;
+		} else if (optname == "no-new-targets") {
+			opts.no_new_targets = true;
+		} else if (optname == "module") {
+			opts.is_module = true;
+		} else {
+			patchcompile_error("invalid option '%s', try '--help'",
+					   optname.c_str());
+			return 1;
+		}
+	}
+
+	for (int i = optind; i < argc; ++i)
+		opts.spslr_files.emplace_back(argv[i]);
+
+	if (opts.out_file.empty()) {
+		patchcompile_error(
+			"missing output file path, supply it via '--out=<file>'");
+		return 1;
+	}
+
+	if (opts.spslr_files.empty()) {
+		patchcompile_error(
+			"missing spslr meta data files, pass them as positional arguments");
+		return 1;
+	}
+
+	/*
+	 * --no-new-targets only makes sense with a preloaded target map; otherwise
+	 * there is no existing namespace to validate against.
+	 */
+	if (opts.no_new_targets && opts.load_targets_file.empty()) {
+		patchcompile_error("--no-new-targets requires --load-targets");
+		return 1;
+	}
+
+	if (!opts.load_targets_file.empty()) {
+		if (!load_target_map(opts.load_targets_file)) {
+			patchcompile_error("failed to load target map from %s",
+					   opts.load_targets_file.c_str());
+			return 1;
+		}
+	}
+
+	if (!accumulate(opts.spslr_files, opts.no_new_targets)) {
+		patchcompile_error("failed to accumulate meta data");
+		return 1;
+	}
+
+	std::filesystem::path out_path{ opts.out_file };
+	if (out_path.has_parent_path()) {
+		std::error_code ec;
+		std::filesystem::create_directories(out_path.parent_path(), ec);
+		if (ec) {
+			patchcompile_error(
+				"failed to create output directory '%s' with error '%s'",
+				out_path.parent_path().c_str(),
+				ec.message().c_str());
+			return 1;
+		}
+	}
+
+	std::ofstream out(out_path);
+	if (!out) {
+		patchcompile_error("failed to open output file '%s'",
+				   opts.out_file.c_str());
+		return 1;
+	}
+
+	/*
+	 * The output is assembly rather than binary data so the normal assembler/linker
+	 * can resolve symbols referenced by ipin and dpin records.
+	 */
+	if (!emit_patcher_program_asm(out, opts.is_module)) {
+		patchcompile_error("failed to write spslr section");
+		return 1;
+	}
+
+	if (!opts.dump_targets_file.empty()) {
+		if (!dump_target_map(opts.dump_targets_file)) {
+			patchcompile_error("failed to write target map to '%s'",
+					   opts.dump_targets_file.c_str());
+			return 1;
+		}
+	}
+
+	return 0;
+}
diff --git a/tools/spslr/src/patchcompile/patchcompile_error.h b/tools/spslr/src/patchcompile/patchcompile_error.h
new file mode 100644
index 000000000000..93e2fc66055c
--- /dev/null
+++ b/tools/spslr/src/patchcompile/patchcompile_error.h
@@ -0,0 +1,41 @@
+#pragma once
+
+#include <cstdio>
+
+extern bool patchcompile_verbose_enabled;
+
+#define patchcompile_error(fmt, ...)                                          \
+	do {                                                                  \
+		std::fprintf(stderr, "[spslr::patchcompile] error: " fmt "\n", \
+			     ##__VA_ARGS__);                                  \
+	} while (0)
+
+#define patchcompile_file_error(f, l, fmt, ...)                               \
+	do {                                                                  \
+		std::fprintf(                                                 \
+			stderr,                                               \
+			"[spslr::patchcompile] error in %s at line %llu: " fmt \
+			"\n",                                                 \
+			f, l, ##__VA_ARGS__);                                 \
+	} while (0)
+
+#define patchcompile_warn(fmt, ...)                                     \
+	do {                                                            \
+		std::fprintf(stderr,                                    \
+			     "[spslr::patchcompile] warning: " fmt "\n", \
+			     ##__VA_ARGS__);                            \
+	} while (0)
+
+#define patchcompile_info(fmt, ...)                                          \
+	do {                                                                 \
+		std::fprintf(stderr, "[spslr::patchcompile] info: " fmt "\n", \
+			     ##__VA_ARGS__);                                 \
+	} while (0)
+
+#define patchcompile_debug(fmt, ...)                                          \
+	do {                                                                  \
+		if (patchcompile_verbose_enabled)                             \
+			std::fprintf(stderr,                                  \
+				     "[spslr::patchcompile] debug: " fmt "\n", \
+				     ##__VA_ARGS__);                          \
+	} while (0)
diff --git a/tools/spslr/src/patchcompile/spslr_list.h b/tools/spslr/src/patchcompile/spslr_list.h
new file mode 100644
index 000000000000..a8946b2fd0a1
--- /dev/null
+++ b/tools/spslr/src/patchcompile/spslr_list.h
@@ -0,0 +1,13 @@
+#ifndef SPSLR_LIST_H
+#define SPSLR_LIST_H
+
+#define SPSLR_IPIN_OP_PATCH 1
+#define SPSLR_IPIN_OP_ADD_INITIAL_OFFSET 2
+#define SPSLR_IPIN_OP_SUB_INITIAL_OFFSET 3
+#define SPSLR_IPIN_OP_ADD_OFFSET 4
+#define SPSLR_IPIN_OP_SUB_OFFSET 5
+#define SPSLR_IPIN_OP_ADD_CONST 6
+
+#define SPSLR_FLAG_FIELD_FIXED 1
+
+#endif
-- 
2.43.0

