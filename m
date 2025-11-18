Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355F331A7E
	for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460269; cv=none; b=MC1sfOVj2RhvKwWmWnT0LY4L1gBIbZUnFnUWqa/d/DPg2RrRVsJ+zwHIOiOFVqmnd7JCPy0DwmV5me/qGcXWSZbIg6E1ooeOhYzt2uDSFZ8N6QJApmVOAHwwqAixDBhrZtsTsXi8i3fIS5W+hD+QBD1A4GCFnjNChLIoAKKM5Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460269; c=relaxed/simple;
	bh=rrzfcCvaja20NV3IfrF9uGjJwXmplFICHOFlmH1KiRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Coubpr3rM39ngPyMsW8LwtHMyQ6h3ezp9sq5HfPvzryRtwryBTSunY56JO7adMmVeNxSBmLMtp/1Bzndk8qSAXr35WUCwMF9CSMWMUncvfo52LZE+DtivcfX6VQRe8ZBT+/CkhGOtV+BwDnfP07P7r32TYc/9Z7ohZ4AEhsPlxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=M29Pk756; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="M29Pk756"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-429c8632fcbso3734978f8f.1
        for <linux-hardening@vger.kernel.org>; Tue, 18 Nov 2025 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763460266; x=1764065066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6+f2V3N75t4meyL8QcQgkaDw7LMhWNEEXGJ+ed7Ez9k=;
        b=M29Pk756eFRg070pAF+8xIwXfvAvP9AikoZScYvyP93MM/GRDosZpXIgIXm6IlLxtp
         yJYodf6yQ/6z2zH5Ac8StUJspbAoBIbDFHeeUsevcRfSB0ar3KkcAi67UCdK3OCGNSbC
         +qBsSUp2W6Um7YGyzYoPAvOOC7N84HqkejbAnHir8GqwVaBjPZ3jEYWazhCLK/IT6z+Y
         /xBQmz3Syer7YJrUWjTBool5pIATRxgJY8Ou2kdH2Fgz6alZKBjEc1jacBUcYPDLQx/p
         wqcRqkaxEXNQXm7PJHwIFeMVoDkPLy/IRs4CUK3MEJ611e/wFwXTG9FsDDMI/buisIYX
         t6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763460266; x=1764065066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6+f2V3N75t4meyL8QcQgkaDw7LMhWNEEXGJ+ed7Ez9k=;
        b=oC9JQcc82EtgE511RlqnNFkjs2XoBKw/F2G0izUdSnDGWoQ5rxb+cNdCYTJh3cwxGF
         lfJpTK4py9ls86XJrpQ+q86hsIgcvIzisEzBeZDn/RA0ZfifYJBrXx/jIj47MrK+lG29
         CyQGN2VrtNb5E0sa5aT7ynL4w9hu1x0fQy8IwIQP1OU/BZNZw0xItCPx6xemtCL9Nu2R
         V0+lkUV0EVHyC68LJRiUPsNI46cpDRQ7B9irRicNXEetYFeAqT/ZGl3Gqlvp3SWfmZiC
         YDyf8xf+lx9JhjZArZcuF6o+FhoxI5qLcnQ+8J1eR7kSTXoMOxeQCsAFCKGoXbILPO2P
         dSag==
X-Gm-Message-State: AOJu0YyCiG1Re47pzu7z1ZrfpFCLYUHs4AH0F+WhyZ65jcqVHr54YSAD
	DeSBWza9zyPCJd1nmgaTAraRLxTY50tCmeQaK+T0MKElIEbwRd6yxsjXSk+7vKohsRw=
X-Gm-Gg: ASbGncuKIOOJqAP3lDSdpOwqViiyYIQJ7zssvwjVHADX5nMw1ONBMsOtzTGOA9i5GC/
	FWO4qz8slVP//t4uMGoBNs/cIqS+6BpXlCP7OHnLq17w0eSoSuyHkJR7B7QSO+xHgE0zwBAfGq+
	sW+W0hiXKxIZI5965K8FE30EXFDE0BtPK+pzirsqPpK5xdZ5KIeEkXaRmdwgaHNJQX0joydg3mF
	n7QWqn9ECg0l9hfLiqN1K1SdIbwez34eZPcwqLtVxkXDpxiTyI0iK8+tj39q3eYNDcJJ40R7q/Z
	KXuLOWQz0uK30nY7YCNs4/laoOr3vdCd1eSjoYzgdGXzPx2CzK2l9ImkYwc9AO+DPQ8LRWiwWKk
	w9tCvC5nTQDcnBlwIdKPjNKdd9SYG3muLlR6MrQi+E56uHXdckKpZm3fI/JK4FAdfoqqQUFAZHS
	aMtPY=
