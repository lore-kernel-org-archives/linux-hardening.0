Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4ACC0015E
	for <linux-hardening@archiver.kernel.org>; Wed, 26 Jul 2023 23:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjGZXLt (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjGZXLs (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 26 Jul 2023 19:11:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA31FC2
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 16:11:46 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bb2468257fso2296765ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Jul 2023 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690413106; x=1691017906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r4jdfUVTE7WBKRvJpfj2d5OTzyL4Pf20Sw0o+vzmWQg=;
        b=cWEM4cw/Xmvw/Yc4U7z6EZydB4+ARQlb9npX06puzQ8ttDgkdjkLDLzoPXiRYyO1Dc
         /WllWfsJwr4GdgXe+YaoqU38sCxEm2l1Zikmsb8G2cVdoF/6xfyjMS/+FISKFdO/zoHp
         JJ/jVwdqi8Mz+WxcTEieLsTvVJsQPtnbc/Oe8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690413106; x=1691017906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r4jdfUVTE7WBKRvJpfj2d5OTzyL4Pf20Sw0o+vzmWQg=;
        b=Kqkbp+IQtDpLLIrXeST/S1KWnWrSggCd4CfKLWOQR1lb7BpYaWueX2RbfWWl5JCraz
         Tmqp8LWNTU7RyOKHZAWltun88rcNUfi2xN2Bauivpix7+gQDQcr1bn3u7oMN3tXiKYgF
         BxsRayS12lMvQdtwQYmFoCKGRsue0PHt5QTNrMaf1IUU3qV1NUL7+6iXmMKz0QvBeLjY
         OXKmcE/29ZFukFU2haw65x1/JMBenqfIwxMoWzSL8wzpZrMDSWcMQe1LSMGl9pS2k/qy
         /7zvjl0nqzuQcQ6KxMuOIO+IsejECsGQJxuKr4G4JRlqJmE0ELbbL/tC34QL87V69A4W
         lFuw==
X-Gm-Message-State: ABy/qLYOIpkDFOfnys5risR+1GAMAqt/4ZhwDqXNPI+RA5IrVpsdCsua
        qD+4vVy0qx5C/7o8I+Lh0/OmSQ==
X-Google-Smtp-Source: APBJJlHIRT7RagOVEgkyJ4BE8SHUXCP9y/ZI0M+lOoJtFqUBjQgpXV1jOJkoWH9XFaUzbitXWxJXWg==
X-Received: by 2002:a17:902:f545:b0:1bb:a367:a70 with SMTP id h5-20020a170902f54500b001bba3670a70mr2634155plf.17.1690413105998;
        Wed, 26 Jul 2023 16:11:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b001bb9883714dsm82329plk.143.2023.07.26.16.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:11:45 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
        linux-hardening@vger.kernel.org
Subject: [PATCH] x86/paravirt: Fix tlb_remove_table function callback prototype warning
Date:   Wed, 26 Jul 2023 16:11:43 -0700
Message-Id: <20230726231139.never.601-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2323; i=keescook@chromium.org;
 h=from:subject:message-id; bh=LqLAiBHCS3SOIFmrkPyUKr3/p9LAy4Na2qeKgbyRhrI=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBkwagvwZ+7zZjxcV7wmzqScO6yy6gJ+KlcGXU/K
 mS4h3RYHdSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZMGoLwAKCRCJcvTf3G3A
 JhbOD/9dxIW8nQqK8eLsN8DjarrXXo2MbTowMSbdqTmppURh3d8EQCiVCszUdxoaRUHvFmiKUwD
 D86KLX1tiSS5FlmX4ehFA5HpFl8hytrIv6LOuRxqCpKGC2bBI/G9LV1VsezmZIaynIqq33TTzSb
 109A2v1VaTm7/xkCakSz3YP1bb54E0aaHp1s8DpDiDQd0TyfFi/M8mdGqi/obyPLhg8JG+rijen
 upCg0o3/Ein1HDCtKa6opIYvNATV0grvRApCnAIctGb9+8SFY2a0OfcJKvkl6PzUSboTIYJGhUj
 BouFli9hesufXioK68mpt9jpJN8jbgriMKaxEWrFmMQFplcKDGpsF1mCidFz+XzJYoBc9JHktUb
 6MkSAssX4OZC+kqJ6DLNqCWg5au02WpdbEhCtzMlZm79xenUBUIgOEulsIrUSqjm1Cs2q5ovoJl
 OOrOyA0ckQKVx+JXSgwDfog4rCyllA0sD2ui31ftHyETeH8MPOr6t45gSN/h6rtv3lNCmlbPuLp
 zwt96o1ZirQgD3U2/AVclaSoqcS7bsL22skLip02dZ0Zx4mVqTxfueAigIzDiB79B6dz+3V4E5J
 ypR9j+96fTzo6acv0GLam7/8ORNyRhm10PhPoup2PKCgVqq2FuhihR9cmInkFlclyfcxbFFHNBh
 00lNaL4 PSbWXsTQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Under W=1, this warning is visible in Clang 16 and newer:

arch/x86/kernel/paravirt.c:337:4: warning: cast from 'void (*)(struct mmu_gather *, struct page *)' to 'void (*)(struct mmu_gather *, void *)' converts to incompatible function type [-Wcast-function-type-strict]
                           (void (*)(struct mmu_gather *, void *))tlb_remove_page,
                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add a direct wrapper instead, which will make this warning (and
potential KCFI failures) go away.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307260332.pJntWR6o-lkp@intel.com/
Cc: Juergen Gross <jgross@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Ajay Kaher <akaher@vmware.com>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/paravirt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index ac10b46c5832..23d4d7114473 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -79,6 +79,11 @@ void __init native_pv_lock_init(void)
 		static_branch_disable(&virt_spin_lock_key);
 }
 
+static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
+{
+	tlb_remove_page(tlb, table);
+}
+
 unsigned int paravirt_patch(u8 type, void *insn_buff, unsigned long addr,
 			    unsigned int len)
 {
@@ -295,8 +300,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
 	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
 	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
-	.mmu.tlb_remove_table	=
-			(void (*)(struct mmu_gather *, void *))tlb_remove_page,
+	.mmu.tlb_remove_table	= native_tlb_remove_table,
 
 	.mmu.exit_mmap		= paravirt_nop,
 	.mmu.notify_page_enc_status_changed	= paravirt_nop,
-- 
2.34.1

