Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F851C4635
	for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 12:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563304; cv=none; b=rkBZh0Jf4o9B1+RFla2FfDKS7mXmqcDKEh032KV8TTYBIG4Y3rBY1BruIB/BFTeSDOLsgR0XhV6Q8VslWQuPpDE8GmK4j+uU8qU/T8JLaUnMHvnaUj1VsnP93G16yzZ1xPqncSogfBkbN8zGQAk+3Cq3ofOS4Mg4d2W2PyD1i2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563304; c=relaxed/simple;
	bh=8A7Rduxh7B7wBcV+WeKKZLLPV5xHM3xV32Vl9/HOJpA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DOJJFq4niXFg6EPb1YzR3lxH09hKfrx3ixXex2YWhoGjRO0wssm6rzc+wLpW0orurS8QXJWRjxPo2zhmmlN8+PhIMJ7nTJ0Wd2OjmHgfmI6qpKmnselmlcaCUyJNh2WTMgVfwfj2FZghXcGQ3bA+BgHHqloQ+SbR0CiZvphtc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hzYnjjrQ; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzYnjjrQ"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-42cb6f3c476so5616565e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Oct 2024 05:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728563301; x=1729168101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c6QcR9n1m0q/l9zGQbgLs5hja5J4WWq16DHiF4+8sPU=;
        b=hzYnjjrQzbuWDq56DW6sYEt7g4oQMA0wg/7Ny+haturPpBAInMuxtB6m65bSgEgr28
         rOEhe5qI15fO+FkJQobpa97Q09kzP8EXxRM1DDHj0onTEcC7EF7YasuRtutM8vlf4ccc
         Ws8nJVzg7K4YRIiC7LOWkmdbwSSDrDM89LZ9/Cax9nf0Xyv2L++lv5c1xCwfVwehycwi
         4wJ9bvRu78+iIoX5/DaTHy25b++Wb4T6oKpA9oNECqzs4EcPZNRBf+rwZwAAbEf/TNH1
         UVUNvYUvalmOqioF/Q25mwuzXOfnnSv/1qdyqv10XGpMLunUYXQeeOFhjuU63EwymaOc
         s/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728563301; x=1729168101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c6QcR9n1m0q/l9zGQbgLs5hja5J4WWq16DHiF4+8sPU=;
        b=FrHHh0oDCFSSi3AGnGAXiyvfGZnBeZJzxFEwatOSdPeeRMVF5zufARFG3EE2LHeWpW
         B4//4IqjJ/n0sXVRjSe6TZkO7FJlKzv5+NIzLzw7OXQaNPoO45bGjMx/zPI0hY2Iu3Xg
         MlxRHhl6DHPxrW+lC70UhUOQu3I4YHnbmpk+udFjjhmm5Dqv1qpVHTMerhjQY5rPkQVt
         uFdyao/ibPTos5gC21UrxREOF0qDYJFaOL2K4xOqUQHbWTTlvEqN4jSttiPIU5BjNKNO
         KAOXxoduyA+WcUiwfmUbwRnVdfx5AUJyV0CWtr1DH5z35AatZiCB4iUz+QoEQEsoXmu3
         R00w==
X-Forwarded-Encrypted: i=1; AJvYcCWWhDO5Wpdyn9FlpZiBAjDuH2Hz+jqiao9Bea5Yi3vJl9g6zSAmzBhoYkAMcq8eK5fjoNU90amWZUxwtTcBu2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvalL/dbHu0eanOX9PtvGWcZuwOlkHCzSiQS3zD8c9jOg8yDuA
	iroP1owSxsdcG1o8hYznmXAF0z4xwjWQB2YmkZihqyOvOkxeAh/AwdBt4KtWs7uJyOOJeA==
X-Google-Smtp-Source: AGHT+IHuM4AVrB3/VA+KSNoFn/gVu2nH/tNFfFetPAnZU3/5n7kxbHksI8Xp5YeqknZ6dS+iHq9qQ/Nz
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a05:600c:4395:b0:42e:8ffd:4276 with SMTP id
 5b1f17b1804b1-430c3a9844bmr82645e9.0.1728563300750; Thu, 10 Oct 2024 05:28:20
 -0700 (PDT)
Date: Thu, 10 Oct 2024 14:28:05 +0200
In-Reply-To: <20241010122801.1321976-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241010122801.1321976-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4558; i=ardb@kernel.org;
 h=from:subject; bh=sRiVcv8Ap32tzSM2ObqgKu+cYGNZF+YeavTcnVlMYrg=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ39RLjOa+4nZq887O5KLzj8mveY2rczSUpNm+NVl/n/v
 ffb0M68o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzk7lSG/9E1Eg6Z/vsnm3io
 JV7be+qa6NNNGyX1khoOzNmskWAYysTwT11BvfDwK90Zj2v3KX3P1oidrammV5H0iI+z/lJbSJ4 5CwA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241010122801.1321976-10-ardb+git@google.com>
