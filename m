Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78E2E889B
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365408; cv=none; b=gBuietgCNIE2q9c5pxx53qHKUGffaJslFDvcJj+BmtlWWbjU/BmTR1+KAzBB7FOLjVt96nRXzvn+fEUljnqCASngonDHXbcg41sYTOarxlHioZJ6JB932uyFcsl8wRRYQ8saXaZD1yD/ConWg76DaKcC0uT2kolzL2hFCDPhPzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365408; c=relaxed/simple;
	bh=4mzNhzQY8HFx0bk+CHpi6+2DgmZYfQ8vHH6EB20MlrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMxjK+eRLnJNpS/T15GfYNxVyBBXGTLyezZjBAHdU8vtNlQkJx6GAe91+2FKv9yF9POi90qpRRGB+dlqnDykNhUZKb/M1YbdxIbpMWQoRTgGB0IbEiY9S9YRaKuTpFrqexknBp+ye83DdmBL8NZluyYXKo2j43nZr53xZ/BGWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iClEbVMJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iClEbVMJ"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a588da60dfso649682f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 06:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753365403; x=1753970203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h5mN880WCISqsqqypOE0OCrYzPzbEuiPZ0HVDAJk/kA=;
        b=iClEbVMJGbk/PyxXaSMMcxMAAqWn6IMjOCGbXGY4SbpO6tWlrOvED9WZH1STFKee6Y
         hHtDKSjj9AXb/itAOMfu+NlNgcBkRokxFC5lEdIpCJJ+u0F3wh8ftd0RFHgtT2YaraSq
         ketGNDB0x/WxBU3SwLV8Obj3mnpIWnW4qIcuRREvISdg4EGUpwQhA4rQRanVEWxhschX
         QLhS77NmD3AasXN5Yqd1WPeHDUyi4MJVAtLajTy+fiY3NdBPLN5juxw4sHLap8dmWM+E
         K4f+4lYqgXd1aplpdLav6VbqVnXZ3qrRTthuhfvreR8lU17u+Vsgb2/2AhqcfcZPWSjc
         BIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753365403; x=1753970203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h5mN880WCISqsqqypOE0OCrYzPzbEuiPZ0HVDAJk/kA=;
        b=AZkflp5PdeYo7NFLCGj2is0+WKlfQIUtIMoVelPBcB9dU/pw97P1g082ED8mGTXf5o
         36usU7TXXSQ34mGSuZBQC+r0Rbg77h/MPyGrmQo+1HVHWU+amRY690o9jiHdnlkDx9h+
         08Q3g3xMhRlXkH95LBdPT0TVXQ6reuU37DtqLt9HfEbFWdxNYHFHJwazU7oNrERym1yI
         DJ+D07HWEi14oqJAXqrQR+2uwf4/J/mUTLu1I6CSWhE4M59fgmRAG9nYOeDPlq9rw3Nv
         if02kLUP7BxdU5jE+Zx4fUw2zi8CrZwtAEoF9uOe5VExH4x/Gj8DrGKgwI8E6uu2xTpa
         3VGw==
X-Forwarded-Encrypted: i=1; AJvYcCX1TKEUG2/iCNgfNf5oH5LLeRbzKCb6Sv25FgYn6colzmF9gJF4i50lbvN1jbZml7AbWbkESPa/v7616YgamrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcwVa5gCA4Zq3SRC4ehZSgsG8/W3pQB8K3zyf5F07TkK72x7hm
	2O2lrggV3+E19cH/on+QcjS85BSFnv8YsXs89NBFIiPOK+KbIml/4wxEDYjvsjpcCTM=
X-Gm-Gg: ASbGncstX/0zeMVB76jcigcpSNvJmPNL29KZqybF1HNv4oRNnChTe/boZDIAWoP6dBa
	gQqh+JjslxdS3JRREM74KD8epJnnT/8FDDYutVbYIsx1qAphVY3qJwlSBR0SDBnGhV8Gfhxh6z+
	hJHWQ1JFeBiXaP68dVAbYRKFTMw4b5+FbJpoWJrqofNp5Rvdz9Bjze7CSoBjB6q1qSGTRl8GrOw
	Ejf35ej31HYWpbd8vvk2jbCjlDHW6PQC9Jn6fS1MCVo1fjn/c5sEFOLo+l2f6aH5q4E+45xqZiP
	/9EibrQ9xD9snnnnR6lW6wHq9PxANr29Y3mycSUl1lt0uIeRmjaYIN4eto/FeU+F82hgqoZOZ/F
	f6hKI4LC0zmuB7X2UmSNOrUFqHAfeK7LTJaH5FbAi4uOiM1E4MIYcnGQvyOvUpOG7sF9PZY7Rak
	gBoXHoM914PtoHbvrvoU9ZjkA=
