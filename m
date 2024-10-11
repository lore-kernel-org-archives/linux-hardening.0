Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD4F1A08A4
	for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666549; cv=none; b=GKeqShX/IT00j4RwccSlXQ+el5NQ8sUg4GKAulfHgaB6D2bVbvZL/DoZIBNF6v0JEww5cdr8gWC+76rwE89FajU4roafiMZvQEg98V/As1QYYWAbD5Di/zxWFe3WH6fCWWhJ4+ZFHrKMNO1pxcJu6405I7Ld6+WDlyqjFv1BKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666549; c=relaxed/simple;
	bh=i07p+euZWicvD4DcduG6W8DaYxJyYJVcmSBCOXNMKfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IPKJxYQN8uwOZTJDbYt+/2lWKgXmGryuf1lAvk680RZV/nQ9nOzqDzo3Ek7IC+ng0PYgByoIftS6JOls0FSi+x7c7PlIUtpflDGFV/ZRCayDOr3k14aBa7lYC4M64XcPKmDPXtStV1o4R1MVsDMNnieNUwChylrm7TYtJrAtKUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jnMqtx0o; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jnMqtx0o"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e29135d1d0cso2460370276.1
        for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 10:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666546; x=1729271346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3qdWVRrVbX3ToZU4Q5VrJuHDTTEiDMG3j538Hbt/T70=;
        b=jnMqtx0oHMW1aQE7Sf7L8F16R6JC4ng7z+VfLXTnUI1LXXD1CwPp/AHetlZviYmOgJ
         WIanZlVOYBnAWdTyjhy4tW7jCBgc2E8x3nnxA9UV76ZmfR23WQZbLCpvhHbBlXL7TPAJ
         0PuL1dbM2TJ2rRh3zfOzsqQqq1n1syvNd8mZ2LJTNoh7xMmPXhaC44PJvP4OrFJ0pDSA
         /xCyUFn59BWhpJ796YZ1K7yD6hDs/8NA6nsGNpGoLWrUpz4+CVzC6D3UeTWFX48fxLpe
         k03G2YSDKzjMG+Bnl82b8cnMHXpDI30P/ViVtQK+fK5VEWt4wYPGdJcQg6JHqOQjLKuF
         gitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666546; x=1729271346;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3qdWVRrVbX3ToZU4Q5VrJuHDTTEiDMG3j538Hbt/T70=;
        b=IPxfkfHaOO9JgzTFYrFkrjegarROrcfAOWbyXyhkShmKgz9IJ8TbO+1+jVx/pYOsG1
         qcZYWZyhkuFcebeDn1Hm6BpMx0rGOeQk5o5FuS/36y3GykZst/oxs14p5MN2U7enA6oN
         0NhLubBS9dUBScnAbL3DurxAYel/Bz3g6a5jdDGJO/4nAXZaOsUugS5riwR+DUekZ0Lh
         HOP6Px7ZEiWqfaC5cRLOl/6aNIm6+HQDcBPQQTlakqBQICxs/KIS/c4na+Sla+21LBYV
         WFX/LHe/esUw72qwN+O+/SwhsnBhm7S5beFZ5rKRluGhF8hry8UWjG2zV/BuHuQcYPZP
         a33Q==
X-Forwarded-Encrypted: i=1; AJvYcCWkfLAKWh0SpUTSwkklmlB2nb8hBfr4p+dBfgwsrLn+YXEHranA1a8KpkbK4tIdudc+ZjnW93Ran8hRYF2RsyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtyMiTR6Ypn6KuxOahO48OKioPm4WxCfBxlifeT8N23waLLb4j
	a1OdxDoWzuaLSv2iJ++4AdmXn1+DGVw4gSIYr176beZZNk0nPU7vqT038nQVG1aL+UAtAw==
X-Google-Smtp-Source: AGHT+IFwVip20YS7zwHFgmSUuevuRJVKrZKv+7d3ChvsNAmYTytYT9sUmJLT2/L4RZPtMTdbzwTJa4eT
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:8702:0:b0:e29:1864:5215 with SMTP id
 3f1490d57ef6-e2919dbd114mr2278276.1.1728666546408; Fri, 11 Oct 2024 10:09:06
 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:49 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5192; i=ardb@kernel.org;
 h=from:subject; bh=fphk4j28lP0ahlwTC1zZcurlE54ngflWbp7fP3s2REU=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zeuFpSY6nGevt91Rsfhp+64WWcP6J5R9O/6l/rSZ90
 fnRMgvHjlIWBjEOBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCRTi2G/36ng8X4bqic8m/f
 wLih91nnA+6eUw/bohXsLjPVTN+2sJ6R4ZjGX/tvOUt3RjnytGbvmluqrf16c+Cn67sN3ilkF01 bxwAA
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-11-ardb+git@google.com>
Subject: [PATCH v3 1/8] objtool: Deal with relative jump tables correctly
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Relative jump tables contain entries that carry the offset between the
target of the jump and the start of the jump table. This permits the use
of the PIC idiom of

    leaq    jump_table(%rip), %tbl
    movslq  (%tbl,%idx,4), %offset
    addq    %offset, %tbl
    jmp     *%tbl

