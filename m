Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794667969;
	b=S13s76gRHMceAYp3JgnZH+T8PO938EOyylNbNGV0rRNOHpxVkxqs4Ldtv1IEeZf5HKad
	 umu7UCBzx/mJbLP4EBNh9DBRvVsWnOigLXpAL3LhOPaZLfsw9Sgmf3gJkFwXOaSSTniZ3
	 IljFQA+ov77EXvzjdLAuK/By+LkPXU9U/syiWM63QnL0NLTEROC37o/ZAuml31XitVm1a
	 jXo3p7+B5F7ekjMVw4EMT1RU0aq9gj8kM7g35BL2B9NxIjQJW3JgMpEyPDg0ZJHnd/c6E
	 4dsFmliPNLpJ4v6MN1K6qxB+mGiPeMgBLkiMPIWETL5LvjB1I3HVBT6VjuLGCk52RiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794667969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Tm/6Ewx7tmmRUl0t+lzW1rhB1ymVzZpDphuMopZREW4=;
	b=FbVDEhRtB3zbpLQSDlt4RatFJu4jpnD04Rhy4TzQSOQoQRlMFHggtQwA9pB1ehB7EdsU
	 0p02mYT7a/cogHWFExtJY7IMM6X+O5uWwS1LZaVELX7AoMRwm9j7EoHoJknH8rNzRTxUO
	 f7Yx/w8/XiEJrH4pW6AKouGPbp9wox8OsUuqu4o73EN1Y4AeCzsyTKYb6c700ycKDEzrL
	 9hy90J07FY/FM/KAKTnzJ5DzStDIRYtoMBef9MyzRj4anI6+T1Am5LSaojGPRKNXhi94P
	 dOlrYeAjzC2d32xh0DudY/F2JXLFa0vR+JroFqPp58/y1dcKA7VzxoyQKElZ3B5BXWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=saV9kE34;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14EC606A331
	for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 14:52:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F14EC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=saV9kE34
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ee0533d249so7197535ad.1
        for <linux-hardening@vger.kernel.org>; Sat, 14 Nov 2026 06:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794667968; x=1795272768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tm/6Ewx7tmmRUl0t+lzW1rhB1ymVzZpDphuMopZREW4=;
        b=saV9kE34Lmn7ne+De0v8m/auVw+yyZwGOV/VEw/BC5+FKPo+Prxrsk8UrgJ3a4lYJ2
         bb3KVJR8e4caOiJgDyw+bIZQrGcq7tPSeGRKAmijjTx4xunoyANvRLm8R7QY+mb4HoK/
         lJOVqI1x4yMGX7bFLihWRniStj2q8C4M/g9NOP4IdFrBK3R3bBvkV/wmiJW7hdkXH76P
         qwQf16Y3C3sFRPo2eh9JDATqueqItO8ke7/o5gbmnb2SRd6+IOxUexEUBgT/jkJAyTQM
         GlG/DkWQrMnl/r06WBYLe6XzRu14tz8tOdpAyepYe5VBPI3SiMgNvLw+NLCYD6rJP1/H
         sFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794667968; x=1795272768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tm/6Ewx7tmmRUl0t+lzW1rhB1ymVzZpDphuMopZREW4=;
        b=agUErHXEd645AD9rVl6YITrGJVnyOoNfBrVFL9ATsdZqeHkAAGU6JBoADbPv/G+xkJ
         rHFeLwC7ChU6rn8ORranJXLA6KFkje/FYuuNqrTQlk/pJXfCMKFYIrtPNe1rPq9Idbby
         UcNjTpeE+fRFDhukOTEhggGRxP/5rBdPPgV1489HkxAFgSfOm6aGoz/ofiUapCpQ+C00
         c58dnoSH8pbo30S6kWfF9LP9NcuVJX7I2AVMS6TkSg9f2k2AlFY90UnmYXh+ngn7runv
         H9HtXpIPIE69d1+HXheeRdcmnCKAsd6ldshrEEhFJc9Mo2UNu8rD3AJiwWMRlvPvGQei
         prYQ==
