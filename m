Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8F2949F6
	for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745914932; cv=none; b=Hm14Le2NXqPh64ACKL9Tdtb01eAz4azieiGtXVCW2gRBf32Wd9UIISs1a5UUelFQSYnthhImpdSQKGbmhYx2JQE16NklxgTDs3ZSSnZ5l9fgYSrVYAe9uYutiKQizKp7/lmoaqRebdbhc6uxUX8+sKnGfu+eMq2WChBwbiVrmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745914932; c=relaxed/simple;
	bh=CC+x9TIuGKZlk9DpvDXPrvuJ/RoLRSdU1UZ8DDd6rSE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jCJEr8X8fWgsXJqECoaY2yhGLMbDRfl7iUvCl6PHoLWEUYU0JSbh/GPGvJ2eN0F7sdfvRyBE0k6waCOsWIcfj0+Ladu0ubwu082Obnn0uiZJ697Hyj0xX17zJjx9uZ8K9gLTMHiY8lPDA4hx6N1QsIKtx9znnHq2IzLYXZKm7/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l/eMqVIJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/eMqVIJ"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2af2f15d1so701936366b.1
        for <linux-hardening@vger.kernel.org>; Tue, 29 Apr 2025 01:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745914927; x=1746519727; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjWwsLzQyeO/7s5cGzDJW5RdjgmzsifvXsymD4VMbYI=;
        b=l/eMqVIJIHcrEJmrvHPlbCrIuL+TGqC/7BKBQxPadEs4Qsl9k2f8+q75iRIVI/6g2d
         cA1ATZfBJaacUYBHGJ6fOZksxrXdc389nLin0CFOV8GzpNTIdCzs/j+tpTfcspnBfc5k
         y+SraQvBPG5iQAeqhPSpmSB3B4oWignWN8unjw0Vqj9AxObzMF7id0NL4+FFFdd2x7E/
         OEu2iUebEKb5/DfHmillvHNHCV1+FDl8JNUH1lQgCqj/cgkP1DpMVuNx4EkX3UftP9AI
         r3pnDO15lDlYTBJ8Kmk4QuB2+G361r0nmf1kYVwDn4tA58jhECuWHi7pjBosp+H+ri16
         KZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745914927; x=1746519727;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjWwsLzQyeO/7s5cGzDJW5RdjgmzsifvXsymD4VMbYI=;
        b=sKd291iRfoKCif5JiiQwS4O7oz+ychDDYjmyWTLoaegAoySu5Kb14chAjnZg9+VUkG
         06uySaN0lGG8kKQl3jA3b7iJQQf2bGVxeEUBkwsCITyOvW7YZdEwsKAoHtBxdAJ/MIp3
         s8V0x/Osn7Sdl+bR36l9/J26JOLW7DNoDHO71XS5j9nw8dpKu24CddKVXiMkB9TAWG9G
         hqbyzY2hXit6zS+4seBJGuFk3iTo/zVjK6rGhByftEd2ZSCS4wCXHav6i67KjQzNa8Jj
         azZ/7ony+SkqtO88zcZkU7gZg3X/BENWmd8QKucs8wM0Vj33z8ua2FgIKbXHoljGlRhk
         w41w==
X-Forwarded-Encrypted: i=1; AJvYcCXaBUJFjUykYPYVtqOgMKJNYy+x4EFPHkpHbYGY0UoVehRNYOn4aJhYShYjSQNO4V+PXhUpiez48R9RPrcE9dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjKOKtlDE/wjXNd3i/pJMR9ako5F4bbnKEhGr5lAY9h+JD+Kp
	QCzs/d7j5roOgeA4IEW0zW3N60m/ADEUcMeuGgtmE3xRZ1iSp/98/0AtIExH5O8=
