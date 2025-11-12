Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB233B6F3
	for <linux-hardening@vger.kernel.org>; Wed, 12 Nov 2025 13:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955757; cv=none; b=SkbC6M/rYPdYlEb8PJ36cgd80NM4sQPyGfBOl5g4McsDNXmflPG0+mVSe2ONrqwY7mwy/eloBwp4lYLq17vHfZ8twL07hjdmlrLb+4zwEKfvViW/3GOhBMLLij0aYg+mkgw2yM9B0DL03TQPCjzWphV3pGdjHJ2TuHwjiTmt5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955757; c=relaxed/simple;
	bh=gq2GeWwtoAxhgReAyByCwNLWKfgCp2mKBgj6Rr+H1s0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=piW2YfRCBM0W0MH39+M50fl25O3RcLcKdul6ZTpsRaZIlnzq8dS3D7rvqij+oIjmm0lvnSJJsFQanRN/TN7HnOtYoCgV2AMvNMDwEDStm0sBuuRENgAhrDYr0z7wDYmqa3gjT1BRUcMUn5ni9qGukZ0GR50wW0NEj5MmbXq+K+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EW2Ixc4B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EW2Ixc4B"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47777000dadso6186935e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 12 Nov 2025 05:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762955754; x=1763560554; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pibor61VRuWGPDBSUEX8Qfx5NaK+JEoulBZiwQw9G1A=;
        b=EW2Ixc4BwrTuFUmr336IYp/JLy1njBjVs/2gKeXYa/JjNNBYEIU/T6i4V6fNxTnFfV
         1VrevNb2NbSx1gswcEDiGMYI6I51RZNSt0dJnvc/qSDSrgNI8pximJF7LgU5LMSZlNdv
         9TUAiFvKKuq38EZ78AepQZnHpdrNIo9Ve/c1NDgeiRGV4VgbCwaPW/lpne3O/dCTArYW
         CRnPejwOVLhTWJvBOESt+hGoh54oXUhGXgfULUc3ByLiRQBIpbUpALpQ3PTlGqKOG/mP
         fzeqkQPv4HfTFBhHDes++lScXwKBkTtR9yZ74axbuyuDF8eLBfnG9q5RWvXn8aBf5xlo
         Hn/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955754; x=1763560554;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pibor61VRuWGPDBSUEX8Qfx5NaK+JEoulBZiwQw9G1A=;
        b=gqN7PUJtpc52m2LW1E/kmBP2Bgf9w0zI0T4hjTbOtilapYucZMgqzC6wtuzWHxqvmt
         SyC44rn8ZOPPby4yeFqFXJM8VDnxPYR6yCki6uDwopeePmRsbYx0+lcHDUR/PIFstCEf
         SkUkEc/T4HU5/N4Sx8o0zrHage+kq4QRsTb5fugbGLMvGQStJvOqJDgoH3ZvSTvkMsCr
         e7en2sH0VKSzU54TmTarlM49C/LAnKU/yl+TPb2BluIhEUFNQ+ykDLFnBYeHIjE+2s8r
         yTZtGWDczobGroq2cjzgh97wCscNJuv5VSWzFiBZxOBr85A8YZ6tk2azMNIqBhmcWdbI
         z/KA==
X-Gm-Message-State: AOJu0YyglZYUtWl79iD/I9A1H7qAbYq1f3UMiP/ODP0Yk9Bhlx0sga0J
	smgQtcPkwZ7Vrf1nNiI4a71SfMNO7NUp/OaR6C87AQe/vHlXLhL3HXvDEK5tqp90fxs=
X-Gm-Gg: ASbGncsdsLBE4cdIXx6vur67TFN6OJVV+5qWOUZrF8d/1oEO6bHGMrsYMny6xvy3DKv
	NVkrebqkVlDJr5vn9cG39nsmu3UxJZp4NtkrjkZkHuT648MDKqGC8Z8K4MNY2KQyhbKlfsDBAtX
	1GiBfnxZgFjSqJTc6l/hyyWAcH5CMGzJ4XdVYrJAluVSW3Ak5ls5YcuMqaejsGvRDHo6nmINkUc
	mR5cAx/9fYvyL8u62datEIdnX+soH1IdSG3CLFtijgKDVP14tJWSTdH/Zc2Pnl4c24XDIn7cU+j
	8Est50CXZIhs8jW7dM94/+yRtO4o3/qsUhiZF8KyKPLM5MwekYPepnsDL5bTl/tqDDt0mxgkwNI
	2qDORxb7ks9z3/pqtFnHna8dC67miGkZD0K1TfUywP/jVMQrZH9YEaQW7TTDGbExBNkg=
