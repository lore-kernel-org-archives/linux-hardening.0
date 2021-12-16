Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47594C433F5
	for <linux-hardening@archiver.kernel.org>; Thu, 16 Dec 2021 21:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhLPVx7 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 16 Dec 2021 16:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbhLPVx6 (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 16 Dec 2021 16:53:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763E1C061574
        for <linux-hardening@vger.kernel.org>; Thu, 16 Dec 2021 13:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=OLGRXuT0pDEzu7k+efSS+/dptga/8chhdLo/ynoHfRo=; b=ZM06qomPpfAx1Amg4RR29uGEkY
        7AC45IvPUjCy9BUf3HzspVcicOujadOzVbkQtjeahZVARrOUJe8rMrXDK3qKRZWVPeJO2GZn4vxrZ
        uSdFmcwoiJutFSSFmGugIl0PZy/EvqJ93qfIEfBXEa9jY46GnPOprug9YIjEaDtl80Q7Ydsn9mWRu
        ezqYVMJFp3xy7VmZgKyEUvSu8TCOrFL5PBUrBnK/zdQw+mF2IM3dqEVMQJSe3VGS3y4KrNrzAPkJH
        JxFj2rXYS3dy4+F/frOGX/TedTr5CtbgvPVAK4wJPGoxoCDmZGPI/3/FVjbslRDbYRbRsDMXovTFF
        QVVGpuFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxyhE-00FzY4-J5; Thu, 16 Dec 2021 21:53:52 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: [PATCH v4 0/4] Assorted improvements to usercopy
Date:   Thu, 16 Dec 2021 21:53:47 +0000
Message-Id: <20211216215351.3811471-1-willy@infradead.org>
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
  mm/usercopy: Detect compound page overruns
  usercopy: Remove HARDENED_USERCOPY_PAGESPAN

 arch/x86/include/asm/highmem.h   |  1 +
 include/linux/highmem-internal.h | 10 ++++
 mm/usercopy.c                    | 98 +++++++++-----------------------
 security/Kconfig                 | 13 +----
 4 files changed, 40 insertions(+), 82 deletions(-)

-- 
2.33.0

