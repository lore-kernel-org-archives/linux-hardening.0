Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5991C8FAA
	for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728666556; cv=none; b=BC5Qh1d4dsfnJ953jBx3Htw2anrrhZip1G87oCBYFOaSbs+PvPxL2gGN51w0V1u4FTCJtLj2H64QtNnm5kXWVay5m2EYhf85+0gko/57098LHXmSoawDILSYVnA0fd4V+QfiSrAJ4fizJy3HIRAb9GB3VPAKr+dB41PorXlQpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728666556; c=relaxed/simple;
	bh=sRBC3imC2fsNC2651TKH0KS++dKocaTpJWGS92trpJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VilgCtFtWWF+alUuZNcqwU4YiJvnMzzKS4XJ8XzWXWzH7I+tLQ6QBw63CCe3z2H2RODyOM+69ZW3Qmv/UJEaPiG6A7hbRrfB+WYTmv9ilFiR9939PUEYQeP9XX9FJJXJwntBO3S1QxgbmXo28PR1noUYQpa+JQsO9wBlPf1X3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSOi1Eyo; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSOi1Eyo"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e35865abe9so7554487b3.0
        for <linux-hardening@vger.kernel.org>; Fri, 11 Oct 2024 10:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728666554; x=1729271354; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NFjU8MWypV/vmYVD9Z8mN2L/hjHRNn6Cg6IdwFQVZM=;
        b=uSOi1EyooFA6gjHawXWVqci9Bykcixp/hd/8E8yf4qkif4inwH/yokm4/itPW1NNgy
         qT9NkcV2jPLvwTUVQ6o1hXfB/ugtb3hwNs7GjpLNbabP6qvou7p6AlRu41w+2UQaSQ5K
         CjvCO8dibaLYnxFHI3MoNbn900Agf5091GfNTy0E4Ehu5MFDG/tVh2pZfTM3fCfFz2Ft
         qC8YfjwkWLyoPet7IFsRJd15yXRfRFoS09M+AWrhfXbXZcwdpHBQW3H+qNEZOctgBq+E
         Oc114aJ9nVeDP5sjmDQj1gvEGzJ63arVHYTK9kBju/i5my4V2GwjhBJJn9KHV26dZJ5W
         FY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728666554; x=1729271354;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NFjU8MWypV/vmYVD9Z8mN2L/hjHRNn6Cg6IdwFQVZM=;
        b=lP5aFS/Wfek+lbiO8nWcX3ANPyZNzis54fLpCo3eQ6S2M+QLUpIFiBQbBU+nB5T3gi
         lhlOu9PVL3PKnsqpsERCMeJgJtRMGyjFfxH+MHpzeuVuhd6i+Mq2zGTred5GoSyYiXD5
         2coPgxNLqch/onCVq7wHPqaM+gRd8hPTv/z6m8Jgt1oOCxrpadZ5jieBrM2Ixt7fXpk5
         VBi28WrIV0jPAj7pvLHdYJj+hf4d08de0FNp9+FyJu2PLVMKD8amRLLXyuuhPI9axY5b
         xk7sdK7XKbM3b2WwaMS5zuw3yKRfUlLep4L4CBL8tZCQw3qJQ50Ss1kORvwVzp2jvkvE
         R3kw==
X-Forwarded-Encrypted: i=1; AJvYcCVVE9DLO/wLiBoaCNrNrYq0956G+ku6j4wfXfJCcgkWvT9BxpueEWmQKz4R7EOUHzqjF+hddLqY45Jmg8fuqdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNwkfLX4yJcgI7OrqrHh1gRdQHt8dHyBfvRr8CAF4fGm0JCL29
	cwy2zokUVOLCwi8UdMy89Ra6g723KHWHM+3b8SMATy0Gby6ZKMDf9MlInRxEs/c5OdauUA==
