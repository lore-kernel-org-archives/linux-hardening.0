Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1DAC433F5
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Oct 2021 11:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2456961029
	for <linux-hardening@archiver.kernel.org>; Fri,  8 Oct 2021 11:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240084AbhJHLTW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 8 Oct 2021 07:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240122AbhJHLTK (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 8 Oct 2021 07:19:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58D7C061764;
        Fri,  8 Oct 2021 04:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xqtSQc07C3rrqTOXV9I/wLRnSKhuTNgADm5tRsfdrx4=; b=jdp2wcmqAFjAKRQTb13W/FfcbX
        5THzVflwDLXHmU+1VHlpGnNzTlDcWbP5Bbhlrn2dMaahApt3v59WDJpUN2/Shz2Y4uzMtzIZ/3GTf
        NIAcpWAqZR4cZjsdrV3CDr0gSgHyhXLcBF8/GnXXvLw1VOmhRxvpKLSa1KrJTHsRZA7hBrkRWQtbo
        2fI1bGOYfoMVgGstcikreGv6tYHZ8JRV5FEEdPt6KH+8bDOlws3gc4nVReriuWNcdJtbzSPOE44gI
        LKwKme969M29j7+Y8UsAj+oo24GOI+8jgA8Av9uVjk/67iNtB9Zc0QnPtn6j8sGvp95ZSHFUDzcWw
        r/Gz8pOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mYnsD-008eLC-AT; Fri, 08 Oct 2021 11:17:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A61EF302D3A;
        Fri,  8 Oct 2021 13:17:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E0CCF2DB84A69; Fri,  8 Oct 2021 13:17:07 +0200 (CEST)
Message-ID: <20211008111626.271115116@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 08 Oct 2021 13:15:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     keescook@chromium.org, jannh@google.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vcaputo@pengaru.com, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, amistry@google.com,
        Kenta.Tada@sony.com, legion@kernel.org,
        michael.weiss@aisec.fraunhofer.de, mhocko@suse.com, deller@gmx.de,
        zhengqi.arch@bytedance.com, me@tobin.cc, tycho@tycho.pizza,
        tglx@linutronix.de, bp@alien8.de, hpa@zytor.com,
        mark.rutland@arm.com, axboe@kernel.dk, metze@samba.org,
        laijs@linux.alibaba.com, luto@kernel.org,
        dave.hansen@linux.intel.com, ebiederm@xmission.com,
        ohoono.kwon@samsung.com, kaleshsingh@google.com,
        yifeifz2@illinois.edu, jpoimboe@redhat.com,
        linux-hardening@vger.kernel.org, linux-arch@vger.kernel.org,
        vgupta@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        guoren@kernel.org, bcain@codeaurora.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        jonas@southpole.se, mpe@ellerman.id.au, paul.walmsley@sifive.com,
        hca@linux.ibm.com, ysato@users.sourceforge.jp, davem@davemloft.net,
        chris@zankel.net
Subject: [PATCH 4/7] x86: Fix get_wchan() to support the ORC unwinder
References: <20211008111527.438276127@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/process.c |   51 ++--------------------------------------------
 1 file changed, 3 insertions(+), 48 deletions(-)

--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -944,58 +944,13 @@ unsigned long arch_randomize_brk(struct
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


