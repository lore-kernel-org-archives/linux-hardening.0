Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E08313277
	for <linux-hardening@vger.kernel.org>; Sat, 25 Oct 2025 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410021; cv=none; b=VPQ68WdmA/GzQl8wxMr1Zcc6pdy9q2Th1C7rpXzd2S5o243xuZhWbBclWwwH4O9PdlPdcoLRlOXP0A+6ds7X2gEy6yZ/KNbtoPrmzRCNnl/RKA5K3NGvO4v2TVlyYhmmj0HZ/VpLTPN5MFkJvLuO3XOS0bu4LLnhVmfoRDb13c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410021; c=relaxed/simple;
	bh=7GwbfwFI4OnHwDpWdSIvynNWO47LZso8CXPD0pWl0FI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dbBYcxGyarLq3EMUeVwFfLs3E7G8mCm7gPhDBCiyiQcU42FItOM/wwyin5Yg6FXtdYR7M0bcaQdCFsALMF0O4iTfhnv0ZjOMAtJIK9p9LvjVFR64lICywOK4tsy9s6TdbOb7L06Fhjt1SQUZcG3eenk2hHWKnw3ZmLfwxRgXRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k61x73+Y; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k61x73+Y"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-87c217f4aaaso37648186d6.0
        for <linux-hardening@vger.kernel.org>; Sat, 25 Oct 2025 09:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410018; x=1762014818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=k61x73+Y1RYjuUy31WY8Bh5vjekgdLShcM1zhnsOhVlzkYY6Nlm9ftAa5Q6NQ3MMw6
         Q1OcUXhqeyV1iogg1y9xps6jNUErn75QVfXIfwBeFV980xGjDaLF+vFwUUb52Mw1toc+
         SuyY9yls6ExAltaagEBPCInvdrjl4Nn3ECeS2AFA4+UW5OA3IR1fZXHge1fLoDczZHvD
         mLbqiQRShAWLI/5e5Ygf5gjk7rcSWpDiSyHOYAX2hhauhSxB7bWYUfi+P0wI3T/r7XZW
         16qEImeIIL4h+MB4wZRwh6gwAtulubNFg+sFy+4Cl/gnPoB0QVRDaeRieaKyF88rZ91j
         G61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410018; x=1762014818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxuvcw+5BokTf5KtZwOgkWEs4upe9ufMvZQ/niv/DKU=;
        b=VhDttW7N97phuuSWgsKZ4aGLawIUwIFE4TY0M4IwLoRokzcF9I+h3Jk8cRdXkojIrz
         zow4CI+Pialu98T2AkFYvzAhATeB+T2nEMSx1WQKR2SMp+dNJZII7rLEyS7m26Yrtvd9
         W++0SqnHQ0FLYogF0ym6CzpsOuEK1/hFLyAZU8/rQklfCyK18w1SxaKkWcvxTKnEciZM
         ZcEbGvtPwjj/ywfYHciKHeMRd1kEpIDpUmm2Ky7OmrSHgreFnUDmlQdwx7fX1mMRzyYi
         nvCtxy51KznSgtHnOgrOp3xuSsEoYIN7KfCA954u0Id3kiQRAVue1QCkFqjZL8xRtobF
         iZzw==
X-Forwarded-Encrypted: i=1; AJvYcCVeKc48utF4s4rGO/AdZtNgxKsyf34QW0/P+oFOnbET6lGypwZ2Cp8xWP5xWSa8OWTR8IUXdFtj8fsULkgoQV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRVttSx7bCC92+65Z2gQpPiDA1E1VTppMWdUqcFGJ2W3Y5Xx6T
	a6KYM8vzebAr1yzCIGgn/zpDM1CaNow/aPvcOercP/3QC18BknWZqEdlYeTjWg==
X-Gm-Gg: ASbGnct1KUtT3UEmX3o3YGuwaUEJSqk4cdNdaoA3sdimKLG8jcCc41/q8T4H9puombt
	ki31fZl6PX8sMyGGGEzcLNZXYQi7/TWe65SMWTBgDpFqXZWz7Uu4S1d04mReMEv7k6dlUy8COFm
	KUMwtq3mnGuPoe9TmdVBTaAU3gzpleFq7O6bAvY1zvfLni1Sxl+5iSpGLAJfR975phU2VnVpcSD
	q2a4kaWP968AOWseYt/5QgosiJhOuUtp82J3WgxXOvzLWyYngNwYEVFiYQgCOIF57/5/EPNi/iI
	UmQwmS+fcqqNZbNvLeyV/7gqoDVF3F4GlXWOOIG9b8j1YDJmsYlwW7jbYuTb4G7bNc3K6vtuHFT
	REFQjaZ2+hDnd+9VtB+kN7HUivP9zyZ9NHMz0AzyWCBfkRZzce5SmbEi+ozbramVjOf/iobwjfW
	4AYgbevaI=
X-Google-Smtp-Source: AGHT+IHWOynP91XK0eWWEmP39+HpO2WIYG1FD6QWp9GErpLHI7PIM/nM4hfHX/dVKVXslC7yeirnSA==
X-Received: by 2002:a05:6214:508f:b0:87c:27c2:2c0e with SMTP id 6a1803df08f44-87c27c22f10mr333708616d6.59.1761410018091;
        Sat, 25 Oct 2025 09:33:38 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc48a8a1bsm16461146d6.8.2025.10.25.09.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:33:37 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Lee Jones <lee@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH 20/21] fortify-string: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:33:02 -0400
Message-ID: <20251025163305.306787-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025162858.305236-1-yury.norov@gmail.com>
References: <20251025162858.305236-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. BITS(low, high) is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/fortify-string.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
index b3b53f8c1b28..0c95cdcca736 100644
--- a/include/linux/fortify-string.h
+++ b/include/linux/fortify-string.h
@@ -11,9 +11,9 @@
 #define __RENAME(x) __asm__(#x)
 
 #define FORTIFY_REASON_DIR(r)		FIELD_GET(BIT(0), r)
-#define FORTIFY_REASON_FUNC(r)		FIELD_GET(GENMASK(7, 1), r)
+#define FORTIFY_REASON_FUNC(r)		FIELD_GET(BITS(1, 7), r)
 #define FORTIFY_REASON(func, write)	(FIELD_PREP(BIT(0), write) | \
-					 FIELD_PREP(GENMASK(7, 1), func))
+					 FIELD_PREP(BITS(1, 7), func))
 
 /* Overridden by KUnit tests. */
 #ifndef fortify_panic
-- 
2.43.0

