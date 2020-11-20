Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD8EC83012
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 451972415A
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU1cTvUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgKTScc (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:32:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:51484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730416AbgKTScc (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:32:32 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FE6324171;
        Fri, 20 Nov 2020 18:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897152;
        bh=Uiq6WbZsFcZNa2qICMel25kTRPDI4/E6GffHMbwMUi8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PU1cTvUZR4VHL6s/0INk6PcX3kNchPKLgx7UBDh0VcqpmnOPVJQ400d3DIBu8n9cT
         fSszpMtkQo4CCRpdmIUtblnX3lFG/vyvAY6I7sg0Quok9q9dsO2knTZjv0XXm85WKw
         5ZYCxYHfAG4TTJ4HJCdNsNebgKxGPjspDVsbDTvE=
Date:   Fri, 20 Nov 2020 12:32:37 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 055/141] uprobes/x86: Fix fall-through warnings for Clang
Message-ID: <aebe7ddf558d3804781345a7fc20a7b1472acdb5.1605896059.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/kernel/uprobes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3fdaa042823d..90f44f44c209 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1015,6 +1015,8 @@ int arch_uprobe_exception_notify(struct notifier_block *self, unsigned long val,
 		if (uprobe_post_sstep_notifier(regs))
 			ret = NOTIFY_STOP;
 
+		break;
+
 	default:
 		break;
 	}
-- 
2.27.0

