Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F82661BE
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419124; cv=none; b=Mdh/fQ5Qqnx0HtBtJI/rQ/BOLr/V8Ap2dzPRPHL5dMphvU5Fq/BrYsemSCkTT+pwrxmPOX40wlQtKTubD5w5wFkdERjRMSmXmXPygsmaNmaCaakNbQDsJlQHbLO73PdREPfXhyMmnCEJkf13g+8LDSoH97xT2Zy6+bmwmfsi0R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419124; c=relaxed/simple;
	bh=GaZ3NHGqOhxDUVbP3LqTaXZumX7Y4lZDhfizHB7R2Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPBa57PD79jPnoCMb7RYgpKYGLWMgp1Q1+57RH3Knp6PHpZejWbmejC3BiCP7S9x7at5dyO50504oNh6DK6YUHV8/LUr/KYtNIW2Fa9DfZZxQA0cT4kPUJX1tIfC8It3b0sYVhxzN86BAUBJTVSVOUrvRV55AnVVtm/GQkgvCJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IW7AmgjR; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IW7AmgjR"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2fc29ac55b5so1223764a91.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740419122; x=1741023922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPTxJ+9VApNW1wIyXAimG9WYLhdSeBQuD2wh8D+5JoY=;
        b=IW7AmgjRUZVUtX8De3//5x9KrWT+xqHCNPoU2YkjrQjBwYZu+RifIoaJxuGmoTQtg8
         UzNJTuFt+9K+fFb0SsyrRrSHrOOSMDJafEfDFs11KuishRJa7NT5f9KjHtYkWPM9EMU8
         sHnoZ9xpj1OKDf/eEBI68ks7w4g1Jh2bCgwdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419122; x=1741023922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pPTxJ+9VApNW1wIyXAimG9WYLhdSeBQuD2wh8D+5JoY=;
        b=ECXKFjVElx1n2W/1G1JbuBQ3p/RYekUqFYyMU1n3LiAjPFZtvyItwuO7NkZ+BIXqBH
         9FgRoP3B4eFWfGbE7YGEwniNBvw9dqLaD+OiifGwgJKXtpef0lOWekCTMmuBVlz1piY8
         lFASLU/RhJuSX3BrEhEOb4bsr6PVLr9x2GKssZb5qqWWMORvpXLTTMTon9c01Q2BpDBS
         qV5k3Wpbs5yAL8eZkkNUWm7LYMTx9CoqIpkxwh0e61gWw5DkGemR47bLGF2bg4TObtDN
         Ze/r46wa30am/UbmpEBmWa3Pn6MLb6sOXOBeu4RphgJUq7/KaAl9gBfkUPEnKluscGe8
         WcJg==
X-Forwarded-Encrypted: i=1; AJvYcCW5zGQBQt4UolOC3JXH4N/Y2+HkcuwnUwzgG+cUc9BT4pAsVhAGnZKnby7ZJQQ4D5JvW+e2u/gOCNgZVb+16Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS1gxRB9lwa2MZO30v9C1oX3eKp4bfPSfQIDo//e7/yNUD0MK5
	hDvbwIzpGdqujRMZDauFjVZ8fU5LZp/GIqJdzRXibdA4xgZoSqVTd1n8t4vlkQ==
X-Gm-Gg: ASbGnctwORU3C+le/iFPPpWIdnNrl/jWdpVtWY9uNgVwz5sqopILEfPKD7TROcZ8FsJ
	YvZzpdVNUMOqTmiXWy67XXKYS/8IvnKNmFCNoLZjLkT4zpTaf7lNGyBsIZlT0gpB8cJ536VAuyh
	NDeVt9PMiuYRFPMwvSLmWIQiPn7YY+OKI58KAVBng96cJu16+lSs0PF9WkCLT1RRmdjnjGauY3Y
	57NTjsCqvt8pHN/rek5rFPdMB3vdmnIscm3vXHTAEeyTOhFSokzkjldSommEyO38g5KsfOnviAe
	Rj/HbaBHbmZgnxqLrKEgIxbfHGxWTVyW5fbGZDPjmeUxVJD4T7M/UV6teQeR
X-Google-Smtp-Source: AGHT+IHP5BJhLkG1y5WlyMonne7HfrmaKX102f8M0T9GVc1W+S/OC3k6B6HWY8ssc4OyfR7EtUf+nA==
X-Received: by 2002:a17:90b:3848:b0:2ee:cbc9:d50b with SMTP id 98e67ed59e1d1-2fce7aef973mr9370465a91.4.1740419121838;
        Mon, 24 Feb 2025 09:45:21 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2fceb02d9b4sm7708790a91.6.2025.02.24.09.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:45:21 -0800 (PST)
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
Subject: [PATCH v6 6/7] mseal, system mappings: uprobe mapping
Date: Mon, 24 Feb 2025 17:45:12 +0000
Message-ID: <20250224174513.3600914-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224174513.3600914-1-jeffxu@google.com>
References: <20250224174513.3600914-1-jeffxu@google.com>
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
 kernel/events/uprobes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2ca797cbe465..c23ca39b81ac 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1662,6 +1662,7 @@ static const struct vm_special_mapping xol_mapping = {
 static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 {
 	struct vm_area_struct *vma;
+	unsigned long vm_flags;
 	int ret;
 
 	if (mmap_write_lock_killable(mm))
@@ -1682,8 +1683,10 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 		}
 	}
 
+	vm_flags = VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO;
+	vm_flags |= MSEAL_SYSTEM_MAPPINGS_VM_FLAG;
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				vm_flags,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.601.g30ceb7b040-goog

