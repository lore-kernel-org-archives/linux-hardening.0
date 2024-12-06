Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A44192B76
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733513593; cv=none; b=NWwv3HF/BxxuoBZlmrNQyO5/S59OdEVNuyFxOtvdwCM4K5Xl5Z8OlNanh3BFZme78r8VQQ//0neFl7zxdrgyFfjF38uewG7mxYWdbAcccDuzr5e9m8H4BrHTz5VHT/VtT+FJacb12/Mt101M+I5JImjl2FcIgWfLMIY7CuVi2NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733513593; c=relaxed/simple;
	bh=kmwXrDdVSFzX1RWQbypl4/vyclBnjb9SVqQFwYrXRpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+SC1bBwKEnxUr/5ofy4WkU7ZNB6FS4srbg+EkB0ObvlgWjznxgmQkx1TqXr9nYCP9JcU/DBC45BpVAJpTlkZPxTe9BLuB1p/9ixdkZ/BhPejAETDqHRunWNT4qGNtyZfTzmRByGHTF/pHMKjmXAnfOrAqER3GoiRV2xSARGafE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WIaj01zc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WIaj01zc"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fbb47b65d8so172100a12.2
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733513591; x=1734118391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HltmlFi5Mtjm1w1ygcJnz7XyQYUTr+uzffhTeU486Yg=;
        b=WIaj01zcjV8N03KzoeHjvsmbHEY1uFBaCtqQrd3ctCp5lXwCtJZ5Qf3u6srdCL7dx4
         O2BbsdhG9YudyWBvaLZFzs1Gg6IB0Wer91bdMqNkl+Ew9MlXXS+TAyzkb3czxiB+6E3e
         y+GNMnPvh/446pxiRm3eWa3lixq5Ag1a4pLQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733513591; x=1734118391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HltmlFi5Mtjm1w1ygcJnz7XyQYUTr+uzffhTeU486Yg=;
        b=P606OCoYbkJIpktChyW4JW0eTCBdh5LCX/0blmco4VpPhnR9QNk5TrsIRZnglxgkZz
         ZE1ovAaKezCFhKT1ZWLITEP6TMR3XjlGT/Bc8zArxJdbLITPdQgnjpsiKC90NheCbAgN
         WLHwNkAU4rXDt5cK+zKUW5o1XHg3h3WLupVMPhjLHnyT63uHtfDR/YSVybrETvCmFODQ
         eCBrCh/8SIsL3ZjwXoptfFj7t5Uit2A+g2BRIVq4C9yEdc+yFry8tiaNwEN1jtY7FjWt
         2KWbY3Mf18pnG3ILREVxDhL9waLor9hQ8WRGBycImoKwZYTeHNdtwGYj2XaW6atgNzJ5
         1j5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvxLlNG3Ro/o1HXdCXS0e6fXjDESGVZjJtuyFiM7IO3h93mLYUE+PCp6umyjXlakmYlQlgX7dqpg15q1Wvj/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4/s6lYtLKcSAnxLvK8+ZMFT8aSSxlbrK1LR6TshghCEJXoDAm
	q8Tl0kUtR3exvVSs3O6zHVzSEAsXtqvF85RvZ8ZqBjmq3WXf10KmJrOt6zc1zQ==
X-Gm-Gg: ASbGncuYZyG87mfjyAn/tzTTnzLNv7YAx2Qa/hrRo3cPKXqp/IVEQFPF56vKyaIgbna
	5CCorfQm9GAukZk4LDSYHlQ5Mx/8O/ErgmHEuZi4aMKmDETADBVDKizE159m4k419rPUkJU65aZ
	BEQHvfuXAxRDrpAN9PFIpjaUrpNLfLoX6HdL7thLrzV7Fp4VCEBu0KRVjMD0TW30GjMiHprTNRM
	UGAAP/Nm/18QXyKR1Z+5MLCuMYBda2uWF1ENGno+nDnbGCjCqZSqStV+v823Sh5izzlNvh0QiBk
	+wTNOe9sYgg=
X-Google-Smtp-Source: AGHT+IFyvwmM7rvSPgBh5Lg1uIbAIveZitsJmrI0lGdli31hAiDag50aHX/3xBKsUCxKFfbxFCRvHA==
X-Received: by 2002:a05:6a20:918d:b0:1d8:a203:95a4 with SMTP id adf61e73a8af0-1e1870b9329mr2877161637.5.1733513591343;
        Fri, 06 Dec 2024 11:33:11 -0800 (PST)
Received: from localhost (238.76.127.34.bc.googleusercontent.com. [34.127.76.238])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-7fd156b7964sm2997645a12.18.2024.12.06.11.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 11:33:10 -0800 (PST)
From: jeffxu@chromium.org
To: akpm@linux-foundation.org,
	vbabka@suse.cz,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@Oracle.com
Cc: linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-mm@kvack.org,
	jorgelo@chromium.org,
	keescook@chromium.org,
	pedro.falcato@gmail.com,
	rdunlap@infradead.org,
	Jeff Xu <jeffxu@google.com>
Subject: [PATCH] mseal: remove can_do_mseal
Date: Fri,  6 Dec 2024 19:33:09 +0000
Message-ID: <20241206193309.3026213-1-jeffxu@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
In-Reply-To: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
References: <CABi2SkUxcgKf1Z_zYNP+LOK8w=uUEKyq3fUpjJNcavhts2g0TA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

Hi Andrew,

Is that possible to squash this change on top of 
"mseal: move can_do_mseal to mseal.c" on the mm-unstable ?

This is the first time I m doing this, because I saw dev did this before,
and saying this is the prefered approach.

I could also send v2 which is what I usually do.

Thanks
-Jeff

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/mseal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mseal.c b/mm/mseal.c
index e167220a0bf0..08e6f328d9c7 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -225,9 +225,9 @@ int do_mseal(unsigned long start, size_t len_in, unsigned long flags)
 	unsigned long end;
 	struct mm_struct *mm = current->mm;
 
-	ret = can_do_mseal(flags);
-	if (ret)
-		return ret;
+	/* Verify flags not set. */
+	if (flags)
+		return -EINVAL;
 
 	start = untagged_addr(start);
 	if (!PAGE_ALIGNED(start))
-- 
2.47.0.338.g60cca15819-goog