X-Google-Smtp-Source: AGHT+IEtvSDyr11LVdJoG53McXc+mzSebCMpeiLoCNayskXzc1xY0qsvnUscd2uSM6nTy0CesNazMg==
X-Received: by 2002:a05:600c:4e8d:b0:477:7f4a:44b4 with SMTP id 5b1f17b1804b1-4778703cdaemr25638175e9.1.1762955754244;
        Wed, 12 Nov 2025 05:55:54 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2a6:e453:42d3:11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2b835sm37711685e9.2.2025.11.12.05.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:55:53 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 14:55:38 +0100
Subject: [PATCH v4 09/10] ASoC: wsa883x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
 flag from GPIO lookup
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-gpio-shared-v4-9-b51f97b1abd8@linaro.org>
References: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
In-Reply-To: <20251112-gpio-shared-v4-0-b51f97b1abd8@linaro.org>
To: Kees Cook <kees@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Alexey Klimov <alexey.klimov@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=J7wcxqH1nXBAkgczyumTwaJPo/9guzjHl7eS3CVDzWM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpFJHXOMadQXWhgF6RsrQC4lofPJXam1qmr5aWm
 Pv+ZdgkgLOJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRSR1wAKCRAFnS7L/zaE
 w9oND/9B2TQibJiQ94fYo4sg5Jc7PIXazrwBZOKxEffUtu865Wr3sHOIb73g/CPdrof6sPFX87v
 tJ0WbOpt1U5fnlUW9N7Ti8lheKmnC5fnqcb4NF/Jo6BLAQdt1VZb3rafkaYKEc2HwLY+cfjJiLn
 +qCNG0p8aDajzp9CfgiKwE8nR0GF1vo6Q4FOIQ3LHa5h0Bjg0QGN98IJYYBHLAVa9QSwra3jKWG
 TJgxLXTg8fIIvmheLbwstNvrAMB7f+0VqIWjSX0H7Ziv9BFtuW+hC9MrZO1u9jGdO/ch5l3/vaV
 LH2hcTM8yiAB3y3fQ+q6ilhh+PRLZNGMoGjCgthQyYi6gzW7/vs7m7iEazsevP/J//jUow58aq0
 jWQrwo01pMpuPp9NCQeRFfhoSlZhG7ct01F90PFKzWgzOkMU7Iw6NXtMF4x/0cmowzP1biWGG2D
 lPJEu7u6BrWuM6gTF6qxoYeNaA5EMECi5SF1keLY2ETkdQskHBsVSknhAg3QUIepSbjIGghr2Zb
 zVzumI7YOFBI6YF/DpPETCLtQ054rpVXLhhcbTGieGU0a8CI3a7S3sgLeo17uaRW4GUbirB+w/G
 ZhTwfaA4DIN+3Zw30zSAWpFkLgJSiwRHA7DQOlip2dpFLaN8V/XeLyMhfsR9krtKjBdB8F+1fkU
 b7r1+CMpTEED/sg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver is only used on Qualcomm platforms which now select
HAVE_SHARED_GPIOS so this flag can be dropped.

Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 sound/soc/codecs/wsa883x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 96dd66c4b88dea34f1f24bed4d5ab66d3e2249ae..c3046e260cb958296a41b78b545f1ac7f377a968 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1572,13 +1572,10 @@ static int wsa883x_get_reset(struct device *dev, struct wsa883x_priv *wsa883x)
 	if (IS_ERR(wsa883x->sd_reset))
 		return dev_err_probe(dev, PTR_ERR(wsa883x->sd_reset),
 				     "Failed to get reset\n");
-	/*
-	 * if sd_reset: NULL, so use the backwards compatible way for powerdown-gpios,
-	 * which does not handle sharing GPIO properly.
-	 */
+
+	 /* if sd_reset: NULL, so use the backwards compatible way for powerdown-gpios */
 	if (!wsa883x->sd_reset) {
 		wsa883x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-							GPIOD_FLAGS_BIT_NONEXCLUSIVE |
 							GPIOD_OUT_HIGH);
 		if (IS_ERR(wsa883x->sd_n))
 			return dev_err_probe(dev, PTR_ERR(wsa883x->sd_n),

-- 
2.51.0