Subject: [PATCH v2 3/5] objtool: Add support for annotated jump tables
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, keescook@chromium.org, 
	linux-hardening@vger.kernel.org, nathan@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jan Beulich <jbeulich@suse.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Add logic to follow R_X86_64_NONE relocations attached to indirect
jumps, which are emitted to annotate jump tables, which are otherwise
difficult to spot reliably.

If an ELF symbol is associated with the jump table, its size is taken as
the size of the jump table, and subsequently used to limit the traversal
of the table and validate its jump destinations.

One complicating factor is that indirect jumps may actually be direct
jumps to retpoline thunks, and therefore already have a relocation
associated with it. Accommodate these by ignoring R_*_NONE relocations
in insn_reloc(), so that the existing code does not get confused by
them.

E.g.,

  8c:   48 63 7c 85 00          movslq 0x0(%rbp,%rax,4),%rdi
  91:   48 01 ef                add    %rbp,%rdi
  94:   e9 00 00 00 00          jmp    99 <crc_pcl+0x89>
            94: R_X86_64_NONE       .rodata+0x400
            95: R_X86_64_PLT32      __x86_indirect_thunk_rdi-0x4

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 tools/objtool/arch/x86/special.c | 33 ++++++++++++++++----
 tools/objtool/check.c            | 10 ++++--
 2 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index f8fb67636384..67c20623d7f7 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -115,30 +115,51 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	struct reloc  *text_reloc, *rodata_reloc;
 	struct section *table_sec;
 	unsigned long table_offset;
+	struct symbol *sym;
 
 	/* look for a relocation which references .rodata */
 	text_reloc = find_reloc_by_dest_range(file->elf, insn->sec,
 					      insn->offset, insn->len);
-	if (!text_reloc || text_reloc->sym->type != STT_SECTION ||
-	    !text_reloc->sym->sec->rodata)
+	if (!text_reloc || !text_reloc->sym->sec->rodata)
 		return NULL;
 
-	table_offset = reloc_addend(text_reloc);
+	/*
+	 * If the indirect jump instruction itself is annotated with a
+	 * R_X86_64_NONE relocation, it should point to the jump table
+	 * in .rodata. In this case, the ELF symbol will give us the
+	 * size of the table. Ignore other occurrences of R_X86_64_NONE.
+	 */
+	if (reloc_type(text_reloc) == R_X86_64_NONE &&
+	    insn->type != INSN_JUMP_DYNAMIC)
+		return NULL;
+
+	table_offset = text_reloc->sym->offset + reloc_addend(text_reloc);
 	table_sec = text_reloc->sym->sec;
 
 	if (reloc_type(text_reloc) == R_X86_64_PC32)
 		table_offset += 4;
 
+	switch (text_reloc->sym->type) {
+	case STT_OBJECT:
+		sym = text_reloc->sym;
+		break;
+	case  STT_SECTION:
+		sym = find_symbol_containing(table_sec, table_offset);
+		break;
+	default:
+		return NULL;
+	}
+
 	/*
 	 * Make sure the .rodata address isn't associated with a
-	 * symbol.  GCC jump tables are anonymous data.
+	 * symbol. Unannotated GCC jump tables are anonymous data.
 	 *
 	 * Also support C jump tables which are in the same format as
 	 * switch jump tables.  For objtool to recognize them, they
 	 * need to be placed in the C_JUMP_TABLE_SECTION section.  They
 	 * have symbols associated with them.
 	 */
-	if (find_symbol_containing(table_sec, table_offset) &&
+	if (reloc_type(text_reloc) != R_X86_64_NONE && sym &&
 	    strcmp(table_sec->name, C_JUMP_TABLE_SECTION))
 		return NULL;
 
@@ -151,6 +172,6 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	if (!rodata_reloc)
 		return NULL;
 
-	*table_size = 0;
+	*table_size = sym ? sym->len : 0;
 	return rodata_reloc;
 }
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5f711ac5b43d..6521c82880f0 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1386,6 +1386,8 @@ __weak const char *arch_nop_fentry_call(int len)
 
 static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *insn)
 {
+	unsigned long offset = insn->offset;
+	unsigned int len = insn->len;
 	struct reloc *reloc;
 
 	if (insn->no_reloc)
@@ -1394,8 +1396,12 @@ static struct reloc *insn_reloc(struct objtool_file *file, struct instruction *i
 	if (!file)
 		return NULL;
 
-	reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					 insn->offset, insn->len);
+	do {
+		/* Skip any R_*_NONE relocations */
+		reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+						 offset++, len--);
+	} while (len && reloc && reloc_type(reloc) == 0);
+
 	if (!reloc) {
 		insn->no_reloc = 1;
 		return NULL;
-- 
2.47.0.rc0.187.ge670bccf7e-goog

