Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C350C433B4
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47543613CE
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Apr 2021 20:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbhDPUj5 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Apr 2021 16:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbhDPUji (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Apr 2021 16:39:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D87C061761
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z39so7471033ybh.23
        for <linux-hardening@vger.kernel.org>; Fri, 16 Apr 2021 13:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dqjKvRAChby1KwNWd3tJUey7yQJEUcmJ1JTwP5gvp4E=;
        b=igg0bNAlgn6LYFxlwoEpfSeUBruunVapLfYNHXpS6rO8EgDBtPDUG3YBIT1l7cBbt/
         fsTlIAtfJ3GeMr6ges+Wn9p5u2QHE9PLwTc3EVqhftHru8/VnWxXmyNNkP8z/a+gF/sP
         s2i3KnDQEm92/EDGu30blOgce2pIEAce/7IN15VW7ssAo3wIKBbI+XzHMaCvFfbKexur
         PXZVBgE5SHOBnuLzNnz8O7SlKdxcOXI/UuJ0SIGiS2n0zwZoAQ9lWhXitPSTPn3jbKgP
         RSQPHfUDvxMV1EDqqFN9YjWVwk5Dn3KSsHcosJOO8C5kqvsZ6mtyecg5WdpNqaTicuYz
         YzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dqjKvRAChby1KwNWd3tJUey7yQJEUcmJ1JTwP5gvp4E=;
        b=PBEXGynAN+mWgBrEp89vsXpIarSNq94zjejcIHMfSTQftOqlhfWzV2GCBhQqDloTQY
         7Zpr1m1Q/VBOpTaXvUEo5xVY/MyznMumkAcPdWDH4blqtwq8jJMg17gJ9E1JOhGjlims
         YzHQIYiknWUZjjU5Hj/Es7TjUBOIodJsG/BzjYJPvopLneGinG5FLt+NLlU9/q6oKUKJ
         jB9d7axTYWmACLm6NDxwv7DJTLIM4YX1jS+HOtjZb6eHrWfCC5ytweZv3jXnquWfoW/n
         CvWk+n7jVIK7RX/XIT8ztFe5LsvCFV2RwiHCsvK+Lwts5jTEEnZj4l9EfYOUeqMZdsj9
         6qFg==
X-Gm-Message-State: AOAM533rTc5P2zWTfda309zJZ91a66psygXJ2c6lABLUpOJ4iA2gnTBO
        GtvgFxyqJF+Mo30Si3nx2ri1aH0L60OUDSzh5vc=
X-Google-Smtp-Source: ABdhPJyK0FVM85dpmFkXQu87h8ZcKF3f9rxJMz3DfsNLVdpnLYfQxNBkrUmp9Tc3i4PHLh1sWd/mew2cqz8EgYgJRRI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:e262:3d8e:cbf:6164])
 (user=samitolvanen job=sendgmr) by 2002:a5b:b8e:: with SMTP id
 l14mr1350126ybq.352.1618605549830; Fri, 16 Apr 2021 13:39:09 -0700 (PDT)
Date:   Fri, 16 Apr 2021 13:38:41 -0700
In-Reply-To: <20210416203844.3803177-1-samitolvanen@google.com>
Message-Id: <20210416203844.3803177-13-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210416203844.3803177-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH 12/15] x86, module: Ignore __typeid__ relocations
From:   Sami Tolvanen <samitolvanen@google.com>
To:     x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
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
2.31.1.368.gbe11c130af-goog

