Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6348326E636
	for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752724; cv=none; b=nHX/jpMwJCSzzoZLdQfqAD9kBgTEHY6bVdkEAYXxkGr0RDv+RKgpUBHXBpJJdRiyLWxxX4HN2wPG4tNSyTXE+MC6QgFIpBVAl7ACDsgmFM7VbrFTtsEDWsYxyvXwHjV9gG7hUd32pvPiodVuk9f1pJ8qRMKn89ou9jUyOvOEhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752724; c=relaxed/simple;
	bh=OIzHAEtZLRdehCT8XTvoyMMkGvyxwP0N0aEn13IQuXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPPRheeGyUj3RuVL842zwj+unkTqMscaRazcQUxJhEwEgtGnBwc+qRvwkMuU9u459JnN95LJrbWRGqMVkrLbvB+JQHhbSrNyzVce/w+QWoUUinXryFFit4upSffCMnXBtp0RJEmjNDKXA6B819ARK/SPtOM3Tm7r3wC387IG3uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YD/Gv684; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YD/Gv684"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abb81285d33so415417666b.0
        for <linux-hardening@vger.kernel.org>; Fri, 28 Feb 2025 06:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740752721; x=1741357521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j95NBh5qzJcx7cZbH3fh5wk/7zjXRZ1HkMfWcLmgpJU=;
        b=YD/Gv684NgBtRmqnEuxv3ZkTs8lpd7IQ/kRJw2IH69AGEhsuwCjyGIrbbnc6xVsqil
         vpcHL45K9SrE2RSI+6cogyigSU04wK14oiP6QTBa186Hz539aRYfvpPOBaejT3ZHmwbs
         Q0w2ILqh91FiCpORBKDYPTasE6hQiXFVBbwDufJMNfYY6kKkaB94yFNvuLGGxLlLInlW
         HA35N+Nexa1pVKWuFQcWotaQuSFow2XY1jRvl97oMFR96jbrBOMaZXCxAFsfajpoSEWx
         gP8tmxAKCc7e49OA+u9wUWWQiICOsTsoRuElQbDbqe8B7kdYDx/z2SDYNg3FN/5npdlZ
         Q1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752721; x=1741357521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j95NBh5qzJcx7cZbH3fh5wk/7zjXRZ1HkMfWcLmgpJU=;
        b=P7xrMJ8wTl70g5a+xZuueZBb+w5fRrX8L6seyZyVdPnYcm6VKxJ9FktUjhXhw2wM2C
         GAL/6pXT+UKMpmlk3Oo5GLSZCpqZtcNeaftXFcyx8h6yNK+5d07VYp0FenDZCj+cz2XD
         pr0LRptxQaaNnbG4nm4YI6ZWlm9zM2S3l53gYs4OD9mX0s9Lyehro4r/jTq2zgaM7v38
         B86UzFiqVmJJWzeSImqdW3jC0TlGo9ENE5L+TRNDAB/Qsa6XtNzV4hS4Ye8faMm9qS4m
         wjs5gvR98miEmzIVDQlcFLJA6+xgvOojBjaFrkPnIhEguOoT1/oyCFnEnggSsGJbVbOK
         XTnA==
X-Forwarded-Encrypted: i=1; AJvYcCVYp5jEljPezoZXJ/LJOKf3D5TJmrGlNrWviuG95R2lP3LQDbK0OJk00+0T4PdiSvkJ84GQKH7rowbi6W/5boI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRY0WY4vU0WXaeawrfcDzHw5LgGqEVeqlhOPXZKerSHM7jPAUM
	e5W/v9xMRlByNUAVvNWGgBRe0wstxV4G8VnTpb62RGt6euRNBAXOaKY1p3ftZnL7SFac8XpNmbj
	9L2s=
X-Gm-Gg: ASbGnctwJ9cUhqRC5yhrlMuMk9OOjbJtxRNFssF5LyZSTohHR7C4rUD2lWTJD0I70lI
	2ZO9c5ZUYuidtVOFlLvdsMi5hrOc9L/d8jJ8Trz0drePRyu3O8T2DnRET1oJmiKXHuZf/Tpy2zx
	lE/LejPueLVNb50xSCeBulNdqzXLrDzqKwY4Xckc+6i7PbzBC9TvGT39qOB37ldMce7R1EjlUmr
	in7/BHRDjkiKSCLbQ6A4XRfRV9/warnQt467wtYskZN1vdmI0vHc34oV1UgLwtYhHzzcbCJzvjr
	EDDvxeK5M8dX28QOLjUZd06205/MNEcd13DVZagCRXhSUSOtv8d9ceT77bPK4lTNrVrjzt8Jdpv
	UwDtzoP2LYA==
X-Google-Smtp-Source: AGHT+IH7P3KcRrpCODNCujFnOOLmi8XeVbBnZbd6Z7IVNjqTTc15B6SHZjXQ6PZV2vMMvoftmGaSyw==
X-Received: by 2002:a17:907:7fa3:b0:ab7:d361:11b4 with SMTP id a640c23a62f3a-abf25f9053bmr352779866b.7.1740752720580;
        Fri, 28 Feb 2025 06:25:20 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c75bffcsm298754466b.143.2025.02.28.06.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:25:20 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 28 Feb 2025 14:25:16 +0000
Subject: [PATCH v3 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250228-max77759-mfd-v3-2-0c3627d42526@linaro.org>
References: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org>
In-Reply-To: <20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org>
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
2.48.1.711.g2feabab25a-goog

