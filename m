Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53B21F7575
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 05:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786424570; cv=none; b=Srdg6OqXfX5klE6OkEDsnLCXzNE4RaLfUKAbApWN+BN365L6mms1RS4P9GRs2/ayN9VQLbLHWlhyruw1uXtcFxRM12nf5PDRhVyBZrByCAnx6u8ADNIjyVDrQDIvbmBz41udz0vHOLmCgODXQ00xn9WXRPP2tf6hZQ0EMUzPl0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786424570; c=relaxed/simple;
	bh=0XOITciiOnBra/r3Ajx1I6Wub7Yecid0iLcQTSs3v3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pm48gzLZsV+Wg+gJIlvf5UlkWejPq6F9TOIq456/hyX7bVjhhveLTmDO1AmlHr0YDj+wO/XlY1T/vs74dPVpV/HCyHSftiqgy+j5YMQ8DFlbuka5rQZa+4EM/yjXm6/nBkFOeQkJdpgFdbKqL+XR+Ed4TUrJe/yIBwdWe2nuTBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvzb3w7Z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvzb3w7Z"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso23277985ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 22:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786424567; x=1787029367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7O7xUkoYVY8AeKODvISm0XPf0ZextZDIpWMTL9lvpDk=;
        b=Xvzb3w7ZLk6dETwQdORGpKtV0vwwKLDWbylROHo7Us7vXc8RrMCcRwoNLFWiY1soPM
         yNZGhJpER4bwG9pMH8mHmcCrhrIxBhgnOTWStP1PWGtdacc5TL2imElITMqDqJRV93r/
         wFbAjW6TKRZQsGoCKdyNSQ6fm74AicspL3kIwxWZwe80H+jv1DNzSffqHA9K6YmM0Hx1
         4a5WlbW6DD7fPU/cFAR/IO9AdYqhb7mlz3t81QMTXe11WnH2cUMY1PkxeyBMJcJB2Yvz
         9M+auKNTLD1z7fFwZgWJUFPXVn4+4MbUPnsLVo7nOM1tU0Gb1cT9sxyTzRJY8uJnl2rW
         PBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786424567; x=1787029367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7O7xUkoYVY8AeKODvISm0XPf0ZextZDIpWMTL9lvpDk=;
        b=L/Ig5vhZ/qYaHqLjrbKDYbuQhxQthyHhgtN7spJTPrdSdY3zPHQN1EA4PmL1KoMwPs
         eMXQFmMX9/1w5D3sbNooQ+UqYXQb34ir1s/YgNl/9vqSzSH6/A9GiMKk1o7u61XmI1Kp
         SHg2skQotgBVd4EIutBz/PycO5nFTAW1DBD7B0EAHcnnmBWdvq4UkXUvAla1CCkAcEYm
         bs8qNtN0LQNY1SWQxrKia7ND8tgO4ry7+3unZrr5QjW36MSYWUgd1QBKKxfEmi7D0uq6
         u5p1aq73vLQq58qvfow7uOaGJgfY+evG+SMDOBZBJ0p9VigZASsIanb4wqsuSo2y/jsz
         Yq1Q==
X-Forwarded-Encrypted: i=1; AHgh+RpdG4hL/ivruX3qgHS/ASa0QEv++Ix7ALd0OBO7bS6RtBQ4QPWQpBVo4qkAfsU0wlAT9h4DkEb/FLPte28OqCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcOp+3otERfwwjaz2IdaqAtGbnYAvzg7NBRBLElChE3KxDJRtS
	7zmPoTqP/Ll4C9uWwk843uusYkMgFUfRtb2mZMzsYhM8FTEHCbMEiFx6
X-Gm-Gg: AR+sD12LwWRal5Cp2gVSCH7MtLp75taBSNlD7TU0jPP+0hbpmFAyTwuCEunSa/AT3X2
	bkrn57gJoMbhKPkLRvxVsFUwKIw1Y6WYnboZLyBNbXhD7H+CdPQt1B3Y1BN1FSliag7GSaQo4pI
	6AkY+EK4Np+VGv4VPpe+RmFQJ9QtWnRG+mdDgkuX3KzNxKxcPCxrSGIWbXDVHaxkU6+YVrBFHvB
	5siex7zm3MWMAL8H5cG7GinG1XdDNIiQ3qgwcGFeGXLXKurFDWJAIUUF401QAYtRc19zVSqStPR
	2xSv83iCw/hOL3ZZb2jsyNuQhHoglw3DeEHUrZHsg04jfa3bq406ipXTskeHX3Gk4ijBob8FF1j
	VKIqaJ3yOdgVPmCz6PNf56h9hks5v9re17TI4q79VX6PV2YDUKHvBFnHaZKosmCp0RAAsorpVLD
	kGN7oLZwKG7HLizZ6L344e5MPodr5RWiam+RHKWEJ9IgodwRLy7AEV9GqAufJrYxnazbV/NPVnG
	0hH0OQK9Zsucv6JM25CgDYfb8hEbVx7D1pbZMhjOjk9qlTdSQ==
