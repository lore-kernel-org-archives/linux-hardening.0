Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D7C1CC162
	for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666558; cv=none; b=FBW6OlEP2S41mZM/q7hzDXlpEvQ/xuVrMHk+C2RksV8RQv3KxBbCUon/8Toi4e0b/h8rdWGAYox+e9aeXVWBVjg3DGeoxHiDP8S7aJz6Gqdrifw4Rc1mHya3gHAeB/Segry1gKw6mdLe6OmLNpqggw8pTDz2fjvAOr6c06czkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666558; c=relaxed/simple;
	bh=sAeCweVaF++1xPImV9kFPIzONcEieIfdQoCU4nI32ZM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cIE+RoDwnqIALmq3s7UU6UNA5KSxADr25EAiIep3SC/Vb0cjTJ7N5H9EYpX9D3AWVXIi//iVyxJUNyA7+UEYSX2Qnm3f+BSH38O9v4xEhhQgSaVk5phGdWvhA/AIeXdhal4nwiW3Xbn3F6Bo4jxj7PZ4uG2szwmg8O8fy7Eb65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ubrs4Hq2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubrs4Hq2"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e347b1e29dso14573297b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 10:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666556; x=1729271356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tkyFy75UvalNrKBAT+vGmyHx9oLFSJKfRi17QpMpSIY=;
        b=ubrs4Hq22sL0CeNjkrYSUGpWEWqjBdPyccWJxkRo55hazWY6aQjm94wIZOHwPwBkPj
         BszVaqeprZbYwjWnKTky7VNRZfsHohHmRoOh4zUr1BsYY5g+IG5GN6MNsrlyHFdBBGkn
         4ESYDuQN4l9qoKj9/n2ZBsUTB5aXW2lLgosTz+MKF7xMIOHhgJLD0mvuV+H6OecZzhr9
         km/oUyxuyBdy3572TGTxxUrpDnzRlH6WE7bh1llSV+Nq331Pr7A/MguHlp06YY2kbXeK
         tTb+lJWNOqL95N5ebUnVd9drk+qbECgJHPVNfe6S25XusNWNw3gEZC6XFIJBqGJXdwda
         iz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666556; x=1729271356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkyFy75UvalNrKBAT+vGmyHx9oLFSJKfRi17QpMpSIY=;
        b=dEUBPna+UnAWxjmOEosYuxqERYAT8LPuZPAkcfK+qxVU8aPWKw6Lo/uPgI901+MUXD
         j5+kTsNorYr7YjI9qEigoewFM/9OzLwfDKMctz2xfYuW/tjf6rnWUK8B61SzVCNI1Fw3
         0udnQVHbftdK03PVOe3W9R0qy5ufZ8o2bSs71gSSFZwd7d3hh39v6IqJ2sw1SIdkLLJW
         NFAVO8Q4gMDdQRYej9I20jdVLUa/MEkQUUzjwyJ0cAY716g7CoV+UI1JGKf1fcq24vRM
         rP1i5HRKHFpi7NFyxgKMQuzIMYKeZp3ofILsAiv0YaHo2FxtUgUvLrGKBSe4sSKjS5w/
         xNgw==
X-Forwarded-Encrypted: i=1; AJvYcCXQaa3pmj2YgQAewhBfyTpHTHBhKqmTx1yb282jyD7B43RyrEhsw74B+SPrrsqUF/PaVFqt4bDLNjOKVfqRpY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVUyUT4dCS5lzfBFnxEdskDXMKDB3hMiVOWD6mbB9c+vaPJMSs
	Tay7s6e4Zyj+qMK5VghlQloUAE/Kp0WnJpuUwPghjp8Ry+RUMNgBq59ARKFZt5PLq/+MnA==
