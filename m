Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624BF31B830
	for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725536; cv=none; b=Wpvz6LBL+fGjOK7I+1N9dDzmZIXAvvcXWAjF8+SgtQ+JcH5dhmGeo468wgAurzUZqH8y4Fc50ZgB2uryXEX+7Wkn9ZAxSYG8qmSKYoRnRugtPW+8Ws5SbivN0LuhqEqbBvhqfaT/dAjn7Pn+e6r1xamgY+wg0xTS0KH1hXNJ6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725536; c=relaxed/simple;
	bh=o3clotEVXCzqMxW1qJk3uiRPSq6aP6WSAmpPzr7h58A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDY4BU91ucr2qn50fXtq06mKccsLPHGeCqvGg4Gj6XFHeZpTE2pr8cgLoA/uoXkE3W3sG1WAWdPRBPVN9ALxcQpAYzNRrrTNviW3ljfiHngk7vzgiSvj743B9FpZDp7m4xM65b9StA3/j7THbuxTyLi/UWA9qUxB4xjJ7Qz/gqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LX6tj7XB; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LX6tj7XB"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee13baf2e1so5210629f8f.3
        for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 07:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758725530; x=1759330330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSTA3g5ank1TH+h8Aobptwj96daqy8jbcBAobAq2Oqo=;
        b=LX6tj7XBbF5A94cSXoUra3tvkYB/nhISdHqZajinQsqjWNgX1NCPsQ6I5XSIpUVoQH
         VMPg4q7SPPujwN5mUrKvGoHSRUmtIG8+rI6oXDwWIjhWAYEWVyJN50nzKfwpWZ7Ou+TK
         xsoARAANfZxb0l1+xIVzRglq7A7li646FL96KRzunURr4LJsBs5QcSlalj7rFjUBg42O
         V4oazIwK5gPOQpjl0xz8Rw2mN/hv1kY5sNfb3Q9a6er8Es6aCEB4gde3F6sA5ZLR9ZC2
         HQo56A7goh8MxExvMpfNMmTRYjgTa5E6g7WAIgywV79rsjAXNp8CctOsT9KLlIH4xou+
         bIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725530; x=1759330330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JSTA3g5ank1TH+h8Aobptwj96daqy8jbcBAobAq2Oqo=;
        b=Vq9wnIyoHtWd865E5Tlbzg2BDnBkIQHqjCFtvZ12TC+CcHftmvFd7fmQJK2C/CQVgs
         5YbuSw1MzxVcVoz8l5sf00ZEOvE3xC04jtGitEIFEO/hy72urEyHRD+MNmRBaY+DyT+S
         WNg2P8j4JpCsAD8rhsg6RUiginjpYa45bnHuRAWGkdEH52i9OtbBcdG/8GT8IbBzN2ye
         c6fS1JbOU0W97I2torNwQNrQU53zgLRnVK3y5pZT5z4tlTbl6R+6vegzwms/X8A+9CFV
         g3W9cDLKBfeqmlztFJ7ZSCc8ZsTXXffBwgcurZRabJtCfEM3Fwo0WCO7MAo8kwH0ooqQ
         VhKw==
X-Gm-Message-State: AOJu0YxKfMcyyM7JW+kikdWV/PKrolWXnRg1TR7bSVzA5GbYwgeI8DVu
	JZhdIT84IYVkUdiIyXVuSdFPeX171vjqxj4W7m6XWRE7l+wYm96gGFeddsGsxpUFWY8mj9QZkBS
	64gDSHtGMHw==
