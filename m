Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4323720A5E7
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740437575; cv=none; b=iYyU/jra7oFqqLH+8+6qhjKju3K5CKcknfWwyMSXgZFh9eXIsdGki4c9tNyOmiDv0kum9aUyzakneeOBF2xrHDtzZe70dJkrI3ofPHubRwaO9veDBraJdYH04NxqHJ6F15wYwoeHd8dq+X/sY0tkM8IQQ1dMflSEsZr4tKK+ei8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740437575; c=relaxed/simple;
	bh=Ahb37i8tu8vEzrUDVo47OFw93L7v5pGugTT95nDEeAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QThvR6ZLUd0BUgomIDKdK7IIGU/DawCczNkEf3wW+scc7sOJhdrRICY/kbNZH0c7Co00gkAI2qpaU5enZNSKVYzJXah6EVjQ/RpLGExRhq5Hk9cD3qgYfbOlWfGSpFD+08+Vcvi3xLQdW2QLvFaddXQ09XhwpHzs48nom/d0J48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lFKRnTU2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lFKRnTU2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21f8f3bd828so10884405ad.2
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 14:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740437573; x=1741042373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iZa0J3oai+8Welu6Zi/1CRi8cf0vv3kefTwVSjChmA=;
        b=lFKRnTU2VEXw8ze8n7zxtER7TYsFf4YXSgxUkEN+WdHmqBHUXjBX+hArhvqkM9zN/C
         pVS18QyJJBeVw/cGnVrZecni44Uai/VvIqOX+viJJLU4MoqPWAcY9U11OgaX/V6guPtT
         horDiJetuuVa7hb3bh03czXSe2svzc3WsLUZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740437573; x=1741042373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1iZa0J3oai+8Welu6Zi/1CRi8cf0vv3kefTwVSjChmA=;
        b=DsHuVt4dHOxkS9KQIWccoy0te7liWuk7fkTWsCUDt7rG27jpNm77bg/D92wDBcUZkj
         oc8K0ca+kwbubTEuOVOq2BW127sUPKJ7t33UWwb3ja2Tn4GMn4nIBaX56MGSsZd9kpcs
         vmYcASwORqgz+KEmtQrRDra57A+l/ZcEZr5wACR+llMP2BDuE0QUFKgXo/Z41S+c8lmK
         W/4osN5XSGaQLZ1fyAe278ks4DWZQQbXGLK3+7tJFW5mj1C9sI/gXyOvW2QTRt6BxOms
         liBzpVJ826PPFFPNpK/J9uYqT/GlWdLpf2uWkv0gK2ZVvmfiSsti5BHAcpui723R/l2f
         3HGw==
X-Forwarded-Encrypted: i=1; AJvYcCUPTbpazlv6OVPyGiW/I4O80+AfZA+1oBaUjIyc+SgbC5mBC4CWCN4CtVGr3FEwWoGtrD2ufx9o4S4SZUVj7/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+U93rHNC3wifuLVRvkJkFLbo+tNNIY5eaJ3HH6n6AKiAH+LT/
	YGxVKJZg36+1HPZdEd9YINBvGEBMp8HxGLkr4vsMBrB+whUX5kvpm91uExEKjg==
X-Gm-Gg: ASbGnctsGqULQdyEeg5wR/m0NvxRXm/oco9cOveHpu2nt5zuyUf+SOarycFMaRX5TA4
	wlTCZt8Eh0JlfmwKtG39v8+Ii2bMv2PVhp+jDS3d3fL2HVDDF+YhNzeFe+syLNAk2etm6QgJ844
	HKPBGasoYrK0e3v5ubnsEg+cqSw6EUCL3GpOR2PJZCyXd8OZJkTQuewj88uFvw2psrSQAj5PXO/
	gZ8cIbQdz6nsvhfJ7iWor/7bgwbKxnXI3HKOQvO7d6XuYQ9yoEZQJDXvjbXWpNqFB8CErO8HVQI
	6XO2N14RYlZp2QYZnkaX986pqQFURuGYB+RD022hEZre4l0dyak0vt94gICH
X-Google-Smtp-Source: AGHT+IFg6PbCJykgEIaP4RauSlaTrid3Wz+OgE4C+L+jwZ9u9/LvDrktm5eCC+LrKCajBp0j3msv1g==
X-Received: by 2002:a05:6a00:3cd4:b0:730:96fa:bdb5 with SMTP id d2e1a72fcca58-73426d9b38dmr8599645b3a.6.1740437573573;
        Mon, 24 Feb 2025 14:52:53 -0800 (PST)
Received: from localhost (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7347a839dffsm173674b3a.172.2025.02.24.14.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 14:52:52 -0800 (PST)
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
Subject: [PATCH v7 6/7] mseal, system mappings: uprobe mapping
Date: Mon, 24 Feb 2025 22:52:45 +0000
Message-ID: <20250224225246.3712295-7-jeffxu@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250224225246.3712295-1-jeffxu@google.com>
References: <20250224225246.3712295-1-jeffxu@google.com>
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
index 2ca797cbe465..8dcdfa0d306b 100644
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
+	vm_flags |= VM_SEALED_SYSMAP;
 	vma = _install_special_mapping(mm, area->vaddr, PAGE_SIZE,
-				VM_EXEC|VM_MAYEXEC|VM_DONTCOPY|VM_IO,
+				vm_flags,
 				&xol_mapping);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
-- 
2.48.1.658.g4767266eb4-goog

