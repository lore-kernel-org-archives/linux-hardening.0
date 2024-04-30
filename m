Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0D91C0DD2
	for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 23:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521073; cv=none; b=CUXrS11QRaL6fdKVVhxDh3PI5BO2nZeyS7ztrPmrxGge3oM7386YWWEhVluhg0ui8/PzuUJIzoyDLLRGj3ehyyWWRteROT8HmTm0wdcoAESAa+kewmf3ZR+DFomIe9SKQpJBenbngQx03BSk0XODohbirk5y+6gKGFbT7pK1Nd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521073; c=relaxed/simple;
	bh=tunHIi+g2h7hRr+bYsKyFGkeHCMhNPEBpe1sdelouTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IsA6eaIxGoAkKmXc8SR4Ske0B20o7ZUP4S6JQ6V8yiCX+0rDLrUGXBsVTKY6axl01NNE97ijNd3L3uW2tm04t176Uywv0xd5LDwe5c0UNlBz9lVkxpBMWAg6a/jZqzzdSqF5Me5TaaB9p3sQwVsXG3upGBzvvG1TZVIfo5nvL0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TZXjNx01; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TZXjNx01"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e5c7d087e1so54690145ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 30 Apr 2024 16:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714521070; x=1715125870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=isr0o1p4ELV76Jirfa57BN8xYD44bT1jEX3qsKxUGp4=;
        b=TZXjNx01q5qy/ApWAmYvX+nYqST8E7t3BKYVDm+Q7duaFc9yQMbjcbgP4Js7nnRb+T
         6tvYkvS76go7sAYWH6cYeieYNpWF9cUTgQllh7DU+PCUqgo5OdkekAkFdGnMjkqYgtv9
         +NPHstN4xRN4XM8p+HX3UqfMxjNlAih+8cDMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521070; x=1715125870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isr0o1p4ELV76Jirfa57BN8xYD44bT1jEX3qsKxUGp4=;
        b=sweie0eq3gycoGNGwlVioRxeNdgUWC72tTzyEr6KqJrxc7uGO7CrelK79pOh3wRXxo
         ETeDQLQ5ubrJ43tJ77hSmDNlaB9PGCX6VCpL6REW6avkNOafdCg4PYSuRRxjiXXe47YK
         pP1lSlr56zxv2NpdwUVRAcY3h93p1DHie8pl+4bkiUvGXdLoqGZrv/Fs01iFrIRRtlE4
         HotXOVdxrSaMz96rRZFRVSAfrbk8kLCruTFlE2vbW/8V+wdRjXkWNippNKA4rgz/+fUX
         0kj8i+kmmlUi1vbccfRyWpHxZrP/KnfhIiYVHFgp+w+HV/LwWOYD/pa50sTr4jx4vbet
         KlpA==
X-Forwarded-Encrypted: i=1; AJvYcCUnRWMNieoO0OEKGLIPRQOMw61fQF7VtbhdXCnh2K4RAbkh5qxjALmrnF3DsZqn2h34R37nNhkWDml2jwv4BM0nZEaIgypYS9XRQ/C+ZzAX
X-Gm-Message-State: AOJu0YydoN0Htpfe5y8P76EIAooWF3gQ58kD5xLdEK6n8EgC+PqdnLQr
	BNzJwR/7/psvCqvdysAqvrOTN8ZcA0Nqu+T9076UYPRf6/v68BTBdIgqic6PPQ==
X-Google-Smtp-Source: AGHT+IH90Ds04cXqGvOTz/xvAuPZEwT9EaB4/+RTFJR4vtPYxtkx7KGrZQQDM1QDaxjXGjsjbGU2pA==
X-Received: by 2002:a17:902:6807:b0:1ea:f7d4:b613 with SMTP id h7-20020a170902680700b001eaf7d4b613mr805421plk.62.1714521070144;
        Tue, 30 Apr 2024 16:51:10 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a170903228400b001eb50fdc38asm7168999plh.44.2024.04.30.16.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:51:09 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Youling Tang <tangyouling@loongson.cn>,
	Jinyang He <hejinyang@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] objtool: Provide origin hint for elf_init_reloc_text_sym() errors
