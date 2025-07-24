Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BC238166
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350112; cv=none; b=R4M7UXGkWzfIHR2KkCRnz0CfljsGXbE8HmvjqGq/DpMTKTXcmBKiWyEKVawGSI2juTE5zkwBdVVrwfDLRWTINyv06/MK5t7FGRVlm/ZYiXrkpwFVevmzej9utX/mvJ7Q3jIYR5QZEGDYL5BSCrx7/krynOK9Ax5NjBn4Miwzvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350112; c=relaxed/simple;
	bh=7uEbnJ2I42h1jINhiLxKuWZoTLhPAnfyJ1Vm/JSEYJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYCoWtGCNjoH2WF847NQLAhw2TeGkkDkZFPBHLnBhD66Z+5u+pzSdq5KuvJ9PwI0qp7I5Pi1jhRJmph5xslmVWSwRL3sdONV88RY6R/QxGOr+wmIsmoBOvVgGAbsGd6D0PNJq+2mFXx+CyennL4U/hwinwoe225BFqhhFKrS5rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=FcFcYXyz; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="FcFcYXyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=pqi6scVX8AxwJ8
	OR0QjkdOlPSeaMekWpfnI+8ituDOQ=; b=FcFcYXyz+oSuSl7RCQoDG57hHaGUYg
	OdAFHD2SC8yRPUqKsSs59297kZclfyitAIPFeU5rf1p4VsWpx1lWHahTggUHD0Tt
	V2W6uBuE2Qbktc3Adpdqm/K+9tD4AZaKQtqN7sURXuYmLFufAmPW9oBStVTZt0oN
	JjN4BpV5bdyu7O1cMMYVdAwLCpW8wj6rwDWOOHoigabDNWcATGGQaeMo7nLlJEP+
	yW2auhgP6IJYBXafNU06rwfzEP7ZEJI2SW4UnQiSQeBU28ZEi/tsjvCto6dP7nVC
	uOvOJ6yOvqHYVowd/JEOS5tHX9opZ8tgbNV6CRyQFxCO/whouXXOpWdw==
Received: (qmail 2016439 invoked from network); 24 Jul 2025 11:41:47 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 24 Jul 2025 11:41:47 +0200
X-UD-Smtp-Session: l3s3148p1@I7ZOoqk6tNEgAwDPXyBWAATEinPyanBm
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v5 0/4] i3c: add support for the Renesas controller
Date: Thu, 24 Jul 2025 11:41:39 +0200
Message-ID: <20250724094146.6443-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Detailed changes since v4 are described in the individual patches. A
branch with enablement patches for RZ/G3S+G3E can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/g3s/i3c

Old coverletter:

Here is a basic driver for the I3C IP found in various Renesas SoCs like
RZ/G3S and G3E. Missing features to be added incrementally are IBI,
HotJoin and maybe target support. Other than that, this driver has been
tested with I3C pure busses (2 targets) and mixed busses (2 I3C +
various I2C targets). DAA and reading/writing to the temperature sensors
worked reliably at different speeds. Scoping the bus, the output from
the protocol analyzer seems reasonable, too. It was created by merging
two versions of it from two different BSPs. Then, improved according to
code analyzers, cleaned up with regard to coding style, and then
refactored to hopefully match I3C subsystem standards.

Looking forward to comments,

   Wolfram


Tommaso Merciai (1):
  dt-bindings: i3c: Add Renesas I3C controller

Wolfram Sang (3):
  i3c: Standardize defines for specification parameters
  i3c: Add more parameters for controllers to the header
  i3c: master: Add basic driver for the Renesas I3C controller

 .../devicetree/bindings/i3c/renesas,i3c.yaml  |  179 +++
 MAINTAINERS                                   |    7 +
 drivers/i3c/master.c                          |   12 +-
 drivers/i3c/master/Kconfig                    |   10 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/dw-i3c-master.c            |    4 +-
 drivers/i3c/master/renesas-i3c.c              | 1404 +++++++++++++++++
 include/linux/i3c/master.h                    |   13 +-
 8 files changed, 1618 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i3c/renesas,i3c.yaml
 create mode 100644 drivers/i3c/master/renesas-i3c.c

-- 
2.47.2

