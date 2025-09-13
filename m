Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6712857C1
	for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 21:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798497; cv=none; b=DWr9xEWaCyg0JfDVovTYGdl8YyiZmI0ETIpp1pd3EW9kLqB7rHhIh8FNBndm4VPalsxC+Q02rnUAK1JI77Y+Eh6O5Xis961ubj5xwuRs6kx7sRt163ajvPeEPKEM8SGuY9LDWq3HdOao16BV/E+YYriEUKKg79dabieLb/Y/eTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798497; c=relaxed/simple;
	bh=uNF4o+FlWLCTLVTWRxLW7Lyuky8hKhwVnIT0SNYmZcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h2UKej15CJUgdkDFSpIvS4mN7jH+ya5pOppYmMrDCNN7ya6jGAMH429RymZ1LFcj0ylFbSatWQnF+KvrUfaJRuffIaCk0eTTPrI/XSkOQtz+/pXo7tP1yfgtC3Iv0vKao1c2Q+sdkU2ylk2Rpn+qTAXtFgovyOGesjX50BkvW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfHZ3JTT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfHZ3JTT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so26697435e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 13 Sep 2025 14:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757798494; x=1758403294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1pL+OZ1Boa6u+YXgScmmKOffrAx3fdC1TFoaMx+6KU=;
        b=cfHZ3JTTFt01f4ehfJRbcSS4SDj1x/bUXwbUzCW+fMrBqtUToYvizBJWw7U4lqd8J6
         4OEsYX2ApZKt0xVuRFeapCieL/IKUscpTuoiKKuN02QadLCMKE0wevSYEXfsv9iG1CxB
         reL1NjeAsijaadDF3/gK7InqIsuovf8zJsvg9aiIDUTUKhxexDgpE7B/VSKk+PCdVyi6
         MmyEPm/vMUzmQ7C2c8V+T8GJQBQRhL9quEy60I3vQx5l/QS0vxoD0WUzeC+1QM+pROr+
         vfpTlRZj1sUS/mOIirua43XUxVgD8Kjpz2VPuWkvraDBb3gNcZJYOmtUd55tvGmvj2X8
         m7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757798494; x=1758403294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1pL+OZ1Boa6u+YXgScmmKOffrAx3fdC1TFoaMx+6KU=;
        b=hpRW1yMAkv9CqhlLOUJb/YCzjwHbccjeN4dD3iWY30+NkABwsCVb+6yT5lvwGZkyzz
         Fzj00fdB93xfOJOsginsFxvsiQNdOANdiVGl4MLIqrwO62CdVbWGQpGrouD+qT63bTbI
         560fLbusl23sJtamKsgn7FbudS0+ef52XLP57U9O/Eljin7VweVCYDVQssEb/gojtqfe
         0s0hh4QaxjqmT02lNp3rGPnRDVgXwzG+J4000uDyACSbkXs5dbiIjnfgwtuRzTicYW7a
         zMGyxRUyz4Z+pijK8z7SGDoSby6mbnMts+j/26kLHQHki2unO0+HZYaKM1Vhw8ZO80JO
         SVCg==
X-Forwarded-Encrypted: i=1; AJvYcCX+DOoADvSuwyG2jLR9IyTd3H2zbT7hDf26+OXgM+vtt2HP7x+bR2mhh2qV3SsZeYjhV4JJiRBESp9LCcScxtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz82tAnFw9ghQwKvFo8rO7p8ndbvXRDWCvKiACHZPZjer2ugSIe
	8P3sdDx6B/MiaPYPfkVs+7N8WLel87AxcszdWsHmulKvhEoRzUlt/OC6
X-Gm-Gg: ASbGncvxC1QY0p2CyZf95NnkChT/tq/gEfW2gA84gXChbnbhsDw5E5APO92nG0o9SBr
	YvrNrrdXk7z1QMpvo6NcGagXoPCgQJVu+u5xKpvZvlnOjVLod533kYyzfk4AxXCnV8i2omJH62S
	o4TZ+LevPejamW+Ite+B0OGfMdjkOcOn0x3lYB+WqL+Ex7xeM9K0XUqvR+71JFyr41SMPpNFOCn
	9sNj714QPVGR1WTqEKmdur6GAUwlo5EvdcHu/sf/HB1HR+c1iSx7h2hsbrklKI7osW32kJXUmoV
	Qmnqqliyr+/Z6VmgvceJ3BNFTZ4GSuQs0Scuyyyx9723ql0HINVgTLtYNNLuyngubpeaqDeYrcg
	RYyAsEV2Mh8CKrZTg7DiChA06nIOxw2sf7R3nzMEuCNn0m0HVtoEZ
