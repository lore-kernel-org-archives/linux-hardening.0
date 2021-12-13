Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D3EC433F5
	for <linux-hardening@archiver.kernel.org>; Mon, 13 Dec 2021 14:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhLMO1L (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 13 Dec 2021 09:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbhLMO1L (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 13 Dec 2021 09:27:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED57EC061574
        for <linux-hardening@vger.kernel.org>; Mon, 13 Dec 2021 06:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=zV0YtvdfLCJEMQDqceavC8GyCVu0H6FprTtis1wh+J0=; b=etQyLPPMorbbhW6PS/Oyh0Gr5n
        maDVOy2meTffMCuCx5lSxzTA3k4HBoHFKZb7nievj9k9o8652Yda2yT5tZqeiw90fYW+AeUmrOjZn
        S7AGAZuBkL1SVDf/X9GIkZQxlskJorTuBzNcybVLApx/LfjCL4SDlDArupfSPCIXYLRSXWoom+uvu
        8cJ/TSJQszrkjalJ/QNq9GZD9HHtyWBXpuImNObjn3/Lu01nc98hAMp6jf+JuVH+L/iRzOqO9MWl/
        6RqciN1E1fYIsUIbRRhUZET0OvkeI8vv0nq40GkKh7wsuCUniYberRoWrljwSLC1pSmKLTGNQd+wK
        hCPqzc3w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwmID-00Crlr-3n; Mon, 13 Dec 2021 14:27:05 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v3 0/3] Assorted improvements to usercopy
Date:   Mon, 13 Dec 2021 14:27:00 +0000
Message-Id: <20211213142703.3066590-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

We must prohibit page boundary crossing for kmap() addresses.
vmap() addresses are limited by the length of the mapping, and
compound pages are limited by the size of the page.

These should probably all have test cases?

v3:
 - Remove a now-unused variable
v2:
 - Prevent a NULL pointer dereference when a vmalloc-range pointer
   doesn't have an associated allocation (me)
 - Report better offsets than "0" (Kees)


Matthew Wilcox (Oracle) (3):
  mm/usercopy: Check kmap addresses properly
  mm/usercopy: Detect vmalloc overruns
  mm/usercopy: Detect compound page overruns

 arch/x86/include/asm/highmem.h   |  1 +
 include/linux/highmem-internal.h | 10 ++++++++
 mm/usercopy.c                    | 43 +++++++++++++++++++++++---------
 3 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.33.0

