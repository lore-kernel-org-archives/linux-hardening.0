Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776026;
	b=j+RTqNwGqwB+zA9pkSzB2eYTKgCgTvMen2Qu0LLKtP/Xm4y5MhHNf42lzwb76keLKs5i
	 9OAtlw/ue8AfYLewnfu22Z/j7xIjc3XR+pJXlzZSsuRM+Mz+U4m51Cujb836dlcTDh1wJ
	 XfkuX5lJsrlke3vKNhnDtw8PdJSpbUOXMDSdsF8kJpj+wFrJ7FDz+eAKsJNV7vHhOrbPi
	 Ob/qZcSQPM6AonDBauWzXNI8tUEp+VOm0h7ck8DOw8bw4MS4teltINciksclsKm6Qq/aZ
	 FMjtp5WQqRsI3eUEVdJK7fuKIpWAUeliqkbvFN8cyXo3GU0Dfqh07ALp9M1BeEO0t5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=2c6Rb/UBk4azewF8bkRw1dkEc/rmGwcJQDMivDwr1lA=;
	b=igZwD8/WaxKIcEv/oTdHD93UnSdySKfA8E5BtzqYfSrxGU6Du/CD3+tM9KCckStscsQp
	 0SQmbnsmQpRf/oORVYj1BOQFM08YSEJowMfdp6qiuHWDedVbOpo7+d3wZbC5K5WSEc0Gy
	 0xQzT6sDgxlDlx4dVFB6wllXB/CV9O7pLoJpKfWST3+YqGQTENozk+8PQL80q1rP3KxkZ
	 rFkGzWVyJm7MbXjJMSiaNuk1KF/eRoFQLo/SgSwiP6qVN8wHufH6DIR47+k00JUnLApKv
	 HwlIYAmH4PjrfaHeKmHFeU8cc8WAjkPozukgueWYYyHHrmgwmYkLYsRjO4tTK+UIeiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A3N0j4LT;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3703606A31F
	for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 10:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3703606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=A3N0j4LT
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b8a1f59d5eso10502883a12.3
        for <linux-hardening@vger.kernel.org>; Fri, 27 Nov 2026 02:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795776024; x=1796380824; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2c6Rb/UBk4azewF8bkRw1dkEc/rmGwcJQDMivDwr1lA=;
        b=A3N0j4LTDHB+nZov0bYOhdq+QD9ToDVXPLoAPfN5BMtkHjHrdYcQjXgk1TJD0C9Lgc
         a2hwnkkvaDX/A9qcpXX9L9KsQwIPdRndlaQygfgxukcPIwXzBG6JI5mkfuKCO05ubFOa
         JVflOniyJ2BLLDHn547HiucnguS0FXCkS9q0lsMWDbElJWYojSpxhnrumQG5q5wCjZU3
         NujxT4+wlFkXa8eqdfwC50bqCBWuEN5IVsySm+1l2M+8krTGtOju2WDK5PuwkXwtW+oU
         UVplpWpkZsHSUaCySe/IW6oegIM4eWFHgByQEwe0mK0rYsTKlDAoHUn2Cdy4oH4VhZw7
         ZA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795776024; x=1796380824;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2c6Rb/UBk4azewF8bkRw1dkEc/rmGwcJQDMivDwr1lA=;
        b=PxmwfEq1/zaeT/1tQu/q7zhgImYX+GodEy0TkAEFCx0nj/Gi8K/17549XnvZNpNkXp
         iAH6aWeMA3bqdyhbmKK9Vkk4fx6wdIm+5p0kyNsca/ZsKMsFy4oNTqksHBkoQ++fZZ/Z
         YYIhvZqd2XXGwxqsrV71Pdreb9Jwl4eeOoIz+J25SnNpa5uKJtkrxtTMd0OkLXNffAAf
         jornKKzL0+dW8lUBGczllKJV77iD0ADyd/9X0Xv0kjymeE8xSawBZEXYAlBJCK9/ujJ7
         tgY7VDgMqIVi71hBp1jmqmjX49XGLpfJ0kKnFy6rQk9RM8US98m9bmoOIo/EGesxItUB
         ruxA==
X-Forwarded-Encrypted: i=1; AL+hErG86nrvsoHEwD4Ud6LglEc/8rip+cx56rYkFifrQhY6L5+LQxPzRoN6V29vIR7tyvGfxAYqdIgJIygoPM/uPXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/vxiCU36hfKz/CJruQgP03WyC4KThdk/GbcWRelCg+fcS0ZSM9
	ppnmjezYT0pmPfKIo2mE8aMLtr5z5f5cIQrTGCdqf/2TSQKPO1oq33U2h/kgkInQvU8=
