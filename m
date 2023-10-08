Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F8515D1
	for <linux-hardening@vger.kernel.org>; Sun,  8 Oct 2023 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zNmONDL/"
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23720C6
	for <linux-hardening@vger.kernel.org>; Sat,  7 Oct 2023 20:36:35 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6c4c594c0eeso2341727a34.0
        for <linux-hardening@vger.kernel.org>; Sat, 07 Oct 2023 20:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696736194; x=1697340994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O46Z79/thQ1J3qOk74OlVCEf6C6SSN1l//6jVCg8hMY=;
        b=zNmONDL/Rio2cmoS1E9S64+48isst4YaPeRvvYGG5wH4h1H5OMjyYny3I3HDVzlifD
         FxfhyKPcs35hfheaJDS0IJOhwlz3RXuElxYuAEWGafN7M76vog4AL3NByF8cdWM6eSM8
         rxeoR59SO4GH6jcIy0slkUpEX1YVAL/iCF4DIDkWK2Np+TryncKSFO649NrMbGZ7uf2q
         s3rqjavv6gkhu4kX5jxuuBlB5/2lVQ6sfDI9Y78b32qteIJfz0Q17UzBMOte2gMPr5pr
         lVZMJhDHdjkvfQhdIbQhqSRntfbK5TPR0fRlT9AxwdZ5GWPt4kNJPtls9Jc4X4O81vPZ
         YTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696736194; x=1697340994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O46Z79/thQ1J3qOk74OlVCEf6C6SSN1l//6jVCg8hMY=;
        b=ibtyIQIj+Y8EwV3Ae+pz4qTWwV5K8CQu7S747dkIIDz7RKHIUj+IMno7EJhSoZgFtq
         9m4qpOxtP0b9Iio8/4FjqQeNEp0kGB0HAGfkFVS8aIUt4kQVcd6nLm1nc9991p+vqXcQ
         n37wyg7gORKJ5YqxUrlu3z31p62yAeyRG4aLq+N22UFHpo1uYubv1dKKPD4SryRvFd2Q
         lIhaRGHmdvuxynCjjJ2LtlMm8fYvqQ5ApY5GOENa+KMK+mM67j6wlcUo8hoaabSRz8rI
         +zG+RSeV+lACe6yN2YKekUqyvNl7fhnXClQLe65xyq5sx6Rt2OLxfgib8V9YyHsJFbQJ
         g7Aw==
X-Gm-Message-State: AOJu0YyOPsSKIbkFqyV2gkhj3VNi04FOo81bNS/c+j895P9OwIa4dxXX
	8p/NoKo+mK6rj2GaidP8aKUCzA==
X-Google-Smtp-Source: AGHT+IF2WJna5aTcHCff9FDb3AFiiR1caqvPjH4/+qNmboSMrw0kS/evk2m4kO5zetYpq0utIAPz9A==
X-Received: by 2002:a9d:7a42:0:b0:6b9:4216:c209 with SMTP id z2-20020a9d7a42000000b006b94216c209mr12258669otm.12.1696736194435;
        Sat, 07 Oct 2023 20:36:34 -0700 (PDT)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id c11-20020a9d684b000000b006c460c58b00sm1104080oto.2.2023.10.07.20.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 20:36:34 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] arm64: dts: exynos: Add reserved memory for pstore on E850-96
Date: Sat,  7 Oct 2023 22:36:33 -0500
Message-Id: <20231008033633.21304-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Reserve a 2 MiB memory region to record kmsg dumps, console, ftrace and
userspace messages. The implemented memory split allows capturing and
reading corresponding ring buffers:
  * dmesg: 6 dumps, 128 KiB each
  * console: 128 KiB
  * ftrace: 128 KiB for each of 8 CPUs (1 MiB total)
  * userspace messages: 128 KiB

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos850-e850-96.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
index 8d733361ef82..d54c8fa55c09 100644
--- a/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
+++ b/arch/arm64/boot/dts/exynos/exynos850-e850-96.dts
@@ -59,6 +59,21 @@ memory@80000000 {
 		      <0x8 0x80000000 0x80000000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		ramoops@f0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xf0000000 0x200000>;
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x100000>;
+			pmsg-size = <0x20000>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
-- 
2.39.2

