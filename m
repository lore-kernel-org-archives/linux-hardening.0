Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D86A1A76AE
	for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742889775; cv=none; b=lFyiCDc+jMc2Onwq+XwBYrGC0ARi3ECULu/wXhBvVnm9XOeGv9egefG4YTtMsTPR16tp/h4K7mDPfXoPI6vAKOJK+y3S6HAniID7SzRkkvBpUytt/Pe0QmcWX2nYrNXqBxo7T0kgEkhuqzTxELIwgZcIKBfNxynwCDOHcqf+Vmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742889775; c=relaxed/simple;
	bh=Kyd5Vj5Wtgn7kWZUmlkSip+En4I9UUHkx0BnikIJZpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ErJxt8LCfUZTlCqgjU9/lhLO+xipNgFnXR9u1EEblkFEt35zaH5neSpOFWvHxJHN11i/3Ug4CpqOd725npw/HY47cw+/OaMJsKvCC7Y5ldVb8S7HWJwU5j3YdI8rxBy0Jj9X4NPS50Q5+n6V/BRSid/mPT1rX2OmNZluNfZwy6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Sh/yOetQ; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sh/yOetQ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so8087537a12.1
        for <linux-hardening@vger.kernel.org>; Tue, 25 Mar 2025 01:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742889772; x=1743494572; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dExfc0LrUCiaYdxVn5B5O2p+BcM4AL59uS0XF6ohUVg=;
        b=Sh/yOetQx7qlE6xZ4IKElb55bK+IAdqaqOXkTk4T8ps6a1LUHbunvwJxpiL6nU7wKo
         OZ6ElVF1DuVoRrmzewl2K5dA8xUI1vE5dYL2nYC5VpL63d8DemfEUt5I6Alx2qgfdYN5
         ul+Ps42jrXGIpMB/98NAzaqjTpK5zm4ugJxafXVCVplFqFZZgS89IJRblUAoD3gq58v6
         6rpOlasXGgipT8b6SGme2tLcCdwtX7KEEA7MVqbC4LxILsd7Yem2dnpXtFkANzCwskwa
         25+JYJUsDWrCLyfqwVfhnbAI1pyfbkC6RNoPw6TYFLwJeggXkIs1UqhTWZMdpY6LfSzE
         KrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742889772; x=1743494572;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dExfc0LrUCiaYdxVn5B5O2p+BcM4AL59uS0XF6ohUVg=;
        b=b994QUHIsnjFiUYhvNmm5lbzTNSfgFsWMcehDp0LwC6yt0HyzTc3JMSutVAwaVARwr
         HIABA6fjrq3Jl7nYTVd27dh0ppTCS0hpbuO+MsFxy7xwwS7+DXjGsBOJA5Ik14yYoopm
         IQAgT0QAYF07CUfWckb8LFhmbwTaQKehwjPIupbKQUeBwmeuv3hf4mW7lkKPe7vkXzmN
         /4QV+CRAFrGd69qe9OPLC2OEljJm4QRzNhGt+MTUOAGOls/u5DOxKmSFpWTR4wSPZRO+
         bJIjU7ct4ro7lFWT0+fzplQPR4xgnB8sc1G3lA75MRC2I2wXwMgTeH63C/eXB0TycdPC
         w3Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUFdVvnDCrEnnK3PWbTgt6I4Qw5AhhBogWJ+4O9c+E+vjlmBdE4kPcQJegICluKeDYHdjCfvu+3IIr80aHHK58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3Rr2QUwLlbT/gIfN4Df40togvq1Fl582Mn72y1q1uc3xyggLV
	NjuruJ9jXqUWjx/cvv7Z9Y5RYzGmK+LK+I48140/uwUrkyjlxMuyoORjEjZpmSo=
X-Gm-Gg: ASbGncvQyRi0qgpGybUloEjKxTg0CRZrASrTm537CJREF9U05MdkNmrGNpJfPRNcMC2
	InOi9T1vzne2CpC+egvBUmaks5PbNizaFgHg4oMrLvbaxZSV0jnBM8gd1ICBdHBG2oa64ULmkvS
	4I96R+8F89FCDp5Hzh3uoSE1WzQx7KTz2Z/uzs1EKZtu7IpSmTns23qDesuZoEuqEj116OVAmff
	hfOLUsUJpl/GXyszcPmxo8Leezah/dyDymP2uoA/YKHgf8VDQoT2wYsVFBVE7jPKbEmQI77Okwu
	+Sz3eC2+nZE2py0EVQQR9V44QEV5EtiWuih5j/7703bk44Z3qkmqf7oB3ev6vf5XqRRjxyExwQ0
	hbpirRVvri7DWUB3SQX9BEOHouenQ
X-Google-Smtp-Source: AGHT+IEqZqvkWsL1rJSlE/DLcPlmZaynYCxoREH4kRFmKv9BJrVDGJjfkKncZLOyDfxBKQoYgQpPWA==
X-Received: by 2002:a05:6402:4307:b0:5ec:cd7c:de55 with SMTP id 4fb4d7f45d1cf-5eccd7ce06dmr4085552a12.17.1742889771562;
        Tue, 25 Mar 2025 01:02:51 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebccfb004fsm7446785a12.40.2025.03.25.01.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 01:02:50 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 25 Mar 2025 08:02:26 +0000
Subject: [PATCH v5 3/6] dt-bindings: mfd: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250325-max77759-mfd-v5-3-69bd6f07a77b@linaro.org>
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

This describes the top-level device.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v3:
* drop gpio-controller and gpio-cells, GPIO is provided by the child
  (Rob)

v2:
* rename expected nvmem subdev nodename to 'nvmem-0'
  I'd have preferred just 'nvmem', but that matches nvmem-consumer.yaml
  and fails validation.

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../devicetree/bindings/mfd/maxim,max77759.yaml    | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..525de9ab3c2b7b431e48497330640857540625b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/maxim,max77759.yaml
@@ -0,0 +1,99 @@
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
+  reg:
+    maxItems: 1
+
+  gpio:
+    $ref: /schemas/gpio/maxim,max77759-gpio.yaml
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
2.49.0.395.g12beb8f557-goog

