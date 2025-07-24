Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2A277CA3
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349109; cv=none; b=RyXKLhtnrrVy9PsK4ygz9Aq9T7jxTLgIWrGPVPtQReXUDzYRArDx+UgJZYc3f5j/V1UsPm1vaXcRV73ga7cpXwlHVXQH6+i8f5osdjnWQyY026Xhyrt87eRzmQ02bUHpxRtRWbskPU0YsJIuvN8/DUahZiQ0yIiW29DndNtHhj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349109; c=relaxed/simple;
	bh=j3hEB3uHMyfG6UC6xkEhr2jxijr1UzMwpOtvGPojo1c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMmawdlAw7Caw3JHO+Rxin7K48ovQAjXZ3PylXxmshFKeo+4GRnGblOcmLlYeYck65UZw3T1qWaq2ejS7pL6ulctuZ31ERXzAn3ByVO0I3tmtPMh1QSbY+ddy1QVJSbUHnQyzv6kINJoOIFvvct0bJirhiF/PCyGFjY6cRK3fB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pZC6z7/L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pZC6z7/L"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a588da60dfso468727f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 02:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1753349103; x=1753953903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h4a+gzu7f3EwTZaPbk859mLIqTYIGZRRwraHyXMWvss=;
        b=pZC6z7/LGtdQGVWRpYaTHqcqRGRzUPMXs5mzavTko1zC2wIanFvf9U0DddlnTl01By
         l/sg4duxd9Q26ivVXRMiaT7Gp0V4wFOf40Sh8+RIQJPJM4jpUG8ltrQLCu5gF5FvD2mF
         1C3xRF39UubD+CfRVByGnbT0Pgl2q3ySpHnufDVIWhq52ZmeTnfcFz0qb2CTN7DbZrIo
         8WL8Cc7X584qxA+y/UFkNCfh1MduOYnBafRW/uMsR2xU7SoSN1Fe7bqKqGXcBsf6Ostl
         DhWkoqlLqaFvaVAIT/poJa9ZwBo94qHYA2YbhD0aQstzDGRDdRomoIG02mV3uLit5+0b
         pRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753349103; x=1753953903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4a+gzu7f3EwTZaPbk859mLIqTYIGZRRwraHyXMWvss=;
        b=U2vC/vnA5dRSkLPiU9+HzV1dDJvfrGFpHZ0uo7Qqtom09Z9FCpS09GCoTOPakW5kK/
         M1A4UZYANna+vlzLoKm3PPkccbpXp0tzMKMH8FckzKudCb0RWv3w6wCRs18K2QWxbqLq
         K4vpBM8AtCTmUGYUFguh5nLdunAtaxTQWajqB/c3eyxOrs2kr4Nz+35g1dKe9WBks7xc
         rOzbeocWLFFSNjtnHsWD9H47hjuKk3+usdTXtxVuaAQrqvH5mXMyNxwt9bu0OA0GxxjZ
         aZ1B0UEVDlS09+KCbMjUaDMfJLksrmut3omBd81PeBVfjI5pUDON7qSuMGSbdFAgc1ZP
         dmSA==
X-Forwarded-Encrypted: i=1; AJvYcCWWE/m/Am/LiACQW2a8+vfqoce3an8/RoRU9YoS5F6v6mn5qK2fh1og6qkQpUUpqbT6Q6S6L7hpulItxfRT3fQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvi6yZEkOcAfCktZLdfCFqllWYRhylMYcEh15BkyMq1AurtAt2
	nju5SSHBnzaWQ/56T/JlWwEhP0lMzy8JBB//bXrNxH5oGL9Cb2EUEztZnBlfsWcBONM=
X-Gm-Gg: ASbGncsNHc/8MRV+faB8C+VxHILY5pbdG0CqKXoXmH6x3iR/hS6Mnn8fCynryuouhUR
	YmtzihHVHEPtCFGkdOcPR9FtA5ouaUWANG8bWYzUDYV8j/UDcMrlgOSLVHgP65Br/gqA0XA2mWr
	1SixDigx5RCCuQvEn58VO2cC+Zfd8mTgBOyGfPfDY1u1G9C8mHV1HVoMw2U3u9cZwnAKlWM68AR
	dQ8CNwENjyV1Kg7JMuDy2/nFpezj0BVg2kBZvYXH3b99yQkQT4fhedjnIQOzxD4h5xZkrUYCY0v
	rA6plXFZtmGzUxTvRhNybVvVFu+E3XMwy3SfE/DWORo43NUx5j5bAyCGQk7n+wVHPSP5xZ5qPyo
	R1kHezK0fZgaFHiID
