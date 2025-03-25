Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA5619F111
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891232; cv=none; b=qBXRFTLDcVBMTPPxyA4flPX0LirFzyRICLi7MJTcjloEW1tZrwdzDBZyjpBK7xo7uQXg/TiGh5NbP3EE5B1a3F2eGNCo/bITUm/roIo9gMk8dFsv9qUlIf3x036KgyX1sLTb4quM5vcE1nNNN6x8Xyc+x5BNmFj3Ul8NAssYuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891232; c=relaxed/simple;
	bh=08g+dfR3FV6Y6Q1D84qQqREWDz+FcRKr/yg3IyPY/+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C212hHQEzdCX50N23q0vF+bKonXMgSJ3m00daZHdUuf4A3NmYuR85VFFaGHKBbHK/LReK6hbN2D00c9eUpiutGiT6i+02vmMYjB7AEXMmZafY/sLtLYAV7LHieEZuonJo8sgK/NKwZprtIK/qSnKlj1h/dF3XcwCHB/fvcmnDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G6scjL9D; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G6scjL9D"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6c18e2c7dso9513754a12.3
        for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742891227; x=1743496027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6SEwl1TCy2+vIo8t3ZzKiS9UVWKw2bXaNUc9+NWEYzs=;
        b=G6scjL9DNmE9GB1Dz/XAmVfBhitUGsomcwc2XIJd9YMuEd8E+9bLZkYFrzqucrBjXC
         hcdMQckwsLHw0ioxKx8yBbrElCVMD3o1aTb4UTYXkCBYuvWJp49lefycQQW3eCk4V2Bp
         m6J44fn3topVeBztYrJl0invvyvSOZtzJgVJeCCerJR3M/0OhrzI6RLBbC+FEoozB8nA
         v0ZwDMMOnGt2K9qmHhyEO3/YlITiDsmlGgGCAZ15epUaGyIlzFglozWrKJTlHlYt8leg
         tHHa/kh2JJ2VvtsWsntOj4vvFhmvWzSq0XhFgsxK9K6jlAYE6/5fX2VVWA484TwSQEF6
         fmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742891227; x=1743496027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SEwl1TCy2+vIo8t3ZzKiS9UVWKw2bXaNUc9+NWEYzs=;
        b=SaTWZ89et6r/dITbWZEoeYEZ+K9TTfLiuTtK5pl1Mm5SYFEsI1tz55cQBA0i7n0zCD
         65prPI06N25gCIQs0jCLVUJy3iAo2GQIf/WTrFLR8QHTZJdwJK+v8YKPj1GTX5NGEy+3
         qvxGSg7m+GTzGuWsShRwqaeRjS+SFgDroBYEsAnZi6vGoxbKXWKw8bkZhOXCaE8pK1+P
         GoOMBp6n2Mnrkex30c5bOjHHy3g95n5PCdEMeLdTcMQtTbuRm+e5zeA6Q/P2sGUFEDZh
         WrYfa02SyFf7n81qhnQf7NKl1c9e4+i6MfDauMDHF42BJcCFME5zklQxDE12YppQOrHZ
         dTDA==
X-Forwarded-Encrypted: i=1; AJvYcCWT3o56F9sIW9e5/wt8qWksa+RUiZwqNH8W/7Il8oXvtbaUyzXa1OSHkgZBddUypHS6BOAdoV5mCEmYaVY5WZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1wbcsONaGYeZs7L/Mu9aT2ZIe6kByBbEPCLG9gyDcZTcYoj0
	ojYgOR/M48R9eNL0v+fZEZZhgi/eCsZclMZnEbaWfn/e+u5h2gsugomEE0dpu3A=
X-Gm-Gg: ASbGncso62P74oXiDIadkZKNhU1KBcuaFGkZ5OGVa6hl0bTv0TIM/m4JQbi3TfKeJwJ
	SUlc5Mk6NB1V3qWx1Q6qDfLvJJsO/F7rLw7dEYcqFFqH3WG+JctU1OrtzOL4IssVdYW6MbJeCzd
	zbIc0w2xwjm/O/mJgKHBZdxBrOdG3yV1ujA8g2foqFRrxGWqcrRoR+fhN/mVJwDRloZAHM/EvHD
	c5dJVp8fnpQ4x4h8qKpu0Ois0vSGamGh034E8nfq5P2rjgYPCf6oxeLoTwce3/14EBbEop6k/VY
	o4Zd11Gu3KGOSPIU6Wvi+Aaa8azKRwPbmqzoRUvxHCWf/012pDcF3Tdr1ZxQEe9We4GT+Sb2qHQ
	8hvwIXvS+tFd+4sBUIDUZWIMKyGUv
X-Google-Smtp-Source: AGHT+IFGom1pvP26uA9aKjTrkI6D6p34D8OfrDEsjpJgJY0txiyido0Z3dDxMIp3H950t0uf76P28A==
X-Received: by 2002:a05:6402:2816:b0:5e5:49af:411d with SMTP id 4fb4d7f45d1cf-5ebcd476285mr15315373a12.17.1742891226502;
        Tue, 25 Mar 2025 01:27:06 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm7377366a12.0.2025.03.25.01.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:27:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:27:02 +0000
Subject: [PATCH v6 1/6] dt-bindings: gpio: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v6-1-c0870ca662ba@linaro.org>
References: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
In-Reply-To: <20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes its GPIO module.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
* drop 'interrupts' property and sort properties alphabetically
---
 .../bindings/gpio/maxim,max77759-gpio.yaml         | 44 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..55734190d5ebdbc351e1f91675dddd8a9db80cd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/maxim,max77759-gpio.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/maxim,max77759-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 GPIO
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The MAX77759 is a PMIC integrating, amongst others, a GPIO controller
+  including interrupt support for 2 GPIO lines.
+
+properties:
+  compatible:
+    const: maxim,max77759-gpio
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-controller: true
+
+  gpio-line-names:
+    minItems: 1
+    maxItems: 2
+
+  "#interrupt-cells":
+    const: 2
+
+  interrupt-controller: true
+
+required:
+  - compatible
+  - "#gpio-cells"
+  - gpio-controller
+  - "#interrupt-cells"
+  - interrupt-controller
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index cc6536141bb3a06fa6bc411ac69053b8be17e0b0..0abd85ff6fdee93424ee3634c56fbcbcea1a7855 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14568,6 +14568,12 @@ F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
 F:	drivers/mfd/max77714.c
 F:	include/linux/mfd/max77714.h
 
+MAXIM MAX77759 PMIC MFD DRIVER
+M:	André Draszik <andre.draszik@linaro.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/*/maxim,max77759*.yaml
+
 MAXIM MAX77802 PMIC REGULATOR DEVICE DRIVER
 M:	Javier Martinez Canillas <javier@dowhile0.org>
 L:	linux-kernel@vger.kernel.org

-- 
2.49.0.395.g12beb8f557-goog

