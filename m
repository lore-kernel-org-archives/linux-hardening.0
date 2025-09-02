Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5641313557
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814389; cv=none; b=cGH04Bhd9Xm+mOHK84sm//nMdaZYbn9Mazd8i7NlfuozQo9e6WfNSe8siKNYM4vTZAWFEWnKK6WhVwxQ1cvSGx0TBl0Ic8ceuIYahTV4dVlAbkJUil/djpvUUcc4Uke0qfmw8JbntY0e+vhruyw+5eoWzDnlThmRo20oiJMOtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814389; c=relaxed/simple;
	bh=6d9MjHR2YhTCisvLaCVyCEkbUcnGQXIAZ1ywg14KUyk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oJPsg97ev0unai42YhGfXNL7uQfqxov35jK3nm8dN1eY9wyFpGxTCsbk7fd5J5wsW+oyr3FvWiM8rN8sBI7yokxb30AgrS1MGmdtR23vwxsVy9gsh0C2/soweald76lLKZuzTJ528ZyQNOvoJBaNVxQ8Ap8lg9yGJR6mLVb6umM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kemE5V4x; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kemE5V4x"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso4535692f8f.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756814383; x=1757419183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZoRwAWe6yFgH80j8Guyt3bkXloByFSMSyop0nIDEao=;
        b=kemE5V4xiv6zhcKiyB0S8kkfARev8ST2Nz3SMyXXjVJdhZL8QkAJr+mcAkDcnPwbEd
         dbwU+kcLm4/Tgi/l3X6SyA6lhQfPjRrqK2sBN5qVNFhhvNWTYul+3mEbIrfMnIhhxBL9
         /yIVeE51yro1M3jJgYk+0EsAeQoRKdn1EV+iDy5RafJTrsXoRoVAYOANgJpIU+fYw+5R
         aqQqj9YYi47VR3NL/uM3SOOVXEdkUU3PsEzJgrCCS39i0H8fRTfn84PLRG+6zrX1lQGC
         teHWNcRA9EEdUjekBqergokimqBfBrwtcfkhzNaeIjJKLNQMuafKiR0LC1CtS3RGdCiQ
         Zn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814383; x=1757419183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bZoRwAWe6yFgH80j8Guyt3bkXloByFSMSyop0nIDEao=;
        b=Xx4Kf/lQuRIr80enV3U8VO779qSCdtxWzF2DUnB4fp35QDVEYn660SlouvZ+3dGE0H
         R+lOBbcuz/N+eY2CGJ7sGAWvJ8sd9Z/wNiaPMShb7k5DfQ6pcHK06MfJ2ezWl0SxrZCc
         S5e451dGfzq6y3rzfLWCtdxe0LmmmhL0ONd96eYsLj9Cv//Ek7TgFoDXtcPLShpmqfEh
         RRbM2XrE34vt8aPeWgEiaZ3fYNcpHd39MBBcQ2dAH2/w3jgxhY4xmpvyInsIcSV6o3f6
         dkv4LD5+c460v1BdL3oU8XYYMalBP9tXVADYH9FujOtqusJMGdY1HcGl8JPKAgNYlDdE
         qweA==
X-Forwarded-Encrypted: i=1; AJvYcCWvT75ObapWUi7p4xibE2Irs/33qGrITZwn3BXQPpj9wYQcgtOGWbKlujAOq1jCthCI4OYbpp+JPYpxeuHptYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIIU5AtmX+/AqBCdtZUVXOIK50i1kgJMtwuGuNXkqipc7osKdh
	c3W26xpnDAvnyof/f1bvO4aH891Mxl2pPbhJS1xf4Yc7MdYgC+VGsVbmmtZ9TOadWK4=
X-Gm-Gg: ASbGncvxx1r0BAiEY2ogdXlcSd32zPL6/avEZtfJaj+SAvmSr2xSmwRZcpFFnJndD+7
	Y6Z4F++yngo6gsrTsNnuk15cx1Qb2CDoZv8CtINpdwRFg/oH8If3QIiOqX5lAp0mPIWvt15qnz/
	B97KaZXYDxYIvB7tWKDzUxnENGG4AfbmWXc01Q9sZ4PJEIKo08XAZibAFMIqw6WzS5jgtbiFI4t
	GoQWJWhV4HEoEnNgiLpICkeal8NqDls72xq/Z15LBYl4jekUAKqtQd8hE9KLkNUOkSCQcsDfnMk
	334qkyn6qL7E0F2onNBitgy2luldJgd+OhydYFvI6N12VuSrFN3QPtf2sPTg3T+MOvVwIOJptJ/
	nTlc7D0sOxZCN1PBAFepNSWw6pSU=