X-Google-Smtp-Source: AGHT+IGMNagPLd2f5e3cks8tlI/NbU5Eiyxm0UEjGwCJmB1Pvx62gpt8GDgIRWCX+baPrvA1I2aArE9A
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:690c:5048:b0:6db:bd8f:2c59 with SMTP id
 00721157ae682-6e347b3aa77mr657047b3.4.1728666553837; Fri, 11 Oct 2024
 10:09:13 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:08:52 +0200
In-Reply-To: <20241011170847.334429-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011170847.334429-10-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=10349; i=ardb@kernel.org;
 h=from:subject; bh=Ubt7RQjuRDIfCARVycqrXHI/7Y7hGzCx+rj5JuA2brA=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ0zemnHHr2KoxPDrWaG8jOvEHNbtmqutkHemsRvq+fMK
 TE41jWjo5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEyku5zhf8LMnDCH1BctSt81
 m+5cDbr5KerLtMDgrU32/x4zLv9pWs3IsK/V6oTzsQ/P/+/V7FUU+mq3Skz3cuI6ZgO+fEnha5l PGQE=
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241011170847.334429-14-ardb+git@google.com>
Subject: [PATCH v3 4/8] objtool: Move jump table heuristics to a x86 specific
 source file
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

In preparation for implementing support for the use of compiler emitted
jump table annotations, move the existing code out of the generic
sources. This will permit a clean separation between the two approaches,
where the old one will not be wired up for architectures other than x86.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/arch/loongarch/special.c  |   7 --
 tools/objtool/arch/powerpc/special.c    |   7 --
 tools/objtool/arch/x86/special.c        | 114 +++++++++++++++++++-
 tools/objtool/check.c                   | 112 +------------------
 tools/objtool/include/objtool/special.h |   9 +-
 5 files changed, 122 insertions(+), 127 deletions(-)

diff --git a/tools/objtool/arch/loongarch/special.c b/tools/objtool/arch/loongarch/special.c
index 87230ed570fd..acf3a391a2f9 100644
--- a/tools/objtool/arch/loongarch/special.c
+++ b/tools/objtool/arch/loongarch/special.c
@@ -7,10 +7,3 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 {
 	return false;
 }
-
-struct reloc *arch_find_switch_table(struct objtool_file *file,
-				     struct instruction *insn,
-				     unsigned long *table_size)
-{
-	return NULL;
-}
diff --git a/tools/objtool/arch/powerpc/special.c b/tools/objtool/arch/powerpc/special.c
index 51610689abf7..3a108437cfa6 100644
--- a/tools/objtool/arch/powerpc/special.c
+++ b/tools/objtool/arch/powerpc/special.c
@@ -11,10 +11,3 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
 {
 	exit(-1);
 }
