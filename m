Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9652676FC
	for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745840173; cv=none; b=AvtJ6cIaB0savG4LBQwj6r3DJlYneOAEOX+FeeHVdU8XZgFacrIb9QSG2pouTVWrNJfnA5k6PaGPa+oDapclkMSLTaSrPGB/So+UqW+eqcE9uzuXUSJXhe1zO4IzKbKdJKMFiUK7LItXwfKBMjxuCzV2RCT0Jj4FU3O5JnmVmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745840173; c=relaxed/simple;
	bh=U6P6ZeSrPYv97XE+r6V4N7rXLoprPzfswXE2mWXxNIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUxT+K1LVoAin5r0JYqXBK7lR2E84zgi5pwi0i/EgxCCWG6+nCbwPTGhNfiOvXfB9n8DU1QAulG1H6is3XBbWUgAMPICRwShBYGfe+dDmD9ZCzgXuKUjmi2sGKBTCsB923/mw94Bw3PT92TSW5Ib7AGLVp3vPb77xXiPXiBuQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QIzvOetu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QIzvOetu"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac25d2b2354so682467566b.1
        for <linux-hardening@vger.kernel.org>; Mon, 28 Apr 2025 04:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745840168; x=1746444968; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NBA5CuIc8YCbS4yzG+KOg86MsWIMfhXd5TGhL3Zsn8A=;
        b=QIzvOetu2zQNGBnY6qQ10Hd0E2cuXjR3yEknUr4z1FLnwaXDRKbM19Z5ZcAU8wm9M6
         lS9tLZJ19BvARJta5dYONz47toSyzpXr8C/EkCaZDalPz3aKqz13iePB1O/OVOX9USre
         o+EXG+Rq28vJy7hISuwU6UnYMG3tYs+RoYuFlIZUYBKmR0ZwXX38VRtzqSCN3v2jwMrn
         esWXADdmjmuGKxM3exWpDG8l1iQS/N3Ansdjjv6GL66QuBrBHsd+rLq71vRENBBFDIsP
         kxothbp/p6gsTA0v7Lro3gFRIEyyaR0bGhcCPIVqEuPGXiAt+c4EzKBv+KlwQzEHR8qb
         QTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745840168; x=1746444968;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NBA5CuIc8YCbS4yzG+KOg86MsWIMfhXd5TGhL3Zsn8A=;
        b=t+K8kJtoN4Y8YUH4An2/W8hGwaooTDb30IXAhOojBs5rM4STb6aeRN5cwuJ+sot1+F
         u+CeZAfLtSpenPyHQZpN2UMsoOmXXrRpoMovhbsROBb61dozu9Q6TlTCSSouii4Ri8/a
         VgVdTEfI0/eFSUf5l4KLd5YD22sCbLDJ/nkTJzm3CIWYaY8OQ0ZtQK1GaH0+Z70zJQg6
         zGu/B9NS+83VDogwoiiH5v+pek+Z8oVgIPwFPYVJ583PXvb4OcQFne4YsINsV7f0VKvj
         Z68e8kWyILAPqtunE0jTxWFNDzdcty/EgKLBBlF1Yn0WElqVywjO22iSNtXnuOlsMrcf
         7bMw==
X-Forwarded-Encrypted: i=1; AJvYcCVpL+kWJbycpLsXQNhaBGeCdRSm322rPUuhm4eHva0sGPRwS7WkF/lg1xsgSMGtoMXJkiMIn1ks8OgAKKEGvLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyQse26+t/q1YYppcLGlD3USpfcf+8VrxOPqsWkO++VbfzCg3L
	eTgz3dNSZsXwbDeTs49X+JiDDE5YEke6sUQxtnU/i2VuR4h/bjUA+EL8mglo0Xg=
X-Gm-Gg: ASbGncuC9gR7hBdvmfUtN1mH+VPurVUxl0qT3IHK7un9c1lgAAF04GKhsnrr/f7dgor
	A+o+SbtjVqmqGxlNFbuS1ki4rrfONTQvYp/4Wi5/Q8vQG/ISHTWjco5Xfc9j0Hf+oOxdUFU484D
	8K8Ip0t1Fsqpui/fICYLtN1tzjdKUE7iiBcq1uFax/eRBuGQGlBLQLhHgI3k69azjCiNM68RC0Y
	d+vEXQtKI6AsH24RCGAnUNbetRDcqh27wAyLOOUfy8054TcQS3Y8k7Q3NIcZrBkZylxeG3jxeRk
	nb7KM9KuRVA1Kw5L+dk0hm4N7uFzXxkWfHkfGFe7zmDdhLNHRUmm9tMhoENxkEokI96g8Wh5x6r
	nrH2Npxi4uZjHAL3+7aNzcTq4
X-Google-Smtp-Source: AGHT+IEg+c7X+Ta+5FJs9im5JHBiLsTS2tROmBMx41A+5pPg9TXu3iCXPaGd3tUwOuhF2Ei4yP46AQ==
X-Received: by 2002:a17:906:9fc6:b0:acb:5583:6fe0 with SMTP id a640c23a62f3a-ace71095745mr954872166b.15.1745840168498;
        Mon, 28 Apr 2025 04:36:08 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1580sm619937766b.175.2025.04.28.04.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 04:36:08 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 28 Apr 2025 12:36:05 +0100
Subject: [PATCH v7 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250428-max77759-mfd-v7-2-edfe40c16fe8@linaro.org>
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
2.49.0.850.g28803427d3-goog

