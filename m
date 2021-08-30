Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 858BFC43216
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B6560E98
	for <linux-hardening@archiver.kernel.org>; Tue, 31 Aug 2021 00:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhHaABK (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 30 Aug 2021 20:01:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:50159 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239208AbhHaABB (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 30 Aug 2021 20:01:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="218381546"
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="218381546"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,364,1620716400"; 
   d="scan'208";a="530712977"
Received: from ajinkyak-mobl2.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.240.95])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 17:00:06 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     dave.hansen@intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, akpm@linux-foundation.org, keescook@chromium.org,
        shakeelb@google.com, vbabka@suse.cz, rppt@kernel.org
Cc:     Rick Edgecombe <rick.p.edgecombe@intel.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 14/19] x86/efi: Toggle table protections when copying
Date:   Mon, 30 Aug 2021 16:59:22 -0700
Message-Id: <20210830235927.6443-15-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Toggle page table writability when copying page tables in
efi_sync_low_kernel_mappings(). These page tables will not be protected
until after init, but later on they will not be writable.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/platform/efi/efi_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index 7515e78ef898..7a5c81450fa4 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -116,7 +116,9 @@ void efi_sync_low_kernel_mappings(void)
 	pgd_k = pgd_offset_k(PAGE_OFFSET);
 
 	num_entries = pgd_index(EFI_VA_END) - pgd_index(PAGE_OFFSET);
+	enable_pgtable_write();
 	memcpy(pgd_efi, pgd_k, sizeof(pgd_t) * num_entries);
+	disable_pgtable_write();
 
 	pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
 	pgd_k = pgd_offset_k(EFI_VA_END);
@@ -124,7 +126,9 @@ void efi_sync_low_kernel_mappings(void)
 	p4d_k = p4d_offset(pgd_k, 0);
 
 	num_entries = p4d_index(EFI_VA_END);
+	enable_pgtable_write();
 	memcpy(p4d_efi, p4d_k, sizeof(p4d_t) * num_entries);
+	disable_pgtable_write();
 
 	/*
 	 * We share all the PUD entries apart from those that map the
@@ -139,13 +143,17 @@ void efi_sync_low_kernel_mappings(void)
 	pud_k = pud_offset(p4d_k, 0);
 
 	num_entries = pud_index(EFI_VA_END);
+	enable_pgtable_write();
 	memcpy(pud_efi, pud_k, sizeof(pud_t) * num_entries);
+	disable_pgtable_write();
 
 	pud_efi = pud_offset(p4d_efi, EFI_VA_START);
 	pud_k = pud_offset(p4d_k, EFI_VA_START);
 
 	num_entries = PTRS_PER_PUD - pud_index(EFI_VA_START);
+	enable_pgtable_write();
 	memcpy(pud_efi, pud_k, sizeof(pud_t) * num_entries);
+	disable_pgtable_write();
 }
 
 /*
-- 
2.17.1

