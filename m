Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F44EECAAD8
	for <linux-hardening@archiver.kernel.org>; Fri, 16 Sep 2022 14:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIPOPQ (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiIPOPN (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 16 Sep 2022 10:15:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA833CBD6;
        Fri, 16 Sep 2022 07:15:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597066277E;
        Fri, 16 Sep 2022 14:15:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2302C433D6;
        Fri, 16 Sep 2022 14:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663337709;
        bh=ZP/LxkFN5dV5vhW4DgkYG+8YyHxvLgZVftkuiKVPu7M=;
        h=Date:From:To:Cc:Subject:From;
        b=j2UFEmLJdjhCi7rpTJe3YiWaumoVT7ncJfH1W+mqqPrQmS0A2NAC8tc2Mi9fVUal/
         MVCNPOqdgl6SIUYDPBti2lPFcGA0UxNYMe5WqjITsvIFgoCVaTDmMvUSwQlmOgs6SP
         mqB2usFMLP47Qw8doPEduBZ/+6Quyk05vMhF694Vz2j5TALOyhxEsC5/wPac2kCxhC
         s6hnaPHw4ICg5bachbAgoGma8zf098TFxYPZfsB9cB6TADN4rWwcUg/pHkGegF267o
         NOKzeD7o4tCWNJljcMVUn9lnLRsRUy1qpKLlyS6W2EezwpzI76sqNf6JKmIi/zyCog
         ZemiUfmafvcMQ==
Date:   Fri, 16 Sep 2022 15:15:04 +0100
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] powerpc/xmon: Fix -Wswitch-unreachable warning in
 bpt_cmds
Message-ID: <YySE6FHiOcbWWR+9@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

When building with automatic stack variable initialization, GCC 12
complains about variables defined outside of switch case statements.
Move the variable into the case that uses it, which silences the warning:

arch/powerpc/xmon/xmon.c: In function ‘bpt_cmds’:
arch/powerpc/xmon/xmon.c:1529:13: warning: statement will never be executed [-Wswitch-unreachable]
 1529 |         int mode;
      |             ^~~~

Fixes: 09b6c1129f89 ("powerpc/xmon: Fix compile error with PPC_8xx=y")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/powerpc/xmon/xmon.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 26ef3388c24c..df91dfc7ff72 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1525,9 +1525,9 @@ bpt_cmds(void)
 	cmd = inchar();
 
 	switch (cmd) {
-	static const char badaddr[] = "Only kernel addresses are permitted for breakpoints\n";
-	int mode;
-	case 'd':	/* bd - hardware data breakpoint */
+	case 'd': {	/* bd - hardware data breakpoint */
+		static const char badaddr[] = "Only kernel addresses are permitted for breakpoints\n";
+		int mode;
 		if (xmon_is_ro) {
 			printf(xmon_ro_msg);
 			break;
@@ -1560,6 +1560,7 @@ bpt_cmds(void)
 
 		force_enable_xmon();
 		break;
+	}
 
 	case 'i':	/* bi - hardware instr breakpoint */
 		if (xmon_is_ro) {
-- 
2.34.1