X-Gm-Gg: ASbGnctbGopAJrsBPg69hWRjZx36FeoZoQBZotuu6Yorx/RHz5p+XkJuU4vJJgBQRCh
	Na9gTwS4xvH83/BVQ9JJf05dIFCDxnf9/T6NN6Nz3pt+83spstFMei1h+q7x6vN25RzFdg+oMdk
	L6tBMBIF9dUvudOWsGdaixEYd/yv8cxiYlFdT4735UX6X2CICJ4Kktrkrb1X8MsGLjJCCzEqeTX
	d4o2XEJZthOQeElg0hT56FTEaobTC5wqQWGuzPau6kXsGSp7YQb1+VvGbnh1HxqlG6GYRzYXKxE
	GHREwJhkU9j4bg/jh6YFNTWZXtPcqW1IhtSQLIid+sKf4LiQe9FuvB3bLFTJqzAX/R5pS/BP1wS
	hDyFX9kDJQPzQpTS1DnjvhnLR
X-Google-Smtp-Source: AGHT+IEJLdAyByvjWpRoQZ5u+uEMWUik7hg7SKC/v1n2JhrHzJOvQXoId+i7WUJMsyDMVZ567KCnZw==
X-Received: by 2002:a17:907:7f0f:b0:aca:c49a:aec5 with SMTP id a640c23a62f3a-acec84b7d10mr137455466b.8.1745914927052;
        Tue, 29 Apr 2025 01:22:07 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbf4sm737905466b.36.2025.04.29.01.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:22:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v8 0/6] Maxim Integrated MAX77759 PMIC MFD-based drivers
Date: Tue, 29 Apr 2025 09:21:36 +0100
Message-Id: <20250429-max77759-mfd-v8-0-72d72dc79a1f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABCMEGgC/33PTWrDMBCG4asErasyHksjuaveo3Qx+ksEjV3kY
 lKC714lm7gW7fIbeF6Yq5hjyXEWL4erKHHJc57GOuzTQfgTj8coc6hbIKAGRCXPfDHG6EGeU5D
 MbLjvsHOEopLPElO+3HNv73Wf8vw1le97felu1z9CSydBokuppzQE0Pr1I49cpuepHMWttOBW0
 05j1Uw6uojOAw+N7rfa7nRfNfie0ASFGqnR6qHrszutqnYD2EBA3nrXaL3RqHdaV02DC5TAsDG
 tpv80Ve3BGvBMhI4bbR5aNX+bqmNIUYHvKEX7S6/r+gMULYNHHQIAAA==
X-Change-ID: 20250224-max77759-mfd-aaa7a3121b62
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

Hi,

This series improves support for the Maxim Integrated MAX77759
companion PMIC for USB Type-C applications using the MFD framework.

This series must be applied in-order, due to interdependencies of some
of the patches:
* to avoid use of undocumented compatibles by the newly added drivers,
  the bindings are added first in this series
* patch 1 ("dt-bindings: gpio: add max77759 binding") also creates a
  new MAINTAINERS entry, including a wildcard match for the other
  bindings in this series
* patch 3 ("dt-bindings: mfd: add max77759 binding") references the
  bindings added in patch 1 and 2 and can not work if those aren't
  available
* patch 4 ("mfd: max77759: add Maxim MAX77759 core mfd driver") adds
  the core MFD driver, which also exposes an API to its leaf drivers
  and is used by patches 5 and 6
* patches 5 and 6 won't compile without patch 4

The MAX77759 PMIC includes Battery Charger, Fuel Gauge, temperature
sensors, USB Type-C Port Controller (TCPC), NVMEM, and a GPIO expander.

This PMIC is used on the Google Pixel 6 and 6 Pro (oriole / raven).

This series adds support for the top-level MFD device, the gpio, and
nvmem cells. Other components are excluded for the following reasons:

    While in the same package, Fuel Gauge and TCPC have separate and
    independent I2C addresses, register maps, interrupt lines, and
    aren't part of the top-level package interrupt hierarchy.
    Furthermore, a driver for the TCPC part exists already (in
    drivers/usb/typec/tcpm/tcpci_maxim_core.c).

    I'm leaving out temperature sensors and charger in this submission,
    because the former are not in use on Pixel 6 and I therefore can
    not test them, and the latter can be added later, once we look at
    the whole charging topic in more detail.