X-Google-Smtp-Source: AGHT+IEUygTfQFxD0Xjd1YPk8jG2g29zmtJi+7jJLe6De4WxzayNW1WWv1CJtbsKPSYW8CMC/jCaBg==
X-Received: by 2002:a05:600d:f:b0:45d:e531:99df with SMTP id 5b1f17b1804b1-45dfd5ab3bamr97128825e9.3.1757798494216;
        Sat, 13 Sep 2025 14:21:34 -0700 (PDT)
Received: from Radijator.localdomain ([93.140.65.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd6absm11576842f8f.34.2025.09.13.14.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 14:21:33 -0700 (PDT)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <dujemihanovic32@gmail.com>
Date: Sat, 13 Sep 2025 23:21:07 +0200
Subject: [PATCH RESEND 5/9] arm64: dts: marvell: samsung,coreprimevelte:
 Add vibrator
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250913-pxa1908-dts-v1-5-8120cdc969b8@dujemihanovic.xyz>
References: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
In-Reply-To: <20250913-pxa1908-dts-v1-0-8120cdc969b8@dujemihanovic.xyz>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Karel Balej <balejk@matfyz.cz>, David Wronek <david@mainlining.org>, 
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1770;
 i=duje@dujemihanovic.xyz; s=20240706; h=from:subject:message-id;
 bh=jyb7dMVKfzm+pC9ukuRfnyNGN4DBhDuznQcq0ZsICNA=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDBlHH/j37juY9Cokv79Ivex67/u52+yiz786v2NtQu+Kn
 W9sVvlId5SyMIhxMciKKbLk/ne8xvtZZOv27GUGMHNYmUCGMHBxCsBE+lMZ/se8UnkwxUnpNgP7
 C83rcy38H4a8W2+xQN79ernL5Qu6boqMDKt1+L48Ov2+rGaZ52PZPb8kBU7dail6FLLr4sG8yZz
 LLzMCAA==
X-Developer-Key: i=duje@dujemihanovic.xyz; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03

From: Duje Mihanović <duje@dujemihanovic.xyz>

The board has a vibrator hooked up to PWM3. Add a node for it and its
associated pinctrl configuration.

Signed-off-by: Duje Mihanović <duje@dujemihanovic.xyz>
---
 .../marvell/mmp/pxa1908-samsung-coreprimevelte.dts | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
index 78b7bccfc5f299889d1b9a8fd2c08554f17eb147..c28c2eadc42cc538fc5491ecdfcfbe0191004794 100644
--- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
+++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
@@ -121,6 +121,15 @@ backlight {
 		ctrl-gpios = <&gpio 97 GPIO_ACTIVE_HIGH>;
 		max-brightness = <210>;
 	};
+
+	vibrator {
+		compatible = "pwm-vibrator";
+		pwm-names = "enable";
+		pwms = <&pwm3 100000>;
+		enable-gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vibrator_pin>;
+	};
 };
 
 &smmu {
@@ -365,6 +374,16 @@ sdh2_fast_pins_2: sdh2-fast-pins-2 {
 		pinctrl-single,bias-pulldown = <0x8000 0xa000 0x8000 0xa000>;
 		pinctrl-single,low-power-mode = <0x288 0x388>;
 	};
+
+	vibrator_pin: vibrator-pin {
+		pinctrl-single,pins = <0x12c 0>;
+		pinctrl-single,drive-strength = <0x1000 0x1800>;
+		pinctrl-single,bias-pullup = <0x8000 0xc000 0x8000 0xc000>;
+		pinctrl-single,bias-pulldown = <0xa000 0xa000 0 0xa000>;
+		pinctrl-single,input-schmitt = <0 0x30>;
+		pinctrl-single,input-schmitt-enable = <0x40 0 0x40 0x40>;
+		pinctrl-single,low-power-mode = <0 0x388>;
+	};
 };
 
 &uart0 {
@@ -409,3 +428,7 @@ &sdh0 {
 	bus-width = <4>;
 	wp-inverted;
 };
+
+&pwm3 {
+	status = "okay";
+};

-- 
2.51.0

