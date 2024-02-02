Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BC877F2F
	for <linux-hardening@vger.kernel.org>; Fri,  2 Feb 2024 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867829; cv=none; b=EM57HL8JKg0aZa0Lls/eEC4Y1YEl2ZV7UZpBg5jeG8yVSQfyp8T8WJT2dunEn46OkgL05qCzRNXNJFOc5OWOaXFkt6wBEPJSin7eL8hkO3Oi/nHjmg9/T0eTHeb00TbOBIAL8+JP58WUaRNYQJwjc2wLBZNAKcxLi/sgYFzx3IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867829; c=relaxed/simple;
	bh=bjEXqr7juqAo7r0UWVj0k7PItANAjVW+zMO2xDYVoUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5hrlcvuOPe20NCgUazN8cIlpLMbIo4wKkZopNH3qRGPgTDe8j+rV9H749mccj3mf5O3/03RjA1aTTvpYYsuBJN13cRjxYLKNTjcA4+mSOarNbDRNER24xqSkTuAo8PBiGHtDfXZ1qbVSBrpr4JFx+VYDWjnyQOcVHC5nx7IJq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FaIptal0; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FaIptal0"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e0f43074edso1178336a34.1
        for <linux-hardening@vger.kernel.org>; Fri, 02 Feb 2024 01:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706867827; x=1707472627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Yz9MZHC3+Z3f/8BosEm+IOYEK4vP+FaJ0leFZuxaRw=;
        b=FaIptal05pmHRBxIAtBIGuTAED3nNoIVZxpk7vKZ1k499kytlB/fgHgDL4uqsC15KL
         s8dnjpvPlNkldhTkGuhtkcqRNWmjsdxoqfN6WzHa1s/yaa0h1A2d1slMVpmDfc6lo9Wk
         5eav+ZP5vOCVfN1hsdamFqCdBLXxP7h5dZ+7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867827; x=1707472627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Yz9MZHC3+Z3f/8BosEm+IOYEK4vP+FaJ0leFZuxaRw=;
        b=bPHMGIrDKyf2J/0a/LBotto8kKglEVc6AgngVuI/SeD/KMM8Kix6BSW1NGqn1BgDnY
         EWurJ74xp5a8XC9zGCjZ4r/8RozxC92bMe3eQIEoX+zs4zZH9l8sSTDXq5ryVK0CGxVG
         MAC8nSFwTSnJD18Mvj9RR0jlz13UYcLPe9T7pZaXrvks2IX5phyql9LrORer8kB/Q/jy
         89bicQK9pj6yuXzK9t5QC4cMd4P2MBEVbdfZrQX1jHg9qStoBqvzPbKmjS8yu7GaG4/+
         BFYYhuCRWEtv7Mp0IYGz3EqV+n9IX36dyqfxbV224flrfuvwNzHSbt9fHyPVVZ7wfHtz
         SMnw==
X-Gm-Message-State: AOJu0YwvIADKujBDjjWh8k56lZo80FZr2hf9oT+7PeUa8ykKFd47rlkR
	0TYWpDMzQ5a2Vwz6qm7j+6H/lxSkkPj0pecx/hkHiGqnpDR980SevflXWXP0+w==
X-Google-Smtp-Source: AGHT+IGhZTIVf910PLrWcx+f8/j22fPtLX1oTamO9hshyDyLvopL6psh6+ke57hX8ua5JlyhlOlSxA==
X-Received: by 2002:a05:6830:2b26:b0:6dd:ecfc:622e with SMTP id l38-20020a0568302b2600b006ddecfc622emr1812794otv.24.1706867827211;
        Fri, 02 Feb 2024 01:57:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXIfVH9IQWGEtrbj/s4rYjobOiW696NXE69dTTUGP712R24JpVzfOQVeXYuf5lelldK9rd42bHbjyJMmQIDBBeFPP/tDqXckQksHFkTuw27epfiTJntaFIuwlUa6Bbstq604qh0ffTCIxiIDYmSbUK6bvThsIsjLAhgyVXJIYMzujwr4RqEZIFrzcoofu3yuG3wrV33Jw==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h13-20020a63c00d000000b005ceac534e47sm1199559pgg.51.2024.02.02.01.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 01:57:06 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Kees Cook <keescook@chromium.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] MAINTAINERS: Add UBSAN section
