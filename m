Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2293093BF
	for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725519; cv=none; b=M0Icp28pnfpaP4qQKoCpCPNmKyJ0v1XtNxfEaxaFPPksqPvQT5iMYB+uRNRew5gsSLeEl91RWunA4/qUcgC07QgiQVKf4Vkt2xYTcuCHWfoF/0kOUH+Gwi+Z4taHk1/nQ7VgpPxoBvbKnP5PzyqO798HpTrhPHxcnf44DOCHwJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725519; c=relaxed/simple;
	bh=L2kLAKhXcPRTSxYID5+lqGdmVixmb8cY89yQVUKyTsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZR5CY+k/bDaaiG3xyYPu4EFfRXDRIywJPgpAzbWyeGVtRGXUCjl1h7UBYGcutS+11993iHLDtV1yWkajQm586lLQG3At4CwXqzHnlempX8ignntvQrwkyp2Ew6TGYwJiKPVKUHFLZEHt1QnX7AwhUJ99F3rCTsckO2yEE45bl6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=e0lxZtHL; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="e0lxZtHL"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46c889b310dso9405085e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 07:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758725515; x=1759330315; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Q+Hgya9r+CWJ27IcqRYKkvlXmEyTvOuBCqoT3y8qw=;
        b=e0lxZtHLY+v0rBmlEbUurgnddp5kvZvgYOJbyCrfZMJBKNV2jPOD+ZMWL/cVDu6alT
         WVT22A7bGD+QsL73jovvMsZepws1MokS3LbFlQa7sIVtOMoBkMdyJ90fAeSy3uuLCV/z
         9ITaMZW30GmCShAm508ips6VzY8JNchv53v78GjQpljyHTFZebMT9iurFw9kr2ii67oP
         w89oqJJtsoWAO6k2LNQv7oJYOSUgvtzf09h18HGXCN2vzAPZTQlnEgwO6GTsmFzcYCFf
         2OJ/zzFM7ssPpsuMXJX+1jcUTC6zep0t0pTj745K3uOrk0Acnk4qvGOWodyJm+WlZ1IG
         sSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725515; x=1759330315;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0Q+Hgya9r+CWJ27IcqRYKkvlXmEyTvOuBCqoT3y8qw=;
        b=X05KiQd9rk7FNc5SnhXki3rJEv/49TYvh7CfnXmvXpnsdcqTaut5mI39hIiCthUeKO
         18cFQ0S38K9cmLQEOIXkt8H9YuXXnghJPg8Phz6tYgb1vw9e8yGR3Wft2fe7xwGOsxoD
         q/1W0EMunY+bP54DsYUCGPoFfcpzxUmK0M25exHghQ861fwHpthlbzcqMq+V+LGtbblQ
         uMo6TNoRLU/VbP0Klw9LmRbn5yjZ5xZKO+4lfiP/IR0zTofH6MHoSmb/mExD009Nvmu4
         1wvWhvpCII2bS8ZHTDTc7tc0Asg+YuX3TKg0P7bEg6emx8m1l2+GiXLE9OGQumsIUq1K
         8rLw==
X-Gm-Message-State: AOJu0YwbCzS4LRrYPGBcx7d6/xicDBt2gEsQwX9PJ5ntIzViJpcOcPfG
	saMpuOIyV5ngzTkZe+7dwoOju7Fbp/LQW3AJcKKRi9YqTCDqWj07d4xsfpemzTqCxe2IjaEUp1Q
	oBl8VMv5OMQ==
X-Gm-Gg: ASbGncvlQ5qOUmhwtKS7n86lVL+VoemWxR8OXqWzu9HMd7YGwrq1ZRoU1CCvEMDV2xj
	YW0a05xOHf/HcqYy4JbUL0sMvoXlYxXO22ect9LQaQtiflvQx3uKTRMXBWm1rnv7jCnJPxP+wbU
	YtuI90COTDlSjxxq7A3DyzLdx88UXObmD91LV1phOLKcba8Gg9JvKgf9Yqhlz49QHlGgFfo6F5q
	mtgRQLT2kIeping0c7WOXGRQjJsBUrTnuiWSu6iS9cl8YF3d0G3ZzUiqRgLdf80eNcWAJwvtTpM
	o+KBOTVyA3XcflZh4VB8F8ufJ1sUtk3Pa+6N0Rt0bcR189IaqPk/whF6p6V2P5G88OmhZOGS8Be
	3I06TqDj0yPFWqc19ZAFZdWDfE1Te