X-Google-Smtp-Source: AGHT+IF4egT06XIAWuc0TJnVdNpe1wQ7sn3xvEGeH8Rc0pzDJnMJjBpN4GYnZW+sz3u5f7Eq0JGLQw==
X-Received: by 2002:a05:6000:3103:b0:3b5:dc05:79b with SMTP id ffacd0b85a97d-3b768cb0f15mr6041122f8f.14.1753365402888;
        Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
Received: from eugen-station.. (cpc148880-bexl9-2-0-cust354.2-3.cable.virginm.net. [82.11.253.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4587054e37dsm20889375e9.14.2025.07.24.06.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 06:56:42 -0700 (PDT)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	eugen.hristev@linaro.org,
	corbet@lwn.net,
	mojha@qti.qualcomm.com,
	rostedt@goodmis.org,
	jonechou@google.com,
	tudor.ambarus@linaro.org
Subject: [RFC][PATCH v2 23/29] mm/sparse: Register information into Kmemdump
Date: Thu, 24 Jul 2025 16:55:06 +0300
Message-ID: <20250724135512.518487-24-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724135512.518487-1-eugen.hristev@linaro.org>
References: <20250724135512.518487-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into kmemdump:
 - mem_section

Information on these variables is stored into dedicated kmemdump section.

Register dynamic information into kmemdump:
 - section
 - mem_section_usage

This information is being allocated for each node, so call
kmemdump_alloc_size that will allocate an unique kmemdump uid, and
register the address.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/sparse.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 3c012cf83cc2..04b1b679a2ad 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
 #include <linux/vmstat.h>
+#include <linux/kmemdump.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -30,6 +31,7 @@ struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 	____cacheline_internodealigned_in_smp;
 #endif
 EXPORT_SYMBOL(mem_section);
+KMEMDUMP_VAR_CORE(mem_section, sizeof(mem_section));
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 /*
@@ -67,10 +69,11 @@ static noinline struct mem_section __ref *sparse_index_alloc(int nid)
 				   sizeof(struct mem_section);
 
 	if (slab_is_available()) {
-		section = kzalloc_node(array_size, GFP_KERNEL, nid);
+		section = kmemdump_alloc_size(array_size, kzalloc_node,
+					      array_size, GFP_KERNEL, nid);
 	} else {
-		section = memblock_alloc_node(array_size, SMP_CACHE_BYTES,
-					      nid);
+		section = kmemdump_alloc_size(array_size, memblock_alloc_node,
+					      array_size, SMP_CACHE_BYTES, nid);
 		if (!section)
 			panic("%s: Failed to allocate %lu bytes nid=%d\n",
 			      __func__, array_size, nid);
@@ -252,7 +255,9 @@ static void __init memblocks_present(void)
 
 		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 		align = 1 << (INTERNODE_CACHE_SHIFT);
-		mem_section = memblock_alloc_or_panic(size, align);
+		mem_section = kmemdump_alloc_id_size(KMEMDUMP_ID_COREIMAGE_MEMSECT,
+						     size, memblock_alloc_or_panic,
+						     size, align);
 	}
 #endif
 
@@ -338,7 +343,8 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 	limit = goal + (1UL << PA_SECTION_SHIFT);
 	nid = early_pfn_to_nid(goal >> PAGE_SHIFT);
 again:
-	usage = memblock_alloc_try_nid(size, SMP_CACHE_BYTES, goal, limit, nid);
+	usage = kmemdump_alloc_size(size, memblock_alloc_try_nid, size,
+				    SMP_CACHE_BYTES, goal, limit, nid);
 	if (!usage && limit) {
 		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
 		goto again;
-- 
2.43.0

