Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822F23A9BF
	for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 09:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741771578; cv=none; b=RqDDuhNGEidn+CFOYQj4osw+NAXYuyVfWoAdCm+G0tfgGuXE1EnhM+pn4N4k9DbCB5k2A0pJRUxIG4eHtV6RRgJBAtFOeyg3fs9THJNzf4bz9KpU2cYhZshSkq4xIbOnoDX59RZg3tTj7jcZwkMUXI34JsCfLkT9O/GudU5+PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741771578; c=relaxed/simple;
	bh=WrKCHVU9WeE23NeOMrdhi+N2H8I570pU6Ew1AKLcPyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FvF6PLmvitfCL+D5nOuF7Rj2dQU1p4sD0+ftajovZ/JuLlKCfej3ibKNG1nFNlQ4k8oHEcO32Jpwnw4Ey3yUgiYqLohHVBK5NHk/VH3k3Ahci+PxTUkJvUYUgA3k2Nb6g6sOSgcQioQTBSOSXw07kNeVnmoDj3WGh1VDC/tZB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I7e/l9JF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I7e/l9JF"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so1116273866b.3
        for <linux-hardening@vger.kernel.org>; Wed, 12 Mar 2025 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741771574; x=1742376374; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Lfobpgc3Deyg3z2F30QYKZenkvsowTCFz1IUvtrFV4=;
        b=I7e/l9JFBGWxUbrBYIb4KZpPlvnLot4Ae2gGS8Dso5uL9snVibcdocOt1MxJtC7BqI
         WytDUEZERenf/tCfvE8bzFofzLY4gBhXryEqMleBJXzdkqj1XxDHD8Buuy8L63tSF8ul
         CMO6fpN6yL+0AUV9SkUjYaZRfgTTulYyanMc9afNei7bWqJDKX9ODNH6rPDeZ/9Q4co8
         lxNuLUVNJDmetoIDzsnnZmQXf3zjpogJvnhaFVuS5iGVGk+8U8jJzYxZONjmT37orvHg
         b2IPJphha+8BsSl5dUPYwuFoMj3klPAxfgdk+Pcoa/a839CcYbL/S0xIMewgYbaCEkqi
         XGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741771574; x=1742376374;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Lfobpgc3Deyg3z2F30QYKZenkvsowTCFz1IUvtrFV4=;
        b=pPWMFYwwB0O1NSRLGWueWrIKNktD8jmhbu38zOvOWJuAa43RqS1T+/4dkPGNfW3uo5
         oNNrvPhWxirc7pzwq/L4dbERtV21Nf6fRAIZdC5mX6U3Vg18c+RJ/89otitQcTAJJVC4
         Q9cKcv9i1DTqotyZFD4s6WT2KfPIQu+sZApXPZiYetTb7Qj0OhJrbVcoTgVzvJVNqoem
         ZoraMMS0IZ8xih3E8Rb9dBdPdvXTO1T9iJxGVCBY27fPjQOwlfyTTocSpImc11xYnBko
         dFzsJomf+i9FVf0TwKua64ogsrm7e1B7O+CFXd65k5Pp+pGRlvYPcNc0eODDgoPSqdYv
         kEHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbSrI2/gpRgjbWAfIxu/UZAe17FT12pEWSsLq4T7dPLElqLshDw7/FTtA/jY+pXmyQYwrpXBBT9eyIaeBZMHI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoq+Jux48MnQSKanAthsSHdXLzG2JvK0Yi5j4urcSNV8gdzcnK
	ljL9CPsfOpprIhdPGwoAimWSW4eVXeCrOqE/eg6cQbCBXzzboItUUf2BBLiJ/N4=
X-Gm-Gg: ASbGncthrzcTWmcj6x07hiVmnxbag6UvixjKykaaC0qMWJtoBqpPilgH5a/Rc1Bhk7X
	vfsjI9FoPzYRe7+RkUTfNbsn2dTFm6aaA9Z82KOWNTCF4I8zMs6EW0FuVQ4M9yHIQ4UbT9ji4LG
	MyRLkhT6j85fK2Ozd/FYdzJvtLDrOZqOHMIxWaIUQj7BnE9YXWamUbmDSer8iaWELWqxQSnqfRn
	bHTLrvnPCzyn5/ESrwzsyTW8Ay7jrJSCz1ZVJD7VYexkeHlSFsrE5xB5C0l2iub8c3P/LlBRf1j
	cxaJeFdtQvgFPlC4WUQsdabaUeUAOqxbx/AcsCh75z/bN8MeNHDfQS1YF4idty8FoecsXtEISOY
	74B5/cDUwH/MUP1un446PRJY/YzOQ/cF45kxKRNM=
X-Google-Smtp-Source: AGHT+IGMqDlLwT7rGvz8I6XYBpku/gmPdWmh/R1p3fJdAcAGTYdKy3MrEXnddG5CRbYlt4DioQT3/Q==
X-Received: by 2002:a17:907:828a:b0:ac2:c424:c316 with SMTP id a640c23a62f3a-ac2c424cd75mr606058866b.57.1741771573595;
        Wed, 12 Mar 2025 02:26:13 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac25777c748sm894535266b.2.2025.03.12.02.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:26:13 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v4 0/6] Maxim Integrated MAX77759 PMIC MFD-based drivers
Date: Wed, 12 Mar 2025 09:25:58 +0000
Message-Id: <20250312-max77759-mfd-v4-0-b908d606c8cb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACZT0WcC/3XM0Q6CIBiG4VtxHEeDH4HsqPtoHfwIKFtpw8Zsz
 nsPPTJbh9+3Pe9EBheDG8i5mEh0KQyh7/IoDwWpW+waR4PNmwADyQBK+sBRay0r+vCWIqJGwYE
 bBSSTZ3Q+jGvuesu7DcOrj++1nvjy/gklThkF471QvrJMyss9dBj7Yx8bspQSbLXaacgalXTGg
 akZVj9abPVpp0XWrBYKtC1BgvrS8zx/AAKKFmMlAQAA
X-Change-ID: 20250224-max77759-mfd-aaa7a3121b62
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
 drivers/gpio/gpio-max77759.c                       | 524 +++++++++++++++
 drivers/mfd/Kconfig                                |  20 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/max77759.c                             | 738 +++++++++++++++++++++
 drivers/nvmem/Kconfig                              |  12 +
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/max77759-nvmem.c                     | 156 +++++
 include/linux/mfd/max77759.h                       |  98 +++
 14 files changed, 1750 insertions(+)
---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250224-max77759-mfd-aaa7a3121b62

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>