To make maintainers' work easier, I am planning to send the relevant
DTS and defconfig changes via a different series, unless everything
is expected to go via Lee's MFD tree in one series?

Cheers,
Andre'

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v8:
- gpio: switch to gpio_chip::set_rv() (Bartosz)
- gpio, nvmem: replace MODULE_ALIAS() with .id_table (Krzysztof)
- gpio, nvmem: drop previous tags due to above
- Link to v7: https://lore.kernel.org/r/20250428-max77759-mfd-v7-0-edfe40c16fe8@linaro.org

Changes in v7:
- rebased against next-20250424
- Link to v6: https://lore.kernel.org/r/20250325-max77759-mfd-v6-0-c0870ca662ba@linaro.org

Changes in v6:
- add one missing change in core driver
- Link to v5: https://lore.kernel.org/r/20250325-max77759-mfd-v5-0-69bd6f07a77b@linaro.org

Changes in v5:
- core: incorporate Lee's comments (hoping I didn't miss any :-)
- Link to v4: https://lore.kernel.org/r/20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org

Changes in v4:
- collect tags
- mfd: add missing build_bug.h include
- mfd: update an irq chip comment
- mfd: fix a whitespace in register definitions
- Link to v3: https://lore.kernel.org/r/20250228-max77759-mfd-v3-0-0c3627d42526@linaro.org

Changes in v3:
- collect tags
- mfd: drop gpio-controller and gpio-cells, GPIO is provided by the
  child (Rob)
- gpio: drop duplicate init of 'handled' variable in irq handler
- gpio: use boolean with IRQ_RETVAL() (Linus)
- gpio: drop 'virq' variable inside irq handler to avoid confusion
  (Linus)
- gpio: drop assignment of struct gpio_chip::owner (Linus)
- Link to v2: https://lore.kernel.org/r/20250226-max77759-mfd-v2-0-a65ebe2bc0a9@linaro.org

Changes in v2:
- reorder bindings patches to avoid validation failures
- add dependency information to cover letter (Krzysztof)
- fix max77759_gpio_direction_from_control() in gpio driver
- gpio: drop 'interrupts' property from binding and sort properties
  alphabetically (Rob)
- nvmem: drop example from nvmem binding as the MFD binding has a
  complete one (Rob)
- nvmem: rename expected nvmem subdev nodename to 'nvmem-0' (Rob)
- mfd: add kernel doc
- mfd: fix an msec / usec typo
- mfd: error handling of devm_mutex_init (Christophe)
- whitespace fixes & tidy-ups (Christophe)
- Link to v1: https://lore.kernel.org/r/20250224-max77759-mfd-v1-0-2bff36f9d055@linaro.org

---
André Draszik (6):
      dt-bindings: gpio: add max77759 binding
      dt-bindings: nvmem: add max77759 binding
      dt-bindings: mfd: add max77759 binding
      mfd: max77759: add Maxim MAX77759 core mfd driver
      gpio: max77759: add Maxim MAX77759 gpio driver
      nvmem: max77759: add Maxim MAX77759 NVMEM driver

 .../bindings/gpio/maxim,max77759-gpio.yaml         |  44 ++
 .../devicetree/bindings/mfd/maxim,max77759.yaml    |  99 +++
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       |  32 +
 MAINTAINERS                                        |  10 +
 drivers/gpio/Kconfig                               |  13 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-max77759.c                       | 530 ++++++++++++++++
 drivers/mfd/Kconfig                                |  20 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77759.c                             | 690 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/max77759-nvmem.c                     | 162 +++++
 include/linux/mfd/max77759.h                       | 165 +++++
 14 files changed, 1781 insertions(+)
---
base-commit: 33035b665157558254b3c21c3f049fd728e72368
change-id: 20250224-max77759-mfd-aaa7a3121b62

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

