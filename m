Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C63128D5
	for <linux-hardening@vger.kernel.org>; Tue,  2 Sep 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814381; cv=none; b=Af0kS7tXa6r+6Y0/iI3dJRh8w5ljaM0N2yD9dB2Li00/OZcu6CBxSelqj13RmTu+ewWY2fQIbgQc6b8JJV2ivZh0Y4fsXxKCGDYoE9cWT5wOaqvR83msOHOfIPOxMdZMiFQzZc8XRh+L7iu8vVHoGWylsZNw8Tcvv33KpYFav9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814381; c=relaxed/simple;
	bh=/WoBx7YcDnY5wm6zfflRNeXj5FexRbP7TbXPY2dLB8A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKLfqHOjPstALtkha8vdMC4ANjZPyJdFc6buLmD0CRcFe/973+zV793C0aDId03ODH8EfJ5T9s06BVEtx4gN8aVdT/mJSTOioX1jjMAA9+w9OT1zi6S2AMHkXSz92e91CmpiRNF7+/90v0xU5aYuoTSB4J9VXZSz2KmzsRcYy9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=MG1yyfOy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="MG1yyfOy"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so2864705e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 02 Sep 2025 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756814374; x=1757419174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2G59MubZTeiU7liQ7BG00dmfAPEuJzh2uMSB42Di6Tc=;
        b=MG1yyfOytwBcNc6rluBRMLrOxvoFIWZTvyo82aryaUoRmUv9BuOoVQTS2LZ4awA2I8
         9JAk2AAqykCFOUVWTVUFWceipnIdwV2CaaDZAWR0xYSvyx4PgthTJZ1UY+C2J+9Yf92Z
         XOL64tojLmkphdn6SkjnQDmLEzcIy31J0mBbKr6WAaLC9227sdyohtCt73BoDfN32Bx6
         FUkr+ZkPJ3KmqiejpR/9fGJ2YIlTQiMSK+fcR7cpwqk8WeKOXdiIpV2/2WzqG6YStQqQ
         XXhIxFid0DJOSBT3zCoiBqOusW3RPhbe/uRVQBq65Ww7yyP9J05lMC0vFlPUDLLRQD4c
         BBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814374; x=1757419174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2G59MubZTeiU7liQ7BG00dmfAPEuJzh2uMSB42Di6Tc=;
        b=bLmqYpuYczYPPOVm0knqb2vGZW+++ckWIhOdklwUVOMlO+wwwgjRTzlU4zwdLWOuwF
         zSRbCZji2ohgB4e1xoR4cIrc8FB7f/xcjY+ISPABBWJNs6hObYcEnRYPQSqbDgIVKQMX
         udQT5oJYC9XOsnS5xoERuJ+cB3YFhL73UTr5l0U+yUDs6q92RgmsJfQPzNgzxd/au4xl
         y+GY6Zl3hm0M6V9o87VlTqwoG5+50yJi/FeBzSQfOSC1wL6zRVQDlGDsGLMZjo507ama
         3fxIRsxOObm0rJY2YaRBlYSVqxOlhllx1fOGcAgR1v3uOhsif17XWNKIiuLnFfGB2yZ+
         LPng==
X-Forwarded-Encrypted: i=1; AJvYcCUOkFPqjVnmSFMXmszGOlFXUITj9Er4vkO0hNlo5312/0IG1/PwVaDjdU9L20X39igkpUOLTp3cQs1H1jhIbZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMFML+JpwyHT10t3h+SC3kIIYQ0tyloYiM20koB4+P65jvELMe
	l3iNE3kdzoB1BBUEh5iqBH3FMejSW3QQ+bG0pZnd4iuL2qV9ohmPgIz+4ab1lG2nAbg=
X-Gm-Gg: ASbGnctMJtfXkGF6T5fgIhaJaqJvXWLaGoq785LW9XgdDtOxOZ4Wl9AS7qYdPh2Heyh
	tV7R5+0MSNfwhjXornGDetL0btsWglOYrl5giOjTWo6Xrc3nNQTRuwRphKKri21vhVLTvaRIpTY
	gDkXo8q+MIBVm3jwdKpCz6m3/l7ewIXSf4U04M3hTA111qzDIROAn5Fvj3til+aYdEjjrqw5sy9
	sP2yIZTkhvpOqaID2NeCHOJRtpFdRutwb+ghSnMaD3OyLBUIK6mfEsNKdMjYXwq6025P1cq6ysX
	eMNDW4TN+tROUE52rQchSGpuf7RchxMTVPornrbUGUxhV1f0QJ+odU1ty4RYDDMRlNanjEqfnZ9
	2Q14pK8cCHwkwbdCS
X-Google-Smtp-Source: AGHT+IFLYpm7MHCoBbrYA9yPFwTU4Oi261s/PzucYOvn9j2GG1ZzAR8wL2RYvG0trkoc4GH+jx5MDg==
X-Received: by 2002:a05:600c:1d07:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45b8553417fmr112095205e9.16.1756814374299;
        Tue, 02 Sep 2025 04:59:34 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:3327:447f:34e9:44f7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b9c234b24sm10224195e9.16.2025.09.02.04.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:59:33 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 02 Sep 2025 13:59:18 +0200
