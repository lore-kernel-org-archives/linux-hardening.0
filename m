Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4E8C00528
	for <linux-hardening@archiver.kernel.org>; Tue,  1 Aug 2023 21:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjHAVPF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Aug 2023 17:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHAVPD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Aug 2023 17:15:03 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C98912B
        for <linux-hardening@vger.kernel.org>; Tue,  1 Aug 2023 14:15:02 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5843fed1e88so75655897b3.0
        for <linux-hardening@vger.kernel.org>; Tue, 01 Aug 2023 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690924501; x=1691529301;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cvCPvXEXJi+AWuMnKm+64/X3uAVVE34xKMNOfWT1BRs=;
        b=PR7tMSy5f4UYTvY4LrTeHg5FaPYcYdynCZ7BdMeTUjCGQFv3V9+d2wyZpspcsT2Lk2
         lwZLurzuBUx24t7W9okeaEOLhZWGzAN+Ac9k9MR3EsSKBEA3pv66qqM7dL744LXA4fwu
         98yACZNsKu3Be7cHWDnwKZa6JnGb6wZslBqVSc4zOgR/35FFx2Lr92lR6rI6tuOmKzs5
         0qBsLA2GF9pI0XIWbCabH3dB04lZqx9ULoUWh0+i1GQGSmAxEwa2r89230sMVJ1hBbpR
         6pQPp3LFMFfmtB4oeDv3kVOgapuenW7gLqDSM8eN9Qz6klCRAhk8qyicxnIJN+aH651H
         tC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690924501; x=1691529301;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cvCPvXEXJi+AWuMnKm+64/X3uAVVE34xKMNOfWT1BRs=;
        b=EFqxm16vdtnzSzFfuLyGVv4tLmE125+EcUy/7jGnLepBnGbsbXE/byqxNd+tjYYlwk
         ro7nFhm5hNVzO2GSJuT3u9R1+T102P6htcUuF+XrJ2ZVRBNQPtPr9UY4RtRh7WCCfLs/
         7RN10lCkNupJL3ac1gl1iwH22Ptcu1WgNhrGwKbIKEAabyhMiCoXU/dmHQPjZsjqq934
         hMyswQetajyFSWVBjPX17L0gxfoi9JTSvwXfFJkwMOFvJFuzZ8veYORdSuL0G+nBnK6V
         eTLY4u86ZEgwfmJfsDLOxpAsTfsfeHMlylI2rLuJIhE/Xze6xy15pcCc5syUCIqFudXH
         B6sQ==
X-Gm-Message-State: ABy/qLajrUU+SnFxRD7LLcDBpRV4sBSn8iiRLutgKnUCkS4kYFQjdN28
        w+AdAJ0dYrJGf2Vs0v8b17PtMVEjiwymp268MQ==
X-Google-Smtp-Source: APBJJlH6aRZtqfR1X4T8qWnxez8AGlbXuy2EkOO9dyhBk5KJPlduqXXSo2+gRcBiY1QYA4mWnF6JSgOt/rTMp+KuJQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a25:dbcc:0:b0:c4d:9831:9712 with SMTP
 id g195-20020a25dbcc000000b00c4d98319712mr91040ybf.0.1690924501488; Tue, 01
 Aug 2023 14:15:01 -0700 (PDT)
Date:   Tue, 01 Aug 2023 21:14:56 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAM91yWQC/x3MMQqAMAxA0atIZgOtFi1eRRxKjBqUKimIULy7x
 fEN/2dIrMIJhiqD8i1Jzlhg6wpoC3FllLkYGtO0xhuLQWlDlUQ37qyRD7QuGOeJOtf1ULpLeZH nf47T+34o9Y8zYwAAAA==
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690924500; l=2927;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=s3m7CWALnl/nC1KMRD2GMsw7JbTdQy5wYGZxtQUQlGM=; b=7eJSjj6jI+aQ7sQWqwG3t2xsmy39xyn26rfVvRq1stqWx/hW8lh8ZtyNbqdNOhiBoBHEvbHbd
 dtYNXKXBITPC026HWfdakwEnyjQW2KzToCm+rBDZJ3IalP45DI9fCa2
X-Mailer: b4 0.12.3
Message-ID: <20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com>
Subject: [PATCH] RISC-V: cpu: refactor deprecated strncpy
From:   Justin Stitt <justinstitt@google.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

A suitable replacement is `strscpy` [2] due to the fact that it
guarantees NUL-termination on its destination buffer argument which is
_not_ the case for `strncpy`!

The `sv_type` buffer is declared with a size of 16 which is then
followed by some `strncpy` calls to populate the buffer with one of:
"sv32", "sv57", "sv48", "sv39" or "none". Hard-coding the max length as 5 is
error-prone and involves counting the number of characters (and
hopefully not forgetting to count the NUL-byte) in the raw string.

Using a pre-determined max length in combination with `strscpy` provides
a cleaner, less error-prone as well as a less ambiguous implementation.
`strscpy` guarantees that it's destination buffer is NUL-terminated even
if it's source argument exceeds the max length as defined by the third
argument.

To be clear, there is no bug (i think?) in the current implementation
but the current hard-coded values in combination with using a deprecated
interface make this a worthwhile change, IMO.

[1]: www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
[2]: manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 arch/riscv/kernel/cpu.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..1c576e4ec171 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -17,6 +17,8 @@
 #include <asm/smp.h>
 #include <asm/pgtable.h>
 
+#define SV_TYPE_MAX_LENGTH 16
+
 /*
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
  * isn't an enabled and valid RISC-V hart node.
@@ -271,21 +273,21 @@ static void print_isa(struct seq_file *f, const char *isa)
 
 static void print_mmu(struct seq_file *f)
 {
-	char sv_type[16];
+	char sv_type[SV_TYPE_MAX_LENGTH];
 
 #ifdef CONFIG_MMU
 #if defined(CONFIG_32BIT)
-	strncpy(sv_type, "sv32", 5);
+	strscpy(sv_type, "sv32", SV_TYPE_MAX_LENGTH);
 #elif defined(CONFIG_64BIT)
 	if (pgtable_l5_enabled)
-		strncpy(sv_type, "sv57", 5);
+		strscpy(sv_type, "sv57", SV_TYPE_MAX_LENGTH);
 	else if (pgtable_l4_enabled)
-		strncpy(sv_type, "sv48", 5);
+		strscpy(sv_type, "sv48", SV_TYPE_MAX_LENGTH);
 	else
-		strncpy(sv_type, "sv39", 5);
+		strscpy(sv_type, "sv39", SV_TYPE_MAX_LENGTH);
 #endif
 #else
-	strncpy(sv_type, "none", 5);
+	strscpy(sv_type, "none", SV_TYPE_MAX_LENGTH);
 #endif /* CONFIG_MMU */
 	seq_printf(f, "mmu\t\t: %s\n", sv_type);
 }

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230801-arch-riscv-kernel-14a048cc6467

Best regards,
--
Justin Stitt <justinstitt@google.com>

