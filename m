Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB9C1A23A0
	for <linux-hardening@vger.kernel.org>; Fri, 25 Apr 2025 17:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745600992; cv=none; b=HsK9ynQDfg05lDcqhpPh9gF0uZpXVhz4Xw/ifAe0WXnKHS3WT5irBxxO+7IuaQJ2nGgAKP+nf9NdCR5kxKFyY2lgJcPSxWuyHkZ6nw/3dVbhgd8KZ0h3+uLCa+zbFJGOgDjzc75f4hzui+Wy+hcSUQXC6TPArVpcLuEhJZK1tzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745600992; c=relaxed/simple;
	bh=dYqLI7u6j7zrd5PXopfq6mUq2GOVheKBP/CHkLosnvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjAggSs2s+PNsmJKxYK394NQw5Yir+oZvHkccmmyjJtSx31lTL6hNLRLfS7lKiMO6maFMjmfAtypbgGMpYYXi0bKHJpVjdrOowDJgwVNRTYNxpDazOXwKszsb5Wg/bIdqrS10dSEyRSf15BOnv0Mom/mT0V1C6aTIJSzfxoVZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXSdxail; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXSdxail"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745600990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GqqQjjEwcJFLkEviIiNfaNPHHWIhRoIIV2Bq/TIESdo=;
	b=GXSdxail2lOHpKcSHUspcRF/bihxGTKrBw9+DO3q3FoYthPob4NZ/j/YDMELoM2chutsUO
	1V4zU9WgPckxxjUyxl20ZwOPN1KNK7sHI+9RgsfqweSMj0gXCnbO5o1wB6TByLyC4nfm78
	1DpWGJ8Icx0Nu6AnFs7bwoE9CbUoZe4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Ux3H4YJhPQW0vudd90qvtw-1; Fri,
 25 Apr 2025 13:09:44 -0400
X-MC-Unique: Ux3H4YJhPQW0vudd90qvtw-1
X-Mimecast-MFC-AGG-ID: Ux3H4YJhPQW0vudd90qvtw_1745600982
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 265E71956077;
	Fri, 25 Apr 2025 17:09:42 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B81031800D9F;
	Fri, 25 Apr 2025 17:09:36 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Lee Jones <lee@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Schmidt <mschmidt@redhat.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v5 0/8] Add Microchip ZL3073x support (part 1)
Date: Fri, 25 Apr 2025 19:09:27 +0200
Message-ID: <20250425170935.740102-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add support for Microchip Azurite DPLL/PTP/SyncE chip family that
provides DPLL and PTP functionality. This series bring first part
that adds the common MFD driver that provides an access to the bus
that can be either I2C or SPI.

The next part of the series is bringing the DPLL driver that will
covers DPLL functionality. Another series will bring PTP driver and
flashing capability via devlink in the MFD driver will follow soon.

Testing was done by myself and by Prathosh Satish on Microchip EDS2
development board with ZL30732 DPLL chip connected over I2C bus.

Patch breakdown
===============
Patch 1 - Common DT schema for DPLL device and pin
Patch 2 - DT bindings for microchip,zl3073* devices
Patch 3 - Basic support for I2C, SPI and regmap configuration
Patch 4 - Devlink device registration and info
Patch 5 - Helpers for reading and writing register mailboxes
Patch 6 - Fetch invariant register values used by DPLL/PTP sub-drivers
Patch 7 - Clock ID generation for DPLL driver
Patch 8 - Register/create DPLL device cells

---
v4->v5:
* fixed DT patches description
* dropped mailbox API
* added type-safe register access functions
* added an ability to protect multi-op accesses
v3->v4:
* fixed shortcomings in DT patches
* completely reworked register access
* removed a need to manage locking during mailbox accesses by callers
* regcache switched to maple
* dev_err_probe() in probe path
* static mfd cells during sub-devices registration

v1->v3:
* dropped macros for generating register access functions
* register access functions are provided in <linux/mfd/zl3073x_regs.h>
* fixed DT descriptions and compatible wildcard usage
* reworked regmap locking
  - regmap uses implicit locking
  - mailbox registers are additionally protected by extra mutex
* fixed regmap virtual address range
* added regmap rbtree cache (only for page selector now)
* dropped patches for exporting strnchrnul and for supporting mfg file
  this will be maybe added later

Ivan Vecera (8):
  dt-bindings: dpll: Add DPLL device and pin
  dt-bindings: dpll: Add support for Microchip Azurite chip family
  mfd: Add Microchip ZL3073x support
  mfd: zl3073x: Add support for devlink device info
  mfd: zl3073x: Protect operations requiring multiple register accesses
  mfd: zl3073x: Fetch invariants during probe
  mfd: zl3073x: Add clock_id field
  mfd: zl3073x: Register DPLL sub-device during init

 .../devicetree/bindings/dpll/dpll-device.yaml |  76 ++
 .../devicetree/bindings/dpll/dpll-pin.yaml    |  45 +
 .../bindings/dpll/microchip,zl30731.yaml      | 115 +++
 MAINTAINERS                                   |  11 +
 drivers/mfd/Kconfig                           |  32 +
 drivers/mfd/Makefile                          |   5 +
 drivers/mfd/zl3073x-core.c                    | 855 ++++++++++++++++++
 drivers/mfd/zl3073x-i2c.c                     |  68 ++
 drivers/mfd/zl3073x-regs.h                    |  54 ++
 drivers/mfd/zl3073x-spi.c                     |  68 ++
 drivers/mfd/zl3073x.h                         |  31 +
 include/linux/mfd/zl3073x-regs.h              |  88 ++
 include/linux/mfd/zl3073x.h                   | 188 ++++
 13 files changed, 1636 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-device.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin.yaml
 create mode 100644 Documentation/devicetree/bindings/dpll/microchip,zl30731.yaml
 create mode 100644 drivers/mfd/zl3073x-core.c
 create mode 100644 drivers/mfd/zl3073x-i2c.c
 create mode 100644 drivers/mfd/zl3073x-regs.h
 create mode 100644 drivers/mfd/zl3073x-spi.c
 create mode 100644 drivers/mfd/zl3073x.h
 create mode 100644 include/linux/mfd/zl3073x-regs.h
 create mode 100644 include/linux/mfd/zl3073x.h

-- 
2.49.0