X-Google-Smtp-Source: AGHT+IG8uyTeSXYrP2xbYDgV1i6m+IIf5hhHRlJp4OnDNqMleSdN0I9pfGlD5rZwlLnRFzNchILK3KTJ
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:2e01:b0:6dd:fda3:6568 with SMTP id
 00721157ae682-6e347b36782mr258307b3.3.1728666556111; Fri, 11 Oct 2024
 10:09:16 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:53 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=7204; i=ardb@kernel.org;
 h=from:subject; bh=gMBS2qjTsD8TMc2JpqTm0UjfHcu7H8Q7pFD2ywB6NtE=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zevm59bWM+taeTtUnFd+8kE8slUlWup/d9WzJm8u1R
 0TuHcvsKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABNZFc7wP/hEvt/0VkWLiV+k
 /TlDwo0Yp6ZNLDw3ndm25V+cllivHiPDtZwqc5PY5VPdi48k9an47rLmOcLw181DRpn7DAevpCQ zAA==
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-15-ardb+git@google.com>
Subject: [PATCH v3 5/8] objtool: Add generic support for jump table annotations
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Refactor the jump table handling code so that a generic code path is
provided that can identify jump tables attached to indirect jumps based
only on compiler provided annotations. This will be used by non-x86
architectures which do not support jump tables at all at this point.

Refactor the x86 code to share the logic that follows relocations on
instructions into the .rodata section and finds the associated symbols.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/arch/x86/special.c      | 46 ++++------
 tools/objtool/check.c                 | 88 +++++++++++++++++++-
 tools/objtool/include/objtool/check.h |  4 +
 3 files changed, 106 insertions(+), 32 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index cd964b85e2b1..08a5ce662974 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -112,46 +112,34 @@ static struct reloc *find_switch_table(struct objtool_file *file,
 				       struct instruction *insn,
 				       unsigned long *table_size)
 {
-	struct reloc  *text_reloc, *rodata_reloc;
-	struct section *table_sec;
-	unsigned long table_offset;
-
-	/* look for a relocation which references .rodata */
-	text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					      insn->offset, insn->len);
-	if (!text_reloc || text_reloc->sym->type != STT_SECTION ||
-	    !text_reloc->sym->sec->rodata)
-		return NULL;
-
-	table_offset = reloc_addend(text_reloc);
-	table_sec = text_reloc->sym->sec;
+	struct reloc *rodata_reloc;
+	struct symbol *sym = NULL;
 
-	if (reloc_type(text_reloc) == R_X86_64_PC32)
-		table_offset += 4;
+	/*
+	 * Each table entry has a rela associated with it.  The rela
+	 * should reference text in the same function as the original
+	 * instruction.
+	 */
+	rodata_reloc = find_rodata_sym_reference(file, insn, &sym);
 
 	/*
-	 * Make sure the .rodata address isn't associated with a
-	 * symbol.  GCC jump tables are anonymous data.
+	 * Annotations, if present, are attached to the indirect jump
+	 * instruction directly. In this case, a symbol annotation is
+	 * expected.
+	 *
+	 * Otherwise, make sure the .rodata address isn't associated with
+	 * a symbol. Unannotated GCC jump tables are anonymous data.
 	 *
 	 * Also support C jump tables which are in the same format as
 	 * switch jump tables.  For objtool to recognize them, they
 	 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
 	 * have symbols associated with them.
 	 */
-	if (find_symbol_containing(table_sec, table_offset) &&
-	    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
-		return NULL;
-
-	/*
-	 * Each table entry has a rela associated with it.  The rela
-	 * should reference text in the same function as the original
-	 * instruction.
-	 */
-	rodata_reloc = find_reloc_by_dest(file->elf, table_sec, table_offset);
-	if (!rodata_reloc)
+	if (insn->type != INSN_JUMP_DYNAMIC && sym &&
+	    strcmp(sym->sec->name, C_JUMP_TABLE_SECTION))
 		return NULL;
 
-	*table_size = 0;
+	*table_size = sym ? sym->len : 0;
 	return rodata_reloc;
 }
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 389475dde47c..b923d4a4efcb 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1372,6 +1372,8 @@ __weak const char *arch_nop_fentry_call(int len)
 
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
+	unsigned long offset = insn->offset;
+	unsigned int len = insn->len;
 	struct reloc *reloc;
 
 	if (insn->no_reloc)