-
-struct reloc *arch_find_switch_table(struct objtool_file *file,
-				     struct instruction *insn,
-				     unsigned long *table_size)
-{
-	exit(-1);
-}
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index f8fb67636384..cd964b85e2b1 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -108,9 +108,9 @@ bool arch_support_alt_relocation(struct special_alt *special_alt,
  *
  *    NOTE: MITIGATION_RETPOLINE made it harder still to decode dynamic jumps.
  */
-struct reloc *arch_find_switch_table(struct objtool_file *file,
-				     struct instruction *insn,
-				     unsigned long *table_size)
+static struct reloc *find_switch_table(struct objtool_file *file,
+				       struct instruction *insn,
+				       unsigned long *table_size)
 {
 	struct reloc  *text_reloc, *rodata_reloc;
 	struct section *table_sec;
@@ -154,3 +154,111 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	*table_size = 0;
 	return rodata_reloc;
 }
+
+/*
+ * find_jump_table() - Given a dynamic jump, find the switch jump table
+ * associated with it.
+ */
+static void find_jump_table(struct objtool_file *file,
+			    struct symbol *func,
+			    struct instruction *insn)
+{
+	struct reloc *table_reloc;
+	struct instruction *dest_insn, *orig_insn = insn;
+	unsigned long table_size;
+
+	/*
+	 * Backward search using the @first_jump_src links, these help avoid
+	 * much of the 'in between' code. Which avoids us getting confused by
+	 * it.
+	 */
+	for (;
+	     insn && insn_func(insn) && insn_func(insn)->pfunc == func;
+	     insn = insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
+
+		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
+			break;
+
+		/* allow small jumps within the range */
+		if (insn->type == INSN_JUMP_UNCONDITIONAL &&
+		    insn->jump_dest &&
+		    (insn->jump_dest->offset <= insn->offset ||
+		     insn->jump_dest->offset > orig_insn->offset))
+		    break;
+
+		table_reloc = find_switch_table(file, insn, &table_size);
+		if (!table_reloc)
+			continue;
+		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
+		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
+			continue;
+
+		orig_insn->_jump_table = table_reloc;
+		orig_insn->_jump_table_size = table_size;
+		break;
+	}
+}
+
+/*
+ * First pass: Mark the head of each jump table so that in the next pass,
+ * we know when a given jump table ends and the next one starts.
+ */
+static void mark_func_jump_tables(struct objtool_file *file,
+				    struct symbol *func)
+{
+	struct instruction *insn, *last = NULL;
+
+	func_for_each_insn(file, func, insn) {
+		if (!last)
+			last = insn;
+
+		/*
+		 * Store back-pointers for unconditional forward jumps such
+		 * that find_jump_table() can back-track using those and
+		 * avoid some potentially confusing code.
+		 */
+		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
+		    insn->offset > last->offset &&
+		    insn->jump_dest->offset > insn->offset &&
+		    !insn->jump_dest->first_jump_src) {
+
+			insn->jump_dest->first_jump_src = insn;
+			last = insn->jump_dest;
+		}
+
+		if (insn->type == INSN_JUMP_DYNAMIC)
+			find_jump_table(file, func, insn);
+	}
+}
+
+int add_func_jump_tables(struct objtool_file *file,
+			 struct symbol *func)
+{
+	struct instruction *insn, *insn_t1 = NULL, *insn_t2;
+	int ret = 0;
+
+	mark_func_jump_tables(file, func);
+
+	func_for_each_insn(file, func, insn) {
+		if (!insn_jump_table(insn))
+			continue;
+
+		if (!insn_t1) {
+			insn_t1 = insn;
+			continue;
+		}
+
+		insn_t2 = insn;
+
+		ret = add_jump_table(file, insn_t1, insn_jump_table(insn_t2));
+		if (ret)
+			return ret;
+
+		insn_t1 = insn_t2;
+	}
+
+	if (insn_t1)
+		ret = add_jump_table(file, insn_t1, NULL);
+
+	return ret;
+}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index fbb05e973acc..389475dde47c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2091,8 +2091,8 @@ static int add_special_section_alts(struct objtool_file *file)
 	return ret;
 }
 
-static int add_jump_table(struct objtool_file *file, struct instruction *insn,
-			  struct reloc *next_table)
+int add_jump_table(struct objtool_file *file, struct instruction *insn,
+		   struct reloc *next_table)
 {
 	unsigned long table_size = insn_jump_table_size(insn);
 	struct symbol *pfunc = insn_func(insn)->pfunc;
@@ -2169,111 +2169,10 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	return 0;
 }
 