X-Google-Smtp-Source: AGHT+IHz8mdQWqTyhmMB0ZG+8L6TVE19ty06ZAmXzeUhPHLnnpUiicbAZq6zHZQREbvQTz8dLW8DeA==
X-Received: by 2002:a05:6000:420a:b0:429:d725:410c with SMTP id ffacd0b85a97d-42b59373658mr14506290f8f.44.1763460266248;
        Tue, 18 Nov 2025 02:04:26 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:c283:3472:316:988d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7aea7sm30999781f8f.1.2025.11.18.02.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 02:04:24 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 18 Nov 2025 11:04:04 +0100
Subject: [PATCH 2/2] string: use __attribute__((nonnull())) in strends()
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-strends-follow-up-v1-2-d3f8ef750f59@linaro.org>
References: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
In-Reply-To: <20251118-strends-follow-up-v1-0-d3f8ef750f59@linaro.org>
To: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=sTUv/WTYwbSxtxmj4w6EABSPn9wDbZi3OeCAMwVKu+w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpHESlaA5oQ1dBdh2HD7p0M4YzE5XmBxTtviBLA
 nPqkqgcqJmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRxEpQAKCRAFnS7L/zaE
 w2btD/wMFCNoXpG1HtZ45QSrpUnqTtWDLvAq+YMa8tbU2PO0Op1Z2H3K3V0Hi+u+5R8jU7RBH1D
 ckaCf2aWPQKb7fMb3wH5ox9BaGoY2tYSibDEaOv6J63EJYj0BzdaMeu2NISqYxlHRsHMDyNKST2
 VPmSh8WEY6DoHHWlNlS84SQ/al+LyOXlLOZ9L5hGVru9edAwE4+tAW2b5Pa/Uxpk0PaeAY1d3pL
 wbq8Dj0At6TgqnTRVxC9M5LQlwh/NCEDSa+Ji4MajNHm7k1bm9s/5aW7ubYFoXtpVS1/PZ/TL5L
 xa5oJYW0AQRtsrJsOerlEzAHsejxHHqYzY+Pk0p6lKrBvnQ1LDzhHHDqkiY3Q1mn4WdYupUjGJF
 1WTgyUMZBldyF48vbsaVyL1o6TcwAAguMA2qFzHzKHpb5JnUmW3cjESzxnj6BRmMe5yW2nq+nI5
 fdXU1k0Kf8wVXwtEa0weejEj/BknlKi0rP2ZtKyHJUAg02yEe4la3+2IzPes0/kxynTOj2DM9T6
 crpnHlFthZLn++ulnCvC3ltA34v7Y3kk+XUDToY1pOpwTPzsHK77vQ97iUPNHculyP5+J94TPqa
 TgjMBsdS91PXkL7WUEpZrt1Lw80s/zGLt/7bdyghxsxHDXJ2Elib7BkSovdGuURZHA77QaShZAY
 Sf11aFe477B80pQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The arguments of strends() must not be NULL so annotate the function
with the nonnull attribute.

Suggested-by: Kees Cook <kees@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/string.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/string.h b/include/linux/string.h
index 69e9256592f87e446d6f0be5034056aa7d0b78b0..0266dbdaa4cde7a388f1c1d5e8755d7f00335e42 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -570,7 +570,8 @@ static inline bool strstarts(const char *str, const char *prefix)
  * Returns:
  * True if @str ends with @suffix. False in all other cases.
  */
-static inline bool strends(const char *str, const char *suffix)
+static inline bool __attribute__((nonnull(1, 2)))
+strends(const char *str, const char *suffix)
 {
 	unsigned int str_len = strlen(str), suffix_len = strlen(suffix);
 

-- 
2.51.0

