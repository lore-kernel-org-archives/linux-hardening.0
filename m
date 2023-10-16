Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D74F28E2C
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SyHIg9Dz"
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B854F0
	for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 07:39:05 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-27d104fa285so3708331a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 16 Oct 2023 07:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697467145; x=1698071945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Sn/gKJWR6siX+0KJWM5lAESAe3sWf60qybDDt1Pys=;
        b=SyHIg9DzLy+zp4y+Yjhwxt7wJqC+tl1u18o8eoNRpREPgA952TWGap3RWoHe48fL/B
         lmPrS1T+aBpXzrmOxFFdrcwxUHbvE7dcFfK2m3qQPckUiVWb4eLDa+6NG1GMgzX8Lhtv
         Tl8DP06YSVWn5f2JDlapE7Je/kQQC73QZ0XpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467145; x=1698071945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0Sn/gKJWR6siX+0KJWM5lAESAe3sWf60qybDDt1Pys=;
        b=B9EJj4vx7pRKgPUFqCscET1bE54wFMdS/mebbFUw9QSa7RsF0wEBJFG562O72jYx7z
         5FTS3/OWfoqo+3CJ481t2SbgXzZXVP6UivNFY6R3BjaG/njMNeQaQ1J2Lscrp6/bSS8B
         w4zHjj0Ujn+7E3tUXc0MVrm23ZBZlunbvyalaukajOuslhT2mY0TBLUWWGhg94XS+zP5
         xff7le8bc/MVSGefYDM+DQZ3zIyQvCfyZ8/ur8QEjeScfuQ5lnGz2NWuzsNsMb3Iy+nz
         p8q5aM+Bxvu/AZa6tkax5cZuu1hrUecycMG1M/Hxkhfj/zIxNTRBNcOXWNKRR32x1Oj2
         iHhg==
X-Gm-Message-State: AOJu0YxRgLLErbA9WI106YFqfW3oFCdLtBKvP4zrw5akREqse3EHocU1
	V608iOol5iRD02eRuHtvDJFCZg==
X-Google-Smtp-Source: AGHT+IHQKvwpFIbGSIva7hn5sjCBlscbClIlMg0fHg4jXNaku6Zt8hbJMcw6wC8Uuvj5QeuKGPqvTA==
X-Received: by 2002:a17:90b:1fc6:b0:27d:4283:b8a2 with SMTP id st6-20020a17090b1fc600b0027d4283b8a2mr7510538pjb.14.1697467144783;
        Mon, 16 Oct 2023 07:39:04 -0700 (PDT)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id nh24-20020a17090b365800b0026f39c90111sm5008030pjb.20.2023.10.16.07.39.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 07:39:04 -0700 (PDT)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	sroettger@google.com
Cc: jeffxu@google.com,
	jorgelo@chromium.org,
	groeck@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	jannh@google.com,
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
	torvalds@linux-foundation.org,
	lstoakes@gmail.com,
	willy@infradead.org,
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
Subject: [RFC PATCH v1 6/8] mseal mremap
Date: Mon, 16 Oct 2023 14:38:25 +0000
Message-ID: <20231016143828.647848-7-jeffxu@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016143828.647848-1-jeffxu@chromium.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
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

check seal for mremap(2)

Signed-off-by: Jeff Xu <jeffxu@google.com>
---
 mm/mremap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/mremap.c b/mm/mremap.c
index e43f9ceaa29d..2288f9d0b126 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -836,7 +836,15 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	if ((mm->map_count + 2) >= sysctl_max_map_count - 3)
 		return -ENOMEM;
 
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_ACTION_MREMAP,
+			   ON_BEHALF_OF_USERSPACE))
+		return -EACCES;
+
 	if (flags & MREMAP_FIXED) {
+		if (!can_modify_mm(mm, new_addr, new_addr + new_len,
+				   MM_ACTION_MREMAP, ON_BEHALF_OF_USERSPACE))
+			return -EACCES;
+
 		ret = do_munmap(mm, new_addr, new_len, uf_unmap_early);
 		if (ret)
 			goto out;
@@ -995,6 +1003,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		goto out;
 	}
 
+	if (!can_modify_mm(mm, addr, addr + old_len, MM_ACTION_MREMAP,
+			   ON_BEHALF_OF_USERSPACE)) {
+		ret = -EACCES;
+		goto out;
+	}
+
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-- 
2.42.0.609.gbb76f46606-goog

