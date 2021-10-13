Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7659C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62C861053
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbhJMSTK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJMSTI (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B418C061570
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b197-20020a2534ce000000b005b71a4e189eso4141466yba.5
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=W4bH1nkK7xzfrNNZ5lkRiMFsqG6a9dKc6f+FT90kTO0=;
        b=IaPCRVxH8jSdM1KTJzGlkrf0BikrM8BSY47HGIKs47ISWmOChWglr13ne6iqKrKa3C
         cyRa3frcyeH5LLncdUVqGwzlbSJF0VpeLAHETBhaLoXUofjnfn0jzqzxF+8XMF6Oba3b
         GXy0X7Ho7CIteGeYIjUAmX9sEC5SOIqhXMaWnFYy3GB8TUOwobBU3UKF+aPUydw03EYj
         Sf7cSCImsdCR5Ca7K450ltTU6TsmqXtR9GHk/CFZZdmjcc8powrhgZwonYV9ls77LBTB
         ld4emmCDXM8azjga8aR3AePMWfQ/+PT7NQns+hPlhIlwNqNRtvJcVgfOf4q02VrXRh7R
         WORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W4bH1nkK7xzfrNNZ5lkRiMFsqG6a9dKc6f+FT90kTO0=;
        b=AM8E340rDmPn90PVldNaqRP9gzPwH3tSCPAEy95zXg/NL4G5bee5biprF964AtYI0s
         cgvo4/ih3Z4lUgFB+S/MZf6pxnwbXaCzkufOTScpTNnokJ7Xf3C6zc2M8u63KcWcwrtW
         8uf4WDnZDlOim6HFR/QjwllTnTbjwu0sAuT/A1NBszil54T9kFYaRfVGiciq/OXjWJU7
         Zk/CXZnEZPLsNTPOYvBwZuSAkF46J1IbZPzFSRVAnKiixp3MUkB4nP+rZWGgRMG6+dQ2
         jiW6Q9FUAw5u8T/GU6HllBG7KTD991RPK+aMcL63W2k8KC5n5BE+qqSrYwPXy90fJLop
         hu+A==
X-Gm-Message-State: AOAM532HgNb0Ya6PwAEy13vaLm7U1TD4M2RGNrZu1bh7u9kLBTvRpn68
        v0m9cEM9In7gr4d+yS/Tvz1b2GSwdigl196MKG8=
X-Google-Smtp-Source: ABdhPJwIu1o6oOSecHloEwQAWuf5jfQ+OTJaAHyaR5GQcSsEvoAjaNgnpV3g4fjqOeIwmX73wKVjtmMl4CkeP9g45zk=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:dac8:: with SMTP id
 n191mr990701ybf.390.1634149023837; Wed, 13 Oct 2021 11:17:03 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:44 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=6627; h=from:subject;
 bh=bmZVkzx+ryW/5L9gcOwk+Z2yP2VdUVZdeuK33/2Ghq4=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKYozW2J45q3Q+18UIrvjTazkUOsSABNi6EDNmH
 cqIPVhSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimAAKCRBMtfaEi7xW7l6+C/
 kBa9QiaYhKQ2z/S2OgLLJIKYQVMtoontRw3OK5R2pduUmBxRibSFgpA6ClkOrVCZaLzglceSKD5BLn
 kr9tp+b7yII73ZMp1ElTiM79mEeffO9CuwF1uwG2mrIJ4OjuglvzhnLWXcwfVisPSCTF5G9gPcuo1Y
 O/HhYUFzwDZ6hGCpezRadwZewoyBRLU/rF44JitK8v+7HD/Zr4NFJ6zAZiw3b26xq72fikg79Mx/FY
 pyp10RZQj3vc4exfV5BSyfhCezKdFKrV/bY1OubmgGuy27O9YXnTS/cTeEnAb3YLmSSH9epHebbAno
 sq7eyo4fGWrCPiyhOBTM/MgqqIim/j7zMgtNo5mH7ffHO8X5LJNInGLh3jwSIRdOe/OjQVvKBdrRTR
 E3XueRIRXL/uXpqHHWKij92qwjDC5wb44n61acb+sX2pBpMsgWxmfTVf3IAgcJe9+RA75l1slVokgO
 KoJosryVs3DgEX5wbU6ZdE+/vVqQw0LslUHb1uaIHbxgE=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 01/15] objtool: Add CONFIG_CFI_CLANG support
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The upcoming CONFIG_CFI_CLANG support uses -fsanitize=cfi, the
non-canonical version of which hijacks function entry by changing
function relocation references to point to an intermediary jump table.

For example:

  Relocation section '.rela.discard.func_stack_frame_non_standard' at offset 0x37e018 contains 6 entries:
      Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
  0000000000000000  0002944700000002 R_X86_64_PC32          00000000000023f0 do_suspend_lowlevel + 0
  0000000000000008  0003c11900000001 R_X86_64_64            0000000000000008 xen_cpuid$e69bc59f4fade3b6f2b579b3934137df.cfi_jt + 0
  0000000000000010  0003980900000001 R_X86_64_64            0000000000000060 machine_real_restart.cfi_jt + 0
  0000000000000018  0003962b00000001 R_X86_64_64            0000000000000e18 kretprobe_trampoline.cfi_jt + 0
  0000000000000020  000028f300000001 R_X86_64_64            0000000000000000 .rodata + 12
  0000000000000028  000349f400000001 R_X86_64_64            0000000000000018 __crash_kexec.cfi_jt + 0

  0000000000000060 <machine_real_restart.cfi_jt>:
    60: e9 00 00 00 00          jmpq   65 <machine_real_restart.cfi_jt+0x5>
                        61: R_X86_64_PLT32      machine_real_restart-0x4
    65: cc                      int3
    66: cc                      int3
    67: cc                      int3

