Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB43B3793CC
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 21:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779313826; cv=none; b=uB5EhxtBHUdg49pI4IAOjyKdcOn++ZW3D0OgDXklxncUVCavfTFzTLv+vnNlolEzpXJkFdTmokdsUrOy4qEJLUuesl/kYG6/XEj7qpfrs7tBrx61NrokB09h3Nqsyn+dySQy8QFji1Sys85SB+8P/UNppeREAPtCQnbpZL5XF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779313826; c=relaxed/simple;
	bh=ynN8Vs0xZzsjVZyAdUWO19rgjTDbt1mNQ9hyGrhUVek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MkG7bmQ9Cs5WOCpMrcWJMEtyPSIj0SfYSVVon+cEEVSea8B9zf+nc4ezzgriWm9qspXEIe0r8gUVGKbjvBLC69ChwUqI5av5aMiD+BcTejOD4UwaJYHHH/IhrFLEBa3zLUyKfEWpMPouRScvCmMsST1KCwTbmKAEoBeTz4j/YXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSayCSYG; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSayCSYG"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c801d732058so2420651a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 14:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779313824; x=1779918624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nyj701wbzyjF0Dc32YbM2f3R90qkbdPz6PEZTrxwlPQ=;
        b=HSayCSYGXyken6FFqgT8THC76HETxqzGfRCxtmKc4kYaiDc0DPeRKfOO4xs1iiNQgX
         ln5TCop0iQGT6AwevjjDO12zmwf7HEP/8U+1KH0oUxnniK52iz133VfK6gn77FzR2LjX
         twx0ZnOkjlLcKHDNf9FckT7oKc8FPN091in3A8wx9HIwdg53Oimg3YTjbTFT9P58Jebo
         jnVhjKHEQi4MiepfpaivfKuu9bJnun+xdZirYENh+KLd/oy+ACUwZXB4yJHWklRG/Kzw
         /AG8es08UKjWGxH+/CF7N1ZAI4FyQOUFfQ04aQrKxzHF0q+jmh5pXL4bLo3Vi97Pmd/Z
         CKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779313824; x=1779918624;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nyj701wbzyjF0Dc32YbM2f3R90qkbdPz6PEZTrxwlPQ=;
        b=RPgHCJp/NwZsYiP2H3s5LY50J9PxQbEMHC9MV8YfrFDG2/CbMdlsB4RLHE3i2zFPxD
         rmhjrDUKlB2YSPCYDjMu2qah0++fY4hiDpxpit4ncstnBpoNlnNbhLoEgGRnMdRTMZ3F
         PYhG9AjPIyGUBh7IhfVbwzBdsDDIa6GcPJ3zIkkzVUPsRL2JBkmJWJDYySuCaYt4IV9m
         8hjeTyoGMoEYYWfV4OBKOuIOn0+fcikA8VfIB3eWdgKEMrdfxiAbj69rvHgFCVOsuGLN
         d1wCMDjstcSewWGTTDgOzs03aiPTR9/6Fn31lwtiWJWduqzHWIEWsOQchhP82IUe741f
         3Z+g==
X-Forwarded-Encrypted: i=1; AFNElJ8iwLfO7KJkeDgjrQx7+4i8OM1wgkMDyPGGlCFL2jvHuLIFrpwGlrKkgWMt4TPw6sKiTey+SyIuqGPJ6d/rqLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3ez3mUIzMvjRPh5Q8Vm4fi0hyUDMBWUnzslldQo4b1H1hF6VC
	jtoZKlkBKhbFx44Oas1/FLqYA61m+yzLR7M9GZBg4Eqp9Z5ro3l0x8G0ix5t2pzV
X-Gm-Gg: Acq92OFbjwue5TajOMfgIHb2edXzxet5qiihTzE57McJVfrDT3V/Mg2/LXi60p0Iexd
	y5iVXxd1VR2guFEG21ELRU68uCvfG8S7VkjyMZljChZSeokUyC1v6czpXvGRox+kZi0E/1H5OAN
	6GJCQXtuiqXi5C6lhRfszBkr7yaLLFy4gDQtcgcKO7K+dBC4AemBbbCx9y3l153S50b8uvN7uu8
	Qw7919jvoWYurzFgiosr7YYy8I+w6XRcKTYsnGsLn2wRgBc/v9eOqPo32iM5E9Ncn1ce/Jg3z6c
	GrR+QOnYuO1S8r9Nt7QfWbxTk8qWmELLTCPBwCm97a1w/+N3jdDtM8d4w+LGnBF6f8+xIlxWRgx
	F/ZUEV6nlBkid9WRe69OGJAp3YJyDsH/OiNWcInHbdFqKw4Sd8ECSljugDZiY1eoy6V3EWlLr0v
	nC9L15c0ZTGCJ24n7/Wm+eHCkvYDb2JpfZ0JW9aHp+Ka1tQUC9C6m8bgFIMWDStgXguedjg8hTj
	zz9ejqK+L4ycGjOwMfbltOLTx+cbzFadrk=