The jump table entries are decorated with PC32 relocations, which record
the offset of the referenced symbol relative to the target of the
relocation, which is the individual entry in the table.  This means that
only the first entry produces the correct value directly; the subsequent
ones need to be corrected to produce the offset relative to the start of
the table, by applying an addend.

Given that the referenced symbols are anonymous, and thus already
expressed in terms of sections and addends, e.g., .text+0x5df9, the
correction is incorporated into the existing addend. The upshot of this
is that chasing the reference to find the target instruction needs to
take this second addend into account as well.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/arch/x86/special.c    |  8 -------
 tools/objtool/check.c               | 24 +++++++++++++++++---
 tools/objtool/include/objtool/elf.h |  6 +++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 4ea0f9815fda..415e4d035e53 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -150,13 +150,5 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	if (!rodata_reloc)
 		return NULL;
 
-	/*
-	 * Use of RIP-relative switch jumps is quite rare, and
-	 * indicates a rare GCC quirk/bug which can leave dead
-	 * code behind.
-	 */
-	if (reloc_type(text_reloc) == R_X86_64_PC32)
-		file->ignore_unreachables = true;
-
 	return rodata_reloc;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2b0965153b25..aa07fdf1cf13 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2101,6 +2101,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 {
 	struct symbol *pfunc = insn_func(insn)->pfunc;
 	struct reloc *table = insn_jump_table(insn);
+	unsigned int rtype = reloc_type(table);
+	bool pcrel = (rtype == elf_text_rela_type(file->elf));
 	struct instruction *dest_insn;
 	unsigned int prev_offset = 0;
 	struct reloc *reloc = table;
@@ -2111,13 +2113,18 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	 * instruction.
 	 */
 	for_each_reloc_from(table->sec, reloc) {
+		unsigned long addend = reloc_addend(reloc);
 
 		/* Check for the end of the table: */
 		if (reloc != table && reloc == next_table)
 			break;
 
+		/* Each entry in the jump table should use the same relocation type */
+		if (reloc_type(reloc) != rtype)
+			break;
+
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + (pcrel ? 4 : 8))
 			break;
 
 		/* Detect function pointers from contiguous objects: */
@@ -2125,7 +2132,15 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		    reloc_addend(reloc) == pfunc->offset)
 			break;
 
-		dest_insn = find_insn(file, reloc->sym->sec, reloc_addend(reloc));
+		/*
+		 * Place-relative jump tables carry offsets relative to the
+		 * start of the jump table, not to the entry itself. So correct
+		 * the addend for the location of the entry in the table.
+		 */
+		if (pcrel)
+			addend -= reloc_offset(reloc) - reloc_offset(table);
+
+		dest_insn = find_insn(file, reloc->sym->sec, addend);
 		if (!dest_insn)
 			break;
 
@@ -2133,6 +2148,9 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		if (!insn_func(dest_insn) || insn_func(dest_insn)->pfunc != pfunc)
 			break;
 
+		if (pcrel)
+			reloc->sym_offset = addend;
+
 		alt = malloc(sizeof(*alt));
 		if (!alt) {
 			WARN("malloc failed");
@@ -4535,7 +4553,7 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 	struct instruction *dest;
 
 	dest = find_insn(file, reloc->sym->sec,
-			 reloc->sym->offset + reloc_addend(reloc));
+			 reloc->sym->offset + reloc_sym_offset(reloc));
 	if (!dest)
 		return 0;
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d7e815c2fd15..f4a6307f4c08 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -78,6 +78,7 @@ struct reloc {
 	struct section *sec;
 	struct symbol *sym;
 	struct reloc *sym_next_reloc;
+	s64 sym_offset;
 };
 
 struct elf {
@@ -251,6 +252,11 @@ static inline s64 reloc_addend(struct reloc *reloc)
 	return __get_reloc_field(reloc, r_addend);
 }
 
+static inline s64 reloc_sym_offset(struct reloc *reloc)
+{
+	return reloc->sym_offset ?: reloc_addend(reloc);
+}
+
 static inline void set_reloc_addend(struct elf *elf, struct reloc *reloc, s64 addend)
 {
 	__set_reloc_field(reloc, r_addend, addend);
-- 
2.47.0.rc1.288.g06298d1525-goog

