Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BAD233707;
	Sun, 14 Dec 2025 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765713116; cv=none; b=ffUbP10NWUyvXNEBHbu8ZcN87PcHhOz+uXSYzEoxYqenVXYKYmo68e3KDc5KrmREYd6ijSzHAmG8o2MTyYp4xVWDC1I2j6KCG3IilgVPSn3mw4JQkkbvsw5ck848w6+Poe+ra2XkXr28N+ct93Xcb7sFTnAEDTr9LLHzIeNb8zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765713116; c=relaxed/simple;
	bh=A9b5Y7XPAJ4q0XUe8bUjFOzSiI/pDmxH2l9xPh4oLjE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y5XACfp5JRG0BHZlyZI0c2FUCliDlkFXrEfmlsT+HTrg9pzt/yAwHcePjRao0oOPGtNNgpsJIy3Q/pixPpL81/jLAxme3a/9hQAwNkLX158vOofXCVZ4Jt4Y7M0cTfyPUCVD++jG/MJbtrFibApRfg5obIUKAClVhpHExfmvAXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFFq9KLQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFFq9KLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E45CC4CEF1;
	Sun, 14 Dec 2025 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765713115;
	bh=A9b5Y7XPAJ4q0XUe8bUjFOzSiI/pDmxH2l9xPh4oLjE=;
	h=From:Subject:Date:To:Cc:From;
	b=OFFq9KLQKCdqawPp1tT703Q4j0XqLQijvanlATZPtYXmVZ7tescSWXNeGeTl2upMF
	 Tc7xJ5Ce0ndnlQ0eeGlRNyn74pJAtT2HW7F2crPt36bq4FQsVxjgUVNUPqhQ0bTmp5
	 cm8WC1u0AQQ39Nx9zd9xp9ZFKtrG0EsB3lhktSuQh0LOhDJmzh73z8WowBuMP7Jr5M
	 Gx7THo8GR+ItIxxecEO8W9Yi9m7TjxnqUC3qRcHsa5IdfmbT463ADGQlXZpj5f2nEN
	 /Yco9zNEViWKvLIpfSNWmqfmFqCr/ib7yGXs/eZPt9HNNuhU8oJzFWCyrqnDu/5TZb
	 XvOvJRH/wfyGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59013D5B158;
	Sun, 14 Dec 2025 11:51:55 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Subject: [PATCH v3 0/3] Apple Silicon Type-C PHY
Date: Sun, 14 Dec 2025 11:51:33 +0000
Message-Id: <20251214-b4-atcphy-v3-0-ba82b20e9459@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMWkPmkC/1WOzQqDMBAGX0X23JTsxp+mp75H6SHGqKHFSCKhI
 r57oxRqj/OxM+wCwXhrAlyzBbyJNlg3JBCnDHSvhs4w2yQG4lQgR8HqnKlJj/3MmlJVWgrZ5Fh
 Buh+9ae17b90fiXsbJufnPR1xW78VKg+ViIyz9oI1EhWt1OXtafxgXmfnO9gykX4q0vGBSEkVu
 dYVl1QTqT91XdcPQOtkWt4AAAA=
X-Change-ID: 20251013-b4-atcphy-d6a7c939d417
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-hardening@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3216; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=A9b5Y7XPAJ4q0XUe8bUjFOzSiI/pDmxH2l9xPh4oLjE=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ6bdkst/lq6P4gyc+M3nktzcrkdJ0QuzeOenTZIqmbwn2
 13kU3ZjRykLgxgHg6yYIsv2/famTx6+EVy66dJ7mDmsTCBDGLg4BWAimaEM/3R9e4t/qBib3pAT
 LfXYuTcwqck7zzpHls/bq3C29xINXkaGne8/z1KU8c1nkTxy4dX2SI8N1ybtifynoL9Eo8MsMiy
 EAQA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

Hi,

This series adds support for the combined Type-C PHY found in Apple
Silicon machines and required for USB3, DP-AltMode, and Thunderbolt/USB4
support. As in the previous versions, this is limited to USB3 support so
far since the other modes need further work in different subsystems.
With the dwc3 glue driver being upstream this is however the last part
required for upstream USB3 support.

The generic tunable support inside driver/soc/apple will also be re-used
for Thunderbolt later but it's fine to take it through the PHY tree
since thunderbolt will depend on that anyway.

Changes in v3:
- Link to v2: https://patch.msgid.link/20251123-b4-atcphy-v2-0-34cc7092b22a@kernel.org
- Rebased on 6.19-rc1

Changes in v2:
- Link to v1: https://patch.msgid.link/20251026-b4-atcphy-v1-0-f81b1225f9c6@kernel.org
- Picked up tags from Rob and Janne, thanks!
- Added additional sanity checks for the tunables to guard against bugs
  in our bootloader (Janne)
- Used struct_size from overflow.h instead of open-coding it inside
  tunables.c (Janne)
- Fixed a bunch of typos in atc.c pointed out by Mark Kettenis via IRC

Changes since v2 of the combined series:
- Link to v2: https://lore.kernel.org/asahi/20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org/
- atc.c:
  - Removed a bunch of outdated safety checks from atc.c that were only
    required in a previous version that did not rely on the dwc3-glue
    driver
  - Addressed Philipp's review comments:
    - Added documentation for struct apple_atcphy (and a bunch of other
      things while I was at it)
    - Moved the mutex guard from atcphy_dpphy_configure to atcphy_dp_configure
      since the first one doesn't touch any shared structures or MMIO
- apple,atcphy.yaml:
  - Added a generic apple,tunable definition that uses uint32-matrix
    and refer to that one from the individual tunable properties
  - Adjust the tunable description to make it easier to understand
  - Limited all lines to 80 chars
  - Used > for longer descriptions
  - Fixed some typos
- Picked up r-b tags (thanks!)

Best,

Sven

Signed-off-by: Sven Peter <sven@kernel.org>
---
Sven Peter (3):
      soc: apple: Add hardware tunable support
      dt-bindings: phy: Add Apple Type-C PHY
      phy: apple: Add Apple Type-C PHY

 .../devicetree/bindings/phy/apple,atcphy.yaml      |  222 ++
 MAINTAINERS                                        |    2 +
 drivers/phy/Kconfig                                |    1 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/apple/Kconfig                          |   14 +
 drivers/phy/apple/Makefile                         |    4 +
 drivers/phy/apple/atc.c                            | 2294 ++++++++++++++++++++
 drivers/soc/apple/Kconfig                          |    4 +
 drivers/soc/apple/Makefile                         |    3 +
 drivers/soc/apple/tunable.c                        |   80 +
 include/linux/soc/apple/tunable.h                  |   62 +
 11 files changed, 2687 insertions(+)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251013-b4-atcphy-d6a7c939d417

Best regards,
-- 
Sven Peter <sven@kernel.org>


