Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECB9469836;
	Mon, 19 Oct 2026 05:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792388078; cv=none; b=juUE5VmLOPjEkySYftYzW3+Cs9JHs/b/129A1K4jt4j7PjiWJAeyw+aeMPoaWe1jRUA3GGeYI7ZdUuehSfI+Lsdf+NFS8N1c8fPpHo69WhKRNS2BGMzSwo/Zh34CR4mqBE6OG0vRqn2HvuTVHXppkqpBz4invdWtlppq+TstOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792388078; c=relaxed/simple;
	bh=pgIkA9EQP4kVbdf5QtIU9MRFvhNyPH6tw4oAfuEjiik=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AV2T8znNGe6p5jmWjWa7F10xJrLFu8r5S8E3DJnk7USx0mxJLk2uSKLLfsH1IPGGIlt8HaoTH7PhNIjIVJJcfy6vmTlp60qZfer47OYEWZfaPUQUeQt0tpNRpVdGF2+L2JS6S3kZvlqFgDwkPJAlemEK9vrHCyW1+qWRSYLenYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osk9oNO+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osk9oNO+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4F27C2BCF4;
	Mon, 19 Oct 2026 05:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792388077;
	bh=pgIkA9EQP4kVbdf5QtIU9MRFvhNyPH6tw4oAfuEjiik=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=osk9oNO+pVwQbN8AhVKAKifgi3TxtDEA2fogTdzyKng9O0f68wCB7E5Q0PyS3DbXR
	 4ZmgLFe+IR59dwrSORr+QiVJDH56y1DS3Qzrf5CPodX3RHtHN/JT4A/KEwsfzZbHLu
	 rf5VNWJMgMtG9rMGYkeCfPBh0zolDLgcoc0z5AEtBBIsxIuPtWOBIfUTGlk1UjXFUG
	 0M38L2KtU9/wDRbvaCVMm4t9pJ7OpP+5tU0Yr+R6Oa3zpYzuTxkiwgPW2H5mOG49AS
	 l2PGFFV3KrgU9aVddIVvenxgTxnoylgbUYmeOwYaELZ9b9gMaLe9TjhK+BUdcTVQgL
	 fa8rzL7FQxpzA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9CFCCF2DB;
	Mon, 19 Oct 2026 05:34:37 +0000 (UTC)
From: Junyi Zhao via B4 Relay <devnull+junyi.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] Add vendor glue layer support and Amlogic A9
 implementation
Date: Mon, 19 Oct 2026 13:34:25 +0800
Message-Id: <20261019-a9_i3c-v1-0-329d819d621f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOGr1WoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0MD3UTL+EzjZF3LFFMjE9MUA0uTZAsloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0AmYvdyWoAAAA=
X-Change-ID: 20261010-a9_i3c-9d5245d094c8
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, imx@lists.linux.dev, 
 linux-hardening@vger.kernel.org, xianwei.zhao@amlogic.com, 
 Kelvin.Zhang@amlogic.com, Junyi Zhao <junyi.zhao@amlogic.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792388075; l=1948;
 i=junyi.zhao@amlogic.com; s=20260924; h=from:subject:message-id;
 bh=pgIkA9EQP4kVbdf5QtIU9MRFvhNyPH6tw4oAfuEjiik=;
 b=QIGcl9ephVHWpuLWE8j6m/z4Ati/770ms7/xAPm1vRqUYUPZMK1LXMa/5Whq8a8K6loC9Gw5I
 KWH3cPY2l1xAuI3YvuF4GsbgSjndplpbnU+NZEYeW3luoxe1XAHVz36
X-Developer-Key: i=junyi.zhao@amlogic.com; a=ed25519;
 pk=hiL5PjGIksGFiWvEx9J3MhQqU/ro6vNbj72NIw4bbvA=
X-Endpoint-Received: by B4 Relay for junyi.zhao@amlogic.com/20260924 with
 auth_id=1054
X-Original-From: Junyi Zhao <junyi.zhao@amlogic.com>
Reply-To: junyi.zhao@amlogic.com

The SVC I3C controller IP is used by multiple vendors, which may
require platform-specific handling for controller resources and
integration details.

Rework the SVC I3C driver to introduce a vendor glue layer that
separates common controller logic from vendor-specific extensions.
This allows different implementations to reuse the shared SVC I3C
framework while providing their own platform-dependent operations.

On top of the glue layer framework, add support for the Amlogic A9
implementation of the SVC I3C controller, including Device Tree
bindings and the A9-specific glue layer driver.

This series consists of:

  - Rework the SVC I3C driver to support vendor glue layers.
  - Add Device Tree bindings for the Amlogic A9 I3C controller.
  - Add the Amlogic A9 SVC I3C glue layer driver.

Signed-off-by: Junyi Zhao <junyi.zhao@amlogic.com>
---
Junyi Zhao (3):
      i3c: master: Rework SVC I3C to support vendor glue layers
      dt-bindings: i3c: Add Amlogic A9 I3C controller
      i3c: master: svc: Add Amlogic A9 glue layer

 .../devicetree/bindings/i3c/amlogic,i3c-a9.yaml    | 102 +++++
 MAINTAINERS                                        |  12 +-
 drivers/i3c/master/Kconfig                         |   9 +-
 drivers/i3c/master/Makefile                        |   2 +-
 drivers/i3c/master/svc/Kconfig                     |  28 ++
 drivers/i3c/master/svc/Makefile                    |   6 +
 drivers/i3c/master/svc/i3c-amlogic.c               | 250 +++++++++++
 .../master/{svc-i3c-master.c => svc/i3c-main.c}    | 467 ++-------------------
 drivers/i3c/master/svc/i3c-main.h                  | 297 +++++++++++++
 drivers/i3c/master/svc/i3c-silvaco.c               | 173 ++++++++
 10 files changed, 909 insertions(+), 437 deletions(-)
---
base-commit: aac26bee2287c88af5be5a5ff96d783b19a28790
change-id: 20261010-a9_i3c-9d5245d094c8

Best regards,
--  
Junyi Zhao <junyi.zhao@amlogic.com>