X-Google-Smtp-Source: AGHT+IH0iAkuA6GzMHME9lyvaFVrb9WaSOmQdANpljoKy1DeZvDX7IaJl8X91dcX7f0LjUclpn3P5A==
X-Received: by 2002:a05:6000:1447:b0:3a5:2b75:56cc with SMTP id ffacd0b85a97d-3b768cb3ac1mr4981697f8f.23.1753349103057;
        Thu, 24 Jul 2025 02:25:03 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:f44c:20db:7ada:b556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc72548sm1600833f8f.30.2025.07.24.02.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 02:25:02 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 24 Jul 2025 11:24:43 +0200
Subject: [PATCH v3 15/15] pinctrl: qcom: make the pinmuxing strict
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-pinctrl-gpio-pinfuncs-v3-15-af4db9302de4@linaro.org>
References: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
In-Reply-To: <20250724-pinctrl-gpio-pinfuncs-v3-0-af4db9302de4@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Sean Wang <sean.wang@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Paul Cercueil <paul@crapouillou.net>, Kees Cook <kees@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@redhat.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Tony Lindgren <tony@atomide.com>, 
 Haojian Zhuang <haojian.zhuang@linaro.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1142;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=M36QPREHYk2Y1Ol3wL/sT7z2U9JVD+MimNp7WJSOHU0=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBogfvUuNqnvhBaTQ7E02dLbZ93XPdMix/+wojXR
 G62efWlN2eJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaIH71AAKCRARpy6gFHHX
 csIEEACcYzcalCunEHwwLc8fC351P1QZ0/EviGqXfAPEAKDWr3P+rwFdN2Ta12zzVjBkLzjyQ91
 Zv3Pyd8ByzwdIUsKqqnTCqQXU561HpvlpivEPwqQfk2Fv1/z8zXTLdhqLYeWc2DtYwXVL47+ep1
 hvPNS0sKjxZZSbhD2Cv0so7lDbU9TIvO8FfROCo+OUmJ+fNRIHwJdm3DZ3UCBbKrfqj0JKqwStC
 SmdBFpZg+RC6pqBdqVp2puRBkrX4kkPXma3WhGUgbQa/jdRrzeKTzhOecZSN78aF+JYuAOuEWas
 9ZYmbC12bDFImUccK4LcZfdm6UKPE66KoyCTfbJSdLsUaafuNUop1v3HMU+T1Qr/Xjdxcfc1d72
 xDxNII3sKlNkkl6WGjDNi7bqM437VkY4D3MqKo2PdUpL8pWVacs90dpKk/TeHcMZqMlSPpWf6Ir
 w0BoC8kdAtDjE9Xmx8h4NgBJrMuqyRB+w2H/MkSVj85rAH3A8nrxlRd/vqL77bGkehXfVeY7coP
 hWnYxxxDdbXZTNWgEpW4pWcbFrtw2pyKmva81FwQzEbINBVc2nQJQb2Qpd68J7/3170a6GFWyeN
 MElcFiUfHMZhzI5U6MPEUSceL4b9e10SrngoFXdrORgydvHqnRID4/lq5Qv8dryavy2pK7C0AN1
 RovE1kMQsSfBwRA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The strict flag in struct pinmux_ops disallows the usage of the same pin
as a GPIO and for another function. Without it, a rouge user-space
process with enough privileges (or even a buggy driver) can request a
used pin as GPIO and drive it, potentially confusing devices or even
crashing the system. Set it globally for all pinctrl-msm users.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 7010be8d1ace062fcf7743e539d2065d4aed856b..ad572c923e2ab8caed134207ec02c4107d4dc2bd 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -268,6 +268,7 @@ static const struct pinmux_ops msm_pinmux_ops = {
 	.function_is_gpio	= pinmux_generic_function_is_gpio,
 	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
+	.strict			= true,
 };
 
 static int msm_config_reg(struct msm_pinctrl *pctrl,

-- 
2.48.1

