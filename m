Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5441B1E7C19
	for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330524; cv=none; b=sKrO0k0X9TTjlACFlsgf7UzrEpPI9Io2c1kLRH7RKU94UNWwC9Bsc56N/MkjWUV3sVPQuroPNndLk79NbICLyUTfWUHWnB62IRgPzilQYsSgvL7lJbE6VQXkbIdihBfleh5ONV2o+ubKuzBRslE6eH6joPFoe0zYENkkiAYk/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330524; c=relaxed/simple;
	bh=rT7bFBNt1F+exb7tPl5r3kNd1kDl3uip2zjF/VDFZKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wmk32bw8tSt+LIRlu9GO4seHVm3Vj/EXbZwLxP9AlKBp0Il8/Rwl90iOUr80c1Nq4H+JCO9TZh1iM+9xeQouv4Wxl7iqjO6L5Tym+NlC8aHgn/83fqtDM/4rheJuYNFPxCnEirbk3CM8/cUOZTIUn7KoFBYNNLmz9UrUjQB0PwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oMBtQLEh; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oMBtQLEh"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166db59927so13167025ad.0
        for <linux-hardening@vger.kernel.org>; Tue, 11 Feb 2025 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739330522; x=1739935322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDmXk529F7J07bTvTA0+iYc1CKNvDiUkVRu5HOXs43g=;
        b=oMBtQLEhicnC/QBq+zDSHW76MzQFFq0HsIZFVCPUMsGqjbq6p2X6iIpbKBy27li2lA
         I97CnA5u5B93kl85ZqwGNjcA8aBHHgKk3XC5kLLPgDZiFzFf0WN0Y7cFyxsHqIGkMpdS
         2OsnraFHHbuZkA0x7tFnh3mu+zolDMtXz0YsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330522; x=1739935322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDmXk529F7J07bTvTA0+iYc1CKNvDiUkVRu5HOXs43g=;
        b=YqS52uitmYPVkSCvnvJWE+EjcV/0O6LVeELlLpeu7xtvVEKvmQ8mmyFcFoeIsllQJl
         NVHglxYpPmdOhSwwPPVKPI5h3aIVCpp8P73isxXxx+/csKHTn2MuiSxnVAiMWjpBOsw0
         XEF4b6/5DqgKUtdFkWI205+nn7cEFFS/trfRQpr75h67H22RivzgDv5fJe4g1GNn60TS
         dEAHThSDgXUjbTEMQLF490m7AokcgI7E2pgfem9uP2IG1Dt0GOiQb16fdeQe3TPRn+6t
         ANJv/xWV7O77m70FrSCIIw4bRr7WKOC0/u4uwWemlrBuJGdnjiydwZaRuGUMTwK/2nAZ
         hEPA==
X-Forwarded-Encrypted: i=1; AJvYcCVUdsjTCJAyjBCLH+QVe2uraJ6EBojlboqDtgRpJbMeMca/cNdWOpZDo4OHTN/Nxfx/vFbhw151RIA2Qqk3aXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEVHTfCombsUOxfFF6gBKnRe8rA8E73cq/mUBAhY7DD6bciFQ4
	kztmra50JexhTvHUZDwADZLBfODHc1HssqfBaK38+MMmnsuk7q4jSGImyH93Ow==
X-Gm-Gg: ASbGncsV0Otdc5P7T/UzD2pyUVWmchto49C4LC6OuOjzDJuuH027FJIMHhpqrobZO95
	JXyf7J8CjgqnSyrouKciwE4wyniALQjRex7xd1hUK3c6QCsi5n3LO1l8B8qzfuoQgBQhTd1eesm
	yjNO4qDlsZ9Ckw2ytmsTWi64OMy9hszt3dqguQcfS75iBFGM30wmtFUTdglswM68LhDyER48h3B
	jQUh1p8paWdFPm7FeX0KT4ElloghN4SHvT55ANmWHXPexJp7EPNW2MsS1yqt76jFN600lhVROrH
	J1kc5tDNYpFEQHEVTEOrnvUHETKkRBVO5HmasCYSGEYsGEaXlw==
X-Google-Smtp-Source: AGHT+IGLyjV6DGNlQC70XXyU6c8VYNX9NRu9NY3TAy8HoniHcIPDAY3iv7rogZ2WB1DXQE04jazm3Q==
X-Received: by 2002:a17:902:f791:b0:20c:da9a:d5b9 with SMTP id d9443c01a7336-220bbad0cf2mr11063425ad.5.1739330522551;
        Tue, 11 Feb 2025 19:22:02 -0800 (PST)
Received: from localhost (9.184.168.34.bc.googleusercontent.com. [34.168.184.9])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-21f36897faesm102883195ad.213.2025.02.11.19.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 19:22:02 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	keescook@chromium.org,
	jannh@google.com,
	torvalds@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com,
	adhemerval.zanella@linaro.org,
	oleg@redhat.com,
	avagin@gmail.com,
	benjamin@sipsolutions.net
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	sroettger@google.com,
	hch@lst.de,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com,
	johannes@sipsolutions.net,
	pedro.falcato@gmail.com,
	hca@linux.ibm.com,
	willy@infradead.org,
	anna-maria@linutronix.de,
	mark.rutland@arm.com,
	linus.walleij@linaro.org,
	Jason@zx2c4.com,
	deller@gmx.de,
	rdunlap@infradead.org,
	davem@davemloft.net,
	peterx@redhat.com,
	f.fainelli@gmail.com,
	gerg@kernel.org,
	dave.hansen@linux.intel.com,
	mingo@kernel.org,
	ardb@kernel.org,
	mhocko@suse.com,
	42.hyeyoo@gmail.com,
	peterz@infradead.org,
	ardb@google.com,
	enh@google.com,
	rientjes@google.com,
	groeck@chromium.org,
	mpe@ellerman.id.au,
	aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com,
	Jeff Xu <jeffxu@chromium.org>
Subject: [RFC PATCH v5 6/7] mseal, system mappings: uprobe mapping
Date: Wed, 12 Feb 2025 03:21:54 +0000
Message-ID: <20250212032155.1276806-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212032155.1276806-1-jeffxu@google.com>
References: <20250212032155.1276806-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Provide support to mseal the uprobe mapping.

Unlike other system mappings, the uprobe mapping is not
established during program startup. However, its lifetime is the same
as the process's lifetime. It could be sealed from creation.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 kernel/events/uprobes.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797cbe465..55e0fa21eee6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -22,6 +22,7 @@
 #include <linux/ptrace.h>	/* user_enable_single_step */
 #include <linux/kdebug.h>	/* notifier mechanism */
 #include <linux/percpu-rwsem.h>
+#include <linux/userprocess.h>
 #include <linux/task_work.h>
 #include <linux/shmem_fs.h>
 #include <linux/khugepaged.h>
@@ -1662,6 +1663,7 @@ static const struct vm_special_mapping xol_mapping = {
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
 	struct vm_area_struct *vma;
+	unsigned long vm_flags;
 	int ret;
 
 	if (mmap_write_lock_killable(mm))
@@ -1682,8 +1684,10 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 		}
 	}
 
+	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
+	vm_flags |= mseal_system_mappings();
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				vm_flags,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.502.g6dc24dfdaf-goog