X-Forwarded-Encrypted: i=1; AL+hErGRLluzwQWnrK1gDGlY/pr2XFGEOfGscs2usnGRzOMeoiHhcwawz2Hd9a8SiRvdBDiRLWrwozicGLdHAGg3NDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yT8j+HJbJRiOv4otTM30IvkYgg/9IQz8DQsyfo5+0LP4Nvjum
	cUh1GURJMEjlFkCEohI2QRA/0CYm0mXqTbtivexpPRjytmSxFiRGGyJr
X-Gm-Gg: AYBFou2oThIRWJ1nbTzc5iu5P7roISkBxpsN3rX4+k9lb4zmCxkjFrGCQP3wGzemaEu
	3CyxRhUSuvWTdWi8d5yvQ+XGjJ7LLn8v7yNIntK8n4S5ewUE0emShUS4AEgUInFBzRwvPBYGU7w
	tvWMZa/NlaOma9B3X3/W0pp+4iAmnhYdxUStfGqi2Hp6USkcoxpLYh78kcndI2OKKhbtCDOVRgf
	lJj1zSqCHyLC9DKzMWr6Z/IA61U93sevHCB7+MKP0lCaMB1lvr99aZb9xz65BXhXdndpyO74PCj
	BJhupfcP/JYbuJJ6C/vnxhgmBMC2X4XkG0GLTyfC5djrPjpFiFKd8sjPFO3tjV9AMNgbb8rq/jt
	AhfjohmNa+QP9jPAxLxmReQKfMRrA1o4x0ilehxkzoBNYBR2mVjOdWZ0TrhoPDEyENXVNSXTCj2
	C+ZYq8jT9Abc9WxpmsNhdacHVb/rYB/OXus2Sld63eLuHMo7QAHWEWc3Pxy1qjYRBWl4uJDoJDX
	Y1f8BVv0MrMLT2dSKjgjLAb+vB+4v7u4cZotGxxnv1Jnsc9eTXqYGq1cCHVXtd/FxNcMaH/k1y8
	S0fVJj8ahvs93Q30Q4+EqADzn77v3lX24d4n/My/2dhWzrrlKdYe0SEeXs9BpUKQOwqO
X-Received: by 2002:a17:903:1b2d:b0:2e9:8e0a:cc4d with SMTP id d9443c01a7336-2ee0dee4092mr53566845ad.41.1794667968394;
        Sat, 14 Nov 2026 06:52:48 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f8623c7sm21620975ad.42.2026.11.14.06.52.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 06:52:47 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [RFC PATCH v4 17/18] mm/swap: skip reader rotation for single-device priority rings
Date: Sat, 14 Nov 2026 22:52:37 +0800
Message-ID: <799821479a3c820a041d0765fbb70a75598e641f.1794666741.git.lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1794666741.git.lianux.mm@gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A priority ring with one device cannot benefit from rotating its starting
offset or maintaining a quota. Read its only entry directly while the
caller continues to hold the topology read lock and migration protection.

Consume the cursor attempt and check the full/disabled pointer tag through
the common path. A masked singleton therefore terminates or falls through
with the same bounded behavior as a multi-device ring. Keep the existing
large-folio same-priority failure boundary.

This removes reader-local state updates for the common single-device case
without bypassing device lifetime or availability checks.

Signed-off-by: Lian Wang <lianux.mm@gmail.com>
---
 mm/swapfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 616339c5ae5b..0c192844b121 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -334,6 +334,11 @@ swap_queue_get_device(long nr_alloc, struct swap_queue_cursor *cursor)
 
 	/* Consume masked peers too, so every walk remains bounded. */
 	nr_iter = cursor->nr_iter++;
+	if (ring->size == 1) {
+		si = READ_ONCE(ring->dev[0]);
+		goto check_device;
+	}
+
 	local_lock(&swap_queue_readers->lock);
 	ri = this_cpu_ptr(&swap_queue_readers->ri[queue_idx]);
 	/*
@@ -363,6 +368,7 @@ swap_queue_get_device(long nr_alloc, struct swap_queue_cursor *cursor)
 	si = READ_ONCE(ring->dev[dev_idx]);
 	local_unlock(&swap_queue_readers->lock);
 
+check_device:
 	if (swap_device_masked(si))
 		return ERR_PTR(-EBUSY);
 
