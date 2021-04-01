Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E85C433ED
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 034AD6112D
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Apr 2021 23:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhDAXcz (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Apr 2021 19:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236156AbhDAXck (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Apr 2021 19:32:40 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77165C0613AA
        for <linux-hardening@vger.kernel.org>; Thu,  1 Apr 2021 16:32:29 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id h21so4793184qkl.12
        for <linux-hardening@vger.kernel.org>; Thu, 01 Apr 2021 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PVR0PDKMcdICThtHzZ05IpjfNpdCKYkDS1ZQgOORGog=;
        b=tM0gdLvYYrIGSQ3UU73+aYUTVKUNIBmfBmMOkqL3kVYculPRqLzgjOxKi8RSH39BMa
         jniLnYQk3/+tuCi/WvnaKTWlkCsW1fENUR+FZ5btuwg0G2PF2KxdXxmwadid13ZqOvDZ
         rnAbh16KswUlnaQJtOdiTw8jRv8opl7cYS0NURIXgAwstF9yjXbgfTteqYONzG6n+08t
         qKrhi560aPcoh7IRXPd/rOy6M0hLASHhaPpvZ1DvsZiV91yOvz7u4r2xHuiyO7s4WLQK
         1hCLqtc2RshinGwJtiZyyBClSa2dPX4j5ksIjHJxzt9tSnvJryiiPqFrpiL8tPgxVSFr
         cCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PVR0PDKMcdICThtHzZ05IpjfNpdCKYkDS1ZQgOORGog=;
        b=DJtzVABi9qgLXAvQM2k2p6xAm41o9xZ66n8KGkvz9ufRMMBqnH+sTqLE4TEUz3to9h
         lIPfSV+acO3CQLeLZZksq/39fzYRoNbcVFR6WDqQFLzVy1X9DyTN4EjJetLWmwhDulxZ
         k82VIVRGmAs35aTyv96ZKDGRYHBU+BbMWjxlSi3yyisM7iYg2wPas7oHOVAL7Oo6ShfV
         RtxTThT/jiI6Aqo8Cd/X522DkYVu+i7pCJPnqmBB5sOMeDK5yNCSdpdyMlEJp6hARsqF
         EXA1YZllSiJCf5NMilqFG1/svgr9/Zu1jGbKoO4Elom6K058coe/0IS9O9BEmTknvRnD
         YrYg==
X-Gm-Message-State: AOAM533L7Z7jlQnI9FpWpIeSAYHNwmokw5P+s2CpFmytk/RT88CTlklo
        /bcV8wBsZPRgEMIUxwX7pnVDng69zn3aHhVJzBE=
X-Google-Smtp-Source: ABdhPJz/GEAYNwZ86yFSuRvcWhakddiQDxgrF7XbdSdZeXfnn4teMz+Kc34ztrNSurf8c3YQYZvgWvRkfDCwo1+2V3U=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:4cd1:da86:e91b:70b4])
 (user=samitolvanen job=sendgmr) by 2002:a0c:d7d2:: with SMTP id
 g18mr10283542qvj.42.1617319948605; Thu, 01 Apr 2021 16:32:28 -0700 (PDT)
Date:   Thu,  1 Apr 2021 16:32:03 -0700
In-Reply-To: <20210401233216.2540591-1-samitolvanen@google.com>
Message-Id: <20210401233216.2540591-6-samitolvanen@google.com>
Mime-Version: 1.0
References: <20210401233216.2540591-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v5 05/18] workqueue: use WARN_ON_FUNCTION_MISMATCH
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

With CONFIG_CFI_CLANG, a callback function passed to
__queue_delayed_work from a module points to a jump table entry
defined in the module instead of the one used in the core kernel,
which breaks function address equality in this check:

  WARN_ON_ONCE(timer->function != delayed_work_timer_fn);

Use WARN_ON_FUNCTION_MISMATCH() instead to disable the warning
when CFI and modules are both enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 kernel/workqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..03fe07d2f39f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1630,7 +1630,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn);
+	WARN_ON_FUNCTION_MISMATCH(timer->function, delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.31.0.208.g409f899ff0-goog

