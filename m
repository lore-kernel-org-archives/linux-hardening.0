Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D32F3F4DF2
	for <linux-hardening@vger.kernel.org>; Tue,  2 Jun 2026 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780419658; cv=none; b=TAd00B7eHROUvjrUCJWXg2l+OBXfq3Jbh6HWlfJjE9w/otcK/YTQ+0ZMqS9y5JOQnZ4EIwwGjNncd2TFd1ytTBKf9d/yS0vZ94zO8jsQB8cmEvV9aR3Ia7cgtp1E+CM8QWpjay3BcJ6YOcziulLU5vg+yLggR03YfATE/6IU8XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780419658; c=relaxed/simple;
	bh=APjGOr4rSujMx24P1jDIzhjkfbHKcFK80a9vPvVqD0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJojXPJ0Jc9khJ8kQ/Oh7eS1omBb1lenriknsRNlGNa4Bq2yrgcLLilyUEbDX5rHcZFd6K6ReS+UM5h7dM8DzL4Z3SBapkGxoYZunFnb01ynmxjlhJD4JfQf9se3SZXXKVgTVQTQkE0sL+iGiMFdnKHc3JiENDIT77GiqzMSuKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nxTfd1N8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nxTfd1N8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49041e84237so95438795e9.1
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780419655; x=1781024455; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9xxE0a97UY7UPF7zz4jpUqke1DXutWR5PtyvwLwWtU=;
        b=nxTfd1N82lNof4cSAAKRVkfrKRNgyqLliF8u2i5qQgXZfDY+kMJzIY2j4l+sTo+x/w
         B1uJTLz1emsVsMfscM+vXIR5qJum0OL6tEGOifr2zD0deirr2XHOOIYfuSG/yo6LE7Nn
         IHUar6wNKpKzj+zzn2j0D8ZFO4GUSrk8//rBrJ9SuKSwECtQQULsN/XuWtRzwasa+XJW
         VNTtbNWHXo7BgI86kTvgnIL/LcR2Q3O21ZWHxUyFl28fdlTZZMgVDbU5J1/ol8qZbpEZ
         LsZD0MFvebfiMCbaOg/CiyhPW6ze96N6ZCjI/Qe0ixRIa8mqQSlMprnxhoS5WqSk1ZVC
         Yjcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780419655; x=1781024455;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b9xxE0a97UY7UPF7zz4jpUqke1DXutWR5PtyvwLwWtU=;
        b=dXnD1BQZCicMZht8l7cBKMJVdH2VjNMKhWxs+qExSUh1ungjBd06OEhEm0ZsbY8QGf
         HWFjSouNGXyhaU2NW/O9sAR2knMdNyQEY/C6W3VXXKDMDIpVX8qHRcfn6ISSMSjB1YQk
         HRhZuKf8kE2evcaVnE7Nx+ny7oEVoKDqmw9YqtzWOKlPqtDgP89NO0FONyOMR830jf1E
         jlasDeKPFCkO7YzChN1FyswJubzHMas1No9LN8X1OwWLE/AYv5efDXvJUSbJ4qHqlS0E
         TFJDhokf8pPQoaqSoOOkmo5WK/83TjxLNilkN5Fm/9djgRgbSNa6iroA1xtCxIftmydV
         vNvw==
X-Forwarded-Encrypted: i=1; AFNElJ/1Wvpv1fQ2sb6ARN8BNSFArPs372JoHVMuQ17dZc7j3LWEjhLQFQZ6J58bM0NXBZrbXrrx9iUPXkritfa5oNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLBwHEWaiRxk5bQZtOJx/9du8StaziP5POLqy5HH+Vw6PSGPeI
	gVTWJFFsgXFZzrmPDTh1xOnHspG/vNpM7cecwUjqS03PYZXrdP0fBVoa6Y2V7SXasd8=
X-Gm-Gg: Acq92OENRceqfp0sF9tZRuewpQPJxUoNSwX7ealvMV1azhBvIuoo7/Vpm3RfAoYVDBZ
	mHAxmP6UrBuJ0v6rZhs01ZYVa1i1/Tc/IEcpR70wkbxBkzNz8TSdeWppaCNlHbS+ar8Sj5m4NPa
	kPiDnReoEvryDS/avqTCaahwhpDW5IhPjsN6AqE1nK8kR8rjDabMognbur2hp+y8t97cs9YBfXP
	ZQkRj5GH9CAcVzQVC+EDM/ta/TyHVfp7B0S9lrDjAVU+HEkGBn8B9GDLwovsKuh8SgxsWgdYKS5
	6QKE0vn2X0BA1cXkp2/5JrFql6uK4AqQJ8QJbMSxJvJyJahHtKfAV3GivOli4/W0E8QiBy/rrH2
	iACSR3CL3SZ5NaJtXmcddbiXFOQi7T6UDiT0lQzVUvFv0eZu5yIgXrTRW52tG6jgTddpn6ary3l
	H81X8fDy9h1jek0j5KqUsZ1gFkEyCnlr7KL6dNSXHGbr5CO/9Mt3D+IOT2RimR1QOODJ2+6MObE
	q2Bcy+fL1b7yok=
X-Received: by 2002:a05:600c:410e:b0:490:addd:1d69 with SMTP id 5b1f17b1804b1-490b0eaf370mr58450785e9.13.1780419654831;
        Tue, 02 Jun 2026 10:00:54 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm541156f8f.36.2026.06.02.10.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 10:00:54 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Tue, 02 Jun 2026 17:00:51 +0000
Subject: [PATCH v7 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-acpm-tmu-v7-5-8047dd54b0e9@linaro.org>
References: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
In-Reply-To: <20260602-acpm-tmu-v7-0-8047dd54b0e9@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: jyescas@google.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780419651; l=795;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=APjGOr4rSujMx24P1jDIzhjkfbHKcFK80a9vPvVqD0g=;
 b=QsERHNC8FPgbTJGtPPDB6Ya/u8jw2mBQU9wWAijdol1fz7fqN6OPrykn8Jo+GBpS1m9JE03oJ
 WGR8WbBY/QdD3cLTko3HsVqrkMKkglmTJ6fLlzdEnf7iZQhpjEYf6jB
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
to allow temperature monitoring and thermal management on Samsung
Exynos SoCs (like Google GS101), used on pixel phones.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d905a0777f93..3fe76a4c2633 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -793,6 +793,7 @@ CONFIG_BCM2711_THERMAL=m
 CONFIG_BCM2835_THERMAL=m
 CONFIG_BRCMSTB_THERMAL=m
 CONFIG_EXYNOS_THERMAL=y
+CONFIG_EXYNOS_ACPM_THERMAL=m
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_GENERIC_ADC_THERMAL=m

-- 
2.54.0.1013.g208068f2d8-goog

