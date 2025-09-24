Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA3430E0D1
	for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725522; cv=none; b=Rm3mTiTLH3K1YjLQN4rqPqRenWogJfEBiogIhX3fnmmSpErLSJEo+5ViSD2zLnm153SPbmpC2AVBMilt2MNwrBc3i8Bk93Br/Oik/YAzgdC6y6ZzKCRQeMlttyiNOysMUuACCqeU4axLpK6VuVnVwrDLOdGDLrqphYOcMcEtxck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725522; c=relaxed/simple;
	bh=2qMqnWq/naOFzTCUU9EEKFnLmItDIx+R8oO+Cct9CwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QAzWCU1Q/5qipuLgjNH48eabGTHHUsJX/v+6++9+d5V4c2+zW62sBIrmnIQHrGE6IN6QRYS8hpzbCZQufiGClryPQGE0mpyeIH/xIUUlxe30OmNv4BoMyOODpONeq+ztiBDYpCJC/F57Lhq26B5l8eQCY8aG3NzhiA8x2141Vxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nV/E1HNy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nV/E1HNy"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso4409305e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 07:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758725519; x=1759330319; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhDMW9EyWA9awJNXX9Q3cXommnoch0fAiufj04SUcx0=;
        b=nV/E1HNyV+9QN7xEVB5QfDKrjBv/H4MFWv88Wqrt+kquUk/2YqkG7g79aCYpyW9FK4
         s5KrBrYL48LPPP4XaBevW4C/aiTY4znvn5ymgvd+gDtz4B6K8bWVYicqK64kWRaHTIUG
         EzlOoJ1cX7aMkAgR1phQfeIn3nsUrVkdKpkxoyigoo9O6rx2nnkUmOD5I0DK+LEpajMr
         K+XT1iZhTrKmISOV5V51LoGUuKTSfAmWyk7Gtao8uvgXOArgD8ZO651Tfec7hy47JT5H
         KnsTVh99zFFWcI0JNKEeaa4YAsO4xE+V33xwQLxckJsLjwTXNVEGJgHtyJXAkhDp+RvD
         y1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725519; x=1759330319;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhDMW9EyWA9awJNXX9Q3cXommnoch0fAiufj04SUcx0=;
        b=s3z4rV0VFkjiZr5zj6xnJCxqG6QACAHIIlizXS1+/XrCGVS6fVlLEQMLloBGBElcme
         QBKywScZh/2dHBQxiijnKj5k69bnwOe8nPeQj6r3AEhr4vTO9xo6QdjbWzwieCO5QScl
         K8VbXktGcRylMbc2ajm467opIeaESvK5klzqRhJCEy02uezLxNQyE6LSri/AGJr0mdgP
         DJAGUMW0PNV8HrYq60eR+VtEnQYHbO8ULDZBvHL9Qg3eQE5n5q+F1kQvXyLsmMaKXUIr
         Gev7NNF9Gr5XKgKVB+GkZJk6litCBa9zRnKKsnfHmn0vcp2eNA8K64grrSXfCt67/oex
         bE7w==
X-Gm-Message-State: AOJu0YwGTo2B2OoEOiQTOua0Sjx6abZipH1LiLPzlWpnfpc0BcrHQFBZ
	hBkEn7XSuLrIROR+4m/usIEGuTOd6cImvfMxjc5oPouB8RdNj61/ERz+d3tNrBW39Rv3qC+ui00
	fV/EGsyzHHQ==
X-Gm-Gg: ASbGncs1dJSdORtc4i5VaffproQxiLuesV87I5DRDpGQMsCEW2s6PMCqMef7NTdzuD3
	JTrlEqXknEyCSjnv1qZQU4BKCEnOw+MoqRbOt8YOeghOkSJ45B7z4iYZNuRiYcl9yyml+VmrPzd
	BJchCyejn1e4TMis1rXQHrGHFAOXJaHJfMjqPNgiQZfLsesCL68BVUVhrda2QyoJDgZlsaTeUrl
	jHourUFdfXUBvv9L4eC0/Cv+TrR/dCMokEGXSLXhshuFJ8KQ6asVczMpZb9gwfgaViVTiyQTibV
	ld0AzS475AQGK3aaFRq3jEacV17XufUNI7dQuc4LKHxUp8e9VKr+ml2IatuDGVv6JEe0W9M+zhe
	jVIdUaT64GMAuS4uOhw==
