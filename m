Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31219CD1B
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889776; cv=none; b=k1lwNgdpavw1szZPiUqy4Hlj8gCu5CRV+FTFdJejJtDexzegvX7Tmc5n1hPpgFNaJBoNh3UYCYnvOP8fVyiFgYvwNdKRHBdcEMUGJT6w5lA/hUbnzV8wOJPbnVtpjNRBzoCcxyQU7rwmWlnp0uBkSlaIfAP+rJk2WCHUeLwxjLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889776; c=relaxed/simple;
	bh=SPqlnkjtrS5DVFkshdhSurAaxj8Nd6Gmu/f6A5AIxGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqn9192jj5wNBIBFesDBpCJUhuF3ecPlHCn43J4ozInMdj2NOq74UkBFTr6In7mNh8ZlbRgxh7CVtzH7duCKIyGyngUGeN/d/lApmVOi50xFhDH4qH00CzrTMsw2gSgDIx8ECFADCsSu/fvtmhH2idpaaV3vgWVq/hisUAF90Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YV7A77AN; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YV7A77AN"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso806976966b.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 01:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742889771; x=1743494571; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O6hGtk8l3NJ5m0ZZ1f8dhJbnrFpOfREyFqNdfBX5qs4=;
        b=YV7A77AN2QHRQNEzMUUVL0ODg5ykfLN0b47U3KqnmW9sRxT1LWAxLiXI25VspD+v3U
         0ycmGp9M1lMT8yjdZ9wL6hIBR6heeONo5sdtieKqSNMnv+BN5ogclbn7v7O/+so3675Y
         gCY0NGULa/K4Rv0Rd1Sl3F6S8I5actofcSqPC67XpcbPjqs0FmXcfLJIfuJsuKAw4QSi
         zZyToiiygdKtwJvA9NxEUGdVNajd1hMeLIUG7+DjpT/ymmcSc/itAeITNZvt88QUT75e
         42UrLlVoHObCbNoEW5+EdLQZRWZcf8ftxZkzH245VR9EX93sKifliTDFJMT1C4VHCy+l
         LzuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889771; x=1743494571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6hGtk8l3NJ5m0ZZ1f8dhJbnrFpOfREyFqNdfBX5qs4=;
        b=eDuo+1yctJN3hVdoQLMo2g08T7edaZModLsLE/lIeTC6hBs9DbKlgoRueDkngrt2Av
         Gyn1Mrky6/btoQ4HNhIToPcj9TUZsJFxwCByYj95jcyhr8BWhcE9bmWxuiaU3rTKQm4h
         pG4wHkMc2TqDFFYctNjYheW7Sd1YkFfifqHnMcPlEop+e6rOsEGghzPMgPArZxJIsIAf
         3mSy/GfYIgg7Jlcka4vv/RQMxb57Eiuqb7QclAFtkJrTWGQQEV3rg5kQN2RswSyC19SP
         NcaKdu+AOq3ICJolOy857TSi1Gssy2YJRs1wN4I0AKW/E9nFLT8cbvOmyoRCdH5Ly7zr
         zZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCWEExCnV/WlT076PRWPwxSWmEpTDmgRw5OSikWWpdjmv7H7WpkoS77EAO48odG0ispgBO9WmpyRE88J8PL6+8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4JjfVG9g69zZa52ItzrTyqHb1QbYpEqL3Mzt74mY0WtBbPj+8
	wMj6/JGs8lOMojEoxc4PHl9iKzv83hEkbc2V6W3cP4SQReLkMHbz+6k083g0K7o=
X-Gm-Gg: ASbGncvtqts/8VBe/IW9cNbmuTwg5oi+ShqRBbVo5bWbx1IeKJIQbMXotvzqZkOHy/S
	puXqsjVBfeSQonQpseM8igOWoIaD8coXdwK0uPSSpymGkq+MnxLwT6Bt7akcZEUK96sKo8jsNpa
	sWLTU8+wOjxtRYeQuciMEchsH9kcIXU0rpRiWAPc7QFcZIxgteyC74RdX5YGTyYxLYGsYXAsHZG
	4etaf+AK0VSFpuN5eSDtiv9ke8zvSE5YuAPuXaLMN423lL4rXV9igSHrVPnW4CCCKjPDWWNzlMc
	7oixwiQt9f+3wIhNkzw0Wc9q7IG+abw0O3hjtkWKZ6so6i+yvWafVA7C+QHhDQbzpFLlyj0C/0+
	NX0rBimuwkop2bT8U4R6hujEh/Ydh
X-Google-Smtp-Source: AGHT+IELkDVeKZ6AufhA6lJ7MjzTQsFQ3gFzAB+1T3Pvd2jU/2VAFg84gQd/PIk9YF8+lS/h85MrWg==
X-Received: by 2002:a17:907:cd04:b0:ac4:3e0:7ca3 with SMTP id a640c23a62f3a-ac403e0a6c8mr1292664066b.18.1742889770672;
        Tue, 25 Mar 2025 01:02:50 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb004fsm7446785a12.40.2025.03.25.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:02:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:02:25 +0000
Subject: [PATCH v5 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v5-2-69bd6f07a77b@linaro.org>
References: <20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org>
In-Reply-To: <20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org>
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

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
2.49.0.395.g12beb8f557-goog