@@ -1380,8 +1382,12 @@ static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *i
 	if (!file)
 		return NULL;
 
-	reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					 insn->offset, insn->len);
+	do {
+		/* Skip any R_*_NONE relocations */
+		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+						 offset++, len--);
+	} while (len && reloc && reloc_type(reloc) == R_NONE);
+
 	if (!reloc) {
 		insn->no_reloc = 1;
 		return NULL;
@@ -2169,10 +2175,86 @@ int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	return 0;
 }
 
+struct reloc *find_rodata_sym_reference(struct objtool_file *file,
+					struct instruction *insn,
+					struct symbol **table_sym)
+{
+	struct reloc *text_reloc, *rodata_reloc;
+	unsigned long addend;
+	struct symbol *sym;
+
+	/*
+	 * Look for a relocation which references .rodata. We must use
+	 * find_reloc_by_dest_range() directly here, as insn_reloc() filters
+	 * out R_*_NONE relocations which are used for jump table annotations.
+	 */
+	text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+					      insn->offset, insn->len);
+	if (!text_reloc) {
+		insn->no_reloc = 1;
+		return NULL;
+	}
+
+	sym = text_reloc->sym;
+	if (!sym->sec->rodata)
+		return NULL;
+
+	if (reloc_type(text_reloc) == elf_data_rela_type(file->elf))
+		addend = arch_dest_reloc_offset(reloc_addend(text_reloc));
+	else
+		addend = reloc_addend(text_reloc);
+
+	rodata_reloc = find_reloc_by_dest(file->elf, sym->sec,
+					  sym->offset + addend);
+	if (!rodata_reloc)
+		return NULL;
+
+	/*
+	 * Find the ELF symbol covering the destination of the relocation. This
+	 * is trivial if the reloc refers to a STT_OBJECT directly, but it may
+	 * have been emitted as section relative as well.
+	 */
+	if (sym->type == STT_SECTION)
+		sym = find_symbol_containing(sym->sec, addend);
+
+	*table_sym = sym;
+	return rodata_reloc;
+}
+
+/*
+ * Generic version of jump table handling, relying strictly on annotations
+ * provided by the compiler. Overridden for x86 using heuristics that attempt
+ * to correlate indirect jump instructions with preceding .rodata references.
+ */
 int __weak add_func_jump_tables(struct objtool_file *file,
 				struct symbol *func)
 {
-	return 0;
+	struct instruction *insn;
+	int ret = 0;
+
+	func_for_each_insn(file, func, insn) {
+		struct reloc *reloc;
+		struct symbol *sym;
+
+		if (insn->type != INSN_JUMP_DYNAMIC)
+			continue;
+
+		/*
+		 * Look for a relocation attached to this indirect jump that
+		 * references an ELF object in .rodata. This should be the jump
+		 * table annotation emitted by the compiler.
+		 */
+		reloc = find_rodata_sym_reference(file, insn, &sym);
+		if (reloc && sym && sym->len) {
+			insn->_jump_table = reloc;
+			insn->_jump_table_size = sym->len;
+
+			ret = add_jump_table(file, insn, NULL);
+			if (ret)
+				break;
+		}
+	}
+	return ret;
 }
 
 /*
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index e2f755484c4a..7781100c9340 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -140,4 +140,8 @@ struct instruction *next_insn_same_func(struct objtool_file *file, struct instru
 	     insn;							\
 	     insn = next_insn_same_func(file, insn))
 
+struct reloc *find_rodata_sym_reference(struct objtool_file *file,
+					struct instruction *insn,
+					struct symbol **sym);
+
 #endif /* _CHECK_H */
-- 
2.47.0.rc1.288.g06298d1525-goog

