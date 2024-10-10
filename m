Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F31C4610
	for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 12:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563299; cv=none; b=UXOdRVE5CJTzKt2dhjWD8VLKOiwaH4oy5bqqcspmNBPq6zjS/7XcZ3g0qGgYFwlRT5mANlVtbowss08IB3Vb2C2fKWiSa3u34MunZx6wkveYj9qWSFQTqwqd+qFe0lLUszFe/2yHW0u8D8IUhChChK1ZixsaEQDr0FcN1Ms4Mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563299; c=relaxed/simple;
	bh=3ypYKGSzXikE1B2PepVX9e//JhorszwPHFIwfpOHiGY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bSE6XixAxugz+PpaWgVudS3c+J7JI/emVeorVNmRZjVRKhI/eUUDgqzR6wrBCEZoWSsArsh/DlxWvJBw4po2UkUsE6aFfPvx3an5QmjlGsnqE0MdWMY/w0ysp9fJDuneI1A4yQmEtt0H3nG8lEG9JbUL+bafDGkeOtZb1VAe2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rXuUtr3v; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rXuUtr3v"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43057c9b32bso5411515e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 05:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563296; x=1729168096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEuVSEUio0W9/y2JZlJcnuGE1IpZn4WTPPWZxA7pzx4=;
        b=rXuUtr3vhURmsFhor46aW0b6+Vn3KjshHCR97fcMo62KzIQ2JLIJ+OHjFLaRH/ssKY
         apNwCVj2Y+hpKvrD1I9geCJ7iusmWwc8uETnzglojFcoqneJ1yx4B61ty6WEhILn4GFt
         WlL9ir4mhguFqxsolZJ3mJE27X3bEDRKT9KeNSJzoVNbOovlSLzDfrc2E+UG/zaR8ZxK
         hp2bS15Ftp7uajqN8AfbeiEFa83TV6K5lUQKuf3Xr0aNQXHgbkl5ffe21e98840xYD5z
         WJXrLHWumV5Zd/pr31nOxPwWrY7wuTkgwjTOL25c4d7rJEFofw2EmCQ8ScFpQ9SXNNTP
         Tj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563296; x=1729168096;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEuVSEUio0W9/y2JZlJcnuGE1IpZn4WTPPWZxA7pzx4=;
        b=djPl4gX1IWmfbYP8KANlPQmmiSojsLZ4OPSCwTO5OvLPS2aCLxbe9enpmcpe4Pxuy+
         Cc28kYYxbOzE/jYWIFDJgZirf3eIfzu6fRcJ+2Ebf8vdL74vJLiodpwa1ubq6CKK3ysC
         5O3I3tFME0b/M+NJwUaV/AivYeTxQj8r7o2i+sccqSaGg4F/3WFcgF55A0MXzuzy5mEm
         YB7dkmgGio7XuE+xyV1yC+srOWMKt+tShTN6guuee3Zlu8ZFT3y6+KFUipxOyTHFkgpX
         pBD92qf8HGbWJi9i88mjsSJKFKLXJ/FxT/oh9MPEympV+649pzx3uIlJqT8WzYiYPM22
         bdZg==
X-Forwarded-Encrypted: i=1; AJvYcCXlI74kwOgH4vS/lvyKOjNbkeehBvx2GJd30weCQB1I6duXr3T30pjbsQT45HvljjoXUCDHcNfNdyfyz0qGPV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwdFzxmeSFqYf4fceOnOWgdLNAIkVtMuwmRdnOai6KpZykhgQ
	C89I8TqAIkjxIH+YFZohtcTL3i75wf8YWgOst2jXozgK5d75WQE0A6S6En4Usz5h+yonVg==
X-Google-Smtp-Source: AGHT+IH8bAk+Lmp5dtvOjzTyZbYIM9r3sv/N3dIVhPFX8SwT+VjdV4Gg9WTBTFNkFQvxbYTAojWxs4Jd
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a7b:c7c8:0:b0:42c:b55a:2be7 with SMTP id
 5b1f17b1804b1-430d70b3d5amr140785e9.6.1728563295804; Thu, 10 Oct 2024
 05:28:15 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:03 +0200
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=5174; i=ardb@kernel.org;
 h=from:subject; bh=X/1hdeUniupkXR56uj3gYLJGGRs5DubM6blrWxZVFtk=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RMj3x1vjymbzxTjlhSxzlHwbHvSq+dCE53cZerw8t
 3qaxu3rKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABMR38Hwz/JU/rnurJmaP13m
 sHtFvK/P/fNBIjTpbydv5MRJ5/QWiDEy9G97ZLkvWCMsKas76enNmfrxphopFy4sPrPzQeavjBt mHAA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-8-ardb+git@google.com>
Subject: [PATCH v2 1/5] objtool: Deal with relative jump tables correctly
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
index 3cb3e9b5ad0b..7f7981a93535 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2101,6 +2101,8 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 {
 	struct symbol *pfunc = insn_func(insn)->pfunc;
 	struct reloc *table = insn_jump_table(insn);
+	unsigned int rtype = reloc_type(table);
+	bool pcrel = rtype == R_X86_64_PC32;
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
@@ -4536,7 +4554,7 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
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
2.47.0.rc0.187.ge670bccf7e-goog

