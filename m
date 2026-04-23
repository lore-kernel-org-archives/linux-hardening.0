Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3136A02E
	for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776957787; cv=none; b=gfmPVwQs5R1jcS7irwqR0CjjU0LVIWUFMVgXHgqTU4e8V0dav/LU4LuWWtCBUNR2UrwaPgpj26eBUSav+1Wwxnls4u7jHYronpJ3gDmQVH5kuQrwkg6vRvo9Ld1G2pyESBXBsGX9W+5a60BfzVGQmrGlJAX+1vwUgUAOcQMuaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776957787; c=relaxed/simple;
	bh=gury5o9fYQVnz5W9CUhyVTJ47BHUwb3hn+iE10aL2Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cdh3ITwS5gOv6e1WiYvJRAC2R3fmbQMZEUsvxgemT+Fxz/4f0Z6RIVbpHlIo2/RSrNDni2DUbOVA0Q7zBVm4qgpCO0gK4tPacb+b01U2bQK48SzOaMtKCqNQ2V/6S2KcF9kvYqd5uF/z1JqOIabMKvjcfde7w3tEqnkanH0gcts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LgzzNB7J; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgzzNB7J"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48374014a77so88947375e9.3
        for <linux-hardening@vger.kernel.org>; Thu, 23 Apr 2026 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1776957781; x=1777562581; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JCThqhLH7NqPNtx6lIFMXhC0R0ZENSripHC9ZQYy5U=;
        b=LgzzNB7JBQu42//n6yFjQskEW1mXxvv5rt1e9kA9WYUUMar/kWtA2mKfxtJ/FQlWE8
         ZzIx50EliucmykkSWvWFQaJLJ73GhAIJe0amseF9vEPWwIYu0WcYSqfgicz8GBcJQ1oR
         JJ4mziBHE0jLsWXjDFurj9+FadSrulj8HSvCzq1hXHSGQzaUi9+S3VjubqQZwEIOku6Q
         ap1Y4CURWUbw3by80qgomRwqh0tbhaV3zksgqzMWgW5Vm59cHyHwiLAFWtAOISzZKi4F
         BANI/UKB2bvzwOnejjsJVgFqqtXAsx6SkGZlxwm7amLRD13P0v7Nx6IPtF8dW480C4Ms
         oIMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776957781; x=1777562581;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5JCThqhLH7NqPNtx6lIFMXhC0R0ZENSripHC9ZQYy5U=;
        b=TjdvTG/edkVzufA8SQVO+Y0DRN6arB085GJFSh+mbg2QDdgCYMZ2o2TtMjuhaLlGKZ
         TdqkTO38A+GJtPheFHKr7sykwLWgwgV7y6lLaX25sbkb5ozHspHGQ7ZeOEJmSNtoLkOl
         TTGEIMtUUX1FkLrYqowIhQbb11kTo0r3DXaWhXFawE4h3dc9vhxLIFJLPxYjCJiGy9xY
         EF5OtaFuZNmFkYPYcs951TUbCJvdxYkPzj4OkxDinsBY9UOQNFc6EMeGWsfWnzfd749n
         CTRuC/ZTitQIWPtDK6bdfN74kmii0tDqrbUTBeRnr7JGaY/GcWif2AV4BHRYqDKf4aEe
         EjUg==
X-Forwarded-Encrypted: i=1; AFNElJ83p77mCj0UDWqB0320+xZ+7S/1kZGo9NPZvpLEyT8PpaSk003hbZnKtv0RFKT4apfuOMcaD7bMsAiyqh30s6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX3nFbVAutBKYULbY101aS2Qy6w7DkPZmCWB1x1NNxgGx8819c
	CYulCh574jb37qLs8hFpJMRLqV/cHh8wJxYwX1Uvu9Cx5NQKx67rA7aGLV9DnDDOsvs=
X-Gm-Gg: AeBDievj4ZK8ohXLjMZPevGlrNLdwKCgaqafKD/Yg00pdopJD22DG2UORwzd7iOiwbx
	W6kWNrftWFNmYUohbxbAFdkcN6u9Wnqj1qoPJIYtjbqDkbWDAmrFjaTgULkt5egK6z/POSKyWQw
	wjW5/qbOBBFUkGJIFmTMayiFhF6IN4aOTISosNEVhiH5r+/UM4s52i9vp9ULntqIsZ4wO2MfDiP
	67x45sDApnJH9SyoeGQVfElErwMDca38VCOyQD5+LenAgy0d8kmn65ub7UYzPNBHvuiBavz8qpo
	Pt7Pb+wI3gR4IEpNlhRqOSlv2RFFmYs3bw1hn48p7qbqnLZkRLOSEK02dRy97/gHPArIWBB3Lkh
	FYmvWJ+EZOskDkeeEIjj5aIs/2ojvwPagt3RkJKXGFB6p0GHpxQHiPO6L0rOcQdribEoa8f8Ogp
	85Eh2cTs8vRtQxin0QLRKgh87uLs2WI1w/JmHyR05nMcYs7S8/vKc7JKrMBj1mcJJsV+S97/Zoa
	5y8zkniybVqWKtL7w==
