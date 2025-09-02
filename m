Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36182306485
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 11:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814386; cv=none; b=oux59M5uNCryfE3QBbUeLV6iT8eQ7frwOUFshCFIOJoep/L00LLIoqvDPejS7XKTU7BY1cYVzADDbjzYzixlIxuNg0fRxXH7xdaFgw2UTAXqFPs5CC7R3+C4xz0yGsKmo7I/zE4UoQlKYNhoKTunAgBECSnqILEvJPKnUjnbWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814386; c=relaxed/simple;
	bh=SV+I2au43zHAy3pv5eee+yllfhgOlyFWT5ZY6Em8qGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mFtZCpu8lXHChU3w65vbXWLvrZ2tzwMHYiVlzvjazeKH9cCmW+/Uze+gY0I4LLYH8jKqU/aR2NlCWMfOX2T+JVzOGsx+HGmhGVcj+B0EN83gboJcUDRIjT0T07UNR1mORy93rquubjhLBPe5BjpTRtmvBOkvwDBgmN1LwVl39y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Hok4d5ns; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Hok4d5ns"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so2524063f8f.2
        for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756814379; x=1757419179; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tEWsVeKHUC/dAllw2aDUrg7lMLZ7DefoZuk24jUoBho=;
        b=Hok4d5nsiFJKt36KxB3HOZa74z8XsGOmTY8KysQJNfg2AyK5ztd/6ug4dDEM+y/pBR
         FO9bKtKZhoamrSuv8HWM2mX9OLgEVV17BsEfH52k3gIZeM5yp7UATZFho4xHxfg9LXrZ
         EonISc6v07+HNER6b43Ug3Aiqm/aAgKKyohyeMs73i5OdK/twvDi22WBVAC8pwKGa3gq
         cdEKMnV79G9/QWPa8xogfEYp2Sgedx9ZJsFTxKCf4LsX7Yoged1HKYFs5SkAjEOo5RAg
         1d31RvGB6vvCYx9Xi0DcJRUuNkrDkFms1z+KUE7gjsaG3qrRh/TA17MPImihvid1k8g4
         ekJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814379; x=1757419179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEWsVeKHUC/dAllw2aDUrg7lMLZ7DefoZuk24jUoBho=;
        b=uHVnuhcIsoNF+oPSl11mFnAHxZdI4mbi3WuB392xThs4VmGGAipT2juJ0WnP9rvsFl
         bXYz/hIf/nu7ZYNq4fRFrM7ncpkP291uU69CvBhgnXYcuUxKWaLnukwMqnQj+kX5ZfKz
         5ag9I68icCru/5MH4+NN6tgcqhGRMpEGEfUhY+JRt2n1N2UJQexDUKKAidPeRoEtkvFv
         37UdQSHpFYiYTe0XURh9qQujS2IG1unG41bYhjrI+P1g/MHJCej5NvRB+OigtnifbYMn
         0Gf8NGBJqozyCO4iiw245bayUCJb97wATFiRQtNNoQLvMYD7YjyRusasgDE5vmfK7hVN
         I2eA==
X-Forwarded-Encrypted: i=1; AJvYcCWAE4OTBYTnjzwSxli61v0uSYhYcg5Li1vXxSye2Pc1LWggcWPOBjmBxXUP9cOOleHUz1tDlnbB3snxeAtd95E=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNqrCOOq0UiKCJwMqax4P7RgsUUP2nMmxfNc4GnyJEhC1k299
	Jy5LnuqTJJzCZGk8r6/4Bp2r2CfWCigNHG24v99kxcgwiW5n9cjXeZBaK1DfpKNGp1U=
X-Gm-Gg: ASbGncvVFIR0NSPgOvp3pZMC2izId/qjO0EcSKzFYPCwCeytZSIzLf8aJoHAj/rFfmd
	i/ac09IArENy0YMIiUKCKkA7J1MjeOeEi/g8EoUrdJUllUZhtr0UGjno6dkDOgBm8SqFQq06bsA
	cWM6Tzeje6dpgQ6kvbMs6dxxvoagcWFyBHsEkzWVETOLEQzrpBX0v27j+U/hYJbY05USs2ZtDkr
	vSwxQsrY0ilZa8b8V7wOaaXwdKtU9YQr55jBlV9pD/lKLSLg97OroTizyEJPzTVnx41xw+fzmzf
	k8Zb21CM5iqT2hlyeFWNxlBLheuwlVffU3nVC9GhsFT0K/oWkH1aNGdAI12bsz7iIhJrmm5Ixt2
	MgNSFQW+Ay3DvZDSPJ3AIK93O0VU=
X-Google-Smtp-Source: AGHT+IFbemdBZVr4cSqFDknoZOXx6G9gv7/Y0ZwIrtmRmycK6XluzE7F7aIjOJthCpOln2BXwIsUdA==
X-Received: by 2002:a5d:5c84:0:b0:3d1:6d7a:ab19 with SMTP id ffacd0b85a97d-3d1de2c6bc9mr8102151f8f.20.1756814379349;
        Tue, 02 Sep 2025 04:59:39 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3327:447f:34e9:44f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm10224195e9.16.2025.09.02.04.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:59:38 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 02 Sep 2025 13:59:21 +0200
