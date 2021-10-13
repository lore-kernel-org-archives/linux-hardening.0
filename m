Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7077C433F5
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD41E61139
	for <linux-hardening@archiver.kernel.org>; Wed, 13 Oct 2021 18:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhJMSTq (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 13 Oct 2021 14:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbhJMSTe (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 13 Oct 2021 14:19:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAD0C061762
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 124-20020a251182000000b005a027223ed9so4021712ybr.13
        for <linux-hardening@vger.kernel.org>; Wed, 13 Oct 2021 11:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FUM1v4YB6XOXHq0iVVCQLmH4e/+1fH3L4oj9Aiz71+c=;
        b=cJ1RW4v4aCr+KHTpjNE9nFrgs4HfHet0ukJeIU7uGGP5p9ejwQrOEsliCMYF9FKBIs
         RciOUaBAZ9CtvoGSa2YuBuvl0bfAbmM0uLrYQVCivLHH1SzaoWyVsNGXEIiHk6hkogY1
         nXctVqDcoegt4qKvEegPTWrk28NhZ+lq2OskyVVPMK/ftAMV5VwkzrbIWFt+iQjEgyTe
         WvbZO+asrN6dpO49mQaalvWHsCWOmuTkYbcTbDmKaPlOltFN5SSfkIeQFrZDe5MazJc8
         32dULY5NTK5IykULt4XohX/ptg+q+LZ+8IRtXytJLex7ZVaGGinB9W6CbsD9sANzVpwN
         NOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FUM1v4YB6XOXHq0iVVCQLmH4e/+1fH3L4oj9Aiz71+c=;
        b=nQfp7aSrw05N/TvEZE1KZIJKXlpe5+sTHgZjF+cHSh1oonb7TrN79lDIGhsPby9b+o
         tebe9sJxOWGyXBJrZ/oDU+jzWRTbebnB5YlfT0+F70u4MVS0NtKRi5oFKRrCemdUBaAe
         GgZ0PqlXb+CE8wBzTzmy04hGVwNxrPZ2p0ymY+Njmpi/gTeaHtQ6XSJadJMa2ou2Zy7L
         6M4Oqxr/+WwnLNvj6HjUbzN30Q04cRLJwKPkpjSgRE3kJC2uPrm4ptVtsT/oH7ZPB1dV
         seuJ/ikRX4npWmlkAsLsFkd9MvM5I8yzgs1sfaeYT/tYn1ZeEXQqLsyE/ZbT1lsYBQ0Z
         ymYA==
X-Gm-Message-State: AOAM531ASpOdG1sRg5xU415KjAP12+hE/MQ6BhdteLElJTcfi6n2DifY
        Ww4pNJiokKuKicwNVG3ixQIGUCgmIfNi5ij9C60=
X-Google-Smtp-Source: ABdhPJzEaDja0J/kqrarjfqGPyMXP2WPI/KPS/LGkqwt9jFxz8/AAqr2O4bu1tJnuUjHgs+PlSzdMs9xiMmwlcVbC4Q=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:9ea6:6c27:1876:926c])
 (user=samitolvanen job=sendgmr) by 2002:a25:5044:: with SMTP id
 e65mr914919ybb.57.1634149049705; Wed, 13 Oct 2021 11:17:29 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:16:55 -0700
In-Reply-To: <20211013181658.1020262-1-samitolvanen@google.com>
Message-Id: <20211013181658.1020262-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20211013181658.1020262-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=979; h=from:subject;
 bh=dUwvm3Vd/5iEIjZYz+BmaUIzxp/ot2yfAHfQNEA+kUM=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBhZyKaIwdgCVuE1IB6wwvqmWNbh+vVqAlev/QJV73m
 c6jvmMGJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYWcimgAKCRBMtfaEi7xW7msKC/
 9Bl6p6NCMyrV45qX2+L/0+XGMXCRfdOX68muhe1EoKDv1+fByHvxCtLgerfyCudZ7URTfLBME/ZnTD
 zl6u0n+N8gANWaDZleltiMEz1hQHPk0VlMZA+dmD+e8q9NFj8yTOX+gdEcDw0UiNmw8CNL6HUUSyG5
 b2gREsgfpxcD1AELTfurUXi96HkTeXXvl/eyWXucGMh87gHRkDMOkAz9QN823Gg6kfR0wGjDckyss8
 dXQrVqJ6XJuwRgr26EXZbLQBe7HJWHq+gXME4PqET7xqp02joqE0j96xPZq6wVHJxQDsHEMRF8RBBz
 /HQ0r3SEHdSxYW51OoKzO19aswKqAb2Pz9op1ZdSY+u/PFOTIK1fYcMtHT+EQoI6GIuZ9Q1ZK76KTc
 rebN6zRrpGYSyU0vcA8+SSkVOZBD3K33QrHj1tGQUhaHAuO4Y+YS8rwQuXyrXKTaq2uUCasy/JeuVM
 htEWYPcnOHQ00htlg7Rfdn9f4tQ1OQiJOevLNaVwDokLA=
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 12/15] x86, module: Ignore __typeid__ relocations
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

The R_X86_64_8 __typeid__* relocations are for constants the compiler
generates for indirect call type checking with CONFIG_CFI_CLANG. Ignore
them when loading modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/kernel/module.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 5e9a34b5bd74..c4aeba237eef 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -197,6 +197,10 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 			val -= (u64)loc;
 			write(loc, &val, 8);
 			break;
+		case R_X86_64_8:
+			if (!strncmp(strtab + sym->st_name, "__typeid__", 10))
+				break;
+			fallthrough;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
-- 
2.33.0.1079.g6e70778dc9-goog

