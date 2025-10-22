Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5D34B433
	for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 13:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138686; cv=none; b=ICSdfaBByoH0Qd8/6JT41GwiYqjGdRfsn48gNR9ZMQ9ku8eapQnHmUqxxURYBPnj89zLaWoywU0hAo/j0XhQxfJwCdULNeRYYL4BdZF22Esu9pKLdBQHr1wx0pQWSayHJ605jlI4pxc1CJzqU8VliBTLOrKzTNm1Vl7eV+8VyPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138686; c=relaxed/simple;
	bh=stH3r1LHkClCkcDML8lbPe+sizlONl6NhOJhh9xR7lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1t7WJLoZ1k5kQkvjZA8RTtuHK2ZHdonQQgluuSReCj92DkwaYEW8rMOUcQSZCFP/flZWOBxu6UDTQusIvA8gh2pnTy2ogPeQU4RTTPldA5SKHZgakuh2xtD0COgUidMrsi+XeINL3jugG/Rph5py2vujFw7338D7cA2QcpxyGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=GtwNNOqd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="GtwNNOqd"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4711810948aso48486535e9.2
        for <linux-hardening@vger.kernel.org>; Wed, 22 Oct 2025 06:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761138682; x=1761743482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIoKmjIInajLiemN3aTwTX5GXSgnREsQmJKoJ1Pkspk=;
        b=GtwNNOqd+3jlSwKgIEOyDgmxAS5B8M+Rj3gvNzrDFgX049wlW2V92ERVsdPNzxF9Ak
         DUTwcKKhVxvBfaUl9RPdBLz2ucR3H9pTuqUvyMN1xy4tMcp0P9kgrGmd1GptSg5kKhcb
         1faAHMOPEPRDEpNMsoyWhvUsM8tUT/+k/znpp19r22mJLHeu5SUh3nRXwvT+2x2CXpgv
         FKA/3IkGa//zx2cARzzdRFoYXFofUEdf7N5vJOJ5BT00i/vUIbVwh8biN08Tn6xa4faY
         tAwm+d5ylHAxpiOxxAfsMlvaAEgk38zanr3ZOTIT2mX+AuTQ4Vpqdbf3b7ExxtonFA1W
         aGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761138682; x=1761743482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIoKmjIInajLiemN3aTwTX5GXSgnREsQmJKoJ1Pkspk=;
        b=BZOcji9CAZNfgSsSxX4tGwMHo3sOSzKanUCh3mLf4LcVa65PaYmtqPyFYpK6KCTQxt
         oyq3O3EN4Jo/W/fxm08TMQVzNp3i4cpXtT7GKEzDUo3smTBG2nUyFsNWWhw5vhZRnJa/
         XbEZKDS4MH2q40PAo96B64p9odPW4F7hzQ14Cde6CRkNnqtbsI/YslMbQpDAEV279WJy
         kBgXomI8JqIsB32ss1ZwUtA2A4Ch/G0yBe7CGGT+0wCC8ViUJbXVd+Gb8XYVkOKxhWTE
         aRzKPHS6ySx6QdK6GhjPm8ADlfbdWBbV/yxV+rowEpmDx6booCYpUJA+tLM8F0/SCOx1
         l4ag==
X-Gm-Message-State: AOJu0YzJMMoI/a7BJORKcNKRJL3Gi2mcpNm43AMaFOI7vQxOE8zQSBB0
	/2zYm8+HkIDHdphsu4ZSgBNJXm/NI1l9+CSPdeEWZ5omdsl1pSjlqnrOnMKPQSqEGJk=
X-Gm-Gg: ASbGncvzpFjvvMY+FSRbR5LikMw2N84KYkoEW5m5Dm+cD2kqSXe0N4jQu2i7KfxlrZe
	3QxwxISnArj062qI1tbcktcdTRIIGHORew6L0Z7QbcOzzSjiih5vG8lv13OXhRI8aZZvj3mm3Qu
	sloyDROpftoFPBcJDMMu109jWOEl2F3kOwNlTTlmASeVzuiVvlJgM+2fNrnSOPdybdSz3eHCB1r
	KmLPvg6x55ovS91D9+LrTwK8w1nzu6R9xtUiGGdkiXKVRDwLYdrz17+jaoY9u2ZfrMzNGqVeYeC
	Hr/BapmM+pJbX/Z+egxNKGHTSM6Y2RDVtI+uaaQ8qcVlklnWDxUtM8y/g483wC+oHpyJID5PGAU
	nsA4lo08xevs+DsaDpYE5vEno6OFQz5SdnckzGiXSrS6ArHiBS+M9cueEMSbVGboW034nQgd37w
	XmtEqEvw==
