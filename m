Return-Path: <SRS0=C0P2=DI=vger.kernel.org=linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E182FC4727C
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A21B121707
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Oct 2020 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601563824;
	bh=t8pOQPAK1E1iVKSe7VQdeI0ZfBGmMSWbeGcL4rn3VQ0=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=o4h5RkvSj98V2c0KbtVXDHTxO0VFOkpznzPO2r7NS53ZyaTEJa5E7m1HrkMicERve
	 ngD4p7cX4mrHUWoMH+9jG7OUpUMfkbKqcgTaHL9pJq/X0zo2hD4/+qYAF5r/bJJhcE
	 IsK8hct0mzbRL/44wFcLkncRJDcr8cG3HuT7unzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbgJAOuY (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Oct 2020 10:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732020AbgJAOuY (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Oct 2020 10:50:24 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57372207DE;
        Thu,  1 Oct 2020 14:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601563823;
        bh=t8pOQPAK1E1iVKSe7VQdeI0ZfBGmMSWbeGcL4rn3VQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=gGUnxK0b49/8l/Ban0p0C38wTdm7W6PISlJuygjueQPbWtEPIqAAwuAvQb9tUuMfB
         Lc/AH8TjKM9lM8FQRlHBrdvbwNUG3zSIAQaHAMlU+Ls0GijEe150gfUm4z7O0r0iA5
         caldDvo0ksv9T0h4JmNunFORCh9CkV/UtXYo5EW4=
Date:   Thu, 1 Oct 2020 09:56:08 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] x86/uv/time: Replace one-element array and save
 heap space
Message-ID: <20201001145608.GA10204@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

There is a regular need in the kernel to provide a way to declare having
a dynamically sized set of trailing elements in a structure. Kernel code
should always use “flexible array members”[1] for these cases. The older
style of one-element or zero-length arrays should no longer be used[2].

struct uv_rtc_timer_head contains a one-element array cpu[1].

Switch it to a flexible array and use the struct_size() helper to
calculate the allocation size. Also, save some heap space in the
process[3].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.9-rc1/process/deprecated.html#zero-length-and-one-element-arrays
[3] https://lore.kernel.org/lkml/20200518190114.GA7757@embeddedor/

Reviewed-by: Kees Cook <keescook@chromium.org>
Build-tested-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/5f75bc0a.rQcNS6620b2eA74S%25lkp@intel.com/
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Modify changelog text (Thomas).
 - Add Reviewed-by and Build-tested-by tags.
 - Add a public link to the build-test results.

 arch/x86/platform/uv/uv_time.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/platform/uv/uv_time.c b/arch/x86/platform/uv/uv_time.c
index f82a1337a608..6c348c2d0def 100644
--- a/arch/x86/platform/uv/uv_time.c
+++ b/arch/x86/platform/uv/uv_time.c
@@ -52,7 +52,7 @@ struct uv_rtc_timer_head {
 	struct {
 		int	lcpu;		/* systemwide logical cpu number */
 		u64	expires;	/* next timer expiration for this cpu */
-	} cpu[1];
+	} cpu[];
 };
 
 /*
@@ -148,9 +148,8 @@ static __init int uv_rtc_allocate_timers(void)
 		struct uv_rtc_timer_head *head = blade_info[bid];
 
 		if (!head) {
-			head = kmalloc_node(sizeof(struct uv_rtc_timer_head) +
-				(uv_blade_nr_possible_cpus(bid) *
-					2 * sizeof(u64)),
+			head = kmalloc_node(struct_size(head, cpu,
+				uv_blade_nr_possible_cpus(bid)),
 				GFP_KERNEL, nid);
 			if (!head) {
 				uv_rtc_deallocate_timers();
-- 
2.27.0