X-Received: by 2002:a05:600c:8717:b0:48a:568f:ae6d with SMTP id 5b1f17b1804b1-48a568faffemr168084565e9.8.1776957780945;
        Thu, 23 Apr 2026 08:23:00 -0700 (PDT)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891f98728dsm90550755e9.23.2026.04.23.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 08:23:00 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Thu, 23 Apr 2026 15:22:51 +0000
Subject: [PATCH v4 03/11] firmware: samsung: acpm: Annotate rx_data->cmd
 with __counted_by_ptr
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-acpm-tmu-v4-3-8b59f8548634@linaro.org>
References: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
In-Reply-To: <20260423-acpm-tmu-v4-0-8b59f8548634@linaro.org>
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
 linux-clk@vger.kernel.org, Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776957778; l=2360;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=gury5o9fYQVnz5W9CUhyVTJ47BHUwb3hn+iE10aL2Hg=;
 b=rnq8EwtbRM8Uo4+EdwheI9WJInqZ2Ii7f76t+qs1T0eX1VEh7VaHRXuo3uQIS5mJhWB2Hl3W3
 K9JwcPUFqrTCwdeRp4V5y5l9W2cA/B6S/kY9D29yeAnF06612VjIT9V
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Rename the `n_cmd` member of `struct acpm_rx_data` to `cmdcnt` to
maintain consistent nomenclature across the driver (aligning with
`txcnt`, `rxcnt`, and transfer helpers).

With the member renamed, annotate the dynamically allocated `cmd`
pointer with the `__counted_by_ptr(cmdcnt)` macro to improve runtime
bounds checking.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/firmware/samsung/exynos-acpm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index c4aca61a63e4..e5c85d769d0a 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -103,12 +103,12 @@ struct acpm_queue {
  * struct acpm_rx_data - RX queue data.
  *
  * @cmd:	pointer to where the data shall be saved.
- * @n_cmd:	number of 32-bit commands.
+ * @cmdcnt:	allocated capacity of the @cmd buffer in 32-bit words.
  * @rxcnt:	expected length of the response in 32-bit words.
  */
 struct acpm_rx_data {
-	u32 *cmd;
-	size_t n_cmd;
+	u32 *cmd __counted_by_ptr(cmdcnt);
+	size_t cmdcnt;
 	size_t rxcnt;
 };
 
@@ -384,7 +384,7 @@ static void acpm_prepare_xfer(struct acpm_chan *achan,
 
 	/* Clear data for upcoming responses */
 	rx_data = &achan->rx_data[achan->seqnum - 1];
-	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->n_cmd);
+	memset(rx_data->cmd, 0, sizeof(*rx_data->cmd) * rx_data->cmdcnt);
 	/* zero means no response expected */
 	rx_data->rxcnt = xfer->rxcnt;
 
@@ -537,19 +537,19 @@ static int acpm_achan_alloc_cmds(struct acpm_chan *achan)
 {
 	struct device *dev = achan->acpm->dev;
 	struct acpm_rx_data *rx_data;
-	size_t cmd_size, n_cmd;
+	size_t cmd_size, cmdcnt;
 	int i;
 
 	if (achan->mlen == 0)
 		return 0;
 
 	cmd_size = sizeof(*(achan->rx_data[0].cmd));
-	n_cmd = DIV_ROUND_UP_ULL(achan->mlen, cmd_size);
+	cmdcnt = DIV_ROUND_UP_ULL(achan->mlen, cmd_size);
 
 	for (i = 0; i < ACPM_SEQNUM_MAX; i++) {
 		rx_data = &achan->rx_data[i];
-		rx_data->n_cmd = n_cmd;
-		rx_data->cmd = devm_kcalloc(dev, n_cmd, cmd_size, GFP_KERNEL);
+		rx_data->cmdcnt = cmdcnt;
+		rx_data->cmd = devm_kcalloc(dev, cmdcnt, cmd_size, GFP_KERNEL);
 		if (!rx_data->cmd)
 			return -ENOMEM;
 	}

-- 
2.54.0.545.g6539524ca2-goog

