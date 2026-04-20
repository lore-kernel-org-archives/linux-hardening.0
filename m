Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12F3A784D
	for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 17:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776706819; cv=none; b=Vtd0NBEJqByzIPASgWcvEh5QW15PgG0zUqj2IQ9ajPM+3ye+SSZd+uX6MvHAAqttxd1hdnFCGF2nBctN1OoF9kKR95NAXRWcmCJisX4h4ySaFFIcnNUgRuPKD7chajKc+YqXEBxIXIW/G6cb/3dBNpk9TOZwQ1+Jt2cTm45Eau4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776706819; c=relaxed/simple;
	bh=utGmC6SX1f1tsmdJMtEQdtOxlDLzgsEsYQAYl4X2W/0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6DitTkxz0RAO54Y/MI4zX7czC3QC2c2cVJEvMeSAnUVEcyJWOUFmJsdrSG5tEZu6yo4uIYUrOrN3x+5MsYUHkDsAsI7INtyl9X6t0WXBWxvQTR/GPCNoC1HoVRCpi7VMu4sjTxJAOjKAF3kNIRiK2BBr51QqbnlRQDc44ktdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sDnjBrPB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDnjBrPB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891b0786beso12238855e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776706811; x=1777311611; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=majqoFYlSL/xq0vEC9MR4HUJoBMpHEo2idjyzWrGGo4=;
        b=sDnjBrPB/7kBQUTlQHDyyMfhRibaGFCdQDG1TqlPH7QPloyKH/5o28pLAncaD5/zOy
         Vdw3QuwL4ht704Vh8XhjBdEgAoR1B/UopTGLC44rWAUSi8MPLwuxBYNNiI9qMzS8EB5U
         1VCNhIyUeJwy8d3wRAXeZmI2tAU9jst1uRDcWtTW5o6d65KaHFMZomtKMXcsPgl+Wn3u
         FT5EkZNr7J+4H4yT7onza0IUVPFiEDuQaTC9UeANDutohl3Vhj0ksv+N98B36CbrVTOs
         MhssuUb3gjcb689XNsYf5+8WSt8/6RndynAYKMsHs/e0UXwkzgr4PT8mDwK9QbpvP9Gj
         zMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776706811; x=1777311611;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=majqoFYlSL/xq0vEC9MR4HUJoBMpHEo2idjyzWrGGo4=;
        b=cPwQ95pJpmH9WAc8/ywda/E4+JmzMRtN2R+MKNe7qAw+oJzOwOAEYiLu+ttW+fJ8PK
         4yb9qp6whL6+wYrAV9UQV+nORxvd1qGGdbINmVG0fxzyU8eZHrMimtrVm9zMrPjR62OA
         gpdtYYAh3Zew68Uo6vcH8zGoQOOVAiWt8Woq+J+GrnyQBI7fq+BXOwdPtNMW8TFnt4Bh
         DKINKTuZ1fP4wfbmWHD9YRM9kHl240Nh8IjJ1pQv+5MeP59IrCOD52W/wqWsCn4LQvv4
         Jm9FQjecyZteMirSdWsxe+hTjiKL9mtsRjrt3ttQlbNTVXREGFFO99kx6YjG/UD23G5C
         8FiA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZW1jFYYSecOoxD52dyW2SY34JwD62sZCP3rGaABl8+kOE5QMgQkP8+p0PALErK7NQqbkP9Nr0Wn5Yu4OmThY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNZqOZo3xzwTXqPNSvpImbm3/OjaIDWRAvi+suj8QV8mnlNbGk
	V/RzVyGa3vNvaqYUzQ/Xeq7ZLgN9ilqsKR0LYipo0PkXdQAKpGe6tRvb/fCO8aPNMY0=
X-Gm-Gg: AeBDieuP4wFbMIoiENXCrj7lFk0qdtwmwLVEsb1SSfPR+k19WjgSZasQUiTN8tE46gc
	1krxkeANI8vf9yf/ndpdhEsS7WvswdBwNI4iYWMQD5isFS8bJHFX6+zkJH9LALsPhQWBMJLR9sD
	3P1gqfYd9Z8+X8wH3n7uuHTUlg+1ZQOQpJc5TykFrcl4RnPTtxXCAlr8o8YSL5Wv8l5ojxELWKu
	d9sqLdi9I9+kuuU5gOM3BVf4qgKLdYPUULeZwbVyZSw9kEJ5gAnx58+bTZOiezfFb4xjobXCfLl
	aVqDr1E7gMCHIw7D1pzpKmmWbGXB+YSsooiQQbqYT9nUw5PMWZwvG2me+5jDc0MsU43xlCJSEE4
	JKE3gHw5nn919SN8z3oAtLQB+hBZJVIYV8rh2Uh0iYIOwmUqdoXgmf8UnS+/aD0GcLy/KgE+hSC
	rHldPg7SMKvLDysl7jTvIF9kTq5IN6AfDvxWci22Z743jYwQKM4oTpmEnwQ1N1sYe1+xC7/eO6d
	eLY7wFa/khBPRE2hw==
X-Received: by 2002:a05:600c:4f13:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-4891a65de3emr95027985e9.8.1776706810700;
        Mon, 20 Apr 2026 10:40:10 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb72d365sm144280285e9.1.2026.04.20.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 10:40:10 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 20 Apr 2026 17:39:54 +0000
Subject: [PATCH v3 08/10] MAINTAINERS: Add entry for Samsung Exynos ACPM
 thermal driver
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-acpm-tmu-v3-8-3dc8e93f0b26@linaro.org>
References: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
In-Reply-To: <20260420-acpm-tmu-v3-0-3dc8e93f0b26@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lee Jones <lee@kernel.org>
Cc: willmcvicker@google.com, jyescas@google.com, shin.son@samsung.com, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776706804; l=992;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=utGmC6SX1f1tsmdJMtEQdtOxlDLzgsEsYQAYl4X2W/0=;
 b=ksF38PEKxEj8F8BXFtqnkVgT2aWgmm/cCh2qiLZZuahhGr02+y1RNkzFa4rchgDi3llZx0f89
 UBd/cw0V2JDB3Hr3mS1DuYCTqeAFm4+ZK/GDr40q1GekCyBRI6bSKdj
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Add a MAINTAINERS entry for the Samsung Exynos ACPM thermal driver.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 76d8291237be..fa67f6f449a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23676,6 +23676,14 @@ F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 
+SAMSUNG EXYNOS ACPM THERMAL DRIVER
+M:	Tudor Ambarus <tudor.ambarus@linaro.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-samsung-soc@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/thermal/google,gs101-tmu-top.yaml
+F:	drivers/thermal/samsung/acpm-tmu.c
+
 SAMSUNG EXYNOS MAILBOX DRIVER
 M:	Tudor Ambarus <tudor.ambarus@linaro.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.54.0.rc1.555.g9c883467ad-goog