Subject: [PATCH v7 12/16] pinctrl: qcom: use generic pin function helpers
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pinctrl-gpio-pinfuncs-v7-12-bb091daedc52@linaro.org>
References: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
In-Reply-To: <20250902-pinctrl-gpio-pinfuncs-v7-0-bb091daedc52@linaro.org>
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
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Mark Brown <broonie@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-mm@kvack.org, imx@lists.linux.dev, 
 linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3806;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=32Zcb9hfB+ZeJyoy3uwQecPB9Xyi4ZVd3B+L7ZvFZiY=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBottwUCgQZBmoTxlTrj8gjD6XedHkrbIupwH0/A
 aWSRMyfc9OJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLbcFAAKCRARpy6gFHHX
 ciHxEACSn9uq6GCoE4OW0AyeoZN7IZ7Lwnvcc5CVALJn3LNwLkXQJla95ogJxXNn6INZUSqnzyZ
 sAv2J4r1nBu6cWS1jCNcbRwgOsUxCD7DOij9DTVk8vVeuUiyb3/nBCtlDSiKX+I+EJ6UBXABrJP
 2ulvPkXnmvHPxoFGDEuoV7ZOvRno5o2gmZUIT0hafWB6etSbvtGLzxA4akcilCxSVle3PTU7OoZ
 rJ8ecXISPikzFtKVSa8iwGbopUmzdfdyaqHjdni8ExsDN8TyDcZLKAkiWHxe+Wn+ovT37ULrXwY
 URy0PXM8ZdNugKFa87z/9zRKbtpRbfznmQOJUMdHJRA/3Ws1XTiF3r7m1C3mAvhJJki+yp8n8ns
 eekmGbBOSMUH+0H6ap2CxYRgxlOFFIARsBHSIK1O4ci5efShHfePBz1yk0YTqE0lMMxwIMBS9OW
 2ww1g3NSRKBROCGTk2V6dGLcOIKnRJgSX6OYWcbmQaifc54U1l44/0nmUnQFfIW8yZepxvX5WZr
 TMbqscKrQY9wJyUsRY/9W7iq0Cs9ZRlfqGO/8OWJ8flLXdJXpeZsEkmsdB6GYbixZ1cdyNpfVd7
 6AZzJLar5yCrsfEiPgfaRWSe/izLz5B8B2bE7q4Js+qhiJKPopM8A0/rJP6mJC4aBWYqvqM/qXZ
 qANi8Fe+TNoz+zA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

With the pinmux core no longer duplicating memory used to store the
struct pinfunction objects in .rodata, we can now use the existing
infrastructure for storing and looking up pin functions in qualcomm
drivers. Remove hand-crafted callbacks.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig       |  1 +
 drivers/pinctrl/qcom/pinctrl-msm.c | 43 ++++++++++++--------------------------
 2 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index dd9bbe8f3e11c37418d2143b33c21eeea10d456b..f7594de4b1e9b95458c2c817e1158026a8006f64 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -8,6 +8,7 @@ config PINCTRL_MSM
 	depends on OF
 	select QCOM_SCM
 	select PINMUX
+	select GENERIC_PINMUX_FUNCTIONS
 	select PINCONF
 	select GENERIC_PINCONF
 	select GPIOLIB_IRQCHIP
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 83eb075b6bfa1728137e47741740fda78046514b..96e40c2342bdedb8857629e503897f171a80e579 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -31,6 +31,7 @@
 #include "../core.h"
 #include "../pinconf.h"
 #include "../pinctrl-utils.h"
+#include "../pinmux.h"
 
 #include "pinctrl-msm.h"
 
@@ -150,33 +151,6 @@ static int msm_pinmux_request(struct pinctrl_dev *pctldev, unsigned offset)
 	return gpiochip_line_is_valid(chip, offset) ? 0 : -EINVAL;
 }
 
-static int msm_get_functions_count(struct pinctrl_dev *pctldev)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->nfunctions;
-}
-
-static const char *msm_get_function_name(struct pinctrl_dev *pctldev,
-					 unsigned function)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	return pctrl->soc->functions[function].name;
-}
-
-static int msm_get_function_groups(struct pinctrl_dev *pctldev,
-				   unsigned function,
-				   const char * const **groups,
-				   unsigned * const num_groups)
-{
-	struct msm_pinctrl *pctrl = pinctrl_dev_get_drvdata(pctldev);
-
-	*groups = pctrl->soc->functions[function].groups;
-	*num_groups = pctrl->soc->functions[function].ngroups;
-	return 0;
-}
-
 static int msm_pinmux_set_mux(struct pinctrl_dev *pctldev,
 			      unsigned function,
 			      unsigned group)
@@ -288,9 +262,9 @@ static int msm_pinmux_request_gpio(struct pinctrl_dev *pctldev,
 
 static const struct pinmux_ops msm_pinmux_ops = {
 	.request		= msm_pinmux_request,
-	.get_functions_count	= msm_get_functions_count,
-	.get_function_name	= msm_get_function_name,
-	.get_function_groups	= msm_get_function_groups,
+	.get_functions_count	= pinmux_generic_get_function_count,
+	.get_function_name	= pinmux_generic_get_function_name,
+	.get_function_groups	= pinmux_generic_get_function_groups,
 	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
 };
@@ -1552,6 +1526,7 @@ EXPORT_SYMBOL(msm_pinctrl_dev_pm_ops);
 int msm_pinctrl_probe(struct platform_device *pdev,
 		      const struct msm_pinctrl_soc_data *soc_data)
 {
+	const struct pinfunction *func;
 	struct msm_pinctrl *pctrl;
 	struct resource *res;
 	int ret;
@@ -1606,6 +1581,14 @@ int msm_pinctrl_probe(struct platform_device *pdev,
 		return PTR_ERR(pctrl->pctrl);
 	}
 
+	for (i = 0; i < soc_data->nfunctions; i++) {
+		func = &soc_data->functions[i];
+
+		ret = pinmux_generic_add_pinfunction(pctrl->pctrl, func, NULL);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = msm_gpio_init(pctrl);
 	if (ret)
 		return ret;

-- 
2.48.1