X-Received: by 2002:a17:90b:4b0c:b0:37f:df85:272f with SMTP id 98e67ed59e1d1-392ec617514mr576960a91.19.1786424566907;
        Mon, 10 Aug 2026 22:02:46 -0700 (PDT)
Received: from Mac.localdomain (198-27-228-154.fiber.dynamic.sonic.net. [198.27.228.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31c619cf07dsm660421eec.4.2026.08.10.22.02.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Aug 2026 22:02:46 -0700 (PDT)
From: Ahmad Byagowi <ahmadexp@gmail.com>
To: netdev@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nam Tran <trannamatk@gmail.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Andi Shyti <andi.shyti@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v3 0/5] ptp: ocp: Add R4006 and V9 I2C peripheral support
Date: Mon, 10 Aug 2026 22:02:39 -0700
Message-ID: <cover.1786423898.git.ahmadexp@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the generic LED and I2C-mux support needed to describe peripherals
behind the FPGA I2C controller, then use it to instantiate the R4006 and
Time Card V9 board topologies from software nodes.

Patches 1 and 2 add the binding and LED-class driver for the Lumissil
IS32FL3207. The driver supports individual and multicolor LEDs, enforces
per-output current limits, and keeps the controller shut down until every
channel has been configured.

Patch 3 propagates software-node channel descriptions to adapters created
by i2c-mux, including a software node attached behind a primary ACPI node.

Patch 4 adds the R4006 profile for the temperature, humidity, pressure,
GNSS LED, and four SMA LEDs. The BNO08x channel remains empty because no
upstream driver binds that device. Profile selection is fail-closed and
requires a supported PCI device plus a printable fixed-width EEPROM ID
with valid padding and an R4006 prefix.

Patch 5 adds the V9 BME280, BNO055, two GNSS LEDs, and four SMA LEDs. It
uses the exact EEPROM ID "TIMECARD-V9" because earlier revisions expose
the same detectable I2C devices with different LED routing.

The prerequisite patches touch DT bindings, LED, and I2C code. Reviews or
acks from those maintainers are requested so the complete dependency
series can be carried through net-next.

Hardware and build validation:
  - Exercised the R4006 LED routing on hardware.
  - Checked the V9 controller address, 4.7 kohm RISET, sequential RGB
    routing, and second GNSS LED against the V9 schematic.
  - Ran dt_binding_check for issi,is32fl3207.yaml.
  - Built i2c-mux.o, leds-is32fl3207.o, and ptp_ocp.o with W=1 for x86-64
    and arm64.
  - Ran strict checkpatch with an 80-column limit on all five patches.
  - Applied the generated mailbox to the stated base and compared the
    resulting tree with the source branch.

Changes since RFC v2:
  - Drop the board-ID over-read fix, now upstream as 6b69f2ef10cd
    ("ptp: ocp: Fix board ID over-read").
  - Fold non-mutating fixed-width ID validation into the R4006 topology
    patch for fail-closed profile selection.
  - Clarify zero-based LED outputs and correct binding color, naming, and
    nonempty-group constraints.
  - Use fail-safe LED reset and enable sequencing, serialize scaling
    writes, validate node structure, and use the driver-specific subject
    prefix and private-data variable name.
  - Preserve secondary software nodes behind ACPI primary firmware nodes
    and balance their adapter lifetime.
  - Validate profile indices and make mux channel, RISET, and current
    limits explicit per profile.
  - Gate topology work before EEPROM access, avoid core device locks around
    client probing, and continue low-rate recovery after retry exhaustion.
  - Confirm the V9 address, RISET, RGB order, and second GNSS LED from the
    schematic.
  - Resolve every 80-column warning reported for RFC v2.

RFC v2:
https://lore.kernel.org/r/20260803205011.1249-1-ahmadexp@gmail.com/

Ahmad Byagowi (5):
  dt-bindings: leds: Add IS32FL3207 controller
  leds: is32fl3207: Add controller driver
  i2c: mux: Propagate software nodes to channel adapters
  ptp: ocp: Add R4006 I2C peripheral topology
  ptp: ocp: Add Time Card V9 I2C peripheral topology

 .../bindings/leds/issi,is32fl3207.yaml        | 251 +++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/i2c-mux.c                         |  69 +-
 drivers/leds/rgb/Kconfig                      |  11 +
 drivers/leds/rgb/Makefile                     |   1 +
 drivers/leds/rgb/leds-is32fl3207.c            | 687 ++++++++++++++
 drivers/ptp/ptp_ocp.c                         | 881 +++++++++++++++++-
 7 files changed, 1859 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/issi,is32fl3207.yaml
 create mode 100644 drivers/leds/rgb/leds-is32fl3207.c


base-commit: d67e5dbda22604d0fcde32fce58c65f88676e676
-- 
2.50.1 (Apple Git-155)
