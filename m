Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE05C4708C
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 20:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31587613E3
	for <linux-hardening@archiver.kernel.org>; Fri, 28 May 2021 20:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhE1UC6 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 28 May 2021 16:02:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229617AbhE1UC6 (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 28 May 2021 16:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A919613B5;
        Fri, 28 May 2021 20:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622232083;
        bh=I03wcNb7HMADoF0wf70BF8zVGLwCCpnsZRwVNuu0vmU=;
        h=Date:From:To:Cc:Subject:From;
        b=SXu5S8Xz1jWB0WbQf6s37rihBlTmvE6G94LYlmkOX/F8+Vj0H5QLS6df+Rx0l+b0X
         4T11rfIeM+UdGcrevpc9lXG33T6fPAxF9emZDJO3DWcXRm6Cm7pcccVWJv/Xd4WnKG
         4hL0fMRUYte/86On8o3aUyvZYifNwtGWSA6eIQrZ3DmsKQSoh6yZeKck1sVxckJx5f
         plGzcnMpmy3UCXj7jwdvPjENCQ7PC2j7SC10z4ANGR4PF/CIeDKKaRGCIlT0W/z5TY
         IgWorsrsOEjzKXM4kH4WOJfHGvxRq5NeXuItHpDXPSXHSN6trZjBu10iWQ9dqi3vox
         xZPfqYoEZUhCw==
Date:   Fri, 28 May 2021 15:02:22 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] kgdb: Fix fall-through warning for Clang
Message-ID: <20210528200222.GA39201@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a
fall-through warning by explicitly adding a goto statement instead
of letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 25 in linux-next. This is one of those last remaining
      warnings.

 kernel/debug/debug_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 4708aec492df..431749dd9ab6 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -1038,6 +1038,7 @@ dbg_notify_reboot(struct notifier_block *this, unsigned long code, void *x)
 	switch (kgdbreboot) {
 	case 1:
 		kgdb_breakpoint();
+		goto done;
 	case -1:
 		goto done;
 	}
-- 
2.27.0