Subject: [PATCH v7 09/16] pinctrl: keembay: use a dedicated structure for
 the pinfunction description
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-pinctrl-gpio-pinfuncs-v7-9-bb091daedc52@linaro.org>
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
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3029;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=ow80ySNnxG4YPhFZmsqjHWDVkfwZ7d2knu+v5a2fm7Y=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBottwTalJ9xEimLer/4deaUbuj2xh0hSCbfKp6h
 mSFLsj8wZaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCaLbcEwAKCRARpy6gFHHX
 chHMD/9qieRrB7kLN2tVVNwNzCXwCyEqCxacgLrSqioX/qG8i5nUPX7EHz277hj9w0PidEZ1ntG
 zmHYDlqsFEPXAuTkXZgG9SopO1HVkY71LVr0hPzCGA3VBpWobmAQSKm/9IMrJPw7ZA2XtQhX32p
 kda1warDySg74DriEQwkfYimyMZ3TQ7pHNBxj/YXFrUqHE2bOWZH7roy8l5AF5dB9oc6S8PQ+Zx
 iS/JncN6wC6U5Ah+lX+mMsuTa6M5HJoJ+Rn00ffY3hUzSpJvZncDxwqdY5oYbRIUnhm31mZ3u+b
 rK9QwspUrOmf2xLBv8KmvqFUo1tNgbKyH8bEe2ODS40J1m4xfAyT81CicpoTkW4hTRN/LoWDmRH
 RUnueU/QhNGG0LtvDy3EesY1kCD0PHgPfvs0eknqOYCNnbgVchgt+WJFs8yWWN/Uh9jHUfgspnL
 GXaBzcEcN+KMnMuO1WjghdXpJcpBfPZK53ftw/blY6FQc3I9OrH6wBgTL7SWFN6WKIrNt6xs3u9
 a62AdwWvXg2t1O7dAJlzT2n25b2Gw+nGqFBM6MI0xKBrxIiV0fCxwFjWnVp0y7jsPy+6f43Jma3
 oTrvmRfRyonsRPxFZ6I3JXqC+NUq2IfQ7hgKvO6WZzeEHpqX0fiqO1ASQcW9zStc6L0O7YQzAEi
 yx6zfFbIqCxZOpQ==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

struct function_desc is a wrapper around struct pinfunction with an
additional void *data pointer. We're working towards reducing the usage
of struct function_desc in pinctrl drivers - they should only be created
by pinmux core and accessed by drivers using
pinmux_generic_get_function(). This driver uses the data pointer so in
order to stop using struct function_desc, we need to provide an
alternative that also wraps the mux mode which is passed to pinctrl core
as user data.

Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-keembay.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-keembay.c b/drivers/pinctrl/pinctrl-keembay.c
index 6aefcbc31309995ec1e235416b40aab3e4a073a9..e78c8b3ec245aad56e3e74a26d27c41ba4a98281 100644
--- a/drivers/pinctrl/pinctrl-keembay.c
+++ b/drivers/pinctrl/pinctrl-keembay.c
@@ -135,6 +135,11 @@ struct keembay_pin_soc {
 	const struct pinctrl_pin_desc *pins;
 };
 
+struct keembay_pinfunction {
+	struct pinfunction func;
+	u8 mux_mode;
+};
+
 static const struct pinctrl_pin_desc keembay_pins[] = {
 	KEEMBAY_PIN_DESC(0, "GPIO0",
 			 KEEMBAY_MUX(0x0, "I2S0_M0"),
@@ -1556,13 +1561,13 @@ static int keembay_pinctrl_reg(struct keembay_pinctrl *kpc,  struct device *dev)
 }
 
 static int keembay_add_functions(struct keembay_pinctrl *kpc,
-				 struct function_desc *functions)
+				 struct keembay_pinfunction *functions)
 {
 	unsigned int i;
 
 	/* Assign the groups for each function */
 	for (i = 0; i < kpc->nfuncs; i++) {
-		struct function_desc *func = &functions[i];
+		struct keembay_pinfunction *func = &functions[i];
 		const char **group_names;
 		unsigned int grp_idx = 0;
 		int j;
@@ -1588,14 +1593,14 @@ static int keembay_add_functions(struct keembay_pinctrl *kpc,
 	/* Add all functions */
 	for (i = 0; i < kpc->nfuncs; i++)
 		pinmux_generic_add_pinfunction(kpc->pctrl, &functions[i].func,
-					       functions[i].data);
+					       &functions[i].mux_mode);
 
 	return 0;
 }
 
 static int keembay_build_functions(struct keembay_pinctrl *kpc)
 {
-	struct function_desc *keembay_funcs, *new_funcs;
+	struct keembay_pinfunction *keembay_funcs, *new_funcs;
 	int i;
 
 	/*
@@ -1614,7 +1619,7 @@ static int keembay_build_functions(struct keembay_pinctrl *kpc)
 		struct keembay_mux_desc *mux;
 
 		for (mux = pdesc->drv_data; mux->name; mux++) {
-			struct function_desc *fdesc;
+			struct keembay_pinfunction *fdesc;
 
 			/* Check if we already have function for this mux */
 			for (fdesc = keembay_funcs; fdesc->func.name; fdesc++) {
@@ -1628,7 +1633,7 @@ static int keembay_build_functions(struct keembay_pinctrl *kpc)
 			if (!fdesc->func.name) {
 				fdesc->func.name = mux->name;
 				fdesc->func.ngroups = 1;
-				fdesc->data = &mux->mode;
+				fdesc->mux_mode = mux->mode;
 				kpc->nfuncs++;
 			}
 		}

-- 
2.48.1

