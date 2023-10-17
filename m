Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7238FA0
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 09:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VDQppkk8"
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3991EFF
	for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 02:08:23 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-27d1b48e20dso3051649a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 17 Oct 2023 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697533702; x=1698138502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4llBoLvRHSRPhxaAVX+Xew1tpI9xPqxP9ssy5QguIl8=;
        b=VDQppkk8b9oCirBVlMxquQtLBR6oq+NEIUW991fieiIzfnXy0uSyhDmOQ/pFCxsfTk
         vNq0/t+GaIHx3RbgU+O+OsbqxmLJ+QfIBiRFL8ZupoXc2g2kM3tDfchfxPLkpoUW6Cks
         mSwqs/n3UF4MnYQ4QiXTGmby2Ib/D07ubXtK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697533702; x=1698138502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4llBoLvRHSRPhxaAVX+Xew1tpI9xPqxP9ssy5QguIl8=;
        b=OOpBD7M+7w3fQDR3Vj20W6eo9uLyOWMk6eV2bG9+7D4XAI4ougnUMTmUk5953nDSem
         2TU2UdRSfRZH5JtclyvLOrPaQGT6IEiSGdsfcyFdPbpZRTzpTeJbyHBpTwYG+gu+y53w
         6t2yu5iC9+aMj1YIUBvg3Ao3P7oPCkCk82SzWywxVKxObimsKJb76cUmQlH3kTsZlFqE
         7mrAmarzz2gQN4m5x0+kb8yCRp4+HQLV0wQaO59PlapnFSker/uUrVwZm+GUhruTqchV
         gCVwdL+WN7WApDdmLK/u5g4XUOCN/MAASJ/XZXWemoJh//PLpEi6cEOTNTVxreJd2yMB
         8xEQ==
X-Gm-Message-State: AOJu0YyrzUr4Jpk9HKiPuloaezfzBwnsh4afffc/IvyCFnb3m6XnTaY5
	uG4ht6G4PFWSeElG1NrLgEuzdw==
X-Google-Smtp-Source: AGHT+IGY8Ka5xTN+9aN+5JwGnYHZ3aFuu39VQWy4bG7nyYFZ0P/8XqDQIp2idGjzoHOlr8sq9RvLbg==
X-Received: by 2002:a17:90b:124a:b0:27c:f21b:6342 with SMTP id gx10-20020a17090b124a00b0027cf21b6342mr1443714pjb.22.1697533702687;
        Tue, 17 Oct 2023 02:08:22 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id t13-20020a17090ae50d00b00277326038dasm868586pjy.39.2023.10.17.02.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 02:08:22 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	sroettger@google.com,
	willy@infradead.org,
	gregkh@linuxfoundation.org,
	torvalds@linux-foundation.org
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	surenb@google.com,
	alex.sierra@amd.com,
	apopple@nvidia.com,
	aneesh.kumar@linux.ibm.com,
	axelrasmussen@google.com,
	ben@decadent.org.uk,
	catalin.marinas@arm.com,
	david@redhat.com,
	dwmw@amazon.co.uk,
	ying.huang@intel.com,
	hughd@google.com,
	joey.gouly@arm.com,
	corbet@lwn.net,
	wangkefeng.wang@huawei.com,
	Liam.Howlett@oracle.com,
	lstoakes@gmail.com,
	mawupeng1@huawei.com,
	linmiaohe@huawei.com,
	namit@vmware.com,
	peterx@redhat.com,
	peterz@infradead.org,
	ryan.roberts@arm.com,
	shr@devkernel.io,
	vbabka@suse.cz,
	xiujianfeng@huawei.com,
	yu.ma@intel.com,
	zhangpeng362@huawei.com,
	dave.hansen@intel.com,
	luto@kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v2 4/8] mseal: Check seal flag for mprotect(2)
Date: Tue, 17 Oct 2023 09:08:11 +0000
Message-ID: <20231017090815.1067790-5-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231017090815.1067790-1-jeffxu@chromium.org>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jeff Xu <jeffxu@google.com>

mprotect(2) changes protection of VMAs in the given address
range. Sealing will prevent unintended mprotect call.

What this patch does:
When a mprotect(2) is invoked, if one of its VMAs has MM_SEAL_MPROTECT
set from previous mseal(2) call, this mprotect(2) will fail, without
any VMA modified.

This patch is based on following:
1. do_mprotect_pkey() currently called in two places:
SYSCALL_DEFINE3(mprotect,...)
SYSCALL_DEFINE4(pkey_mprotect, ...)
and not in any other places, therefore omit changing the signature of
do_mprotect_pkey(), i.e. not passing checkSeals flag.

2. In do_mprotect_pkey(), calls can_modify_mm() before any
update is made on the VMAs.

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/mprotect.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 130db91d3a8c..6321c4d0aa3f 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -32,6 +32,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/userfaultfd_k.h>
 #include <linux/memory-tiers.h>
+#include <uapi/linux/mman.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -753,6 +754,20 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 		}
 	}
 
+       /*
+	* do_mprotect_pkey() currently called from two places:
+	* SYSCALL_DEFINE3(mprotect,...)
+	* SYSCALL_DEFINE4(pkey_mprotect, ...)
+	* and not from other places.
+	* Therefore, omit changing the signature of do_mprotect_pkey().
+	* Otherwise, we might need to add checkSeals and pass it
+	* from all callers of do_mprotect_pkey().
+	*/
+	if (!can_modify_mm(current->mm, start, end, MM_SEAL_MPROTECT)) {
+		error = -EACCES;
+		goto out;
+	}
+
 	prev = vma_prev(&vmi);
 	if (start > vma->vm_start)
 		prev = vma;
-- 
2.42.0.655.g421f12c284-goog

