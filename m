Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E80FC433E5
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721C6619B5
	for <linux-hardening@archiver.kernel.org>; Fri, 19 Mar 2021 21:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhCSV3A (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 19 Mar 2021 17:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhCSV2n (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 19 Mar 2021 17:28:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C11C061760
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so5482510pjv.1
        for <linux-hardening@vger.kernel.org>; Fri, 19 Mar 2021 14:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=ejy6cWiCTJfmWKQMk10p5UZeWDqZFvT4CND7HoHywBT5DNVyVD3UOAa8Hrycw/ps6+
         05vKXy4nxWv8bg0fVn+U3gkIt4cS3ofZ2TNfd6JbdV1F91DCWJ71jwYLEQtMn9HAXozO
         Mmrjz0kenbtMJXw5cpxlGpbaVeCZwXEnCNpMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uk0/1LocoDticB91SF6FsgWpOKPsEr1Pb6N+E6L28KI=;
        b=cdukKYocnIZ36FC/oJco5z8nTSb7lsRcvYzN3C2OBAxn43ogZV/nsmzVJ7WmoKctNd
         tvqgIGvMsj8PLl3R3LjAdFat+jPINFq4uvUNDgRokZXTUghBxqI1ynYbes51C1nupjRA
         MxSX4p+mMOGDEanJGl7nTcFmqSxht4noHRcJruVYY7wo4ApxbLfmibsPaQMuCGrNZhuM
         RsmuK1OSWslH7du0+lNESSRGzCjsQp5Qfwqgp9a/VRGD9+mnHEuMNMSm3roO2Avgx3mj
         gbrWo4Vpe6k8b0m4hI1ctRDpe3LcX33/nm2PaoRmAxwTguvk5puh+2x1i7IVAC+KT1gB
         AQLg==
X-Gm-Message-State: AOAM530v9FZyHndPqMGpfplO7HSA0enwIFZqFa9gvi6uSCx9lCW8B9Z2
        bfOvYFmF/tpo3Y+SynvtqWlNfw==
X-Google-Smtp-Source: ABdhPJzFbnTfmwXyUjVzk+FU45Te/V6SoFc0L6xXU2lvrEGD0zL0nHl9H9x2B3ZLK0nvFsxdZyfnYA==
X-Received: by 2002:a17:90b:681:: with SMTP id m1mr476466pjz.168.1616189322441;
        Fri, 19 Mar 2021 14:28:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y24sm6148989pfn.213.2021.03.19.14.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:28:41 -0700 (PDT)
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
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] lkdtm: Add REPORT_STACK for checking stack offsets
Date:   Fri, 19 Mar 2021 14:28:35 -0700
Message-Id: <20210319212835.3928492-7-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210319212835.3928492-1-keescook@chromium.org>
References: <20210319212835.3928492-1-keescook@chromium.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=fb815901a1ccc1d9c4ca5c3e3cd3729b7f382fe2; i=b69wRsxT78r/3tM1mGa7N6ME6+rlXyFg15giRWRwPAQ=; m=aFqgiEE+nAZdug79A1F+fVTg9ZceUb0WPE8cbHqssVg=; p=ZQ32/kILkW5AD3nBZHO0VMTp4prIPkm7+DdhCHX8KdA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmBVF4IACgkQiXL039xtwCY3XA/9Hc7 uCdnb6IBdks8FZIXBvGn8iqxkiI9jjjTCKozGcJ39SUBhTi98eLk12QE8/L8iuMzlY7nSS93HTrGV T+BS6LWgoYdWZ1vzeRqKj2ovp8AESLtcLZoWFhX/oM7kbXFpWiChKtvW8u8occfMmeCPD0fjX9OXc 9VwR2F51qP9IA+X7ihTmMfEwT7YurTNg/POD9NMFjhkktXwKJVnxKq7yqnpI9eouW3EMIU26EH2pm b6tihBnsotHNjZJ89gD8aM1o5mg2JgcpQ/lJY3jX3YuNKdjsG2Vg8DUB+04NrbdLysjqZQ0DIHamy UVXKM0B6ZPLPz5nOimx/D5TYpWDY7Yj5lTS7gYnjJzt0UFCECHHocfss+/eC5EnJwETz/JpUcRpuS CsswP/CZZ9Hf1HqvEy3F+aIuT5uP8PgGSNRztkK76YJ6Xrj9Mln6u7bPBCn0+EYsmlsL2/oCGVc4M /nfQmQ9sjPsm1hGhs4Xdoh4HX2OpPln6fqCYaV/yWfgQysuaGi083LU3OVDKvw6HWc8ZzqF48EU42 sisXTwgZJadagLzYDaJurWB+bqV52QnkLr6/Hb0Mp0Yu1tW+0pp5IMVxP3Fo575mLgTyeWbmv/kCs TDzCPCOMxiG4lsvlDqgluKkVTdZ1PD/AylEtmoS2tOihVR0k2loLyrEXi//t+jKk=
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

