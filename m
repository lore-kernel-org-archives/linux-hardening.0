Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D17CC433B4
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 00:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12ED1613D6
	for <linux-hardening@archiver.kernel.org>; Wed,  5 May 2021 00:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhEEAd3 (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 4 May 2021 20:33:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:19824 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231503AbhEEAdZ (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 4 May 2021 20:33:25 -0400
IronPort-SDR: NIsHcdQNd+ujF+DaYrQYv1vv2+UuhtKgyL12HctS6yC3so/6XADMpEG007r5UfBMSUFJymDfbP
 8tt9W/2EZCWA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="196058598"
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="196058598"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:29 -0700
IronPort-SDR: ystkmVaLd3ynX9ydNCnx/U8bOYtmoL7EVqOaerYbN9eiXBwAlyVZHDuTDCv0OgBOAZiPRXxDBx
 AVuB95agEXmA==
X-IronPort-AV: E=Sophos;i="5.82,273,1613462400"; 
   d="scan'208";a="429490807"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.209.26.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 17:32:28 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Cc:     ira.weiny@intel.com, rppt@kernel.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH RFC 6/9] x86/mm/cpa: Add set_memory_pks()
Date:   Tue,  4 May 2021 17:30:29 -0700
Message-Id: <20210505003032.489164-7-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
References: <20210505003032.489164-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add function for setting PKS key on kernel memory.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/set_memory.h | 1 +
 arch/x86/mm/pat/set_memory.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index b63f09cc282a..a2bab1626fdd 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -52,6 +52,7 @@ int set_memory_decrypted(unsigned long addr, int numpages);
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
+int set_memory_pks(unsigned long addr, int numpages, int key);
 
 int set_pages_array_uc(struct page **pages, int addrinarray);
 int set_pages_array_wc(struct page **pages, int addrinarray);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 6877ef66793b..29e61afb4a94 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1914,6 +1914,13 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
 
+int set_memory_pks(unsigned long addr, int numpages, int key)
+{
+	return change_page_attr_set_clr(&addr, numpages, __pgprot(_PAGE_PKEY(key)),
+					__pgprot(_PAGE_PKEY(0xF & ~(unsigned int)key)),
+					0, 0, NULL);
+}
+
 int set_memory_x(unsigned long addr, int numpages)
 {
 	if (!(__supported_pte_mask & _PAGE_NX))
-- 
2.30.2

