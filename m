Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D63CC433FE
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BA3619F6
	for <linux-hardening@archiver.kernel.org>; Thu, 30 Sep 2021 18:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353229AbhI3SIF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 30 Sep 2021 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353145AbhI3SHs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 30 Sep 2021 14:07:48 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D99CC061770
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id q24-20020ac84118000000b002a6d14f21e9so12472703qtl.9
        for <linux-hardening@vger.kernel.org>; Thu, 30 Sep 2021 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6Sx35dcc+ZTMADfJZWhUXml0PH3ooMBccB8Q+X9WArY=;
        b=pk5WOqOatQc/RJ42WoGinJC4/twjfgeWj1OXnhRiKHOSyA+pezAiWCoNBnz9Fj+AjS
         aOIDIpm1iy+TcjZpq5DTIf5dzaYDjtKWxePGXlKJa1s8UPeIkYjw0jRVH3Fo7J0/v0qa
         Y2+1NlkQ7MA9G1a8IAApp1+pO7VRGdMokUvCl+6ZqMyyCl/dV0LjnCsymGj+FNDQdi2n
         3daBKXh9Aoyuacg/VlU0MSjADI1JKmnKQdrM641Bl1X+yQD52QCGprXK4zzCdYcdsyEE
         oGzZH6nn/kGwgiv5PC/yBBtgiJkSbK5MH/dRMdPRgoeoO/0StI8Cr8IDhLNSg1Y1Z3L3
         Bzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6Sx35dcc+ZTMADfJZWhUXml0PH3ooMBccB8Q+X9WArY=;
        b=JdbUlaTaQY9SoltUJukDAKNdHYlCpAQESgqH1Yxry3hCZ9FXX8vZp8rvsJGFssjEJl
         48luFQ3NlLT/1rVhrBHXOZKnVRG/5iILogWllZu1NnzDkX9UdVi/JHc/0UHXDAPotNuB
         W48W4+2G0a6irqC1jtOYN9SBi3hAC9GuzIERrq4T9WkiIxGW03bKTsItl7j91if6gxfu
         0lqnPptW+4WFSlGCO9TfUJ+qNFWmEnhBer4Xyma9SnjCRSuhB5gvA0PbwIHhPiq3jvK0
         oYXHAY6B/3agYRGxIJba5h+KJ9AA5A2ZM6R6fW9d9Oub9AST8sHLab8Zn3krx/7tMxiM
         hq9w==
X-Gm-Message-State: AOAM530kI/fuA5PuVdsozI8ylHmV0Y0H5rcDA6vw9nmD/pJaZjjcAo3+
        +MqPfhul1kS5uQS9rzYz/8fJG36Yl/gGqqw4Pbo=
X-Google-Smtp-Source: ABdhPJw0mNH+hlrHNL741Ke8vSbHmQVJvJ7uLoZQ3qKxdZHJuHeykLu/G/qfGGTqGEDZGgeR0jdbNGhA10M2iltx9l4=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:ce43:4366:95ca:d6e9])
 (user=samitolvanen job=sendgmr) by 2002:ad4:408f:: with SMTP id
 l15mr4167941qvp.60.1633025163728; Thu, 30 Sep 2021 11:06:03 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:05:28 -0700
In-Reply-To: <20210930180531.1190642-1-samitolvanen@google.com>
Message-Id: <20210930180531.1190642-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210930180531.1190642-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 12/15] x86, module: Ignore __typeid__ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Ignore the __typeid__ relocations generated with CONFIG_CFI_CLANG
when loading modules.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
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
2.33.0.800.g4c38ced690-goog

