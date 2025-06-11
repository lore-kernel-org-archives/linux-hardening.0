Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE92206BB
	for <linux-hardening@vger.kernel.org>; Wed, 11 Jun 2025 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749634802; cv=none; b=PmpDMKyv6MDxcu9KhzHA1L+NHf1RooT3vBoBClwVL5hvT3oEIhKkeo0qQiqxMgFKGz/6+kMBMCd3JI8TJeRvw755Fq21QZP3ps/1XFQcf+KaVvq2I4HAeIb00bLXoJnDbzDJO+EVEPWobmAXxpofpPvi61HztGp9y6xYtk+15r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749634802; c=relaxed/simple;
	bh=djmGttJvgdrAuT76sTzzM7mwhva2mmL/CWA7Yznfn9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/coqR/vnzM9o1hAN/lkb9EUSTyhE5aHUw8cc70rUp1d0g/z4s/oK9Z6jd+PE9QIorX+aXbCKfgKOoKVHvIpDaMzfHsOw8Gh0dm8+NtvPj1tP6nvFVHba/PlyBBNX4BJF1mNl8Guqbf289ONRMO1udqtXSuo5c0kXr6f0unSSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=VFNVNpSb; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="VFNVNpSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=zH0VzyGLR/mOki
	AFq6apyRlsnaQD4TKPWwgqIVI/8Ew=; b=VFNVNpSbvQWU5HJ5S3bJmFMYPyssop
	9Kdmvnr0gWqtRkWE0lq0z8lz4U+TJr8pKSwhd1DpHFsWj9/g+NDUEBLscwAOILa/
	eOxecLtRZS+aThdI32f0HEJsqfBjJyY1YrGtHZURtQNkDl5zlT4PGsISf6a8MMAr
	0PolMggQk72ZK3oopSOZ+WiQ4Ovgl1jVXITUU/4rJQN3nZOcwXvYfwKTjXuIASNz
	a/GmQyd0+WTSagKcidSAAs7fsFEnEvxKJzQ9U7xWEwXCuZ5ac8ZVLzcq4hjFfLzW
	2+m1XlN5fs8ITMH/W8yMyfZlNZKufKfcExK9abUMZ1/G9DvM1hyEDGYQ==
Received: (qmail 3186264 invoked from network); 11 Jun 2025 11:39:48 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Jun 2025 11:39:48 +0200
X-UD-Smtp-Session: l3s3148p1@EIQHmEg33rAgAwDPXy2/ACpZfVCNKldR
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH RFC 0/7] i3c: add driver for the Renesas IP and support RZ/G3S+G3E
Date: Wed, 11 Jun 2025 11:39:24 +0200
Message-ID: <20250611093934.4208-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is finally the first RFC of a driver for the Renesas I3C IP. It was
created by merging two versions of it from two different BSPs. Then,
improved according to code analyzers, cleaned up with regard to coding
style, and then refactored to hopefully match I3C subsystem standards.

It is a basic driver for the I3C IP found in various SoCs like RZ/G3S
and G3E. Missing features to be added incrementally are IBI, HotJoin and
maybe target support. Other than that, this driver has been tested with
I3C pure busses (2 targets) and mixed busses (2 I3C + various I2C
targets). DAA and reading/writing to the temperature sensors worked
reliably at different speeds. Scoping the bus, the output from the
protocol analyzer seems reasonable, too. But hey, I am still new to all
this, so I might have overlooked something.

The first patches are needed to enable I3C on the RZ/G3S and G3E boards.
Once this series loses RFC status, they will be sent out individually,
of course. All is on top of 6.16-rc1. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/g3s/i3c

Why is this still RFC?

- On G3E (but not G3S), we get a spurious irq during boot. We are
  working on it. This is just platform dependent, though, kind of
  independent of the high level design of the driver. For this, we
  would love to get comments already. So, we can fix things in parallel

- G3S has 17 irqs, G3E only 16. The way we handle this might need
  discussion (see patch 3)

- On G3S, clocks are named 'i3c' while on G3E they are named 'i3c0'
  I don't have all the needed docs for this, but Tommaso can surely
  figure this out meanwhile

- There are some open questions regarding the driver itself
  (see patch 4)

Really looking forward to comments! This has been quite a ride. Getting
a suitable test setup was a surprisingly big task. If someone knows an
off-the-shelf device supporting HotJoin, I am all ears. I couldn't find
one.

So much for now here, some patches have more details.

All the best,

   Wolfram


Quynh Nguyen (1):
  arm64: dts: renesas: r9a08g045: Add I3C node

Tommaso Merciai (3):
  clk: renesas: r9a09g047: Add I3C0 clocks and resets
  dt-bindings: i3c: renesas,i3c: Add binding for Renesas I3C controller
  arm64: dts: renesas: r9a09g047: Add I3C node

Wolfram Sang (3):
  clk: renesas: r9a08g045: Add I3C clocks, resets and power domain
  i3c: add driver for Renesas I3C IP
  WIP: arm64: dts: renesas: rzg3s-smarc-som: Enable I3C

 .../devicetree/bindings/i3c/renesas,i3c.yaml  |  186 +++
 MAINTAINERS                                   |    7 +
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    |   35 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |   35 +
 .../boot/dts/renesas/rzg3s-smarc-som.dtsi     |   33 +
 drivers/clk/renesas/r9a08g045-cpg.c           |    7 +
 drivers/clk/renesas/r9a09g047-cpg.c           |    8 +
 drivers/i3c/master/Kconfig                    |   10 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/renesas-i3c.c              | 1441 +++++++++++++++++
 10 files changed, 1763 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/renesas,i3c.yaml
 create mode 100644 drivers/i3c/master/renesas-i3c.c

-- 
2.47.2

