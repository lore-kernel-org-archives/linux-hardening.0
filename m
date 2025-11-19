Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95816393DF4
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567161; cv=none; b=reGyOpjt61mLEzt9rsiXn/EcSMfExrl4iOIBU+KBGg3mnsYZ/806iSoS0PIAt+utnusJybwCQqVpYJYrqLKCMZ9F4SOGq3jITjJmSn6bXZey7jUWyoAp1mt6NPBzgz/NYuB09S4MwR4mTTyNgj+Z/U2odbL9KgOoXlNDhyYENWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567161; c=relaxed/simple;
	bh=UTLUC0zYLNIpIU6hlTY4UtGB00tOu5axyPBTWNkQRLE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f264u5PG6logGw9EtRoAZdZewV9qYthoFmxLio1tSHLtA4dL1O0LQb19FTNfqTArUkWvRN1eOwN1NLNGNSCjz0y9mye2Gjh2Xy88B1/Dg7B0AKpZDT45h+GHzTDzj3B61nnRX/SLY3UDuxrQtoK3Zh6+nuDtRKrYfBZPTcFiiQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=topb2Bvh; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="topb2Bvh"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b31507ed8so5577090f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567152; x=1764171952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk1lFWru0IGdhKwRKbnhtV9p6FImm0O6RRZYNI9uc9w=;
        b=topb2Bvhry0CkWkwgvz5KAsjSApRvdGEL1pk4gMYp+l4C8pvgogsHSnOylyQYtNqmK
         xj7iQtzRUmAd9OItTRZYSMc/IzfCoVaVreqgx/0YEF3wJeXogmRbE18mBN+eLD00CRbY
         iQ7DeBReF3MEWzqmOejNVnppa85e7BV6FTKJYdyxTgm96vEEgfbr1/sNC+CpwzR4u3Br
         fChbO4MWB2+bwmXjYximwr6WjjZcWE4JLslUhK2xGsDrBD7MCbXDaWd71K9ivllolQQp
         zIEgSm+Da5qdhnUixIs7MzqvUebI3nSqy6Lw2+6JzsNBgyLN8jGP+XjoNUVRUMGhXAlZ
         mtKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567152; x=1764171952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uk1lFWru0IGdhKwRKbnhtV9p6FImm0O6RRZYNI9uc9w=;
        b=t/zSJW0tSVjRytdZ8zbZPvh1V8B8awXJ2/dT8dlvf8wJepAKaxtSeIM0BMUOwG6fgz
         jYCIYW95G9zXbslURjnQvUPFpfCh1EpSEgu80+0Ww9bF1mxMBlR1lw17dUllZbWQMbFj
         +pffq7cv0ewydgc1QG6IbpOljsYR9fB7r7ztfWZO4Bcn/2VyGoD1GpCexAGouG+9z+h9
         xhP4wUlUjk65oy6l/kTfw5mZHUBqXev5T8oq+M9FmJogJleTjpcWHL3xPgvQHtXq4wl/
         AQ4/Duo34D8580bUvLbH0J9heKSR4lY50A9ZSb82Qxr20SSlt0PMTHL2HQPWnMopAS9f
         98lw==
X-Forwarded-Encrypted: i=1; AJvYcCW7elvEm5c91eGxiaX6WT885dWa3YOHvOBC11LXAPLAybOehKF6dt1N4ZBxopMjIzaMEMjOTOay2KpPC278shQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJYBy9AQcIIBughqxPdZ7cfNrGa4Qol2UXaKDsK7tMS5P126N
	5CnYzJKzSAAqXjlOwK+8v7glmOC606wirvoUIts2rhHZf5bO0bUAxv0YauSU6OJ7SW0=
