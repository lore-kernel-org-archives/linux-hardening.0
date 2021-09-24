Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19CAC433F5
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 06:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D00846124F
	for <linux-hardening@archiver.kernel.org>; Fri, 24 Sep 2021 06:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbhIXGXD (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 24 Sep 2021 02:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244165AbhIXGW7 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 24 Sep 2021 02:22:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBF5C0613E1
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id n2so5743073plk.12
        for <linux-hardening@vger.kernel.org>; Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gtp+PhiNYL14RQ36xZy2Q/C53xERkhDc4tFWQNnO3vk=;
        b=fNdXsf2wBVkiDe6gWGju9kPx4AwSHKIvM1vTsiqeS3wn1Iu5U/KnbMDLraPJUIO8uk
         N3aouM1uMKmG6c0c0qREFiGypCqRzRWn3qsSlq2Q2pWXoJI+tzpXZmoNGgeCXEE2ifGj
         /80880cCTeP6f7uSPWy7pg/+N6GqRbqq8iaGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gtp+PhiNYL14RQ36xZy2Q/C53xERkhDc4tFWQNnO3vk=;
        b=6d+x8lyCy55XikUKv2Ul/iNnHKpWe9rEhj5XrPRAKViPrhbnOdYsmLxIvp0AOfTTMT
         k1v5CKXR0JkhIZWuYxRT1S2Z2KrgUTN7KDmRLUD/iO9re6jZ7asfh0OtE6w0mROY8nCe
         NkrDLkYmNBDPX+vajR8uR6jQq/BZgXe8AwoUdBxppZnTzOym2v8TXnumn+V5GZ6jqpee
         euWqOwa4po+xjvGSPVeSqsRNreGpKN/BfHNIcS291AwFXxCEUknQORJ/V+QTxb8DMLOj
         d77l8ShWIFBdcG34s9qlVRLocCJw1ImqyETwp+LjNIZbwqXdJe5iCII+adMLI1rAuhkA
         jZDg==
X-Gm-Message-State: AOAM532C6A7ft9Ri3tUlx6snIlNBgLwG/jWyt80nRX0fGJZIXo3AVlJp
        GGaGqiV8m4UZff0AcQqLwSpcyA==
X-Google-Smtp-Source: ABdhPJy1zhOzlP3OCh0HTB40xpV43kVP1bbFS8pCx+Z34LJkWO7dDHbsvHF2OOX5mJ7P7a2qPluUQg==
X-Received: by 2002:a17:90a:2e0e:: with SMTP id q14mr234223pjd.171.1632464418245;
        Thu, 23 Sep 2021 23:20:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w142sm7521009pfc.47.2021.09.23.23.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 23:20:16 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Vito Caputo <vcaputo@pengaru.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jann Horn <jannh@google.com>, "Tobin C. Harding" <me@tobin.cc>,
        Tycho Andersen <tycho@tycho.pizza>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Stefan Metzmacher <metze@samba.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Michal Hocko <mhocko@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        kernel test robot <oliver.sang@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        x86@kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/3] x86: Fix get_wchan() to support the ORC unwinder