X-Gm-Gg: ASbGnctRnm0Txq/mY4MX7wl29Ic6Hznz4x3VTm+vXtR48pPSoLpXvu9KwZUnb/BTfTQ
	W3xuGuRo/aebJUoB9AwEeR7Exmf74nAQdxVIDVgO/CoBaYUK97C17hDA7iqUB6kfHYsJxP2GRSf
	ckmoB2YVhhZV9raWKNtEgu3LdHUrr+uVjZvbykhfEafEuDolQHtSdv44oaoV7Z7trN8rHatdUzQ
	uo6R5FScjWlfOe1MVa4Mx3vCqhBSHJvarhCmX74wnee0zartoPzcqqWay7hhpiLjy+OKGUqT8RI
	oo9ibGnw5jQ7ukEzH4WVl4jKXZUdD5mCUqSpQ5S35OHCE7n/C6cFGwyVPZVBWqOsRsKMu1HjM+u
	t1RuFvLWFSVKw6hyPC6bvik21e+rd
X-Google-Smtp-Source: AGHT+IHo7hPpbL4ZM5xq7bjjRM9vk1iuX0jyZL5Qov4depu+7BABKiS+a1RzqJgCrKv8lOkO/9BmkA==
X-Received: by 2002:a05:6000:26ce:b0:3ee:15b4:8470 with SMTP id ffacd0b85a97d-40e4be0c962mr219796f8f.45.1758725530045;
        Wed, 24 Sep 2025 07:52:10 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm29514750f8f.37.2025.09.24.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:52:08 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Sep 2025 16:51:36 +0200
Subject: [PATCH RFC 8/9] ASoC: wsa881x: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
 flag from GPIO lookup
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-gpio-shared-v1-8-775e7efeb1a3@linaro.org>
References: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
In-Reply-To: <20250924-gpio-shared-v1-0-775e7efeb1a3@linaro.org>
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
 Takashi Iwai <tiwai@suse.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=vspstOLquen8UYYEalfT4SF6xCukX3qfgdJchdoYapg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo1AWGMBU259VWbLUFQV6SPSQ1mCX0iBW23guMa
 VXKoI+zVNmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNQFhgAKCRARpy6gFHHX
 cvj7EADf10cfXI03PODvy6iln82xUiPu89UJlugKSbbUiWCkjYBUDIBAkVerwrnChTfbjHklBlo
 QUwiI+HkzY/nBc0LJyuNwptKpjTuk0LrX+T08cIKUntvoXc9WetrGMPVFQ321J1SApioK1TqDtN
 eoGSM3XqRfRMsDAVYZlSCbq80fpyJMFlhljP/c8+obGy4YZwce6bthnE3ybROshaTXJcP3gTINk
 95vvtfxAr+pRCqipNgqPcbeX3oLJbZ/MVQZC5mEj+2xSCwkYJKXrkXHB2aae20UeTJZHfYaqSvC
 H2DOs/6NLW6ml/KfZjRvfjfaA+VTqD7cn4iV7/PtDDLkCvcamm/OA+lQ07D61TF1I8M9bUVbn5u
 A21uSs++ScVL6XfDunZtHE75ylZXpRIp6VZ866ltMYEjWd1FKnxDdDeTvZE1/CiZYywppWzayxV
 fHPPn8s+btRwJ/0TUj+czn2GFqIOzixzbELM9gw8Z+ULFwWN4LOOcwj2ZykbMa9VzR1DgAGnpw1
 Aq9Cni1x/fjU2gmiHPy4LNG6375hP+wT8EIGg6URIzJkQ6ljy/t2wMCfVww9AGfhEDzGonwAvxC
 Zo9kN9wOH6p0IRXa5eL/6tmPExvW+oMuBd9LOPTJFzWwtCL40ZujGTgOzuq5S20xvsaPQlcBnrW
 Z6DRjLjjbDf35Uw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This driver is only used on Qualcomm platforms which now select
HAVE_SHARED_GPIOS so this flag can be dropped.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 636e59abc3772fc0b333873a329b65f4213c3ef3..92a1e3bb8371e178571a6c1ed6f1185fe6c2e757 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1112,8 +1112,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
 	if (!wsa881x)
 		return -ENOMEM;
 
-	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
+	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown", 0);
 	if (IS_ERR(wsa881x->sd_n))
 		return dev_err_probe(dev, PTR_ERR(wsa881x->sd_n),
 				     "Shutdown Control GPIO not found\n");

-- 
2.48.1

