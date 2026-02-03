Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FB4288A2
	for <linux-hardening@vger.kernel.org>; Tue,  3 Feb 2026 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770084248; cv=none; b=YDd6ylYBPjWzvulsEY9a+FHtCHyCHUJ3yVafJYUpMdesmx13elkHHGkMYnj7cP/3AXDp8FqEjg3rZ1gQL8Gn035CQI/p0mxPCdadbv+rNfMJq/EtzVV4YXJ0i7COvvrBsXsI9cosmRZj4h9g7Q2UXIHyhIRDJVX4wFaeoejJQtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770084248; c=relaxed/simple;
	bh=6C1SR84yN6FqnhvKGEelh/3b2JiW/+3WB3x48bWYaUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WHvYBFK/SjN5wyuPj1JK/rTzD1FfeUSDLOsWqB33qFtt24kfXjNvX7+M5hqVbEQsACkDuEEeFZQdx8wyCNnQGh5ZL7aKD1RCfSCpKU7uViTRAxlsZak1Wwj2B7ugWqPDT070hU4llN21+W65JZ8V+bLcpZ3Y8pB5Dd4SYMlypmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOIPMoCj; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOIPMoCj"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8220bd582ddso2960306b3a.2
        for <linux-hardening@vger.kernel.org>; Mon, 02 Feb 2026 18:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770084247; x=1770689047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RXoNt3OMv0JZ1pvXPN5KfReeelCsaduQQtB03taw4dE=;
        b=IOIPMoCjlV3fYg8G+22PPmuNk4bNnHO9yE9F80q34UbUWhnqUUuBBcSEk5x1toSbP2
         Vl4XyP1yvZ3gQ5OxoM54SDZcfQySNjVpXZtBqA9FJhQrt9c0xbjfqcuyqYFwKI7stcIU
         icDzt/bm2tQbNa6DEilKYplxYE/hqAlxCdOLdhTJ06WFER5+e1EYh6jSzITS5yikAImK
         2XpkEOUFTKPoLg6nnqPdb5yTW5c2okFkXzcCHtMzRwTNlF2vEC6JjUYnnOx3zovM7UnT
         x75aSB4E6lkehb8ZE7NXUuntQ+md0oKMDq5d1By0fMyKaxOkmCguULdke9pedE4dygLP
         R+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770084247; x=1770689047;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXoNt3OMv0JZ1pvXPN5KfReeelCsaduQQtB03taw4dE=;
        b=Ey1WscMtTrqXAK5c7lCU3V1HQDTnNrY4xEb9rj7/fxPT63okJf8N7pNL0Y/WIm0M4m
         zfWOj/HxVxvVxnWuhClhKsDlG+eUU7gfgcegu+NTG2x0L5iV5FmPdoZ1En6lmR8un4Qj
         9d+cWzHq6YhV94GbQreN8egVSVqzuz2oRrLNrWAO1iFy/4dAOTaHtp/DPdnwq3i4nG8x
         Rm+QnW7g5fxrCB6wqVYkqS9gwc7rejHVL0pL09OCzdPvcppRQdKrBVATcuYWLzJ8j5rI
         XEBac08CYCzLH78VIEElJ5Sjbc0xqm9LxOWTS81WQuW40EGvDGNY/kx03nqg4MwyU51O
         HCow==
X-Forwarded-Encrypted: i=1; AJvYcCXpLNJ1AAKAF1W+eK6Ntxx+p/T24XzaNcxu0JYLP/NMEEQGbnEFuTO9eqPLEHA/ItkfyAMROwrI6bQWSISVpzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNRxEHB6/81NLL0+IFfbenMqhbiKFkaq87uurnKar1azmQaCpz
	hBhVXd0nZTEP0oGefwfPyX4qHNcTJLMJIypoZC2LX3QrSMXGI28wvROJ
X-Gm-Gg: AZuq6aIW0lMiScr0iE29UujGNpRErauRVsr90RDWqHF5RMiyU4ohbajce1nbRPN2u79
	eLhloL2KCm+Vz6vlQEtyNIRO4BD23JEiW8glGJqzsW2cU0luCDrfjZrJ+ErQ76AWuQdI8Bz/gXR
	wfiDKTZ0NcYpywv5DzXQborj2mf9aheoxljEA3pTp0FwtMAj1oWLQ+seaXL37XwBZp2QsV6RDLg
	YGdT0/qUbqohO+lt9RS2s7iOT71GaB1DhfAJR5eazSVKreqy1wEjTIuXf9dZT3qBb02wfBlGXBe
	Cv5CVcCTFuWIurcDhA4Umqx5rhORwG1eiIsPkuKoNkxZlrpaLv7LMmq8ijH0KSyI7YtrUQUprwE
	It5nCrvxIHa3Jfy6tgMXeMLt/ip+gaPB7nW9wQ+bStwn3xXSNZkRXGM6RIfxOgEaEb5+HDlxoXq
	AjTN+HLHY+t0EnA2gnsxM7UA92eIrU+5v5DzRGnfYObWaXr1wiBj6WsXM=
X-Received: by 2002:a05:6a00:8d96:b0:81f:be3c:9c9e with SMTP id d2e1a72fcca58-823aa959df6mr12562945b3a.33.1770084246793;
        Mon, 02 Feb 2026 18:04:06 -0800 (PST)
Received: from lixiang-ThinkCentre-M755e-N000.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c521cdsm15950496b3a.62.2026.02.02.18.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 18:04:06 -0800 (PST)
From: ruipengqi <ruipengqi3@gmail.com>
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruipeng Qi <ruipengqi3@gmail.com>
Subject: [PATCH] pstore: ram_core: fix incorrect success return when vmap() fails
Date: Tue,  3 Feb 2026 10:03:58 +0800
Message-Id: <20260203020358.3315299-1-ruipengqi3@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruipeng Qi <ruipengqi3@gmail.com>

In persistent_ram_vmap(), vmap() may return NULL on failure.

If offset is non-zero, adding offset_in_page(start) causes the function
to return a non-NULL pointer even though the mapping failed.
persistent_ram_buffer_map() therefore incorrectly returns success.

Subsequent access to prz->buffer may dereference an invalid address
and cause crashes.

Add proper NULL checking for vmap() failures.

Signed-off-by: Ruipeng Qi <ruipengqi3@gmail.com>
---
 fs/pstore/ram_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index f1848cdd6d34..f8b9b47e8b24 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -446,6 +446,13 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 	vaddr = vmap(pages, page_count, VM_MAP | VM_IOREMAP, prot);
 	kfree(pages);
 
+	/*
+	 * vmap() may fail and return NULL. Do not add the offset in this
+	 * case, otherwise a NULL mapping would appear successful.
+	 */
+	if (!vaddr)
+		return NULL;
+
 	/*
 	 * Since vmap() uses page granularity, we must add the offset
 	 * into the page here, to get the byte granularity address
-- 
2.25.1

