Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49E30FC1C
	for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 14:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725532; cv=none; b=rvCk5BckoWr+VpibatKRD+4A3IKMfMzjwztJnQMLKRR7X+6EsipiW2KCaAWWhCUHHUrCcoDiwESQ5qAJ7RRk6Nr3c2nBB/SJdycPVuJij4aLiXGpYSP9lYx1z7snXnq0FUuyZWkNLEjnSn7kUbHNcCtDcLfFJgrDN0uGOW/1hLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725532; c=relaxed/simple;
	bh=qcX1d63axfEm3RBwV296f+6+sRglnyR7jSQ67K8y59Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aMBpwA1t7a5oRgp20ZlY+YoMODY2kZfsL1VAIeVV/2oaOtog8BlJXhYoLY+XTJ4TYxEEBK3K0k/b/MozleKP0G0QOM344kE2WcqSabFCDpFfHrUFlsTT6/gOZJCkc/K6hmgJX/jpOlyOOqv8ph0HR/U79Q3Bm9sUUPWMjN22Ewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=F1uZ4dEJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="F1uZ4dEJ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46b303f755aso39162945e9.1
        for <linux-hardening@vger.kernel.org>; Wed, 24 Sep 2025 07:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758725528; x=1759330328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibo0NSWbl5C+bQQFmoxlAmjW8oHbuGgT0ysyiGqJH04=;
        b=F1uZ4dEJwYU/q/uT5cIg2WhczgG4i3NNjrikY2TSzz8YgnQk/Zot9R2fFx6KFk64nB
         GHkJBI/T7m91xemjea8GOyyyIPUG+4OullhJQKrLZqY4Dz5MdmCAVv4qdLnJzHExWXx+
         6TjO2IBPQkBkW7/XdnRxCDkjfhwg5afy8OLpEDnotXhluGtTt/qbQPLycfham+idZ1Vo
         bktbhRi2k/yMC9F/9x9yN8u0Qo40lwB/vFZxIFJBansI0kRznZ3iXeCrJ1v+usZVjxG9
         JKdtRVz8SgKjKlR9NpEIEFNr2HjLtZoPnmqVCPOUYAR05dxMH9B48EZw4YvVbWWbXJ4O
         tqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725528; x=1759330328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ibo0NSWbl5C+bQQFmoxlAmjW8oHbuGgT0ysyiGqJH04=;
        b=tC3a+ZHhSkU2+/3v43B8rSYsu2y4aHxsHQ8FqcvPKPS0KnUiXQZihe0J8RTyrJpzw9
         34orYkni61vYy5M4cxGdBn8r+sh1tgmUVRq20fIJopHeMK4eCVpvzvbJ8irearKtx6GR
         phyjVuFh72Sf7pFdF+hfpeNFoqM3ZlHkHPuSvHJmJT+y4mwCnY6EDYWtHqkBHSQMUHEK
         DyuVea5J3RT9ln0EF+5lFH8igBUUa9MQfCgHWTpHMEcMO9GOABFRgMVMjhTdEAEjdYDt
         e+RcCksbCoTiiVAEUkRbXOGZzZalO7l/NcZjqahxeJwYs4iGz/umoPr+TzWP1jZ+EEAs
         EiFw==
X-Gm-Message-State: AOJu0YxfGPhE5SKYuExWr/JA88yX9yRa4LEMwkHZlcBnUxhzLMb/x3Wd
	u9Giuuu8siOvr7/qB9fByXsG/k//DWlxmqDxSXBbNJ4br6+s8DWyv3anQIo7rOAnxIw86z2p0Kj
	n8H4wt9hZDg==