Date:   Thu, 23 Sep 2021 23:20:06 -0700
Message-Id: <20210924062006.231699-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210924062006.231699-1-keescook@chromium.org>
References: <20210924062006.231699-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2655; i=keescook@chromium.org; h=from:subject; bh=h4Mwhvti6HC9Gzl6rvebY2d6U2FoXZWvHbtyd+yZEFo=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhTW4Wr/0QSzXjC1MlF3eZkA04AE/CdBQgh6sIk6Hd p5JfgfyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYU1uFgAKCRCJcvTf3G3AJvgvD/ 0Wj7dtO4lv/TyeF7NG65VuqZkcc0g9euy9CGnrus/2KjABDj/SDPpG5kn2qPiosFecigyVpj7ZcOG7 xo2svpeeZMqWDEOJcWKDaTFOh8VrQHuyk5hFFu2TalMkGchr2DZpRU3vP8HbCh/KWjScvx/Hjuktfl cCn9i2tuzuZWm2pw7n+ZB4BMkXg3dtcUUmLLiJgRff4oBkpoF4msWMubgYr54JRuRuVHBH23ZQP+k4 GDdm1MFMDoZ9bz6D2wDbP7mFXl5OzN09gKxl92IpVr9bOz7oZ+mzrJevkm8Frw2+Wd2FFTVkI4JJ2l F5BGukMT6aM+9Uio5hAQIFH0n+yRc6Vm9Pref6/4gb7QXzeuBP//kg8Z6qyZ50WwWMEIVg4RHH+Jqu MTsrlKAxfl8UWPTSB8pbBgjWxzJqWIlPTTIRXn0LFyqOKf/Z+I0ZG5F+7HrnvM6yhNcxmdddeRoUdP mNAOr2EoH/D4m3iqko+20JYvHgsgfrXqrHABEQ+JPO8NBZ3vKc19VMPLsHoUtOlVDGw/bVLMqAZn61 iIQxBEhODvlR4eXY3rO9Zs+k3hoHiV9/NZaZtjAVOVEAaeLUg2/pGoCVC2ltfxrlF8n9RiEC7OYWPB L3h8n6Nz1IgbJpcDgT5qPegnC8uVTjfBdyWOjmn2mbIHJS9ezNyH4CMBJ4BQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

Currently, the kernel CONFIG_UNWINDER_ORC option is enabled by default
on x86, but the implementation of get_wchan() is still based on the frame
pointer unwinder, so the /proc/<pid>/wchan usually returned 0 regardless
of whether the task <pid> is running.

Reimplement get_wchan() by calling stack_trace_save_tsk(), which is
adapted to the ORC and frame pointer unwinders.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Link: https://lore.kernel.org/r/20210831083625.59554-1-zhengqi.arch@bytedance.com
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/process.c | 51 +++------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..e645925f9f02 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -944,58 +944,13 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
  */
 unsigned long get_wchan(struct task_struct *p)
 {
-	unsigned long start, bottom, top, sp, fp, ip, ret = 0;
-	int count = 0;
+	unsigned long entry = 0;
 
 	if (p == current || task_is_running(p))
 		return 0;
 
-	if (!try_get_task_stack(p))
-		return 0;
-
-	start = (unsigned long)task_stack_page(p);
-	if (!start)
-		goto out;
-
-	/*
-	 * Layout of the stack page:
-	 *
-	 * ----------- topmax = start + THREAD_SIZE - sizeof(unsigned long)
-	 * PADDING
-	 * ----------- top = topmax - TOP_OF_KERNEL_STACK_PADDING
-	 * stack
-	 * ----------- bottom = start
-	 *
-	 * The tasks stack pointer points at the location where the
-	 * framepointer is stored. The data on the stack is:
-	 * ... IP FP ... IP FP
-	 *
-	 * We need to read FP and IP, so we need to adjust the upper
-	 * bound by another unsigned long.
-	 */
-	top = start + THREAD_SIZE - TOP_OF_KERNEL_STACK_PADDING;
-	top -= 2 * sizeof(unsigned long);
-	bottom = start;
-
-	sp = READ_ONCE(p->thread.sp);
-	if (sp < bottom || sp > top)
-		goto out;
-
-	fp = READ_ONCE_NOCHECK(((struct inactive_task_frame *)sp)->bp);
-	do {
-		if (fp < bottom || fp > top)
-			goto out;
-		ip = READ_ONCE_NOCHECK(*(unsigned long *)(fp + sizeof(unsigned long)));
-		if (!in_sched_functions(ip)) {
-			ret = ip;
-			goto out;
-		}
-		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
-	} while (count++ < 16 && !task_is_running(p));
-
-out:
-	put_task_stack(p);
-	return ret;
+	stack_trace_save_tsk(p, &entry, 1, 0);
+	return entry;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int option,
-- 
2.30.2