This breaks objtool vmlinux validation in many ways, including static
call site detection and the STACK_FRAME_NON_STANDARD() macro.

Fix it by converting those relocations' symbol references back to their
original non-jump-table versions.  Note this doesn't change the actual
relocations in the object itself, it just changes objtool's view of
them. This change is based on Josh's initial patch:

https://lore.kernel.org/r/d743f4b36e120c06506567a9f87a062ae03da47f.1611263462.git.jpoimboe@redhat.com/

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 tools/objtool/arch/x86/decode.c      | 17 ++++++++++
 tools/objtool/elf.c                  | 51 ++++++++++++++++++++++++++++
 tools/objtool/include/objtool/arch.h |  3 ++
 tools/objtool/include/objtool/elf.h  |  2 +-
 4 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 1f2ae708b223..5fe31523e51f 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -63,6 +63,23 @@ bool arch_callee_saved_reg(unsigned char reg)
 	}
 }
 
+unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc)
+{
+	if (!reloc->addend)
+		return 0;
+
+	if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+		return reloc->addend + 4;
+
+	return reloc->addend;
+}
+
+unsigned long arch_cfi_jump_reloc_offset(unsigned long offset)
+{
+	/* offset to the relocation in a jmp instruction */
+	return offset + 1;
+}
+
 unsigned long arch_dest_reloc_offset(int addend)
 {
 	return addend + 4;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index b18f0055b50b..cd09c93c34fb 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -18,6 +18,7 @@
 #include <errno.h>
 #include <objtool/builtin.h>
 
+#include <objtool/arch.h>
 #include <objtool/elf.h>
 #include <objtool/warn.h>
 
@@ -290,6 +291,10 @@ static int read_sections(struct elf *elf)
 		if (sec->sh.sh_flags & SHF_EXECINSTR)
 			elf->text_size += sec->sh.sh_size;
 
+		/* Detect -fsanitize=cfi jump table sections */
+		if (!strncmp(sec->name, ".text..L.cfi.jumptable", 22))
+			sec->cfi_jt = true;
+
 		list_add_tail(&sec->list, &elf->sections);
 		elf_hash_add(section, &sec->hash, sec->idx);
 		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
@@ -575,6 +580,49 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
 	return 0;
 }
 
+/*
+ * CONFIG_CFI_CLANG replaces function relocations to refer to an intermediate
+ * jump table. Undo the conversion so objtool can make sense of things.
+ */
+static int fix_cfi_relocs(const struct elf *elf)
+{
+	struct section *sec;
+	struct reloc *reloc;
+
+	list_for_each_entry(sec, &elf->sections, list) {
+		list_for_each_entry(reloc, &sec->reloc_list, list) {
+			struct reloc *cfi_reloc;
+			unsigned long offset;
+
+			if (!reloc->sym->sec->cfi_jt)
+				continue;
+
+			if (reloc->sym->type == STT_SECTION)
+				offset = arch_cfi_section_reloc_offset(reloc);
+			else
+				offset = reloc->sym->offset;
+
+			/*
+			 * The jump table immediately jumps to the actual function,
+			 * so look up the relocation there.
+			 */
+			offset = arch_cfi_jump_reloc_offset(offset);
+			cfi_reloc = find_reloc_by_dest(elf, reloc->sym->sec, offset);
+
+			if (!cfi_reloc || !cfi_reloc->sym) {
+				WARN("can't find a CFI jump table relocation at %s+0x%lx",
+					reloc->sym->sec->name, offset);
+				return -1;
+			}
+
+			reloc->sym = cfi_reloc->sym;
+			reloc->addend = 0;
+		}
+	}
+
+	return 0;
+}
+
 static int read_relocs(struct elf *elf)
 {
 	struct section *sec;
@@ -638,6 +686,9 @@ static int read_relocs(struct elf *elf)
 		tot_reloc += nr_reloc;
 	}
 
+	if (fix_cfi_relocs(elf))
+		return -1;
+
 	if (stats) {
 		printf("max_reloc: %lu\n", max_reloc);
 		printf("tot_reloc: %lu\n", tot_reloc);
diff --git a/tools/objtool/include/objtool/arch.h b/tools/objtool/include/objtool/arch.h
index 589ff58426ab..93bde8aaf2e3 100644
--- a/tools/objtool/include/objtool/arch.h
+++ b/tools/objtool/include/objtool/arch.h
@@ -81,6 +81,9 @@ unsigned long arch_jump_destination(struct instruction *insn);
 
 unsigned long arch_dest_reloc_offset(int addend);
 
+unsigned long arch_cfi_section_reloc_offset(struct reloc *reloc);
+unsigned long arch_cfi_jump_reloc_offset(unsigned long offset);
+
 const char *arch_nop_insn(int len);
 const char *arch_ret_insn(int len);
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c48c1067797d..e9432be2a0b0 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -38,7 +38,7 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	bool changed, text, rodata, noinstr;
+	bool changed, text, rodata, noinstr, cfi_jt;
 };
 
 struct symbol {
-- 
2.33.0.1079.g6e70778dc9-goog