X-Gm-Gg: ASbGnctD509CvzZu8hDEfo/hOxYZNsFAtQxEvyhler7dy9HQuVbU254ZpLyQtYpBzIA
	3sbYYBiDsE1IpxAY4kOTjYlM/dryJcliEbNQ+mvsRyj64+pmvdHFx6TC6ybQtM48QYU5kRe4QWe
	uqUmk4TFUUfTvTQpguEwdJQe+UdY/6cc0/4l2vbXp3BfEyZ2JdqnJqzs1KHHvlHZL5AK0YY9PAv
	GTK0IUBObvIcJxZqtx4GB1ply4ubVJg1xtzExB60xENHH4Hsf26obz4B8icP8m3FXTg9KW6+DS2
	8INI0mKjXhPaHdEweZlYo63NKJoTJtH4uAUWKcF0MiwwWSExrSbTcxi985lylqVbCSI5kVh2DbH
	jCBeW8ZVZs7SPa3Mh4A==
X-Google-Smtp-Source: AGHT+IH2UM0b2DoB2jVzXodkJqn7cNt+S1+id56qPKU1HujmDmjEKCztQlK5G0qjmChMEW9QPceS2w==
X-Received: by 2002:a05:600c:4b19:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-46e32a23f8dmr637135e9.32.1758725527921;
        Wed, 24 Sep 2025 07:52:07 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1729:c9b6:7a46:b4a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm29514750f8f.37.2025.09.24.07.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:52:05 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 24 Sep 2025 16:51:35 +0200
Subject: [PATCH RFC 7/9] arm64: select HAVE_SHARED_GPIOS for ARCH_QCOM
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-gpio-shared-v1-7-775e7efeb1a3@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=LQ6GmHpD/iWFySPYiWNs4nA4WFevXV0FDAv5KxrY5e0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBo1AWGfry/qkeWFwp5USy/SVwuycKAk3dAKJzbt
 0gOWPScWyyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaNQFhgAKCRARpy6gFHHX
 cqo4D/0R7BakY98Bieuwd9AXA5Zz3ZPzUXUHxuC407kcVrlX4alt2GtuQcMPCAS4/e6+vlNQRNO
 gDZhb71YkyFGZxgwFPPt1MxOMN/buFbmL3CTvTWwOOPx8TaKDO/whWvLq8R+u16ltl2k4g2zBzP
 gfrA9rXzjl/jkf4hjCnRDeXFDTKKg7X4eKOOX/UTX8mTSKBwbCRXQMza5ygAvvl0YGoFM2ZgE4l
 J/cWLJSWqJU/9P12SYQPt+bsmOhXSvp5FYJ6QBv8+6fdDWD54kBEktJRBdShjrK1pVoiiCRd01F
 2S2IRfykO5jZiju4Bvo37TSestnnupumzoC3I+FzdsoSC9qpOprXBct1IPk7kJk+ndtID3zOioY
 sFR2bORVE+q0qo4jHu9ETc1ffR0uGNl0hFjEoClR2HwlLr3YIaLbHR5FtLXB3erXC5GyPr7JfTN
 dusEehQcGYYM4r37bWusqOhdg+aqvCdwn+i9UXVYwnXKR2mE1+VeRB74CDxm7MqqU5VO8AJxMoQ
 jFIen2jZnt4Ch30oPMyaSA/TcR659d9+U9+0c6GzqkiGwufduZoayKA9Odsny/iIfr/bzGYLrJb
 l0hjNAXa8pv4FcvrvTkFXt9nGiemMn/I6g9khHxqM7bvzGsmU+v3ojYDcKsNw21/T0dEgFXkSUF
 OM8RQivtzHHfEkw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Some qualcomm platforms use shared GPIOs. Enable support for them by
selecting the Kconfig switch provided by GPIOLIB.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 13173795c43d4f28e2d47acc700f80a165d44671..3dbff0261f0add0516d8cb3fd0f29e277af94f20 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -316,6 +316,7 @@ config ARCH_QCOM
 	select GPIOLIB
 	select PINCTRL
 	select HAVE_PWRCTRL if PCI
+	select HAVE_SHARED_GPIOS
 	help
 	  This enables support for the ARMv8 based Qualcomm chipsets.
 

-- 
2.48.1

