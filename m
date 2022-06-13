Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55AC433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Jun 2022 18:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245222AbiFMSbK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Jun 2022 14:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbiFMSay (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Jun 2022 14:30:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CCDB579D
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 07:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB5C612DF
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jun 2022 14:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC839C34114;
        Mon, 13 Jun 2022 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655131590;
        bh=LjOcH+X/tm2Am8CI0leYbdLYQWiWtQgJBPgRi4QCq8E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a6tlQ6t3KlnYMjDx6BXlyvRjCEkX8sLRsRMhj4rQ2mHoGfhiOmbDu5PeGrkdGi/rV
         ArWHFQMCQdY2HN4J3lPFs38Ee0/2XssFK1ZBOCThL3ZETC/FQUhYPJc4IHTh1VQ+Qf
         tlFVGqupybqJ3NwTULu2iSOoNHI0jUn6ZxMb3qmqDeOMB7ZT5dnmKibCV/FauZmmSG
         dcljUi6Wo1d3/p1MNDXYUbX2365CKPsp/2gceTTMSXtCPQP8SWv3DB8LmNh78wbZA5
         CGPiQJ62pom47a6GbHeElLeMfCuLe6BL8UI03rVKd9t7Cfx2CEb5zvSslst6RPIH1x
         wxqoy6VDPRHKA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-hardening@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH v4 11/26] arm64: head: add helper function to remap regions in early page tables
Date:   Mon, 13 Jun 2022 16:45:35 +0200
Message-Id: <20220613144550.3760857-12-ardb@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144550.3760857-1-ardb@kernel.org>
References: <20220613144550.3760857-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2144; h=from:subject; bh=LjOcH+X/tm2Am8CI0leYbdLYQWiWtQgJBPgRi4QCq8E=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBip01/7ud8ilSZjcXZ1b0RhQ/5UPWS02h8A+JMdYP6 DlobcwuJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqdNfwAKCRDDTyI5ktmPJC6iDA C/aUL3MNHRrbfyhpvFNjuYk9d8DQh703O3nCOQqjbepHVyA8kvTix232Y+Fw//1eE2Tdc85nFfL2p8 CeEs6MNDcfzXGkdyW9ZiUQrqvo8IPzxLt1onNJKka3eBa7bs8MZoqq7Lxw0yT+3t9tuXqnpMIETYDT lmGlgFprjhzwIDjPFJC1RE9IMfa3iTTp7KGfMmcfYvqDtqlV1Jyp443BpSXVfy5Osjd+iU/2Nls4CT nVha04y6QpHB0IytnqkeQeRbkPGHsxM5b7424pr5/oD1JgZhkISoiSKku+J2vv/zBdH2TF05V+TVPX ryuD99HWo40LbvmF7dtIXcfF71nBg5mJQhfAkwwhUGnvlrLt7orQOJrW94RXa/9PDKjOQRT9fFOrCg DmY2CednZiaSR9oMoyAdvGRznrRFWcqP2OzYrhHkUkbNYNVycOgSW+jBCkYw+R6zzjYxOBdjAibCT4 VVQxR/pwNZo3tNTh2N4ps6nXvqQvsrPbGoPbRoHMu6iUw=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The asm macros used to create the initial ID map and kernel mappings
don't support randomly remapping parts of the address space after it has
been populated. What we can do, however, given that all block or page
mappings are created at the final level, is take a subset of the mapped
range and update its attributes or output address. This will permit us
to make parts of these page tables read-only, or remap a part of it to
cover the device tree.

So add a helper that encapsulates this.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/head.S | 33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 70c462bbd6bf..7397555f8437 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -263,6 +263,39 @@ SYM_FUNC_END(clear_page_tables)
 	populate_entries \tbl, \rtbl, \istart, \iend, \flags, #SWAPPER_BLOCK_SIZE, \tmp
 	.endm
 
+/*
+ * Remap a subregion created with the map_memory macro with modified attributes
+ * or output address. The entire remapped region must have been covered in the
+ * invocation of map_memory.
+ *
+ * x0: last level table address (returned in first argument to map_memory)
+ * x1: start VA of the existing mapping
+ * x2: start VA of the region to update
+ * x3: end VA of the region to update (exclusive)
+ * x4: start PA associated with the region to update
+ * x5: attributes to set on the updated region
+ * x6: order of the last level mappings
+ */
+SYM_FUNC_START_LOCAL(remap_region)
+	sub	x3, x3, #1		// make end inclusive
+
+	// Get the index offset for the start of the last level table
+	lsr	x1, x1, x6
+	bfi	x1, xzr, #0, #PAGE_SHIFT - 3
+
+	// Derive the start and end indexes into the last level table
+	// associated with the provided region
+	lsr	x2, x2, x6
+	lsr	x3, x3, x6
+	sub	x2, x2, x1
+	sub	x3, x3, x1
+
+	mov	x1, #1
+	lsl	x6, x1, x6		// block size at this level
+
+	populate_entries x0, x4, x2, x3, x5, x6, x7
+	ret
+SYM_FUNC_END(remap_region)
 
 SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x0, idmap_pg_dir
-- 
2.30.2