-/*
- * find_jump_table() - Given a dynamic jump, find the switch jump table
- * associated with it.
- */
-static void find_jump_table(struct objtool_file *file, struct symbol *func,
-			    struct instruction *insn)
+int __weak add_func_jump_tables(struct objtool_file *file,
+				struct symbol *func)
 {
-	struct reloc *table_reloc;
-	struct instruction *dest_insn, *orig_insn = insn;
-	unsigned long table_size;
-
-	/*
-	 * Backward search using the @first_jump_src links, these help avoid
-	 * much of the 'in between' code. Which avoids us getting confused by
-	 * it.
-	 */
-	for (;
-	     insn && insn_func(insn) && insn_func(insn)->pfunc == func;
-	     insn = insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
-
-		if (insn != orig_insn && insn->type == INSN_JUMP_DYNAMIC)
-			break;
-
-		/* allow small jumps within the range */
-		if (insn->type == INSN_JUMP_UNCONDITIONAL &&
-		    insn->jump_dest &&
-		    (insn->jump_dest->offset <= insn->offset ||
-		     insn->jump_dest->offset > orig_insn->offset))
-		    break;
-
-		table_reloc = arch_find_switch_table(file, insn, &table_size);
-		if (!table_reloc)
-			continue;
-		dest_insn = find_insn(file, table_reloc->sym->sec, reloc_addend(table_reloc));
-		if (!dest_insn || !insn_func(dest_insn) || insn_func(dest_insn)->pfunc != func)
-			continue;
-
-		orig_insn->_jump_table = table_reloc;
-		orig_insn->_jump_table_size = table_size;
-		break;
-	}
-}
-
-/*
- * First pass: Mark the head of each jump table so that in the next pass,
- * we know when a given jump table ends and the next one starts.
- */
-static void mark_func_jump_tables(struct objtool_file *file,
-				    struct symbol *func)
-{
-	struct instruction *insn, *last = NULL;
-
-	func_for_each_insn(file, func, insn) {
-		if (!last)
-			last = insn;
-
-		/*
-		 * Store back-pointers for unconditional forward jumps such
-		 * that find_jump_table() can back-track using those and
-		 * avoid some potentially confusing code.
-		 */
-		if (insn->type == INSN_JUMP_UNCONDITIONAL && insn->jump_dest &&
-		    insn->offset > last->offset &&
-		    insn->jump_dest->offset > insn->offset &&
-		    !insn->jump_dest->first_jump_src) {
-
-			insn->jump_dest->first_jump_src = insn;
-			last = insn->jump_dest;
-		}
-
-		if (insn->type != INSN_JUMP_DYNAMIC)
-			continue;
-
-		find_jump_table(file, func, insn);
-	}
-}
-
-static int add_func_jump_tables(struct objtool_file *file,
-				  struct symbol *func)
-{
-	struct instruction *insn, *insn_t1 = NULL, *insn_t2;
-	int ret = 0;
-
-	func_for_each_insn(file, func, insn) {
-		if (!insn_jump_table(insn))
-			continue;
-
-		if (!insn_t1) {
-			insn_t1 = insn;
-			continue;
-		}
-
-		insn_t2 = insn;
-
-		ret = add_jump_table(file, insn_t1, insn_jump_table(insn_t2));
-		if (ret)
-			return ret;
-
-		insn_t1 = insn_t2;
-	}
-
-	if (insn_t1)
-		ret = add_jump_table(file, insn_t1, NULL);
-
-	return ret;
+	return 0;
 }
 
 /*
@@ -2293,7 +2192,6 @@ static int add_jump_table_alts(struct objtool_file *file)
 		if (func->type != STT_FUNC)
 			continue;
 
-		mark_func_jump_tables(file, func);
 		ret = add_func_jump_tables(file, func);
 		if (ret)
 			return ret;
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index e7ee7ffccefd..019b511eca6e 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -37,7 +37,10 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt);
 bool arch_support_alt_relocation(struct special_alt *special_alt,
 				 struct instruction *insn,
 				 struct reloc *reloc);
-struct reloc *arch_find_switch_table(struct objtool_file *file,
-				     struct instruction *insn,
-				     unsigned long *table_size);
+
+int add_func_jump_tables(struct objtool_file *file, struct symbol *func);
+
+int add_jump_table(struct objtool_file *file, struct instruction *insn,
+		   struct reloc *next_table);
+
 #endif /* _SPECIAL_H */
-- 
2.47.0.rc1.288.g06298d1525-goog

