Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09687C433EF
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0E0B610C8
	for <linux-hardening@archiver.kernel.org>; Thu, 18 Nov 2021 20:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbhKRUZU (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbhKRUZU (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 18 Nov 2021 15:25:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08960C061574
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:22:20 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id h63so6426318pgc.12
        for <linux-hardening@vger.kernel.org>; Thu, 18 Nov 2021 12:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NN+1nK45BHSkImYf6ZodrZEc2yKCKofH6gEEO0/JrA=;
        b=Hhu4lPecOWYqSDmCEtuCIv9aoB7v58qsCp5npK+joXCK1vErdgAydRN0rnIgMZ0jKy
         LWxOM4gipBBrs0s1n+yw8QWm1M5kwEsLxxwBenmXR07glvDR2phzg5lB07Xg8MtoyX8X
         H4u48vBszumbfva6YQivX0MIcwgplnPBtANJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NN+1nK45BHSkImYf6ZodrZEc2yKCKofH6gEEO0/JrA=;
        b=TQ5vKUlmMrvx57FKLhZFHMvt9Cn0IlnIxqcEkja3FTNq4lZgBTWKtVS5guLH2JkHoT
         ryfdJXwXxfb/oGSuleYuWEgGd7H76cPCvHN3BsA7FUoEwHeoIhYMU/VsKiY37F6hQFje
         cOK1W6C1afcHo6DvX9w32qfLE35woOMDAwesW9HbIF4yeQYTts700P1VYwrVEJsCCHKA
         8vbaktvKM9CHONgvLKhQGjsRKCH1krJoJJSuwdSYS6dY+046WZ0m/hxYLF0tGQGStc/n
         z8GABMfK4H1dF8MZP4bfXRgErVtfjQ18yY1IRKsl941rmrTUkeGbr2GvhxeDVwsJI47J
         UXVg==
X-Gm-Message-State: AOAM533kd6wP7ocu0B26Tdi0fdE8x6FlQvSq03SpSVCiqCvZksUZZXnL
        gb/L6l8d/OsluWsfAMp/J2NjmJDIZu1gkA==
X-Google-Smtp-Source: ABdhPJxnlerFWtMMvQznBjcjaOTIWk+vb2WlXHeUEB4sKBD875o+SosCQnWomCv9gGMS9/cK1Pgp2Q==
X-Received: by 2002:a63:8ac3:: with SMTP id y186mr13439232pgd.444.1637266939652;
        Thu, 18 Nov 2021 12:22:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t8sm384779pgk.66.2021.11.18.12.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 12:22:19 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] tracing: Use memset_startat() to zero struct trace_iterator
Date:   Thu, 18 Nov 2021 12:22:17 -0800
Message-Id: <20211118202217.1285588-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; h=from:subject; bh=Or3Zz/FgWlK+lUON8T4CDH2/5TJ3uqemt7E5bllyab4=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhlrX4AxQyT+rUJsTyDxvi/eHEapUCKtkKsFBEtfT8 Sdx77Y2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYZa1+AAKCRCJcvTf3G3AJi/aEA CMGD3cq8RZKap2de38j9tpuhhpskiCG+hDT0vKa5qSFmoDNRV/RxfJP7+mHHpaTBttUVfkCYaY7Exo kFqF7/M7219agIwGswmRogk7vcNAdJdJ1PjjkVTHv6mNfJ0Vi9GZa9diLFyoN4ZhXX3DgMV6c5BJQI 5HIJEZbU7bBvSHWL7f2l3pqn0kncWj0ifsOcXM01QRiozID6T/zogR8EZX49jWJNwqTAsaSmTiUF68 POybeb3iYyVH3WI0wutv/L28abFwq4hD02Lkn+RIcaZ3S1khaJWxpjz8vFPE7VCcMc4BKQ5mqbaSwH niZ/lFPN8et7i2z1S64TWtRzYlysHgsGgLnfaVPqd3r0hwUXHuwRAGyZJY66bQgb2DWEtywn17WNH+ 3k+a4mSJEh78aTtIakEefSCBiZJiTpV5Cek19kpjakGMmu8TNz/g/dxAYa+evdDt9oOafHThkQ+BiP 5BbLqy1QePQNaJa9Sxmra/T4zwVH9EmGZWwFtOsRxuLIxN9Yyr5MVZ2kZSMssJ6rma1YI+IkUNl5+c Q21Feu8znWKUFqtaWuwnOPoS5TuioH5mV58BLZxSy9zvZdQbgF2yTz7ioijGEoEfT+CA2Eww6DxvhR ZxYlb1LjTiDSRWrEx5smnAUyzIIwGUURNWdorXV13OKdGk/8HNsfHxz+TaTg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memset(), avoid intentionally writing across
neighboring fields.

Use memset_startat() to avoid confusing memset() about writing beyond
the target struct member.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/trace/trace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f9139dc1262c..e3c80cfd4eec 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6706,9 +6706,7 @@ tracing_read_pipe(struct file *filp, char __user *ubuf,
 		cnt = PAGE_SIZE - 1;
 
 	/* reset all but tr, trace, and overruns */
-	memset(&iter->seq, 0,
-	       sizeof(struct trace_iterator) -
-	       offsetof(struct trace_iterator, seq));
+	memset_startat(iter, 0, seq);
 	cpumask_clear(iter->started);
 	trace_seq_init(&iter->seq);
 	iter->pos = -1;
-- 
2.30.2