X-Gm-Gg: AZFdTZdZDe8PaMqqWT92YBzmrzf2yaPApWx0OcHBf1VTY9ZFfnClKPn1Z7gQWW6H44J
	hf9eOUaiDMOrNqypIeCr2VXC2RL4a4q+jb3axJtdbshBlvzS7f8p1O8Go0JKSrZXbwiUWT1cEYE
	wHZ640hZuSjVFe0/11hIeMLW/b/Ahgb+y+Kepaes767OhthDE05DX5LFZZqH5QGRisKon9dFp7v
	bFqMVCe0sLlIHYKuGbv3wVkRP0KZ7TLMs8SjB0pCL4o1rRsAdX6nmXZSVQDo7EivN9w04BaQNOq
	l6Jxx7FcY6VBEYeEg9fXGs54w96eC0ibJEKVo4m8cPnbvdEOkv2B41oq8Baxe13S//3NFeqsy7o
	tJJxW6AiHkXwo2VVRRKHwHxwrOqSkJQeoIB4I4KDPsqnCNghZ/bTW9K2RQH0ZcUDGk3hEAlaKh6
	GuTqeyC5l2xjg1vg5FiBw4HOIhMckdskB6pHQ1gXNBKpgMn/+FSszw8AdhfKAA9qLyhUg4KAGtf
	CsKbsbYzqLDuImwEXj5u/8I718MfIdBUXRcj+pSbARi+lisrdQIAiMgZjRgxI3DN2RL5p4RRp+F
	1jZBUHvFiIKZoKHn8KNytujZyJMNcVFp0fbzCLa0JXb365NvaUwiROApuUERTxGs/B499RucLwi
	3qq7dgTJWQ1HyfPf5Nw==
X-Received: by 2002:a05:6402:1492:b0:6b8:68fd:bf30 with SMTP id 4fb4d7f45d1cf-6ba37d5bf2dmr12996663a12.13.1795776024088;
        Fri, 27 Nov 2026 02:40:24 -0800 (PST)
Received: from puffmais2.c.googlers.com (226.124.90.34.bc.googleusercontent.com. [34.90.124.226])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6bb11ff543fsm3919199a12.2.2026.11.27.02.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 02:40:23 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 0/3] phy: samsung-ufs: fix gs101 OOB read and use counted
 config tables
Date: Fri, 27 Nov 2026 10:40:20 +0000
Message-Id: <20261127-gs101-ufs-phy-oob-v1-0-144b0e04c3a8@linaro.org>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABReCWsC/x3MSQqAMAxA0atI1gaaOiBeRVw4pG02VhoURby7x
 eVb/P+AchJW6IsHEp+iErcMKgtYwrR5RlmzwRrbEtkGvZIhPJziHm6MccbOVKaa2oZcPUPu9sR
 Orv85jO/7AcBI7qxjAAAA
X-Change-ID: 20261125-gs101-ufs-phy-oob-80303a651f4b
To: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Juan Yescas <jyescas@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-hardening@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3

Hi,

Booting a gs101 platform with generic KASAN enabled triggers a
global-out-of-bounds read during UFS PHY calibration because
tensor_gs101_pre_pwr_hs_config[] omits the END_UFS_PHY_CFG sentinel.

This series starts with the minimal fix suitable for backporting to
stable kernels, followed by two hardening patches to prevent missing
sentinels and out-of-bounds config table accesses in the future:

- Fix the global-out-of-bounds read on gs101 by adding the missing
  END_UFS_PHY_CFG terminator (tagged for stable).
- Embed the per-SoC config pointer arrays in struct
  samsung_ufs_phy_drvdata with fixed bounds and move them to .rodata.
- Replace END_UFS_PHY_CFG sentinel iteration with ARRAY_SIZE()-counted
  tables annotated with __counted_by_ptr().

On arm64 (non-debug build), the two refactor patches shrink
phy-exynos-ufs.o by 144 bytes overall (.text -160, .data -176,
.rodata +192).

Note that exynosautov9_ufs_phy.wait_for_cdr is never called (before or
after this series), because exynosautov9 defines neither a
CFG_POST_PWR_HS table nor hibern8 tables - this series preserves the
existing wait_for_cdr behaviour.

Tested on Pixel 6 (gs101) with generic KASAN and UBSAN_BOUNDS enabled,
including UFS hibern8 enter/exit cycles.

Cheers
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
André Draszik (3):
      phy: samsung: gs101-ufs: terminate pre_pwr_hs config
      phy: samsung-ufs: embed cfgs arrays in drvdata
      phy: samsung-ufs: use counted config tables

 drivers/phy/samsung/phy-exynos7-ufs.c        | 17 ++++------
 drivers/phy/samsung/phy-exynosautov9-ufs.c   | 14 +++-----
 drivers/phy/samsung/phy-exynosautov920-ufs.c | 25 +++++++--------
 drivers/phy/samsung/phy-fsd-ufs.c            | 23 ++++++-------
 drivers/phy/samsung/phy-gs101-ufs.c          | 26 ++++++---------
 drivers/phy/samsung/phy-samsung-ufs.c        | 48 ++++++++++++++--------------
 drivers/phy/samsung/phy-samsung-ufs.h        | 26 ++++++++++++---
 7 files changed, 87 insertions(+), 92 deletions(-)
---
base-commit: 3191063649dbf7c0d0b768e1f3655e4c5fc6edb5
change-id: 20261125-gs101-ufs-phy-oob-80303a651f4b

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

