Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD922C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 10 Feb 2022 02:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiBJCxX (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 9 Feb 2022 21:53:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiBJCxW (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 9 Feb 2022 21:53:22 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E293240AE
        for <linux-hardening@vger.kernel.org>; Wed,  9 Feb 2022 18:53:24 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id y8so5028914pfa.11
        for <linux-hardening@vger.kernel.org>; Wed, 09 Feb 2022 18:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAGMTswugNiTZ1kXBcJzDC6qec1Rg+Bf2TmsXf8NPtk=;
        b=hNQ1SIOimY2cRr4L6bXEXRc4h6C6qK/+mg9wzsu3yTFb+KMg7Srt1bpi0gKTBQesXm
         br6NSFuTtcw6AbX8Ym4Xkl820I3ALalFPOC0uPIVzCgkoWz3W0zINEJj71mcfuqME64o
         VIGGonQ4W+Iw60jDFMovhRFlG252FKJepcxq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAGMTswugNiTZ1kXBcJzDC6qec1Rg+Bf2TmsXf8NPtk=;
        b=zcxNfn2ylVujEADlY2HXkYJdaeHlAPj4y6ge60wamNXcQGi6H5xpw9J4NhaDFY1lyM
         ghF1ZLdN441u1zHbQWUOek7+tkqlS103c7YFXd/wuJr9C891eWLdV3dc30L3micwS7v9
         Kd5UrMob0z3tlb2cv9AiUL7QQlKbyxjxKTMScCR8lmQ2gWrxQTUjZB6G9vFtm/yATGuP
         CmjivLLqw118y6iz39GJPp2KtJhJ+yq2fT/pWba5RK430rbdI4xej7xqDMXM5was5ZRS
         3vpJva7gmNRvgE1E7sOOpFdM3qXnC/NFoQZ5zPjcjYN7Zr1q5logEeQ59Mjh5eTxjaOg
         Qgaw==
X-Gm-Message-State: AOAM530bm0q2pmTNK607AL4+AIktIfPW6cr5eJJwcB1MUKoZIHrz+s90
        kC6YDEVRZwV208LOwKkPFeogiQ==
X-Google-Smtp-Source: ABdhPJzcGsonrQcnzQzEVQ6afui9cuexHSR3QDQJ+2GhZgyPRW7BfaHiyCpPUSzHXZJGyAXuSvd8lQ==
X-Received: by 2002:a05:6a00:1914:: with SMTP id y20mr5440888pfi.39.1644461603856;
        Wed, 09 Feb 2022 18:53:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k15sm20941205pff.39.2022.02.09.18.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 18:53:23 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Robert=20=C5=9Awi=C4=99cki?= <robert@swiecki.net>,
        stable@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
Date:   Wed,  9 Feb 2022 18:53:19 -0800
Message-Id: <20220210025321.787113-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210025321.787113-1-keescook@chromium.org>
References: <20220210025321.787113-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; h=from:subject; bh=Zg+yQalW086+hV+gVFWrJHCSof9cbVJhSUGsHAKczTk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiBH4g9ZFRdN7zSC8BSYALnR2/fZGzP1bwBsZpGH2U 28HkRGaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYgR+IAAKCRCJcvTf3G3AJvJPD/ wJb3mw6sOrz6CALnTWLCdZyJ7Xr8aJtz+h8afQ8e1lWoXRWLAbBNfMEYKjOfdW18iyQbG7VQe+0LfG 0dIVMdrARaUTVIARyoFtrDtMWH+Ej0RGH2KakNMsSisRRBUEhoxOgRdgdZdeUdq/w6c+suiyNhRcD4 96eYh/LSkU2cvYFyvqkaPmki3EcKaukOATdXtDpw6ebGeq1xwRYmzzZrBxSq9Kk39IV/hXENwE216e VXpuHayx0UpAy5kFjh4HFkLPMlgseXT2KLxoDWBlacdFynt4M5JLIdIOXsz/CFrHHihhlj3gFbg7uu 0Iv2qhSrTSs1+jtQBEt8yucWTt3s8NZvlNDOY4TgEfXr0ogHjqN+wVhDNsk+kKuXSQDu6rmk3Eoyof s/IbWa+Z5dXO+Ntk/9JvuccGZ12+77UYCZhdEpw8KfV4Gi+tBcaXRpnjF8WE+C+TDM8K9T5/eWGDBj lfyqtC5Lkk9QD5lLGVI5UtzVNSGiWXecVk0srGEUQ2pb1dwWxwfHs/2BX32Cujb86ZBsqpYmix5dSo SwN/WuJIyaDh5SST+THWAhIyXUiAFhxBVXJRIU6yUtWACbtqPFds/p9sECwpJuRzS11GvrcIpqUq11 YnEHvKm8z8Sn3dh9h1DkFCc/R8RcUjSE0SRcYTtKQLczq3FitMTpg/LPyrGw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Fatal SIGSYS signals were not being delivered to pid namespace init
processes. Make sure the SIGNAL_UNKILLABLE doesn't get set for these
cases.

Reported-by: Robert Święcki <robert@swiecki.net>
Suggested-by: "Eric W. Biederman" <ebiederm@xmission.com>
Fixes: 00b06da29cf9 ("signal: Add SA_IMMUTABLE to ensure forced siganls do not get changed")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/signal.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 38602738866e..33e3ee4f3383 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1342,9 +1342,10 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
 	}
 	/*
 	 * Don't clear SIGNAL_UNKILLABLE for traced tasks, users won't expect
-	 * debugging to leave init killable.
+	 * debugging to leave init killable, unless it is intended to exit.
 	 */
-	if (action->sa.sa_handler == SIG_DFL && !t->ptrace)
+	if (action->sa.sa_handler == SIG_DFL &&
+	    (!t->ptrace || (handler == HANDLER_EXIT)))
 		t->signal->flags &= ~SIGNAL_UNKILLABLE;
 	ret = send_signal(sig, info, t, PIDTYPE_PID);
 	spin_unlock_irqrestore(&t->sighand->siglock, flags);
-- 
2.30.2