X-Google-Smtp-Source: AGHT+IEXQ1OsqbaopW/81AV01FMskOhevY3liqHQ+TaZzWyXAp5VdKtAaaFJhzum2Q2RFl6zG/ksTg==
X-Received: by 2002:a05:600c:c168:b0:45d:f897:fbe1 with SMTP id 5b1f17b1804b1-46e32a0de18mr1279345e9.32.1758725518644;
        Wed, 24 Sep 2025 07:51:58 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm29514750f8f.37.2025.09.24.07.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:51:57 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Sep 2025 16:51:31 +0200
Subject: [PATCH RFC 3/9] gpiolib: define GPIOD_FLAG_SHARED
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-gpio-shared-v1-3-775e7efeb1a3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1034;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=der9rbuzwFrj8Ks9ulK3QjlAd3x3WVP4lOrBQ5vkuIQ=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo1AWF7GWhBGJxTAGF0PPNPgubeRhYpSPwz8NCv
 Nvi6uNAKwmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNQFhQAKCRARpy6gFHHX
 clM3EADgqkPo+x/ufaWkg/WHiN9hw/cvQg7FiJdhEdeFpxtrREOwOstiUn/WMlvJf2D4BMLn7cu
 mokj2sl9AHpKriv5ymzg4FA1FGhJEgjkK46mjC6T56uk4Lj9yapACQkatEbVat7XhRM8PnBgluX
 Jc+89aNvU/Dx088tAolt+UYFAl+45zfiOJEARt1xuEWwW8P/26l93XIE+bDy0qu9fGkKuWiRiec
 5PdwrLSNmbfVKAra7sRgOFFBewIJM2rhf9J34K74Y3g4fM9WjzeTKconSAaEHPSkgUzxHn2Q8Bo
 sSz2uatngoMnPxxCaiAuGawKLv90e+HbbLng9dghn5mD9Espf42WF6cqI5EJ1kbl76L1Xv4oiue
 4RnSq6pmGN3nL+LQg99+Yv2BmrBcQsjFh5vIuLyKyCGI7YLSssw+V5trZHExBH3knl1QCTqHCNH
 V3CU9z91FC4t5KeEimKB2XzTMj6XkCOI5YUN3iau8Od1M16+qMysica7cKJ6L+gPMKCrgkLVfqP
 DV6Y3x/EvuCr1EbBd2jXOdBJ0vxxBXrwn4+N1KFQR3AyEkhgar155iTpZRzVjehN0VABnc/eJCp
 sRS11jZ1qiNgb7iCtv05Cc3QFmyId9CcL8ck/LYyTKXH2HqwC9kuIWvmrc27II/8qMFiGJZM5tT
 G4vQ94hkIbTiDFw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Define a new GPIO descriptor flag for marking pins that are shared by
multiple consumer. This flag will be used in several places so we need
to do it in advance and separately from other changes.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 2a003a7311e7ac5beeaa1c947d921149ad991acf..09ac92ed0853f2ff0013d1b16a5dd082c9fd162e 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -204,6 +204,7 @@ struct gpio_desc {
 #define GPIOD_FLAG_EDGE_FALLING		17 /* GPIO CDEV detects falling edge events */
 #define GPIOD_FLAG_EVENT_CLOCK_REALTIME	18 /* GPIO CDEV reports REALTIME timestamps in events */
 #define GPIOD_FLAG_EVENT_CLOCK_HTE	19 /* GPIO CDEV reports hardware timestamps in events */
+#define GPIOD_FLAG_SHARED		20 /* GPIO is shared by multiple consumers */
 
 	/* Connection label */
 	struct gpio_desc_label __rcu *label;

-- 
2.48.1