X-Google-Smtp-Source: AGHT+IHihsnMuL05+vqbU1MvgQT0F+2Pejjix+ounk5ux1VyL7KdAqS4iEwvv3M3i/aDvS1YgEbYFw==
X-Received: by 2002:a05:6000:1acd:b0:3cb:46fc:8eaa with SMTP id ffacd0b85a97d-3d1de5b087dmr9071418f8f.31.1756814382749;
        Tue, 02 Sep 2025 04:59:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3327:447f:34e9:44f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm10224195e9.16.2025.09.02.04.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:59:42 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 02 Sep 2025 13:59:23 +0200
Subject: [PATCH v7 14/16] pinctrl: qcom: add infrastructure for marking pin
 functions as GPIOs
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pinctrl-gpio-pinfuncs-v7-14-bb091daedc52@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=YcrXV+Vw/YHr5QitFviEgvwH6L2clCkUiJkOzNHp++Q=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBottwUt1OLXwkEzKoyV51MgdE+jkRh1wSFrqCYt
 Vx/Yn7dwPyJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLbcFAAKCRARpy6gFHHX
 cv6rD/4/T+Qmd60Ccvmhx/iayQBqYuiWX2dIgsN6ptYMZPxH3lMhAjcyUTDe0eLlcA5KhOrzexH
 jqtqCqq/9JjES+aB5QllNPZSkMWARLzm8TbUEJfWBiCUfzW6G3IKJyzPlNTTYqVeIvhsSKfgCmv
 QWdcag5NzqCY6gKbKw7yFlbwX1vSpzMPvHZfThPRU/b7acMqdTixRbX4p82v8yfWBomrf2YPAxF
 HNHiaWoxArt0IuU41K9SrV0bWr7NhN6d8T1lRHbElpUuREWjXUkVZuAmO10agrMYGFKWLa9txPi
 4TASGnIkv6iU+7pbKOnQx93qTnkOyybTQ36jPlfCdSM96g33OctlRbaHJMWgwT9LQcGCeU/SvP+
 XO1yDDk72nuvYW06zU6f56KjqYxpGwPbs6rcWWs5hDDCyZaRsW2hjmhSl74EBy8tFnQZIwWsaF1
 8qNVhRbJpHrHr9QbM7CG9SQ9y8zVRVG0oV4jPqUV0Udf9sLgMaj0lH7n4v8HPpGeTbFSQNy8haB
 FVxnGiavvme6IkSRNMKQYiRTqKVegC/zsQSeUCdMvnPW+GMvQFj4kC+gc21akybe/N7SOsiQ5pB
 /rLl0+WSQVyHKvouXSW9LJKrXGy0cPRzk1A+pSR0ba5zneegrMyjCFbeB+P97W8RfuwxF3Vw69I
 1xsWVkKRbjBpFeA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a helper macro that wraps PINCTRL_GPIO_PINFUNCTION() for pinctrl-msm
pin functions and assign the .function_is_gpio() callback in pinmux_ops.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 1 +
 drivers/pinctrl/qcom/pinctrl-msm.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 96e40c2342bdedb8857629e503897f171a80e579..a5f69464827119dfe2a7781b558094b283fca215 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -265,6 +265,7 @@ static const struct pinmux_ops msm_pinmux_ops = {
 	.get_functions_count	= pinmux_generic_get_function_count,
 	.get_function_name	= pinmux_generic_get_function_name,
 	.get_function_groups	= pinmux_generic_get_function_groups,
+	.function_is_gpio	= pinmux_generic_function_is_gpio,
 	.gpio_request_enable	= msm_pinmux_request_gpio,
 	.set_mux		= msm_pinmux_set_mux,
 };
diff --git a/drivers/pinctrl/qcom/pinctrl-msm.h b/drivers/pinctrl/qcom/pinctrl-msm.h
index d7dc0947bb161868c8f433dc2536719b8afc8bd8..4625fa5320a95a4d24e3a0c98a249e4f163dd4c7 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.h
+++ b/drivers/pinctrl/qcom/pinctrl-msm.h
@@ -29,6 +29,11 @@ struct pinctrl_pin_desc;
 					fname##_groups,		\
 					ARRAY_SIZE(fname##_groups))
 
+#define MSM_GPIO_PIN_FUNCTION(fname)				\
+	[msm_mux_##fname] = PINCTRL_GPIO_PINFUNCTION(#fname,	\
+					fname##_groups,		\
+					ARRAY_SIZE(fname##_groups))
+
 #define QCA_PIN_FUNCTION(fname)					\
 	[qca_mux_##fname] = PINCTRL_PINFUNCTION(#fname,		\
 					fname##_groups,		\

-- 
2.48.1

