Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35033D6C8
	for <linux-hardening@vger.kernel.org>; Wed, 12 Nov 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955761; cv=none; b=QiQgZPM47ZLCHhOJWrpWav1zc+Vc/E4VdCluT2wj2iUMKrnRQhaC/OMZEkLcnPmW6gxowd7YkynZrnKvTZS8n0CH3QNHKCPZQLYRLZJxIa8+CZRQEwoHGqftDP5Ugu8U4E5C05Q6Z1YzadHC4NPR7KBLpFHkAiiOL5q8k70ysRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955761; c=relaxed/simple;
	bh=Ws7WZR2jJQBsUjKHfWRA1LnGQPkf3K7KRf54zRBU9aU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bdemLJXZ+zogUGnqQuqOVOcAkq70/A3OCiPmnH6cexMRLhhhbGjde4iXPLzgDfhKRli6bX5tIQVwbghqWwMRwYQK9nQk2Xa8/gExSsZrdyp14Ye3mdD3yp1TjciCjndqd+RjYg3RlwRk5Eyu8XvBDnUVu8uQMub9pcKiOE71GO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=vtD1s5Rd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="vtD1s5Rd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so4905325e9.3
        for <linux-hardening@vger.kernel.org>; Wed, 12 Nov 2025 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1762955757; x=1763560557; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kp0FmiCJj71Jl4oZffl9a+Nd4P6twEmX35nVwvd5KFA=;
        b=vtD1s5RdxaI/rWrQIEp0qKscCVOtMbZEGAhFkriFxjO6Ie5U7cgtLb+Y0BSKmHlQRu
         5huKbwDTk5dyOIjdEohzuL6NVCFdOiwXuuYw1AehKo8Oc2noy/92GXW5/bZRrdwzVatj
         tN4xFzYAFS+3fumCB5qR6FO4zTiTdjwBSjKU3QT9GzTyextCn/4AoDIMZJSn0ib3YMWI
         wgUt9decgidFF8k2LuvQkBrcb7pHpkdiYiRwxBrSyf/VTMVeey2GYmo1JOG11odZUrW0
         O++/QKmEqsytsCcdRLPW3K2uKEHZCqTK6+S3KalLanUeljLwCab7BbBaUk87y9z+QBbl
         yxaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955757; x=1763560557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kp0FmiCJj71Jl4oZffl9a+Nd4P6twEmX35nVwvd5KFA=;
        b=DzAXoxWTFwvdwcYkEFoP7QEVcZi9K3AfzD9Up8hXdcDgoiAtXAaUhkLcaSC/2BooDY
         pV8Y0Bqhs9pdiF5eXj5xFbLjyzJ3qBeAiSFIJhHhDVNEHilcgo0FTLlSGsIjl2XGBtWm
         F8xNJ5FRcG+gg6X6XxUn5W/YE3We5Ft8YQ09XzVkNiC7ilNf2j67bRfSuK/DTMOHsFdK
         K2119PA0BYiYZpDMJhq+w+Ot5oLLe9YzcyE1vRxIoPoZ/UrWIJGoJGNfbHrs3U9egRG0
         dU8s8xSGcr02Pg6E2y0PZWc4srkKxCtXFcosWDNhgZp0wU1OKZIz6vW+kZCDWaem0xYN
         wPOw==
X-Gm-Message-State: AOJu0YzOuyw+NCdQoeQVJlTraLwSxcl8YSAYwfgIkSAK2oNPXYd/1eSy
	xgoX39kKTzJxC0iFpqo2YStqWDvrtZVd2uzr/jSM1aDHKOjCuSKXEMBJKQUWE4/wzm4=
X-Gm-Gg: ASbGncvzocosin9FhUcpVYD2t6uE8ckxV6t8T4yA/UMMz8qUi3jD0IkSqyYmnWStbUQ
	AzG/FnJHMHpmlNdcm9oVrLPVJO0fbNi42uNEl3OTWnPsLrPcUN/T0O2DP5LrdpKc/CpPag7pbtU
	1lzMEKvctSCjPdURBRa19Gw2i2zyZCIzQj/iT3UaBAs37MYMDPoVPV+JTGFzrRg2EV711Iw6wHR
	iFx97qsE1Et/T03uvfM8JE2Q/Azo+qouC1qZ3G8lBV7hk9Q09CZM8e7+QH50fPjWovhsUJOsNde
	8GspAicI76EUEftks1Qmd6fFMZMFMmVxWMqrNYSk9tCVSu1Jn8hSq34wEQ99+j/djYmvlte8P+Q
	bzHve/opNgA7sXjNfhlnyXHw26Am72RHFhYXEtiEM/IVqM7djZs1x7tohnrLhXPC6MoQ=
