Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5B2E336E
	for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987259; cv=none; b=Dd8hc4FML+4Q4ci3/HRpz8hXa0VRGxIhQLsXgOzYFnB6ztlwtOILotLzbdxV/UoV17hCR5WqVUPNTLHMiWpAVeFXm/TrDCTY2s29Ip833XrhR35fY0+CM9Wm5TFdBVtNjob2ktng0gNXWYj0YVswMqMrDWRsrOjPNqueIJhrMxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987259; c=relaxed/simple;
	bh=RFujl0Cr/YaORxwURfe0zTKDzCwOsKiOevFTrddSrvg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWbhii9uBGhopmZ1GduLijpS691UxvNCingbMjPhxfjWTEAKuOl70QTxvMqdLjp/xZBXU3WTyN7mym2FKfnSpL/3HS5BjimbCM2LETRtTnaGcx1yuE19E9V+oGPytvIQ+56gwoJ5vTG4PYgkoA+/NtgRFCswWpRchQuJjkcaIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=eMTt1x/n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="eMTt1x/n"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b913a76ba9so242171f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 12 Aug 2025 01:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754987254; x=1755592054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAO2WeXDFkbtwkjKyd1xrqU98u0EGyjojmTyXcAuE7w=;
        b=eMTt1x/n1qgzpLXyHDo6MeIY4+ABzJ1/h6XwcjcSjBY8i4oEErGGJvm96NP7ZKL1ZE
         RXo41IishSEJjQGnZyqdFwr2Ely5coNK7Sonl7CW/iQjuQJwWPA/5ulSPkzbJREn3Tgn
         ItP1zxFMSppYm2uvC74UwX0VSbNhStsWMwGqI7rgRjSrpeluaqVqufJtLf6aNyqWqN6T
         +qESXRX5qhzM/4BacuWQuWpoAjMVhEcDFmg2Gk4bCOlb2H2m4b+QE5pXYY/IrHUeBDCZ
         gzVgkNBfVDNYUpv+pU165as8TndN+xeoIb5EPhLXMkb38ad31ptnJ4kIw7c14EqsKkmJ
         8n2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754987254; x=1755592054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAO2WeXDFkbtwkjKyd1xrqU98u0EGyjojmTyXcAuE7w=;
        b=bHiWo6EcQIJLKSBobAsrDHxSJMsyoBtrvkBcJr58abS1DHmS2BIeeimU9BaNzyRI8e
         i1L5Km7AgHM9fyqqW0v4on01+Xim+21ryroveLkcu51AtKyAlTauQIxSOytQtZaJepSx
         O4DvYhADoS+H4kVpek2sc/UPTIcqenz3YCTSSdZEbOZljujXQe0sffLheahfeDBkOcmp
         VaFukbprRr0WZhHXveCv5ggNcylWp42QYT0HHd3355IUj4iAbECn35s7VilKaXrHXx1E
         uG/+s4Gem9SPTcfKDaGLtY9CbtoQoh9T4AGl/vOXcOCBWm85kJQ8azRJFAtNDPekFNRw
         etEA==
X-Forwarded-Encrypted: i=1; AJvYcCWDMKzlpOZOGDZdEJBSdYfa7dINF9FP8hmqSj4AX48+d3edX6xMJ6NBcLjj+nNbnaQKjPRL7fCh42hOUptP6es=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSEGx83Sk4yjbKvMVqbdXzLw3FHDySgFcRs0RNonBz58KG3dCM
	KWDHLOT8CwpWARlmMBZxaR1oCzGAlNC7YHOCFufaOXdNAn4IVBD/SAG9xijFzd3j9Hs=
X-Gm-Gg: ASbGnctqKHMulTWJ/Fx2TbfpevrvAOETZVGNKlmo2M5TTXQhs9B9zSoN5VzZmFm3gFZ
	btlYmJ7Y5QXdnpXVEjHuAx9qSVaKOlwnwCWkeb7g4MHurswzmx/ZMQ0kEnN6hSzoVn0KVnx2jND
	UTmqPJ+yuePbFlMTltn77Q7CafjKK7hz+Hy3r1SHlo95LOyw1b8vW4eLLZWNnBLB30QWUbutCwG
	HozMo+8BiNgPKOkJg2Lye023cr26aqUx33a/i46q5yqloPJxewczM1pSW1Fl51jOgVYrJPCtmIv
	d0NZsYc3Jbo0SXcEy+K5BpduZZiLTpPMe5dY+luZvGEE/I80LN1hFPe8iJPQ+jAzxz7IdT80uCu
	MpD3f9CQhhGAeoQ0=
X-Google-Smtp-Source: AGHT+IEIkGK210eX4oaAWTvIndQdBKgODaVv89WdHuLZ5yZCYfAUy5DwGLKFKR8W9EpKo9YtXUOSDA==
X-Received: by 2002:a05:6000:2501:b0:3b7:7904:58e1 with SMTP id ffacd0b85a97d-3b910fd9b5bmr1926776f8f.18.1754987253948;
        Tue, 12 Aug 2025 01:27:33 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:16c8:50:27fe:4d94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm43549423f8f.18.2025.08.12.01.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:27:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 12 Aug 2025 10:27:14 +0200
Subject: [PATCH v4 15/15] pinctrl: qcom: make the pinmuxing strict
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pinctrl-gpio-pinfuncs-v4-15-bb3906c55e64@linaro.org>
References: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org>
In-Reply-To: <20250812-pinctrl-gpio-pinfuncs-v4-0-bb3906c55e64@linaro.org>
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
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
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
 bh=M6AAfE1ZYIqFZsBoDZ4O1bJllvK/6bMXFJ6Zryc+i/E=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBomvrZaBmeISpiHCVh1NKR4JJvKfvoR7+4TGM34
 qACMSZiq0aJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaJr62QAKCRARpy6gFHHX
 ci+8EACxohGvZiGTBr0Y9QxyJzsEN0JDEuMPPP2/XSq+kOTHcKkmHErEtvBcohO7KLJzJuDM92q
 Iw3+IzM052WTxd4daM2zpMgweo/2dwzZfR5YEUer3WEroEGm+Bj1fVPmMiit7p1Urk63XsoIjrL
 iIqOXmtlteGyRTKCzz3k/xmfTyEyU7VBHczMECuT5uEu155Bu8nJCumD+wzbe8mmIlfgHaOMDUI
 EhNzoSXVeYCY0FHD/wqktUBCPUxVj3EGM965wJpVDJiroVIyzBPsjcH9gW4ZMI3gsrpLkKSn7/b
 B1DQKX5Md99KuFnktDMJfMeRA9VTUveqdFKrzKWO4O1PCOiNZYTlwh/00gXu8zMpM4AK1/xeHy6
 xv2CMDqxOQQE9pNYsgFWdMK5+GZYlQTAYrjZncSo6RYTzLN9weKlo0cKuhBe3wUVAZQntaTYy8i
 k/Zxwl8sT/axdwTsi8ewRtM0DJYHR7QWCXofS6dAiEDIgSKdzkZJ4mIec2cmwKInyd1Ja38qeyo
 BaUmY5FfX7ADJQDEVQD8b/C/oeUP+bk/MkxTefH5hvrw5RZW6Rm5jF7NwkotqyJwbEKJFZVea+T
 cJiJ5bAYHdIENT0OWfDZvACcGaK8OCdLW3UJoLXH1IZbWn2imkJ1JInadg5ZknF41i/olNLfmrS
 vdUH6mCryqoAAIg==
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
index a5f69464827119dfe2a7781b558094b283fca215..1751d838ce95d6138c824b90098f74891dec7656 100644
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