Date: Fri,  2 Feb 2024 01:57:03 -0800
Message-Id: <20240202095700.it.233-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1379; i=keescook@chromium.org;
 h=from:subject:message-id; bh=bjEXqr7juqAo7r0UWVj0k7PItANAjVW+zMO2xDYVoUM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlvLxv2dmYU9Pilnwk3PcFpt5HtFQBMIgPhqNTg
 giwSkorDYyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZby8bwAKCRCJcvTf3G3A
 JirNEACDzlT04LRgZbXDSYVEouEFVJC6QZRzfIXS+zsybZ72khGFcfiBX/b0DYQ0PUykkAOreoW
 mPMzozdlXMJqikO9VtWY4761S/s8ShNtx/yPqNSpGX0lz88lgtAHtz/mGtpOQa7wdS/ZqWoloBK
 FZmrC0GbLaEN38raOEOetZnCa9GWqaKux4dEwfu5+X7jdmuNbRg3eEi5qDKzBuT1rMZQ6xWGRRt
 r2Kz3PKxV+vx+BwgFnwNhemE2T1SHSj16X7iekq/B8/YDhSJNeuJ+EF8A87xHEwA74vabaPiK3u
 AhspdHA+GAjL/Ud5pUqhqoqOzdr2BJGFm7NB2HaJ5olvd40HtMC5HxaJje26/UwtMPC0/gBWGh1
 0RIKnmE8f0TKFhN+D5V/T0aiSEYRYvc9cdHQr39dFkbXdR2eaEilteMuQ9PseJdyWh/leBRHAgB
 DtBa4065JEGKtzPYJXMCLscPNHWp3Jvk19m9VrYWK3t1tQbylbejEhcR7uzXUEkfJWyoJWA6ZAc
 /BH8smkx5pShfqr5Yy0Ff92laPTlWJ2g//XEE/qhRglgFHaznKqM4UGRwkqIIZC3oiG/Utc8zpT
 VGd2xewumPpTjqGO3jbxc7BzkDo9qx7knsaEOJPBZoRnD+X2ZXGZbsIwCRWMYhaULEOur60gRRR
 jdpWN6U MNHb2gJg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The kernel hardening efforts have continued to depend more and more
heavily on UBSAN, so make an actual MAINTAINERS entry for it.

Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Acked-by: Andrey Konovalov <andreyknvl@gmail.com>
Acked-by: Marco Elver <elver@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - add kasan-dev, drop Andrey Ryabinin
v1: https://lore.kernel.org/all/20240130234634.work.003-kees@kernel.org/
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..990af78b410d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22471,6 +22471,22 @@ F:	Documentation/block/ublk.rst
 F:	drivers/block/ublk_drv.c
 F:	include/uapi/linux/ublk_cmd.h
 
+UBSAN
+M:	Kees Cook <keescook@chromium.org>
+R:	Marco Elver <elver@google.com>
+R:	Andrey Konovalov <andreyknvl@gmail.com>
+L:	kasan-dev@googlegroups.com
+L:	linux-hardening@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/hardening
+F:	Documentation/dev-tools/ubsan.rst
+F:	include/linux/ubsan.h
+F:	lib/Kconfig.ubsan
+F:	lib/test_ubsan.c
+F:	lib/ubsan.c
+F:	scripts/Makefile.ubsan
+K:	\bARCH_HAS_UBSAN\b
+
 UCLINUX (M68KNOMMU AND COLDFIRE)
 M:	Greg Ungerer <gerg@linux-m68k.org>
 L:	linux-m68k@lists.linux-m68k.org
-- 
2.34.1