X-Google-Smtp-Source: AGHT+IG9voS48hdT+xBkoQt9DZv1hKYOn+kmcoFvvCmGnWxQyhCTGn6OKWMid0l6AgV8010JdBsVyg==
X-Received: by 2002:a05:600c:1c0f:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-477870c32a9mr35632365e9.30.1762955756833;
        Wed, 12 Nov 2025 05:55:56 -0800 (PST)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:2a6:e453:42d3:11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e2b835sm37711685e9.2.2025.11.12.05.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 05:55:55 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 12 Nov 2025 14:55:39 +0100
Subject: [PATCH v4 10/10] regulator: make the subsystem aware of shared
 GPIOs
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-gpio-shared-v4-10-b51f97b1abd8@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1453;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=cRJh4UNEG3HFtyWkN4hxt+/hsKQWJv1/Ds8BXH+v1q0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpFJHYk7DEi8vVcJ8C6Jm2yEHPJBGM9iGwZrEld
 QRXIbLOz+iJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaRSR2AAKCRAFnS7L/zaE
 w5z8D/0TLxRCfJwRygeJ86VvClZB7uM7J1J7NnDKtg4UUs56/PXpS0p9l9x6HrZCLCmXiKCXC6S
 rZimvHSWFvMB+C5AzBTweR/w8AU/dwfANLNHEFQo+iD3CLl9eCDO5S4D3mTH+GpDffO431DA2ra
 NV8XBbpp+4Bo/za49Zr9H2ob40gyv6LMnx0JdjauTBGDkdzOzFrNNOwnVCFn/teRwYxnFj/xFrN
 4GP5pbDAURlG/xIMeu9nKdruuD3lEP3b6bQYe/eYqZeHosVGYr7NPr0onVW2wJHG/RzQefqOWOH
 ABURXDvkqFhKu+lb6wia8HbWw+RyjHT672anUmCEfXDZ9LM0nquoSFzeaiN7Jf6cK/jbKzPIlvC
 Ps2AYAZ1GqYqxYwpwn1rZnnBc0OrBt1a58lr5tBW0hKn/7yuvMJrkWbuXj0BttD3FNhif/16siA
 lttnkrbLgbYY0YjPKMPkbEjdJWESGR7zBrNDC2Va507fkTnxZ2Phqf/lxwNF2PfVO1PzwnBZoSc
 CmG3UEV6uBjSgz2CaPMSPEypNdH4WPIeC1t4kRTUWEWsGV4cHpnmh4BBtCS7l/clKFHd9kYjfhf
 ic0J3okXXIW6QgaD1f5jyr+g5oh5qRFfMovbUX6XdJOev5b4Rh8yx/EQPfOmlJUsw+FnPZDBf0p
 o27rB4fzdQATFGg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIOLIB is now aware of shared GPIOs and - for platforms where access to
such pins is managed internally - we don't need to keep track of the
enable count.

Once all users in the kernel switch to using the new mechanism, we'll be
able to drop the internal counting of users from the regulator code.

Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/regulator/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2eab56df042e6b05abf0989f425dc161c7b0e66d..53b2b2d3746f9f2419234912d49bd8b4f21a893d 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2742,6 +2742,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 
 	mutex_lock(&regulator_list_mutex);
 
+	if (gpiod_is_shared(gpiod))
+		/*
+		 * The sharing of this GPIO pin is managed internally by
+		 * GPIOLIB. We don't need to keep track of its enable count.
+		 */
+		goto skip_compare;
+
 	list_for_each_entry(pin, &regulator_ena_gpio_list, list) {
 		if (gpiod_is_equal(pin->gpiod, gpiod)) {
 			rdev_dbg(rdev, "GPIO is already used\n");
@@ -2754,6 +2761,7 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 		return -ENOMEM;
 	}
 
+skip_compare:
 	pin = new_pin;
 	new_pin = NULL;
 

-- 
2.51.0

