Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003C22A1EC
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 17:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592289; cv=none; b=VYm/4wm367H6Q5Xl1dru22V6Rb0CRO+A6kIKLul8zQyenMMMzm25k67XSW0PU1wjEjH2SIFxoST+uF6wZFLSBwK0rMqpnB1aLnQirODAWkbVhXKKcCl8qXIdCXklt310pBq2gUmpGq6f2WZTdxICRJO726eorlcqq0/XAkTXxVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592289; c=relaxed/simple;
	bh=I4feaQK2NeL1iMZsywRHTjEz/SueHsximMXGo9uKgLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mfhv6ZNNKX6SlulmonuN1pUwMJD6yiB/TQOYmQL62+Ixa66iyXaBxO9rVLLM6myXYyVLLkd8hVxc8kYGkRRTGf04tYlHlNf8HBTkcgjQhJXbYOKsD1/KffU2rOkG/1SiC4JnumGrbQ9t9HRchFmURVGBNA52QAa7nyvFwiDUcyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=km5KCfub; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="km5KCfub"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-abf06950db5so7973866b.1
        for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740592285; x=1741197085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9YomS+c0wThxhIl04CUTErMlrQA8JmWzVl1nv3uerI=;
        b=km5KCfuboEwYf3Lk8LTH7jJmnQvgCD+Dc8ClSyE8K3EK2mwV9/emetFM6v+S7X7Hlu
         4uK9rloDtfjz47LEtO9xjUAS9Oj89VIw4I3Py/QU+qc6r8zA39pTHTvSvq/V8+bgBiZY
         hj5VZSTd0RnEm9E3xpJx32rUEzk3Nrf3/Ze6LTAnx0OR0x4paJ5o9GLhCYhwOG/+Bxmb
         05DHgc8rvMxqaTa+VuQyBDwUiVbBEPcYOTO1Zf1pVtoq1c/JHNW0hyVMxDy1vTRWohTf
         6h9LXVt1sg0IlQogJ2yHxaPYzhO/n6JStcDD2mwliNsVUV9qGJB9iGWYaemL3Fh8pwc3
         egIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592285; x=1741197085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9YomS+c0wThxhIl04CUTErMlrQA8JmWzVl1nv3uerI=;
        b=KTGIa58WvXYbY+h+KpWA80Lj4Dbp/bHXt8pt7+rGMq/4TbezOW8T2f+i68On5oaPSp
         CbOvRxtSlbXAvPdmuhBO4uZdjZwg12MqU6DPjzp0vAxOolw3tveAvn7MBMvXjUWoVFvI
         PY3TUxXkwc2zbeTNxdgIKM5XLuWaY4e0B3BnP/tsOaKwY87ZWom0+e1pcPwC/JyOpfw8
         94edsMMbOKC0tv9B66Gu5o7e6DFrH6Xqn4aqZQ6WqlycO0dO9BT9vdKp+yo21WT6TvoN
         oczd6D4JzONOydIIYPzNd8iy2yujwbcW6asaQSosRSuTrsACN/pqMTUg2uFkAljrvD2k
         i9lA==
X-Forwarded-Encrypted: i=1; AJvYcCV050TSREKmnbeC9LHGaEyqBSEFgiyj9ioH6iQyvLZPe323OGctFGumf5T7uiUIsXfnXG8lgpxUuYyqJf6u4sk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHKJLVafEwk3PGaK2VZR/rHzw203f/YDNfDxHmFVkpC4KcjxYL
	5wub95qr1mLzNWKa+TemOzIZkrC28wioFQlvFjfgsEqT3KF20Ese3lYiQF+cyQw=
X-Gm-Gg: ASbGncsAc9/fPy4ArsPQNUC5QDINM6t1Xf0nWPHQCmPsVOs71zsV9mu+BYnJ7oPxMeU
	F4WbOw5lJxxzq2fYdj+4rynAN6/CSY1O4/JRpSQ/M2AQBn/3NNaUm/Cv/Rx7LWOa4TVegg/sx/E
	gyYxOe1sCP98d1ciBy+Ckuv2mztE+qVWywAZdOvEu0LKvmV+8trpJb5xs3Av7b4+p6Rt5Df60YO
	rqleU7h8RgY25vLMYQWdnn8FBnWW4ahFCNyCUmZI9iaoMGhzC5N8uGOoye4Log5gThE0YmsDS5m
	d85m2jtcoE3lQBN/mCQG5ibGCXJdiqED4bdtRDDjHF6Ssjvm6HM3XckG46ifaYP/qVtPL9Ro3B9
	Mt+AlFABwAw==
X-Google-Smtp-Source: AGHT+IF7S3Byg/2EA8G/VaFXwC0WijN7Hyq+Y45Wz3xtOjrJyqaLL3aB8h/6a9ePi5nZG42xtp7hZw==
X-Received: by 2002:a17:906:6a22:b0:aba:6204:1c03 with SMTP id a640c23a62f3a-abc0df5d89fmr2632175766b.57.1740592284983;
        Wed, 26 Feb 2025 09:51:24 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdb131sm361889866b.7.2025.02.26.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:51:24 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 17:51:21 +0000
Subject: [PATCH v2 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-max77759-mfd-v2-2-a65ebe2bc0a9@linaro.org>
References: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
In-Reply-To: <20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org>
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
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes its storage module (NVMEM).

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* drop example as the MFD binding has a complete one (Rob)

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1e3bd4433007341a11040f513bf444866b9e38a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/maxim,max77759-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 Non Volatile Memory
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The MAX77759 is a PMIC integrating, amongst others, Non Volatile Memory
+  (NVMEM) with 30 bytes of storage which can be used by software to store
+  information or communicate with a boot loader.
+
+properties:
+  compatible:
+    const: maxim,max77759-nvmem
+
+  wp-gpios: false
+
+required:
+  - compatible
+
+allOf:
+  - $ref: nvmem.yaml#
+
+unevaluatedProperties: false

-- 
2.48.1.658.g4767266eb4-goog