Date: Tue, 30 Apr 2024 16:51:07 -0700
Message-Id: <20240430235106.work.680-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6645; i=keescook@chromium.org;
 h=from:subject:message-id; bh=tunHIi+g2h7hRr+bYsKyFGkeHCMhNPEBpe1sdelouTg=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmMYPrFZhhJqgTHe31lU/lPWd3vclwC9PT7FsyF
 r+aO2OF1bCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjGD6wAKCRCJcvTf3G3A
 JjH3D/93D7B2VgAUWKPs2GTAsZRLnXfau8FLf1TYKcdznYTjQLDVyfDs4sAyJmgpNiOCYncI2/t
 gSCvPfIQxJgtyP+6Tftd791ObK1gFGUMQgF3alZbmSdzvsZYmgDdXGiaAc2iFe1vjzwlZavo2LR
 WN1YpwWMXPEjaxb8gDxjQE/MYINUHMNsdvHlK5WvwTpep+Fkqf1br/hR15hCh4XPxXseOGrwnlx
 tRwJkg0+zfnBQsxkC5nE8hzdd90LiziciYh3QWLAhU0eKgr6aOnRzFovjsl9rMcPDWonR7m/w/V
 djE1vW6fWhakb3v7SMAG+5WhaAeiDj/7YMr2tsDx2LUw18KZpuTMVkpNObketrTjhi7eeIS98aD
 HJkXruFmTIQsJ1deObfTjxtiMEb8w5pCGTJXcEowAQA6bks8nJQChY7Q/ifl1EduXTxVHTKhWJ3
 Sy9dbfywC085SYsyPOe8ZX8mDEwqjbHy4TtTfj4gmKl8iehutZSl3gaFOHM3YHM7lsJpAdbIt2t
 jKqBw5luPyCIzRnYXSpjA5NyizM1jjVv5bm1jXeXGd8eLcsR4edyco9HNzRI8y2YcpFuqhJkuE1
 /Bp+Z+bHraYp6DI1eEaTxVYEIh2q2c5c7rrlCAT+gsHgd3IIww/a8o06swlCiDasunF/hEjfpaw
 b1cL414 veJe4s0Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

An error report from elf_init_reloc_text_sym() doesn't say what list of
symbols it is working on. Include this on the caller's side so it can be
reported when pathological conditions are encountered.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I added this to confirm debugging of
https://lore.kernel.org/lkml/202308301532.d7acf63e-oliver.sang@intel.com/
---
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Youling Tang <tangyouling@loongson.cn>
Cc: Jinyang He <hejinyang@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/objtool/arch/loongarch/orc.c  |  3 ++-
 tools/objtool/arch/x86/orc.c        |  3 ++-
 tools/objtool/check.c               | 21 +++++++++++++--------
 tools/objtool/elf.c                 |  7 ++++---
 tools/objtool/include/objtool/elf.h |  3 ++-
 5 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/arch/loongarch/orc.c b/tools/objtool/arch/loongarch/orc.c
index 873536d009d9..5ed9c1bb2de3 100644
--- a/tools/objtool/arch/loongarch/orc.c
+++ b/tools/objtool/arch/loongarch/orc.c
@@ -110,7 +110,8 @@ int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	memcpy(orc, o, sizeof(*orc));
 
 	/* populate reloc for ip */
