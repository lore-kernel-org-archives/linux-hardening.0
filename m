Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9C338331A
	for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779713437; cv=none; b=cU6vre00KekKGJZ/l3CQYX7TxiDAKvmoyl7n+Bo3E4EGs/2Jx1cCCfGLy/o5bkWQhN1+RN2u6WrQnE7NlWH1fRSX3qaNadr7jQdA2+8rVuw5cMszcZYINbb/7iHA1JdCOSXj9KU9C8ltCpAq8bPhQnwrvKUM4zZgVMHnlaqdmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779713437; c=relaxed/simple;
	bh=0Frkhb5ER+1m5KgNQbdP8ycXkPjLHDxA2xf3r2hyTAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BLEOxG94v5uGb/31UXKqi6YyY83zq01L8HPUQaKkzLFpqM0PGIQ4Iuv6E/N1Zyo8E/I477uyt84cWuU5VQ78iXh353fCYX+viSbaax7SQOkPXPi2a1O3FIswyHLiwWxHuWHaIY+2w/kb9ADPN02bXgKLOjFCWYUljrYnMdDBvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yIxY8eQv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yIxY8eQv"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso59251965e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 25 May 2026 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779713433; x=1780318233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5TsR1mX2wHDSgzQPfx51FzMucuFNRcZzEimrpeG8plE=;
        b=yIxY8eQv1zNZpTK9cX+t+xCVFvAIkajwDUJOEOPxmSg4NUh5fd2UjGCwvS50qsx9sw
         NZykrXPFGScTThOGNFFpUHKqCxPBqzxNY9LLh6utBzoh29FLkJxqLrlPdZd3uzwl0ad/
         zUK41dZ20AXxm/ZI0nBACI149mT09fQCBXjjlFicscuO6HhmktldWp+89jsqo2XWe1im
         Zh/TPDEeeySU9DSWusWnCNmFDrVTtguPl0NvmDIFmTYRu9OxZUxuNCeVSafu9RK53VBJ
         DwfnVJ1v9tgmY0YVoMVLwy3s9w6z1/9mwop91DoydcXpaHGh0yn2LCquwXD/hmfCu+K/
         Ebyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779713433; x=1780318233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5TsR1mX2wHDSgzQPfx51FzMucuFNRcZzEimrpeG8plE=;
        b=AYKETVTvJpdacN+Bl+oikilPVKGsdZfzKRKBYRVVwBM1szHfp8Y6k0aGT8edM2q0lJ
         kP3STol5HAyR3Uy9uFplhF5Ewow2t24dS2Q5BzNa+z3hE3+v8bDnI2l1jhpK1Ac855vU
         KgkfMrB5AojU74bD2hS+U2PTcRpxYv4QUH/JEid8fo7n7QLxOFphhEJG848P2Xov0Kfh
         2i2TKmQiIEQbb4oUgTNgwwqRG16H7sgrKTOgs12+sWhSvAEfRi1AcLVa+9frNFPwSmMl
         HXmo37a1wvpFPdOU8VrXNSvHwjRf+PLe79GRv6Vb8JLrGy8eSHOeQYP2icLOMvyzZzZY
         YKOg==
X-Forwarded-Encrypted: i=1; AFNElJ8S8CRj1yAhOAicBCBVBuzvWeEuuMebzB7/31v5/P8bvFrku9KVd00cATXHdRhpX322WUJQyOy9vX585o9akE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjnlbT91Fb7sWG0uqukSvrPI4NvEPKaWSMR+AN221yAHgT2K0
	1hh5bu4kuvPkW1WdOlntiA/ioqbmrllB4g7TD0Nmd0WUhYHI7j//sdP6ayAw2G2abSQ=
X-Gm-Gg: Acq92OFG1DGZcem0W1gAoTj0jpENP/IrXmbjIpkF8hD8Pke/VXgUKMFalagCTMPRNVh
	FzXQyNfDpic7FKSbNFCBV3FvLZ9YC5X4DNKfozkbiD7II+JFTWqzowmkN+YHCBE41MM3Z7YPaqR
	U+GWSd6dEzE/lOq39PAZ9UsfXOc/qHJP4u2psVMjLTX8v1gX1FJ6x5EMC0we03PpbMazq2okzXR
	XsvpddiibWDklxVfOlG+BBhBLEHaK5PnM+M/2gsxEsNe3ajjKtyZJp6pI0SvZOiswN79EEeliCb
	r+NLKS81XZ6xLmQCZO+YjU4z7TTshlQvjv4bbrDW0+4cyBI+VdWWoqZqmQ8VisWzxTMFxmDyp3b
	IJvRtO8laCbkmV6rOBDqyXKqsTZI6pPNy+44+8Sw0YKgE1vk19X5akHfKlvFnIGz/NXzgDues6P
	DfFv8JXylrG1akWltyV48pxLo2sQEQl2/sUqUqcQ0bccK7VmQYf6BvZRIC28OBfsFeIkDuK4KFZ
	2MwwDcXxLlUfLvK+w==
X-Received: by 2002:a05:600c:a30d:b0:48e:5d91:cfe3 with SMTP id 5b1f17b1804b1-490424ac7bcmr173716725e9.1.1779713433180;
        Mon, 25 May 2026 05:50:33 -0700 (PDT)
Received: from ta2.c.googlers.com (231.141.38.34.bc.googleusercontent.com. [34.38.141.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454cfcaesm241824825e9.4.2026.05.25.05.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 05:50:32 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 25 May 2026 12:50:25 +0000
Subject: [PATCH v5 5/5] arm64: defconfig: enable Exynos ACPM thermal
 support
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-acpm-tmu-v5-5-85fde739752e@linaro.org>
References: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
In-Reply-To: <20260525-acpm-tmu-v5-0-85fde739752e@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779713428; l=812;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=0Frkhb5ER+1m5KgNQbdP8ycXkPjLHDxA2xf3r2hyTAM=;
 b=ysDvGnb5sGnYo8XyHtqcLtMEVBuxYqkwONOnmQLPxdEJXX+Z8JRyBK2v1SJeQkFgvjbrITrcE
 +ypUtdm16g9B+l1i2lE9lC28ZQzQWSfcXVHHHo8co3aVihoSxuORly3
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the Exynos ACPM thermal driver (CONFIG_EXYNOS_ACPM_THERMAL)
to allow temperature monitoring and thermal management on Samsung
Exynos SoCs that use the Alive Clock and Power Manager (ACPM)
protocol.

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
2.54.0.746.g67dd491aae-goog

