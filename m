Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99BFC25B08
	for <linux-hardening@archiver.kernel.org>; Wed, 17 Aug 2022 05:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiHQFIC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 17 Aug 2022 01:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiHQFIB (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 17 Aug 2022 01:08:01 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DFE6CF74
        for <linux-hardening@vger.kernel.org>; Tue, 16 Aug 2022 22:08:00 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 047D85C012D;
        Wed, 17 Aug 2022 01:07:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 Aug 2022 01:07:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1660712877; x=1660799277; bh=U+StPTdWwzIpuPliBQJoSII+s
        wR2EU+LlrpyJjND3ds=; b=Qc2b6+8Os2pXQf2sSHHWRGv2L3maQR6uJe4XoXKr2
        F/EckCZ2N0agTlRYTBf6OE+vJRj5MNyt59trylyakxrEK8QOUF2QBOPSiSA1xWtj
        rnHPM3PZGzvzq6ldT8CuQA1rm3PctAChXhNwMEASpf6x/D2OBpKyTn+z2Y+aGlrU
        9lxuh9jjv6HC+2SsY7KXqLvEcv8Ako83CLYsa1R3/AMcd0s22PELv6FlO7bRsBTR
        lT7g616eUTUP/TrgeTdQenB3MK+oCJhoYWOETnZxp9l8Alx37MwRefSYO4lwF2A1
        /EsiUPVhoMmeD0oVTBL3bmaBgqP+fwTDA7EnvppUzvB5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1660712877; x=1660799277; bh=U+StPTdWwzIpuPliBQJoSII+swR2EU+Llrp
        yJjND3ds=; b=LkNWjiLCBo11VsUiJnHTRZJCW8iDNg/2sdU3ZDrZzpEnnVXZP6d
        nASWQDT71sEnxhkvDnB2rYLfwOC7EJiO0aW0w6ypNrfoVGJwY2oS/IWYqHZI/8/v
        O+GOFefrhDDt4juTOo+OYXMeuLSTtO86GXTPkSNc01Rx91t8HLncywnepKl2IgMs
        3BwLerzx+FLyUt7murjg1Vos3EwWZ+8Nv7M8tRISZYBAGBPlQdJ0wv/IRgWwvn/y
        ck5Prz0+8zYEHAbftUPA1WIoXzWGFB03cWiqN8aSKKq72ZoLkp5AYGolp1jOsmlV
        XWDg8DX5kRx9oVI+I5uTqA/pZ+eG45OdpvA==
X-ME-Sender: <xms:rXf8Ysf056DxbVUwrg8Wfj-ttXpjVxRIBMrlfhbOGfHa2EpTATL6Cg>
    <xme:rXf8YuMeGGoTLgDAgsSpAYPKpSMFhy5s7cWp7zFbFjhuDkl9LfORhBr5vMQBNZKdO
    5c4tkEYXyLfqWBNmQ>
X-ME-Received: <xmr:rXf8YthwqSIJvi9XticTdtOjftpL5FkKcaotGo1yiLJuHANVeD4ndTp_Jt_MKUgedjwUmpEIkedkzSmlc3Y6qI6LAA4Wh8CmdNykcda2C-zb7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehhedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhrrhgv
    hicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpedvge
    duteejgfevveevuddtieegleeuffevhfefueehueffkefhffehgeehjefhtdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrh
    hushhsvghllhdrtggt
X-ME-Proxy: <xmx:rXf8Yh-Iipn2-MNaI7mwJA1LF_kQweyuZ1Rf7MN7wYwmsXKs8eEubw>
    <xmx:rXf8YouTH3HYFCUmZhisuhuYbJW7M7cG5xKrco6icJHuIElEg9HV5w>
    <xmx:rXf8YoFQC5iBFQEOPfY4DTkbN45ai591Zju47bGD8FeuaiOSCsC-FA>
    <xmx:rXf8YmA_dnlTicWphm30glWUkn9CkcYrz8lefhVMoYEm3uATnOsZaQ>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Aug 2022 01:07:54 -0400 (EDT)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     mpe@ellerman.id.au, ajd@linux.ibm.com, aneesh.kumar@linux.ibm.com,
        npiggin@gmail.com, anshuman.khandual@arm.com,
        christophe.leroy@csgroup.eu, linux-hardening@vger.kernel.org,
        nicholas@linux.ibm.com, Russell Currey <ruscur@russell.cc>
Subject: [PATCH v4 1/2] powerpc/mm: Support execute-only memory on the Radix MMU
Date:   Wed, 17 Aug 2022 15:06:39 +1000
Message-Id: <20220817050640.406017-1-ruscur@russell.cc>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Add support for execute-only memory (XOM) for the Radix MMU by using an
execute-only mapping, as opposed to the RX mapping used by powerpc's
other MMUs.

The Hash MMU already supports XOM through the execute-only pkey,
which is a separate mechanism shared with x86.  A PROT_EXEC-only mapping
will map to RX, and then the pkey will be applied on top of it.

mmap() and mprotect() consumers in userspace should observe the same
behaviour on Hash and Radix despite the differences in implementation.

Replacing the vma_is_accessible() check in access_error() with a read
check should be functionally equivalent for non-Radix MMUs, since it
follows write and execute checks.  For Radix, the change enables
detecting faults on execute-only mappings where vma_is_accessible() would
return true.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
v4: Reword commit message, add changes suggested by Christophe and Aneesh

 arch/powerpc/include/asm/book3s/64/pgtable.h |  2 ++
 arch/powerpc/mm/book3s64/pgtable.c           | 11 +++++++++--
 arch/powerpc/mm/fault.c                      |  6 +++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 392ff48f77df..486902aff040 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -151,6 +151,8 @@
 #define PAGE_COPY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_EXEC)
+/* Radix only, Hash uses PAGE_READONLY_X + execute-only pkey instead */
+#define PAGE_EXECONLY	__pgprot(_PAGE_BASE | _PAGE_EXEC)
 
 /* Permission masks used for kernel mappings */
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_KERNEL_RW)
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 7b9966402b25..f6151a589298 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -553,8 +553,15 @@ EXPORT_SYMBOL_GPL(memremap_compat_align);
 
 pgprot_t vm_get_page_prot(unsigned long vm_flags)
 {
-	unsigned long prot = pgprot_val(protection_map[vm_flags &
-					(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
+	unsigned long prot;
+
+	/* Radix supports execute-only, but protection_map maps X -> RX */
+	if (radix_enabled() && ((vm_flags & VM_ACCESS_FLAGS) == VM_EXEC)) {
+		prot = pgprot_val(PAGE_EXECONLY);
+	} else {
+		prot = pgprot_val(protection_map[vm_flags &
+						 (VM_ACCESS_FLAGS | VM_SHARED)]);
+	}
 
 	if (vm_flags & VM_SAO)
 		prot |= _PAGE_SAO;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 014005428687..1566804e4b3d 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -270,7 +270,11 @@ static bool access_error(bool is_write, bool is_exec, struct vm_area_struct *vma
 		return false;
 	}
 
-	if (unlikely(!vma_is_accessible(vma)))
+	/*
+	 * Check for a read fault.  This could be caused by a read on an
+	 * inaccessible page (i.e. PROT_NONE), or a Radix MMU execute-only page.
+	 */
+	if (unlikely(!(vma->vm_flags & VM_READ)))
 		return true;
 	/*
 	 * We should ideally do the vma pkey access check here. But in the
-- 
2.37.2

