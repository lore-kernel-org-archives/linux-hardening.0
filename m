Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50AE2147E8
	for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003797; cv=none; b=LLRXjxEUxMNalDvHTi26FF14Cqruyxwm3zhtT/NwN9IuYkf7FKSIxr9kp6BOw96+HD6q+qq1AErg2YJFlYgGcFNKMR76PAqG1jtRLJ2jqd9D8lLjULSMO9mEMc7102UoIrllsjtlMxVtb3wrtxtA4LBFp6lCsAWCbfI5l3jwZxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003797; c=relaxed/simple;
	bh=4SBDb8RMix1AfTeAapS22vbsprNHW5kDlKivkfzgJb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LR3jle9mTixzfUyNi2crIC4ssxoxUnAXo/gaFjcqqe7J7IKMkf5nbk3utRwtTNWx+nkNXysWBGZP+zrB/6fpu4XMI5cxyEuZh0FTOTYVpKIMEBulZQIC7i7qJuT+V/7o/i+HQ8NU9Xgjjon4FXi00EVkt0puSuH9fGS9yObwz1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SCR2iUJo; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SCR2iUJo"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-acb39c45b4eso1110773666b.1
        for <linux-hardening@vger.kernel.org>; Wed, 30 Apr 2025 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746003793; x=1746608593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsPhnEzsIjMyr2jWNVlW883QIlYElONTjUn31M/bDFU=;
        b=SCR2iUJouxyuhKI6WT29nyLHmzdiyJvYz0wS2PbWU3IhUKJXILJm7DFm1JvPbEPUbN
         +YZhPJgw/cKXms9tA/5A4Vce8D6AtQVLpZMpt+a5eMmj9T9JMQ900kqNN21C9PUSKgl6
         XweOc73qhilqfh11BHe2WICOT29sjPVcSvaC95w2Eeq2nRice1RA6s9pv5s5NBoJ80qP
         9iSoDsiDiJVFm9VYClO/oAgAhoBdSEQpMjfw11/7bVs5tOWx//l0cEWN2783ffpGZKor
         MRKEO7XQBs6GzKwjO6oVzv+MBmS+l75eFnG0BIUFKUP7/QA8JET+RL1PmvGVQc/ebUTy
         ilJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003793; x=1746608593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsPhnEzsIjMyr2jWNVlW883QIlYElONTjUn31M/bDFU=;
        b=bINErimNW40bc8avSXrDAiAzhT0zpeQZktTUejjYXqQ6Rs7Hlqo1vTO+Y3Ly1/KChm
         zJQbvQazj5+XreMqf99vA9BghZLiKiSopZcUVnAzTsUhfFrX2vrbwIpl8N60LTQP1GaM
         hte98Vmw7a/piwjwgxzBasUlbYckK1OURLqnJ7jr5hCuc/bFWjlV+UEvWO/J5SmXLaSE
         XSN6U4WRsjfTVp7TWYfjMkdxZF6//osw6BevAud7wLzoSmR14bFgPXMTNvPWDIMmeSBL
         y5M/B78pCqYAQqTopDwk7KiwLIcairAMZc8a4KLsEXCh8u/ZGVavzWMiJmD14vTIkyz1
         JjPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVSlDLUlPZYphKkdxAbbqMP8kE9Y54RBNloRIIgBgLDNNKE6obgt1AOJVKc3o5uaaKQHuNOcKaprmqrsQt8Fg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3upqZMLEBJHS45g+hYe3cb7W1sJRyXQmBnjKp0rW4GDSGF6pF
	k8Ta5CokLBu2x2kx6uuM1wMOJNAB76PqGqgltOU2iTtLL6MGXnfTdLg6EUjqIIs=
X-Gm-Gg: ASbGncsk95aIHuxmNDy+LKzVIwEk+zvKP3YOXQi1rm6iKUrcvDrOl56y399e+cGTuBF
	g+GuI/jIiH3PEwuNun/e2R2Ssw1BZ4fbBzkN2k4TBSyhG5+D158KUd/KvDusG5+xdYeC8UqhZgv
	Kqx4ucqBwO/mp1Nr/0xn3W2EtHtThtyr3H8LZik1HvWziD4K6AdUq0Q4IXVgaQCqSDUBEUe4v54
	ZaUKqFJzTG+nBvlNNl5r9XrwgeBUwSmuHH6dWjtV3N2YTjxzIsDf1XatOp3kfAFicHCVE7Kp4q+
	8cmMAW0Tb0EZl/30NffyBtTCDpggKMXH5lBbgYoCWcvLmbgimkfIwvgeOtfpFnMUwyFl7ze6J0X
	A7XhP4uizFh7sFLfOSGnyaybN
X-Google-Smtp-Source: AGHT+IHVsZ8xYEbEizsgZIRrUswi5I9gaZlF8LH7SsKiLHMHKzkdmybyODeG5bKN3kGAyjZ7wypovA==
X-Received: by 2002:a17:907:970d:b0:acb:66ea:5786 with SMTP id a640c23a62f3a-acedc6342a5mr263771366b.31.1746003792448;
        Wed, 30 Apr 2025 02:03:12 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbb6sm889676766b.28.2025.04.30.02.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:03:12 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 30 Apr 2025 10:03:08 +0100
Subject: [PATCH v9 1/6] dt-bindings: gpio: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250430-max77759-mfd-v9-1-639763e23598@linaro.org>
References: <20250430-max77759-mfd-v9-0-639763e23598@linaro.org>
In-Reply-To: <20250430-max77759-mfd-v9-0-639763e23598@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srini@kernel.org>, 
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
index 906881b6c5cb6ff743e13b251873b89138c69a1c..0c7bf694468e9798946baecdfd03d6eacdba2ce3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14663,6 +14663,12 @@ F:	Documentation/devicetree/bindings/mfd/maxim,max77714.yaml
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
2.49.0.901.g37484f566f-goog