X-Google-Smtp-Source: AGHT+IHqrlf5Iy0gafewEVEvZvdqGPtxzn/dahd6Ieio03KFz2MLsdyrnS63HEdvlLZHwR/e4CQuAg==
X-Received: by 2002:a05:600c:c1c8:20b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-46e2b52c35amr23884575e9.8.1758725514877;
        Wed, 24 Sep 2025 07:51:54 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm29514750f8f.37.2025.09.24.07.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:51:53 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Sep 2025 16:51:29 +0200
Subject: [PATCH RFC 1/9] gpio: wcd934x: mark the GPIO controller as
 sleeping
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-gpio-shared-v1-1-775e7efeb1a3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=990;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=+onLqCs+uky6KqRfHsDH/gKs++nVX/GXHjjSwDpjMnY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo1AWFZY+Dx2G8yimcnZUw4X/JDBSCEab4BzQX0
 SEHR9ic5oyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNQFhQAKCRARpy6gFHHX
 csl7D/93a8AjEBhJdr57hZV94lQ6L3oHzmrrx5+I11yewNKQjKjTiq/Sv7simTbkw5LqRHTNOOk
 QWOaGEuOezZILvfSLh1t7XubpcAX+zTbbff5+vb4ZdNe1XGw3g5MD5RLUzKZQ0hjOMJHU7L9tAJ
 NoggHvBT3EnG8Ws9nzAODXZt5TqCAudVYwg8tTt59kKaEXKVyQUpgfYieAEBx3nstzHVwhBZMsN
 PN/W57PhQSenmFgTdbS8wyVjzfM0yQvStz23TE80h/aC9XZT/OgLk/12DNudAF/HRKS5/Q3iuPS
 2HKCzPlKXS+fjOKXLiTomcVP8ARRmUp8VToNMHo4J4KYtNQXi08TC6HgRORLT/1wWctRhPuhb61
 OkA0dqVJVQGYlOElCn2+hsp5eNzF6oKi/t/I3jiVl7XiGyw8uvkoTWCUnNLGmIHFco/iJoLw7Kt
 sPE0BsweoKRZL6tWX9N9iebGP0cqbHMEsyPDeXu8SFvahdcdKtrNFDCksbyNqOKy+4aBmsmslUl
 SuxtbhyvNcNsX/RjP5FpdoDfQkcDHmiWoTFQvz1YGeGNIJeCLCBmFu+3Gbu4uBalakSNLTq5T40
 g+otJPzjjKDtCQ1tClpK7Ad+moqy7orLr6M64tCCWKk2ukhBIo+iwX0F9X3nRRLdISs6m/qIoR+
 N1Boo054QFUaFwA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The slimbus regmap passed to the GPIO driver down from MFD does not use
fast_io. This means a mutex is used for locking and thus this GPIO chip
must not sleep. Change the can_sleep switch in struct gpio_chip to true.

Fixes: 59c324683400 ("gpio: wcd934x: Add support to wcd934x gpio controller")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpio-wcd934x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-wcd934x.c b/drivers/gpio/gpio-wcd934x.c
index 4af504c23e6ff5ad2bad1d70a0c42e2fd91f0c7a..572b85e773700ea0740d3e4efc06d3538f7e368e 100644
--- a/drivers/gpio/gpio-wcd934x.c
+++ b/drivers/gpio/gpio-wcd934x.c
@@ -103,7 +103,7 @@ static int wcd_gpio_probe(struct platform_device *pdev)
 	chip->base = -1;
 	chip->ngpio = WCD934X_NPINS;
 	chip->label = dev_name(dev);
-	chip->can_sleep = false;
+	chip->can_sleep = true;
 
 	return devm_gpiochip_add_data(dev, chip, data);
 }

-- 
2.48.1

