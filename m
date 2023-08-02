Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91917EB64DD
	for <linux-hardening@archiver.kernel.org>; Wed,  2 Aug 2023 00:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjHBAWI (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 1 Aug 2023 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjHBAWH (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 1 Aug 2023 20:22:07 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEA7268D
        for <linux-hardening@vger.kernel.org>; Tue,  1 Aug 2023 17:22:04 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 46e09a7af769-6b9f057f6daso11570760a34.0
        for <linux-hardening@vger.kernel.org>; Tue, 01 Aug 2023 17:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690935724; x=1691540524;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KilSXJK2MVD2AnPm9S8tYLf7mVOFKVkH/54xfLNRqRA=;
        b=OH8wphWtMmg60OnMDGFBbF7ujCNGPfgd2hbBYp4SVBYlFKrjyQu3OyqQGskdp6nUx0
         zrZQow/qzsJWNWHEmuV3V2qPKIKMA9s5C7cY/R7IaT/DqJ6oRdyQY2b82z5poBpUR27F
         du+pXzKwbNL4p7SmBwzwQkAIr0EraF+KpipRtx/9CfQdlWuxFUre1Z5oDrSL9dfERZ8Z
         Ew5uf/pjeNaDEYFWcjMiEED9VgKAfpBYhKT2+HnffFuA0R6qzLEBFB96EoqyguDp8xX8
         3hd9790NAi7zG25zuNBEJP/3LXIyAhUPtDDFV6dHiirHEEXFpZqC04f5xPep+Ptk6QbE
         7/+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690935724; x=1691540524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KilSXJK2MVD2AnPm9S8tYLf7mVOFKVkH/54xfLNRqRA=;
        b=C2Y8Yc8F0KZ38dUxm/esMmuko64Ij2AtG9TeqsVr3f3e0nweKa1w6+NZOXSUM88OcK
         8Kkv+mgld3wVzWJDISWzcl5wtigMy0en7R/8vIjLhuE+nfwDlyUK8Qp8xUIrhbNdeISR
         SvouoawltkXrE6c14ana7vGJkHPxbtiNq2efSK2e1glAttdEUBqqHWCWoeEzoLexKG+z
         G3vBJHiGDfDzcV9lBv+dO7n9qguJBC+uzmVC+InnKx8xm+1JOo1aXrqB9NMr5uK45qq9
         yeysHouLBgTngRgkLECJnAyiHXMCmusWsTYxkPkueJSQ6Z8t9dyjMRZdzm5QpKwt+Ca3
         9lMA==
X-Gm-Message-State: ABy/qLaJ0Z8o/rw0S4a7VxqiU8lRimwksHvwU/gIJna0dIqcDevTnNEW
        IrVMHnTIjzfi6+ofIbT3dAEo90UjzoBLdj/Q/A==
X-Google-Smtp-Source: APBJJlE6hQQSIqZLj/BmT+qswU4s+FzGwFzE/FiZyI/8dUSztNts5afzNmPqF9G3rBrPkMhq6NyTiD2qAN7/Qj9lhg==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a9d:7f0f:0:b0:6b9:6ef7:72f3 with SMTP
 id j15-20020a9d7f0f000000b006b96ef772f3mr15098160otq.0.1690935723801; Tue, 01
 Aug 2023 17:22:03 -0700 (PDT)
Date:   Wed, 02 Aug 2023 00:21:58 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKWhyWQC/32NQQ6CMBBFr0Jm7Zi2ECSuvIdhAcMAE5GSqWk0p
 He3cgCX7yX//R0Cq3CAa7GDcpQgfs3gTgXQ3K0TowyZwRlXmsZY7JRmVAkU8cG68oK26kzVENV VfYG825RHeR/Ne5t5lvDy+jkuov3Zf7Vo0aLry9ENZHqq7W3yflr4TP4JbUrpCzEeraazAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690935722; l=1734;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=D6hZsVI6Tg/cS4gcm5zBne5/wTMEFngDX9MakiPlN9c=; b=BFamEJKVk9qr4ymm+TIZ9Pu636D4xvSUp89XThBbJXvRx+VpNnfLVUV6Vf6elstDWbOXogA6B
 CRRIKYBa1mlBCWmpuuUH5qNbPrKKy1Gn0mQyZbapFhj08hVrY2pqzkp
X-Mailer: b4 0.12.3
Message-ID: <20230802-arch-riscv-kernel-v2-1-24266e85bc96@google.com>
Subject: [PATCH v2] RISC-V: cpu: refactor deprecated strncpy
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

Favor not copying strings onto stack and instead use strings directly.
This avoids hard-coding sizes and buffer lengths all together.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- Use strings directly instead of copying onto stack with `strscpy` (thanks Kees)
- Link to v1: https://lore.kernel.org/r/20230801-arch-riscv-kernel-v1-1-2b3f2dc0bc61@google.com
---
 arch/riscv/kernel/cpu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index a2fc952318e9..872fa7a47d68 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -271,21 +271,21 @@ static void print_isa(struct seq_file *f, const char *isa)
 
 static void print_mmu(struct seq_file *f)
 {
-	char sv_type[16];
+	const char *sv_type;
 
 #ifdef CONFIG_MMU
 #if defined(CONFIG_32BIT)
-	strncpy(sv_type, "sv32", 5);
+	sv_type = "sv32";
 #elif defined(CONFIG_64BIT)
 	if (pgtable_l5_enabled)
-		strncpy(sv_type, "sv57", 5);
+		sv_type = "sv57";
 	else if (pgtable_l4_enabled)
-		strncpy(sv_type, "sv48", 5);
+		sv_type = "sv48";
 	else
-		strncpy(sv_type, "sv39", 5);
+		sv_type = "sv39";
 #endif
 #else
-	strncpy(sv_type, "none", 5);
+	sv_type = "none";
 #endif /* CONFIG_MMU */
 	seq_printf(f, "mmu\t\t: %s\n", sv_type);
 }

---
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
change-id: 20230801-arch-riscv-kernel-14a048cc6467

Best regards,
--
Justin Stitt <justinstitt@google.com>