X-Gm-Gg: ASbGnct8FOXrIWj2oaiXs5fDbZcOpokCLdxxlmrXwv3lDXKjkULNhZ4RFVOYqZquRTK
	B8qcj66oETd+RbGCUXT3EO/fuq6QeJYvsZER3QDmQ3OxSIBJB6uXWmvCUWX5QztqQXqm8C9Zpet
	nDxdyFclIzO96Ys20Hez/SWDq8i8VqzUOF3WQdKwkEenxldniGzqRytRZI4eJuiqvdgE4sHVqC4
	fxSELmax0l41WQ/gguWAxH0mhwbZs42k0y5I/YUyMpwbxDniRel/uvkigC8dsWTRwf+V845jOM4
	kRyclm+kiTYKlAvJAQPtONPWgfbSw3a6KeH7kVb46PdcBR/ek5WJvFJG5yiVhShTk/7Js9aGCgC
	cW6crzBZMmFEPqXn5jG23HUkqFtnI/0CzEVOOwAeRR+deseP8vXuD/IQe2l9E06q8ctgnsC5vH2
	UD+si4GWbT+WSX/umYu+aXlSOVtQy/RQ==
X-Google-Smtp-Source: AGHT+IGiIxmeqrKKXMpyNCEgyddWcck0X4KYjA7E97PFt6A4ulW3WkSU04Vt6omGLvNuAQXzgiycDA==
X-Received: by 2002:a05:6000:2888:b0:42b:3ab7:b8b9 with SMTP id ffacd0b85a97d-42b5934db2cmr19180692f8f.20.1763567151698;
        Wed, 19 Nov 2025 07:45:51 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:51 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	tglx@linutronix.de,
	andersson@kernel.org,
	pmladek@suse.com,
	rdunlap@infradead.org,
	corbet@lwn.net,
	david@redhat.com,
	mhocko@suse.com
Cc: tudor.ambarus@linaro.org,
	mukesh.ojha@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org,
	jonechou@google.com,
	rostedt@goodmis.org,
	linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-arch@vger.kernel.org,
	tony.luck@intel.com,
	kees@kernel.org,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [PATCH 20/26] mm/sparse: Register information into meminspect
Date: Wed, 19 Nov 2025 17:44:21 +0200
Message-ID: <20251119154427.1033475-21-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251119154427.1033475-1-eugen.hristev@linaro.org>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Annotate vital static information into meminspect:
 - mem_section

Information on these variables is stored into inspection table.

Register dynamic information into meminspect:
 - section
 - mem_section_usage

This information is being allocated for each node, so call
memblock_mark_inspect to mark the block accordingly.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/sparse.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/sparse.c b/mm/sparse.c
index 17c50a6415c2..80530e39c8b2 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -15,6 +15,7 @@
 #include <linux/swapops.h>
 #include <linux/bootmem_info.h>
 #include <linux/vmstat.h>
+#include <linux/meminspect.h>
 #include "internal.h"
 #include <asm/dma.h>
 
@@ -30,6 +31,7 @@ struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT]
 	____cacheline_internodealigned_in_smp;
 #endif
 EXPORT_SYMBOL(mem_section);
+MEMINSPECT_SIMPLE_ENTRY(mem_section);
 
 #ifdef NODE_NOT_IN_PAGE_FLAGS
 /*
@@ -253,6 +255,7 @@ static void __init memblocks_present(void)
 		size = sizeof(struct mem_section *) * NR_SECTION_ROOTS;
 		align = 1 << (INTERNODE_CACHE_SHIFT);
 		mem_section = memblock_alloc_or_panic(size, align);
+		memblock_mark_inspect(virt_to_phys(mem_section), size);
 	}
 #endif
 
@@ -343,6 +346,7 @@ sparse_early_usemaps_alloc_pgdat_section(struct pglist_data *pgdat,
 		limit = MEMBLOCK_ALLOC_ACCESSIBLE;
 		goto again;
 	}
+	memblock_mark_inspect(virt_to_phys(usage), size);
 	return usage;
 }
 
-- 
2.43.0

