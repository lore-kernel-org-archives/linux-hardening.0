Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE63C4321A
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 21:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296E964FD4
	for <linux-hardening@archiver.kernel.org>; Tue,  9 Mar 2021 21:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhCIVna (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhCIVnO (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Tue, 9 Mar 2021 16:43:14 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C54DC06175F
        for <linux-hardening@vger.kernel.org>; Tue,  9 Mar 2021 13:43:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id kk2-20020a17090b4a02b02900c777aa746fso5970942pjb.3
        for <linux-hardening@vger.kernel.org>; Tue, 09 Mar 2021 13:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=fXCfvnU3D4wVS2gnx4R+6sEkANTA5C4Qx8s+R2Snvl4CfYrjd711MJmnMdXeC6GL/I
         PCoEcCoP0iSQ5ydymCVNPBPt0drSoZzLLX1BF0oLBizNtnX90NKPXVxlmNQlaA8fAIoj
         ryM7dBfe4KsBcn46bv7w6H7Idv2DnikOzytCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=iarulguydUB7dZZMvRFZ0Sm0KBWwuQ4ow2yyUCixONttOwEHV5AULro4O2ZaN/Gjid
         a6XKrVPu2Jvx1Cwk+DqlmhUF8fgvmkk+LdaXbMMgiQw83VRedDQ10LwALIFxGUPuUt+D
         KyJI/TiTSJYFX6DUMILfracwNlOxwJ1BVzJ3ed3gtIWKT0HY/3ad6osUvQNg9b/Ui/OD
         iJV5OOKYN17C3UllcHXsfzefplhhDuKDOfQ8BJfu92U3DudjJ2A5OtIcg+UJAkL7OVdW
         AkrwRvPhZN0edhAKI8qCVkokMLae7d4i+0ZFJg8ccyfkLbX01HyKjTpXR6QXD1vcUQs+
         9pzA==
X-Gm-Message-State: AOAM531l5M+q78yykZ/VOdtr0pJIVZ/VwW5SeVXz+odAlJHWGTdhK5Ks
        chVIBywB5WcwUv/Z8adS9P8/hQ==
X-Google-Smtp-Source: ABdhPJwMAeJop9UPtI3jZOkzjoT12RbrdsqpFgJGTkl99HdMDta1V57qg5ZxtpfVe+IAGkz4ensuyA==
X-Received: by 2002:a17:902:6ac1:b029:e3:dbc0:bc44 with SMTP id i1-20020a1709026ac1b02900e3dbc0bc44mr27861641plt.15.1615326193986;
        Tue, 09 Mar 2021 13:43:13 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v3sm13672138pff.217.2021.03.09.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 13:43:11 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v5 7/7] lkdtm: Add REPORT_STACK for checking stack offsets
Date:   Tue,  9 Mar 2021 13:43:01 -0800
Message-Id: <20210309214301.678739-8-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210309214301.678739-1-keescook@chromium.org>
References: <20210309214301.678739-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=fb815901a1ccc1d9c4ca5c3e3cd3729b7f382fe2; i=b69wRsxT78r/3tM1mGa7N6ME6+rlXyFg15giRWRwPAQ=; m=aFqgiEE+nAZdug79A1F+fVTg9ZceUb0WPE8cbHqssVg=; p=ZQ32/kILkW5AD3nBZHO0VMTp4prIPkm7+DdhCHX8KdA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBH6+QACgkQiXL039xtwCY9qhAAhOW Jji3ZCJ3RnoaGRrD0g0EhW5yFisz4YxnlNFMM7jo9oEkkaEIg5Cms4k2RvZrJ99lKsWQwbBhzNuM+ rCDNkeT8iaL2KUsW7Wo7+6szheXR5qMdUTHKKX/nOd1uPS8zHdnMNBkOts94EJQ/Zi4WoE4M380XF 47N+kZ8mPuzp9vyHEVUuPre4Dc7Tqmg2bzpBi8tjTrZBVBXul/7Plp2Wbry/KX3lrUl/vq3VaNypY MhHZhQnufm5Nkx93kwAL/aB7zoIZppUx8G4GrqzgT8InUwgfWD/KaX6atmi0FiMIzyFRKfANnk/rG gm0DClhml0R0e5xMPFHy/aDTZxyjkarc66p/PSUfKCRWOfQ9mOA6HxIcpO8phsZ176kf1Ge+nrt0D vT+mGYXOznFNK8yNioU8/h3F6A/IUtFoK0BN1KTG5azbjperev/mix3MNVLHWQn64+OmoknnIZKKf boW/jcOs+FV/7/e11Atvz5H2BQyEer7KZmWnyoc+WZi//J69k8JN11FgMyMttnfU8h5qT3YzzT4F0 sEpmlrNFTfMHnL42Lq2rKO2uVjXqqzti1VNVAPVtpBgNCWdzhlBvF4VC+Y28uivtgwCovRhH4lKaO EcmyX88q25Tn95RBx7Y7EcFqRvubjTsJTcq3Dw9W08iqQrjt+/8Lnfz7XVUtGeJQ=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

For validating the stack offset behavior, report the offset from a given
process's first seen stack address. A quick way to measure the entropy:

for i in $(seq 1 1000); do
	echo "REPORT_STACK" >/sys/kernel/debug/provoke-crash/DIRECT
done
offsets=$(dmesg | grep 'Stack offset' | cut -d: -f3 | sort | uniq -c | sort -n | wc -l)
echo "$(uname -m) bits of stack entropy: $(echo "obase=2; $offsets" | bc | wc -L)"

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/bugs.c  | 17 +++++++++++++++++
 drivers/misc/lkdtm/core.c  |  1 +
 drivers/misc/lkdtm/lkdtm.h |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 110f5a8538e9..0e8254d0cf0b 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -134,6 +134,23 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 	__lkdtm_CORRUPT_STACK((void *)&data);
 }
 
+static pid_t stack_pid;
+static unsigned long stack_addr;
+
+void lkdtm_REPORT_STACK(void)
+{
+	volatile uintptr_t magic;
+	pid_t pid = task_pid_nr(current);
+
+	if (pid != stack_pid) {
+		pr_info("Starting stack offset tracking for pid %d\n", pid);
+		stack_pid = pid;
+		stack_addr = (uintptr_t)&magic;
+	}
+
+	pr_info("Stack offset: %d\n", (int)(stack_addr - (uintptr_t)&magic));
+}
+
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 {
 	static u8 data[5] __attribute__((aligned(4))) = {1, 2, 3, 4, 5};
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b2aff4d87c01..8024b6a5cc7f 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -110,6 +110,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(EXHAUST_STACK),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
+	CRASHTYPE(REPORT_STACK),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 5ae48c64df24..99f90d3e5e9c 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -17,6 +17,7 @@ void lkdtm_LOOP(void);
 void lkdtm_EXHAUST_STACK(void);
 void lkdtm_CORRUPT_STACK(void);
 void lkdtm_CORRUPT_STACK_STRONG(void);
+void lkdtm_REPORT_STACK(void);
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void);
 void lkdtm_SOFTLOCKUP(void);
 void lkdtm_HARDLOCKUP(void);
-- 
2.25.1

