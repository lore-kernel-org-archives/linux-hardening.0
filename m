Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D88C433FE
	for <linux-hardening@archiver.kernel.org>; Mon, 10 Jan 2022 23:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242836AbiAJXPs (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 10 Jan 2022 18:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241981AbiAJXPr (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 10 Jan 2022 18:15:47 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2785C06173F
        for <linux-hardening@vger.kernel.org>; Mon, 10 Jan 2022 15:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gkLyQW+6Ycdwdc+pNLLo7lhLSJHZ64K0RTb7J06MeVI=; b=eUeTG0xNkuY1sWiCq8xs6o+qzL
        ZknC/MqaeLBJOt/ELt02bb+ICarfDB97zD6FoOsY7CGypcinxzEgGSW142+kmCBzgWPtmIpNb7XME
        u12tOhe2QWv9YxEt154MjEiv30jO8jsGuW/vbkNmHE+9CbK32TIvOHLfOmTIODMVMlolg3TWI0iHI
        I9PW6215jJxlpSQ/dr4W8g4C/eiyxdn6ZhZHLmDrJp9agJ5pHvY2b6+7wd3awbK8jndQzsUYH9Cwc
        2s/WGytDuXLoIos1HG6E12/IwMFKR+m4Vqc7GsbCCIhLnC/QHRErpc845QqJj2VeFaAuPC8Z9leUd
        FwAubJZA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n73sy-002nGD-AF; Mon, 10 Jan 2022 23:15:32 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH 0/4] Assorted improvements to usercopy
Date:   Mon, 10 Jan 2022 23:15:26 +0000
Message-Id: <20220110231530.665970-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

The HARDENED_USERCOPY_PAGESPAN config option is hard to turn on because
much of the kernel uses non-compound high-order page allocations.
This patchset extracts the valuable parts of HARDENED_USERCOPY_PAGESPAN
and then removes the remainder.

v5:
 - Use get_vm_area_size() instead of ->size directly (Mark Hemment)
 - Rebase to current Linus (the slab merge changed a lot of code)
v4:
 - Add the fourth patch to remove HARDENED_USERCOPY_PAGESPAN
v3:
 - Remove a now-unused variable
v2:
 - Prevent a NULL pointer dereference when a vmalloc-range pointer
   doesn't have an associated allocation (me)
 - Report better offsets than "0" (Kees)

Matthew Wilcox (Oracle) (4):
  mm/usercopy: Check kmap addresses properly
  mm/usercopy: Detect vmalloc overruns
  mm/usercopy: Detect large folio overruns
  usercopy: Remove HARDENED_USERCOPY_PAGESPAN

 arch/x86/include/asm/highmem.h   |  1 +
 include/linux/highmem-internal.h | 10 ++++
 mm/usercopy.c                    | 97 +++++++++-----------------------
 security/Kconfig                 | 13 +----
 4 files changed, 39 insertions(+), 82 deletions(-)

-- 
2.33.0