X-Received: by 2002:a05:6a20:2e0e:b0:3a2:ebfc:6bfc with SMTP id adf61e73a8af0-3b3083181c5mr110836637.17.1779313823881;
        Wed, 20 May 2026 14:50:23 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5be71sm21006858b3a.39.2026.05.20.14.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:50:23 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv2] tracing: simplify pages allocation
Date: Wed, 20 May 2026 14:50:06 -0700
Message-ID: <20260520215006.12008-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change to a flexible array member to allocate together with the array
struct.

Simplifies code slightly by removing no longer correct null checks for
pages and removing kfrees.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add back kfree(a). Accidentally removed.
 kernel/trace/tracing_map.c | 30 +++++++++++-------------------
 kernel/trace/tracing_map.h |  2 +-
 2 files changed, 12 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
index c59326ad7a84..97f7e3cde262 100644
--- a/kernel/trace/tracing_map.c
+++ b/kernel/trace/tracing_map.c
@@ -288,9 +288,6 @@ static void tracing_map_array_clear(struct tracing_map_array *a)
 {
 	unsigned int i;

-	if (!a->pages)
-		return;
-
 	for (i = 0; i < a->n_pages; i++)
 		memset(a->pages[i], 0, PAGE_SIZE);
 }
@@ -302,9 +299,6 @@ static void tracing_map_array_free(struct tracing_map_array *a)
 	if (!a)
 		return;

-	if (!a->pages)
-		goto free;
-
 	for (i = 0; i < a->n_pages; i++) {
 		if (!a->pages[i])
 			break;
@@ -312,9 +306,6 @@ static void tracing_map_array_free(struct tracing_map_array *a)
 		free_page((unsigned long)a->pages[i]);
 	}

-	kfree(a->pages);
-
- free:
 	kfree(a);
 }

@@ -322,24 +313,25 @@ static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
 						  unsigned int entry_size)
 {
 	struct tracing_map_array *a;
+	unsigned int entry_size_shift;
+	unsigned int entries_per_page;
+	unsigned int n_pages;
 	unsigned int i;

-	a = kzalloc_obj(*a);
+	entry_size_shift = fls(roundup_pow_of_two(entry_size) - 1);
+	entries_per_page = PAGE_SIZE / (1 << entry_size_shift);
+	n_pages = max(1, n_elts / entries_per_page);
+
+	a = kzalloc_flex(*a, pages, n_pages);
 	if (!a)
 		return NULL;

-	a->entry_size_shift = fls(roundup_pow_of_two(entry_size) - 1);
-	a->entries_per_page = PAGE_SIZE / (1 << a->entry_size_shift);
-	a->n_pages = n_elts / a->entries_per_page;
-	if (!a->n_pages)
-		a->n_pages = 1;
+	a->entry_size_shift = entry_size_shift;
+	a->entries_per_page = entries_per_page;
+	a->n_pages = n_pages;
 	a->entry_shift = fls(a->entries_per_page) - 1;
 	a->entry_mask = (1 << a->entry_shift) - 1;

-	a->pages = kcalloc(a->n_pages, sizeof(void *), GFP_KERNEL);
-	if (!a->pages)
-		goto free;
-
 	for (i = 0; i < a->n_pages; i++) {
 		a->pages[i] = (void *)get_zeroed_page(GFP_KERNEL);
 		if (!a->pages[i])
diff --git a/kernel/trace/tracing_map.h b/kernel/trace/tracing_map.h
index ed64136782d8..90a7fde5dd02 100644
--- a/kernel/trace/tracing_map.h
+++ b/kernel/trace/tracing_map.h
@@ -167,7 +167,7 @@ struct tracing_map_array {
 	unsigned int entry_shift;
 	unsigned int entry_mask;
 	unsigned int n_pages;
-	void **pages;
+	void *pages[] __counted_by(n_pages);
 };

 #define TRACING_MAP_ARRAY_ELT(array, idx)				\
--
2.54.0