X-Google-Smtp-Source: AGHT+IGkIuCyg+IuvK9C8PoKW8hm0lv3AC2LKI6qqGW0oK7q5GOxpXH1DI2XWiXLmBBfGx1o6tVduA==
X-Received: by 2002:a05:600c:3b8d:b0:46e:4883:27d with SMTP id 5b1f17b1804b1-4711791c8d3mr166553265e9.30.1761138682075;
        Wed, 22 Oct 2025 06:11:22 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:69df:73af:f16a:eada])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47496afd459sm38839905e9.1.2025.10.22.06.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:11:21 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 22 Oct 2025 15:10:49 +0200
Subject: [PATCH v2 10/10] regulator: make the subsystem aware of shared
 GPIOs
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-gpio-shared-v2-10-d34aa1fbdf06@linaro.org>
References: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
In-Reply-To: <20251022-gpio-shared-v2-0-d34aa1fbdf06@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=p+y5IQEHjJOnxni5Zye5YZtGuUrzZOARpYGAZB998dI=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo+Nfe/WgJn3MUlv6tip0kIveOZg897ohp1tW6c
 islxAr8UxuJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaPjX3gAKCRARpy6gFHHX
 ckM8D/9Wzn/ftmZoRgjjTg5RZ1xRGR72VM20yOSyWEGtCSNeu4uUvBMNAdArlUONgpBYOFuCQ6f
 jxeo2x6+b3i0y/TKIIqp8XOebUFaChUTpW4V2aTOTzZvTL9CQWh7zsEHSztQvU9oHI+7XxP8KMW
 9CY/L3iA8HVGuidSKPr780WTf1ctlM73GpwS8DZHS/+4f9kx8503W6W622tEi7x+fNx7TMYJnE1
 8SkUCFoyxWoLyDmWJFr4Y9uXOrBzTTdTf0h6dGmUMoAVAYCQx90fRDcywibndcFyxTUs/XULCVl
 WcQzccUha2IfGjR+TpqQW/LtoW8xc7Vjig9winnhfWlIrLu0ddM0Xy3AjcWQGeiHoIGUGYy+vi8
 gbRAq4h6J5vlyLsZIgr+4Q+AgPz6xZtpNyVc8hSkFHVQITKHY+xY9gRPIaptn0fMtoCSE7WslZ+
 9d7gHhQrdmlUDrJI68PPaPDaWumjqblocdZYLUS3nxddlkaOEzremAVAmSg2BK6TDEIBagmde57
 lz3x7gKQp1EHI5GrfRSyIHKSkVKyTDnYFAumAYlYaVLc0UBrIvJPqQxUNkn2GGTWLOVC8qb/sgN
 +yauMt1Nu2ItKQTye6/6dBoSixx98QV5zlqOqM0MICJlNSyqWLbPU0uV/Xq2uI236ar5Lzwo/ie
 jAmXnk1wKw3Geaw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

GPIOLIB is now aware of shared GPIOs and - for platforms where access to
such pins is managed internally - we don't need to keep track of the
enable count.

Once all users in the kernel switch to using the new mechanism, we'll be
able to drop the internal counting of users from the regulator code.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/regulator/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index dd7b10e768c06c83d2a4fb5dfd0fce8d796c9185..f9690f0689fda85123d07967f3c87105829e330c 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2616,6 +2616,13 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 
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
@@ -2628,6 +2635,7 @@ static int regulator_ena_gpio_request(struct regulator_dev *rdev,
 		return -ENOMEM;
 	}
 
+skip_compare:
 	pin = new_pin;
 	new_pin = NULL;
 

-- 
2.48.1

