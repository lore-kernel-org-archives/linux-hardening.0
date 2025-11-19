Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA02EBB8F
	for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567138; cv=none; b=iRpLj9O8HkZbU8a+UfMmahezywItxXQBzqi/kayyY0J95iw0WEdEqGpRu5XD47SbHhDedITOk5NaKRLyAhG2rr4vIA3WfOma/9ATT040W9IRLJhHtD9fQ5EzvZGWi3yzYeLAA+jke19Gm5TgWHFL5Sv9Hj7jDKlIjgU+9eiDAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567138; c=relaxed/simple;
	bh=TD1by0OTaP880US48xY3+1tAtbimE4nLFyenW4Dl/t0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LraSWoKks6j9lcTzEFTM0ccsg69mMklHdBiRXLkRuNBAP8Rme1FkkfJvr7n1mM5OiOKNzKVGDQx65PF+NBuddqlneOV04tu0kAejRB6UQjKe9LSoThheDaXmP4UtYO8qzXa5CGNLWdNN4xgvNwPe8OzhRDDLO50TptDGpA4KF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kmDHNoQu; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kmDHNoQu"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42bb288c219so3582970f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 19 Nov 2025 07:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763567132; x=1764171932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THAjTq9x4zT81mmTnIarOvW/kNy7ppuR0bAFxzz05mc=;
        b=kmDHNoQu64HbmUGpkc9vYVbHScLy0U0K3t13WEAzv2EDq8a8uPl0d4aWu6NxEH4N1t
         DYYE8ac89yB69Gol4kY2PYMld6Mj6ywoy/rzvjIZJaK5HRAdqiRUeyuEFTVsLejLbh6W
         3TJ/neVjVhIoqjX30M95snlbaU209rNFQn27MGf9j4vlM2WJL/UQ+DElN6BeNUSNt0m9
         MtOlEDObIPHZ8AQoxYJFwIPUr/dgA/ysyug1orn6TqhN4UiVORtBU+5OYM511Gy710PF
         t+B5gphP+SGCjRgl3wzXRoSe9gTtaPOY3qj52wB5VXVOyBK1swi0MrDrAiE86iSXtahV
         SpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567132; x=1764171932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=THAjTq9x4zT81mmTnIarOvW/kNy7ppuR0bAFxzz05mc=;
        b=VTo6apzGRxoxQ0WiiUWA0I0ou6z9FtFSGdkmkogCKDt+wysZ3GnVYbGn/8YjF5HlER
         YIW1T/HFrgy293osdyb1ld5O7InBzYQE8xHJ7L2gszAfYrxdbCYg3NlfQfgfC028N6qp
         07kPrjGwsmBhWBRguffu8QmWfP0rr/fAc05YjlMKjel517b0JfTzFR7DHl9bSuiASD9x
         7d41PWrXRlsNNsqXPuZxsATW/ez3B1YkWurDXeYnp+nPQ2sTjdMbGSFiqYhKlYsPftXy
         ANZeXggpxhUlSAE26mmC+Lni1989zz8yI6avxTxN9KtZEDer2vA/hT6ceHr0a6w1iozC
         OtZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzjmcVc2yQkkuY3ptZJfVyO57machDxNXYh4Px4JruU2wIxelOAGf8ODcORZxklzc7PSXL+2UCzaBKXCcLR4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMV6poOnbaNYlAVuIcSScoyF7jsfel+mu+yOqK91Gw34JZKuR
	MEHm84mL5Wp44+n/352qL6KaPCJESinpJXL9VHc3LgsBildfhIVNg96sfZ2/wd+tSss=
X-Gm-Gg: ASbGncvWauBkhgMViE/t3nwrHvOpweJM4duF+dwtHWxuNb8yJim6TfeyPrmevppy/et
	E7Z6NvxbHBBrQ0Pg3NNcXXOX7xEf+t2di9JFviuYQtrWe5RrlCW5rEy/FccCUIpyChB6jttJEiE
	IaDWq82bpy3O1ONb+mXRBxsIGySWII8MjnRDRT2tONIvWG2DWc7frqXdaTUDi5HyuA+aiO5jG04
	yJi9qTh32xIwhziOgWOacDevkg6YVtc0aO+8PuBrdgRf+Y33WCxieZ54dUgEYKWCWVMDVHx0t5K
	JBO91eFLrUORJAJbzljPnvnUZuOXqc27PGMqwFwWnNPMxXARthUMn72VzugoPfY7pBH8N5A/3vO
	s/7zeWbTedSiBueOKcUie5lRXPwXmEkfLWvYDZmqtOyb8+CmY//7RrXJPY2/+3UH4BFsnR19uJ7
	gWGMqyf7+Awb+KnWl6IPKToRjnOGIzBw==
X-Google-Smtp-Source: AGHT+IFM/SLutYeAmIo2p7oRt8B5TNnuLzBZ4qt+3E18Kli5wgQjVTHlMxDsxZxKW/tnJD9yRmbxGA==
X-Received: by 2002:a05:6000:2a0a:b0:42c:a449:d68c with SMTP id ffacd0b85a97d-42ca449da11mr9102186f8f.30.1763567132399;
        Wed, 19 Nov 2025 07:45:32 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53dea1c9sm38765632f8f.0.2025.11.19.07.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 07:45:32 -0800 (PST)
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
Subject: [PATCH 09/26] mm/show_mem: Annotate static information into meminspect
Date: Wed, 19 Nov 2025 17:44:10 +0200
Message-ID: <20251119154427.1033475-10-eugen.hristev@linaro.org>
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

Annotate vital static information into inspection table:
 - _totalram_pages

Information on these variables is stored into dedicated inspection section.

Signed-off-by: Eugen Hristev <eugen.hristev@linaro.org>
---
 mm/show_mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/show_mem.c b/mm/show_mem.c
index 3a4b5207635d..be9cded4acdb 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -14,12 +14,14 @@
 #include <linux/mmzone.h>
 #include <linux/swap.h>
 #include <linux/vmstat.h>
+#include <linux/meminspect.h>
 
 #include "internal.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
 EXPORT_SYMBOL(_totalram_pages);
+MEMINSPECT_SIMPLE_ENTRY(_totalram_pages);
 unsigned long totalreserve_pages __read_mostly;
 unsigned long totalcma_pages __read_mostly;
 
-- 
2.43.0

