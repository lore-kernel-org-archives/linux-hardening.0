Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D1266568
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840174; cv=none; b=D7HE5LJfKDOSnaKELbX8z8SnPJ24r8XEZnVFH7JqqVca+GPG4LcU4bc5KinY9nNjh9A/mGsIQQskeiLv6ghoyFUaNncPk0Y4JESD8YR8kj1uhFV82nlOzezkstJGhv7AKV0xVI6hmx9p3I5cXRgCgDSoWlGfzSJ3qoAMoRm2qUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840174; c=relaxed/simple;
	bh=fxP0E3oz31A0KyqJHCt4y3Tc5HhatDkn1hFi7T2wZvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrBkzyzecVUrTZqwkTATMP6PQ23xm2uPJqFdTge2Ra4Uw47JjGUA9mjWgns0kzyTrWDhuyQ1y73DTYrxceUQyr9bJGTLp1Mwx0L8UwOB6MwSQYVA+YN+bAXbIKyfIbZe9tzxOm4IalQoHabAyEEvbiK5QuimmgmgOITiu/3+yD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Saoau0wL; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Saoau0wL"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abec8b750ebso778625166b.0
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745840168; x=1746444968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JJrHTizPWTsQy0MnTcATy6dqXS5edeA6vLqdvTWuGUs=;
        b=Saoau0wLBhkrpZbYWZuQbyRR1ITEtrJCc1GFCiqLA7RzJlt23CnoP+JZcHVMyE+4nJ
         XWincusB+epT1ALz34ppRzKxCNQ0zTw+gh5PLBdfjwdlYCvH9IplIB2aAAzYpy2+1/Mw
         p9PBjWvfgpKj8/MKfChYs6eRna94BFMdpXQgQd2tIfHC5LAqmcBM4jgzth478TU1JA3O
         LmzOEAnj6vVQ3GdJOTHRFaPvSydjDuuVD07VI7JdgXrh8g6yhnpSLrJzHvqWFsaw4UyT
         9X09EeqA5dcSVWLDhviU+AWpZ3NUIAc6koMX7eD+hKqmdIpsb19yIwHGf77lNksF9G9h
         6Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745840168; x=1746444968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJrHTizPWTsQy0MnTcATy6dqXS5edeA6vLqdvTWuGUs=;
        b=uJfxtH/yZ6L5bAQOlS86NI1knOkJJ/r+ee2sCfqoCqjgd3S9iupHuWBpvWiS3cHS1Y
         /SYl+RuexvjYD4yB9jHHrusS4Q+1wowJTWIgdGCNyxwD9CKd4h23HmTRK3Y8eDsGoeBI
         pW+DnOxp26jUg/AbrZKnCOJXU4Gi1d8Is1UJM8A/UcIlwp4m2jPdWT64dqrlXAqWtUp6
         vHjVG/6GERgTr0wtnBRK4y38fYL+wCQU6eLLyATIZPzsa51TCHEkIyAmXS9u877Va69q
         iROWE+G0n3bk4+0LOohZqfOwLeaq0VafukBLu4iRYnu3KUE/I6rI5hZ0UGtxWkjB4HEz
         Xpmg==
X-Forwarded-Encrypted: i=1; AJvYcCU7BiwxvDq+jzGS6RqXiBDzaeAY7ZeUCIRTSWwt7Xr65fuxp2WxWzXN02MPiongdvd7O6uKZSBhIWiVfeun8lo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT7nOdc6Ns5pmB6/7SBp+u6+rEFt7CJNiHcYSHX7YanM+o9GSG
	Tk0P39O0QBwnONuqspjO+WqwifHwzQ7u8GM633sp/Isoi5JtvbX9bNK1D6he9k8=
X-Gm-Gg: ASbGncv2oxu29gusgshluoK0K+wGvYfvyAuxAURXB1BXacsiIUwqZfcB8hYdYp1aN7J
	lWv6CtDyzJF6cfPQKHZT2GG1cOW19JreW5cipbT2tpujX0Mh71ckN/aXEqOrGvroP1SCcuTsVDC
	95HYrnYewnTp8j8g8UYjMLf+Lko8AInXAk09QxnxoDltsx0F/JbrOccwkfdt86ocKt1Nyku4cpj
	Ypjz+mXuowrMBtT2MT5FyI7PjJZusGkHbF9g8VOBj0uWRGen10M9kySWi9OB/e6p5UbJ9djTG8n
	bq4+CqeBKTkMJ3/56hfNv4j29NXPKep6R6M0FM8qMgrQl9ze5I8J7ZAvJBQQkoo7dh1FgywTJsC
	kUse/QlilkIzvC3aKUgEZsufd
X-Google-Smtp-Source: AGHT+IE27mdFaZB6jZVVsaB4JQjYpoU/Ho+LVougKPbVNZmJzND9lyh1kpDE5xRO5oFbeL2yqRSVeA==
X-Received: by 2002:a17:907:7255:b0:acb:4f46:9d18 with SMTP id a640c23a62f3a-ace710384b7mr1113661266b.3.1745840168003;
        Mon, 28 Apr 2025 04:36:08 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1580sm619937766b.175.2025.04.28.04.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:36:07 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 28 Apr 2025 12:36:04 +0100
Subject: [PATCH v7 1/6] dt-bindings: gpio: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-max77759-mfd-v7-1-edfe40c16fe8@linaro.org>
References: <20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org>
In-Reply-To: <20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
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
index b2c3be5f6131432647dd01f22bbf4bf1c8bde9e6..e4115fd92e879706d999fbccc2e41a97222eb0fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14656,6 +14656,12 @@ F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
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
2.49.0.850.g28803427d3-goog

