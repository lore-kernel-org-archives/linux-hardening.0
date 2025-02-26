Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836822A1F5
	for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 17:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592291; cv=none; b=Aw3/2ogZ3N97Y5SxSRvNqwW0I3k0UH1nENI4JcwMri175RfvQR7OcWrCLWyik8DbN7crlRqF3TY51iQAW2WNUXk7b+Snd83T16HO/x/MUeWykeP4uX95QPm7jjcexX5zRbEyeD7FlC28fczZQU8H+LxYmPXBtxaLuVHOs0LooFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592291; c=relaxed/simple;
	bh=Wrk3Tbjy48DhMXMrJ6FsxsEEZWO2wkyYnH7V/hmHbpk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nwhicwgA9+cw64dWimEcc86yQUvPLYfpTsjfi3e172HpFntwgXva/KoMffRJNx2JZkIeSMfo/dZJr0nze1sZOLiVXsxrX5o+m62Z85UfTDZubcn5IQRcgpsWXDE1cFioDcp6HCPJe9SDQZeJEjMUeLxFzInjyAGOAMr95jZCJJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ffGik0Uy; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ffGik0Uy"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so12984357a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 26 Feb 2025 09:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740592285; x=1741197085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JO1yRDgm5kl/hQVQWW5vYh5O5OnfQpLxrGfUp86iA18=;
        b=ffGik0UyZ4H1FZtySsggiTuIg8yRHhj0ec76bakiPDSk2i6s/i+HTahRaoxvkpm7za
         UWZbNHMlbD21o1ixSWUfMfNn7Qm4nt9rOPXJzd1X7nq7qTaZK+EAlZ3k6WYReYuRXMfR
         3dgep0O5GTTLVZ8Qa1Elgl3a56HyF5jrQqPUWhucWAUtsBhe0QJ0YoWvqH1tVoQKingp
         ojZFyajXjNW15pmdgKDEaIDOizj5GvfgiKdMJgebTYBdwyyxygkneNpbye0ZtFTVck9x
         0H18AUMcC2amR1kFm39vXJninBn0yL4bQD4ZyQ6P2K0IKRmiB+meEv8etMxszHkdBO3C
         s8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592285; x=1741197085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JO1yRDgm5kl/hQVQWW5vYh5O5OnfQpLxrGfUp86iA18=;
        b=t/orzJSsJDMv/WYIvuqES87k5R0+6IRfFjdxrrbX0VrCx2B+0q8u6xkmUBSOGcYpwz
         Wvs/78YG4nXu7Geenk2FVYaRqRQawNcPZksqiz7AsQZ5j5XwvkOw8Tk8ZnvNMv1hC5Fc
         Qe2PJM4r/X1rbXEtXEFEJa6J1U5lDBPm+Bh/k3Ll24rfwCimkDayqSy+zF/WAA1h8TKe
         jahrcCgggv+7DRBad9c8ad3e3maMhmhjOCEF/dNFVatdfcFyKcMTumG75ApqeWmiN2Gx
         gx2oFWaBoV6b0b55HJcZovZVcqFbB+DFX/e5dsBg/Ny4gAzZR+0pQsD00Dg5M/X8nLIm
         Uh1w==
X-Forwarded-Encrypted: i=1; AJvYcCWn1Kc+FjUiTd5RKF9SlVgbupmT0v1OYZI9PlXOhGbkv8RmzkXIecvyfEYLLlNuo6OVgkb3vgVc3+uwMOliGco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt3ZBHnWMa5tLgNToJZLKY3RJolXvglrp3dYCgM7paufBqQyt/
	nvvz2FSDQUm5qX+XB8KqbpXbBCHgAvnWBO6e23p/tveLMIR8olkXV7Zfh91+54g=
X-Gm-Gg: ASbGncvoIm4N6hSFERX6WLv4vxwgyQcjZ5hB3hldGr2CrpvmeW5UdUxH3QkiNBt8kSc
	FPPH6B++AL6y3u7TkCIWR4yk23QpRnJLdjSwWfj0KT0dgUoj+HCaiejn3MBEHD+/Fh17LfpMjHo
	7M8/0RXlxOjsk1rrvvLIhxWkIEtbTAi64xZ3UEfJsQksIBnqz2jQUW/Ut4aS6jIk+hdFyS9kt2w
	qxyojP53dk3I4Ftq1PPXC12QYzmwWR0147nVPmxNwmA4o5iv1Ms393GA5l3qdPK1im4HJSqiVnV
	rEUNxcczcTspcDbxwxTHEYL6GlVS9pdryQTQUKfiR9w6H8ojLLp8mGTq/eNzgXzvWRSASwEYVG0
	2R1CdbZBmyA==
X-Google-Smtp-Source: AGHT+IFmKSPF6nqqiaetA3heVfq299jPwpErUmra97HCWFZu+Y10xqFwRt4yZaOIXY+ZiDT6DcAWfQ==
X-Received: by 2002:a17:907:728a:b0:aba:608d:4a22 with SMTP id a640c23a62f3a-abc09a09707mr2420013566b.21.1740592285488;
        Wed, 26 Feb 2025 09:51:25 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1cdb131sm361889866b.7.2025.02.26.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 09:51:25 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 26 Feb 2025 17:51:22 +0000
Subject: [PATCH v2 3/6] dt-bindings: mfd: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250226-max77759-mfd-v2-3-a65ebe2bc0a9@linaro.org>
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

This describes the top-level device.

Signed-off-by: André Draszik <andre.draszik@linaro.org>

---
v2:
* rename expected nvmem subdev nodename to 'nvmem-0'
  I'd have preferred just 'nvmem', but that matches nvmem-consumer.yaml
  and fails validation.

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml    | 104 +++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..87e3737896a289998a18b67932dbccacfb8e3150
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -0,0 +1,104 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/maxim,max77759.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 PMIC for USB Type-C applications
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This is a part of device tree bindings for the MAX77759 companion Power
+  Management IC for USB Type-C applications.
+
+  The MAX77759 includes Battery Charger, Fuel Gauge, temperature sensors, USB
+  Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.
+
+properties:
+  compatible:
+    const: maxim,max77759
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio:
+    $ref: /schemas/gpio/maxim,max77759-gpio.yaml
+
+  reg:
+    maxItems: 1
+
+  nvmem-0:
+    $ref: /schemas/nvmem/maxim,max77759-nvmem.yaml
+
+required:
+  - compatible
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pmic@66 {
+            compatible = "maxim,max77759";
+            reg = <0x66>;
+            interrupts-extended = <&gpa8 3 IRQ_TYPE_LEVEL_LOW>;
+
+            interrupt-controller;
+            #interrupt-cells = <2>;
+
+            gpio {
+                compatible = "maxim,max77759-gpio";
+
+                gpio-controller;
+                #gpio-cells = <2>;
+
+                interrupt-controller;
+                #interrupt-cells = <2>;
+            };
+
+            nvmem-0 {
+                compatible = "maxim,max77759-nvmem";
+
+                nvmem-layout {
+                    compatible = "fixed-layout";
+                    #address-cells = <1>;
+                    #size-cells = <1>;
+
+                    reboot-mode@0 {
+                        reg = <0x0 0x4>;
+                    };
+
+                    boot-reason@4 {
+                        reg = <0x4 0x4>;
+                    };
+
+                    shutdown-user-flag@8 {
+                        reg = <0x8 0x1>;
+                    };
+
+                    rsoc@10 {
+                        reg = <0xa 0x2>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.48.1.658.g4767266eb4-goog

