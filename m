Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E59E28D8D9
	for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 19:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752348264; cv=none; b=MvWnIYNoyIWEOjvdtjb2u1H2e+qpjVfiyIFOI1X19cIEEF2pYN2s8QB/3roVz8rkaQo5HS3t3uu4jFX2NRUDC/rDEKJC8XDtJNiMN4UDHDigEW4bvJyqRjK2wT4PicExAyyCoHAFzOAoqIhsa6bBjgp2d5Q/DF/x7LN+6qUgx+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752348264; c=relaxed/simple;
	bh=AT3FF2mJ6UdRUu3HCqS6+rvaGrs3FO+0IIIyGcNsku8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAtlwEs3wJ1GzX7z33EqNHGbnQrzQ25b37PnxjRTJZ/RJv+nqH2lUawywJmOkjLO0rhrHH0nB+4qtyapfxEb4UOaPrJwLv6XDxQO5POBmgL8CkRIV6RniYifB6NnR8cOsUj4ogUs77qBduNYYwSovHI8uZ+t9kQNPqA+HDZHgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afnkkZ2G; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afnkkZ2G"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-236377f00a1so29148645ad.3
        for <linux-hardening@vger.kernel.org>; Sat, 12 Jul 2025 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752348262; x=1752953062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqS8JR7jlJ4aWaKPMR2h1l061HBskPuLNJkImtvoxCI=;
        b=afnkkZ2GPydlRZQiPR66r/SHTclTMHhVm7TJHvCySocvIpNeMdyeV7U/Y1V2sWXiuf
         EALGAWeuwdv6BwLwqWh0CfvU58dKeV91XHFKqTdwxHexwd9icR+V4piOzZAvgU1tj+vB
         5IHulAlbkmjG9RegFzJ2yjS68dEhguMXVfJflUDTR3ih5L8MJMbYjzKn8nNzOC3kpYrb
         KB/0nyxVhq/iMljDvcs40bZWyj1PWHqvtktrSD7WGEAzJyQLT7osqVGz/TKlciIiQtdZ
         lEcWYv7tiHwFEB/d+UBIFZZAu7UzmrJc3b+VJ7j1XqkrpiqVOqYhy9gO0d6f1E0vRaS4
         lMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752348262; x=1752953062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PqS8JR7jlJ4aWaKPMR2h1l061HBskPuLNJkImtvoxCI=;
        b=vguBUTXfAvmuOjuDIJC3l5B6PbLs0YPQ2k6FW9eEkmbUIcpUokZuI2FJF25dP7D6FR
         DHOSIfDvKkxKWERyu6nc7gtyQK9nQZWA344Mwng29gx0mBkXoaQ9or5AoT68vw3jgj0g
         L+3t5eyUgVViVK5r98LtN50iUgmhFqmz14QYN4wgl95oVNw3CXFB79KL9miwW2HSfqTZ
         1fQNixzq9/ZS/vSRorENCYVvHN0ie0GtSTkRSTDcjmTnQiikTL4JMXtY1osELO6oTp6w
         3Mk7eTCA+HFTuU1pF4qJRwBDdmzC2EW+VynoN3DrXUeeblAhCbWLwshSbp98tNXw3K8L
         kwkg==
X-Gm-Message-State: AOJu0YxLV+f7kxuuxUxNmsRiwWiceJJtuRWCc6AI/o3irYchhz23FL9e
	BF7hPwqhuTkO6MkQMQoyvG5sHsp0QzqF0qIlfYLmuhFcJxYuXt1lnkvWMdG6rVDX
X-Gm-Gg: ASbGncv7pkWIs5qijKdyh2c5I9nFecjPtw2moDd5AreFtvHymAdq4DoWkdYmF3ZrQkv
	FGBaT9Ir/v2mzxcDAiyYNKP4YWfdm2w+jf4ACaU37CKY6QK9KoulufWjZhy4W0oQMjxz5gfScvy
	P6Z4bzK1GoZuAYFifokuHRyaw6IyytdBL6xrvauRJxbIM2dUrH83QwZ+HN8f8sN0bbD2dh7/wfd
	HZAHbogicSNjOJ+d32kFxlZbzQ9lWQu1LEN+319aJ3B53lCXGTI8KUvjYF94XY/5QeE87dJg5cH
	nrpDvRCV8hTUzKRSVbyeA/glxhrLGXiwe8W6VHewWBjuCBIySGJu25rVbnuTC92HEB7xYrLlI0C
	MAsct1ihhtszoR/FvDL3JJQoOMtua0drjSwtZ2bCr4S1T
X-Google-Smtp-Source: AGHT+IH4/6bsXFcmtQNEBQvr0xjcurygWucuwbH/6k8MENPdZYwYLGjtQNtssxZ8mb6L4dC4500rLQ==
X-Received: by 2002:a17:902:fa06:b0:235:c973:ba20 with SMTP id d9443c01a7336-23dede969aemr81581155ad.49.1752348262188;
        Sat, 12 Jul 2025 12:24:22 -0700 (PDT)
Received: from localhost.localdomain ([147.182.204.210])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-23de4332b0csm66013645ad.149.2025.07.12.12.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 12:24:21 -0700 (PDT)
From: Gatlin Newhouse <gatlin.newhouse@gmail.com>
To: linux-hardening@vger.kernel.org
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>
Subject: [RFC v1 11/17] kernel: add SafeFetch cache handling to dup_task_struct()
Date: Sat, 12 Jul 2025 19:21:56 +0000
Message-Id: <20250712192202.707192-12-gatlin.newhouse@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
References: <20250712192202.707192-1-gatlin.newhouse@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

---
 kernel/fork.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..379dcf5626e9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -122,6 +122,12 @@
 
 #include <kunit/visibility.h>
 
+#ifdef CONFIG_SAFEFETCH
+#include <linux/safefetch.h>
+#include <linux/safefetch_static_keys.h>
+#include <linux/mem_range.h>
+#endif
+
 /*
  * Minimum number of threads to boot the kernel
  */
@@ -955,6 +961,17 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->last_mm_cid = -1;
 	tsk->mm_cid_active = 0;
 	tsk->migrate_from_cpu = -1;
+#endif
+
+#ifdef CONFIG_SAFEFETCH
+	IF_SAFEFETCH_STATIC_BRANCH_UNLIKELY_WRAPPER(safefetch_hooks_key) {
+		df_task_dup(tsk);
+	}
+#ifdef SAFEFETCH_DEBUG
+	WARN_ON(SAFEFETCH_TASK_MEM_RANGE_INIT_FLAG(tsk));
+	WARN_ON(tsk->df_prot_struct_head.df_metadata_allocator.extended);
+	WARN_ON(tsk->df_prot_struct_head.df_storage_allocator.extended);
+#endif
 #endif
 	return tsk;
 
-- 
2.25.1