-	if (!elf_init_reloc_text_sym(elf, ip_sec, idx * sizeof(int), idx,
+	if (!elf_init_reloc_text_sym("orc_list", elf, ip_sec,
+				     idx * sizeof(int), idx,
 				     insn_sec, insn_off))
 		return -1;
 
diff --git a/tools/objtool/arch/x86/orc.c b/tools/objtool/arch/x86/orc.c
index b6cd943e87f9..68a78ad0d99e 100644
--- a/tools/objtool/arch/x86/orc.c
+++ b/tools/objtool/arch/x86/orc.c
@@ -111,7 +111,8 @@ int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	orc->bp_offset = bswap_if_needed(elf, orc->bp_offset);
 
 	/* populate reloc for ip */
-	if (!elf_init_reloc_text_sym(elf, ip_sec, idx * sizeof(int), idx,
+	if (!elf_init_reloc_text_sym("orc_list", elf, ip_sec,
+				     idx * sizeof(int), idx,
 				     insn_sec, insn_off))
 		return -1;
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0a33d9195b7a..e7f7300ba88b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -701,7 +701,7 @@ static int create_static_call_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->static_call_list, call_node) {
 
 		/* populate reloc for 'addr' */
-		if (!elf_init_reloc_text_sym(file->elf, sec,
+		if (!elf_init_reloc_text_sym("static_call_list", file->elf, sec,
 					     idx * sizeof(*site), idx * 2,
 					     insn->sec, insn->offset))
 			return -1;
@@ -782,7 +782,8 @@ static int create_retpoline_sites_sections(struct objtool_file *file)
 	idx = 0;
 	list_for_each_entry(insn, &file->retpoline_call_list, call_node) {
 
-		if (!elf_init_reloc_text_sym(file->elf, sec,
+		if (!elf_init_reloc_text_sym("retpoline_call_list",
+					     file->elf, sec,
 					     idx * sizeof(int), idx,
 					     insn->sec, insn->offset))
 			return -1;
@@ -820,7 +821,8 @@ static int create_return_sites_sections(struct objtool_file *file)
 	idx = 0;
 	list_for_each_entry(insn, &file->return_thunk_list, call_node) {
 
-		if (!elf_init_reloc_text_sym(file->elf, sec,
+		if (!elf_init_reloc_text_sym("return_thunk_list",
+					     file->elf, sec,
 					     idx * sizeof(int), idx,
 					     insn->sec, insn->offset))
 			return -1;
@@ -874,7 +876,8 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 		     !strcmp(sym->name, "cleanup_module")))
 			WARN("%s(): not an indirect call target", sym->name);
 
-		if (!elf_init_reloc_text_sym(file->elf, sec,
+		if (!elf_init_reloc_text_sym("endbr_list",
+					     file->elf, sec,
 					     idx * sizeof(int), idx,
 					     insn->sec, insn->offset))
 			return -1;
@@ -922,7 +925,7 @@ static int create_cfi_sections(struct objtool_file *file)
 		if (strncmp(sym->name, "__cfi_", 6))
 			continue;
 
-		if (!elf_init_reloc_text_sym(file->elf, sec,
+		if (!elf_init_reloc_text_sym(".cfi_sites", file->elf, sec,
 					     idx * sizeof(unsigned int), idx,
 					     sym->sec, sym->offset))
 			return -1;
@@ -966,8 +969,10 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 
 		struct reloc *reloc;
 
-		reloc = elf_init_reloc_text_sym(file->elf, sec, idx * addr_size, idx,
-					       insn->sec, insn->offset);
+		reloc = elf_init_reloc_text_sym("mcount_loc_list",
+						file->elf, sec,
+						idx * addr_size, idx,
+						insn->sec, insn->offset);
 		if (!reloc)
 			return -1;
 
@@ -1007,7 +1012,7 @@ static int create_direct_call_sections(struct objtool_file *file)
 	idx = 0;
 	list_for_each_entry(insn, &file->call_list, call_node) {
 
-		if (!elf_init_reloc_text_sym(file->elf, sec,
+		if (!elf_init_reloc_text_sym("call_list", file->elf, sec,
 					     idx * sizeof(unsigned int), idx,
 					     insn->sec, insn->offset))
 			return -1;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d27983dc908..8615672e2ff9 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -881,7 +881,8 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	return reloc;
 }
 
-struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
+struct reloc *elf_init_reloc_text_sym(const char *origin,
+				      struct elf *elf, struct section *sec,
 				      unsigned long offset,
 				      unsigned int reloc_idx,
 				      struct section *insn_sec,
@@ -891,8 +892,8 @@ struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
 	int addend = insn_off;
 
 	if (!(insn_sec->sh.sh_flags & SHF_EXECINSTR)) {
-		WARN("bad call to %s() for data symbol %s",
-		     __func__, sym->name);
+		WARN("bad call to %s() for %s symbol %s",
+		     __func__, origin, sym->name);
 		return NULL;
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 2b8a69de4db8..d026e707806d 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -115,7 +115,8 @@ struct section *elf_create_section_pair(struct elf *elf, const char *name,
 
 struct symbol *elf_create_prefix_symbol(struct elf *elf, struct symbol *orig, long size);
 
-struct reloc *elf_init_reloc_text_sym(struct elf *elf, struct section *sec,
+struct reloc *elf_init_reloc_text_sym(const char *origin,
+				      struct elf *elf, struct section *sec,
 				      unsigned long offset,
 				      unsigned int reloc_idx,
 				      struct section *insn_sec,
-- 
2.34.1

