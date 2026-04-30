Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF5626E710
	for <linux-hardening@vger.kernel.org>; Thu, 30 Apr 2026 02:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777516137; cv=none; b=e7CFlFE2ceqOypKZNTPj993Yvthd/ScHhj1qdBm79DFM9T/u2vXZMjHQYUUyKzIwv+nzfqIHWDgY8sFWouJsAU9NHCtCSq48qlEx/zVdLW2yLgtC6cFtuSYl4nB1sfrltW3iwOLiPBaFqSG8TQMYNEERbogIGE9adNL3KpDrCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777516137; c=relaxed/simple;
	bh=fpI7ThcAkAntW6jxg6C3O495NPhVSuVAiCMm/40Z5xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fK5XuO6Odb8LLbBNkY6kItLJSliAmH3huI5M1IvvbJGeTXJ7Of4QdM1WJE6rLFD2LWTngt4X1sbXssFck8LDFl7TPKX9YWyIkVWAUGUVqecx90idImBHh+iD4lyyh3vJFllJ7rCkskKZz168uvjGGUzaUG5LKlp+W2rn8pvD1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kv3fXVkY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kv3fXVkY"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso240830a91.0
        for <linux-hardening@vger.kernel.org>; Wed, 29 Apr 2026 19:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777516135; x=1778120935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvKNB8FFlV6JIJdaaGCkRo0LW6S72vZF1V6svTAMliY=;
        b=Kv3fXVkYFPt7gejljfTWEvyGxk5IoopqfNRJLsg65LwFQpCMnEuB+MEmjNfNCXdDHp
         RDJu2Ofn2H0akb1Yd661TrgzAJX13mw7PL9f61rjhNyyclPa/A3LG9P4U2JJjnJXGmr5
         voaTNF0ZPzyAxPrGUbArecZCga0SoTfYuhiQhlBiYQvyUFzi5iwvwnyG4PpcPw5AWQMq
         /Y5P6zsqpybLIfUUMK8YpzgEgSQE45j8lKFh7GKJOteQNu3eRuMxtUCIX3OSLbWzPFm3
         OYZnoEMbLMk2UMxADNK8AKpw14SniznQbuJq+HX+e3z8G/bhODpdP8807S7b5cjvMfGA
         533A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777516135; x=1778120935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvKNB8FFlV6JIJdaaGCkRo0LW6S72vZF1V6svTAMliY=;
        b=RYlK3O2NLEfsQpg93TSDxZemyCAeZ3yJrT70LVkksWF9Vpz8KSaCD0+DK+U5mIUrWq
         PS6CWRsFMrhZTOIo3StZHBBRkRtiZdtRq0dl2vF4B5VKlwnn91lRCfX6yI/1mj4oUzQy
         jrdhj3msaebcOdbuFNSmOLqi86v4iJWjc9F2cKLEE3QtsqcaU2MKfWnj/uZvOgu2q9xN
         I/rNP6/yel8kZhKTPBIB1BazdeJrLDsuekvi/gF4MUGVi2L+9sUNJFUu+6tNfhkNUoFR
         LSNcSgBkFBfBLQavEtmivgnI+SEoznIpYYMaHUBW5dNdhXPSQZyY7wO64KwlGUxAE+LF
         Euiw==
X-Forwarded-Encrypted: i=1; AFNElJ9t7JloqjfACVOLVz2lqY4sSOx870MLOuWISuFvVFVj/9G8fk5+CJkhqcw5neTfd7tyJOVYKg3YxSoYKoe0UFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV4SCyST6iU3yqL3nCkuXxUVfxqZPEYZURSBYOSxp6+dkpbpLm
	1S954Ef/4ZmXXiIKqOA5e7uH2e21N9J3NiwE9CfgyOOWjI5OdZATvuE3
X-Gm-Gg: AeBDievncashdeFBEIeBOa4LAPPMi0KOtXl+rErEop/gEgnauiWf4ZrcnUSpYWjlh0i
	sjXnlMhtd6A8qLx+U1EJeZez9jMScHDALmPi/fRHA1knVrA4H46TdckZtuE1Bg4BrdkiyozOTYK
	i1tTpb8QfVHCSqJWZ4fT4ItLR0Iyq1GLC58ZIULIazSSYC9IH9GciaQOtKeIEsIugZ0PvRlFpih
	MkpIeP70xeMiFo3HxMo81twosawuG7XAn67nmG5kf0BEQ5PPvZMImVihfLEPGfdzOUlcMkWPaQ5
	wMtntIMxC6A1fz9plfKY0TRVPfzSGqHMtvJU9sQfa8uMd5HozD6kp6PmGx6w4CvQqtVwlQae3uJ
	z2mzm/Q3izmAhjs8oriP34QE+fYvUUi2MIuhF+YhIPDtzc9EXcQy5WS2hFFZ1fDPGlXusYtFFkf
	fw4B4+mqNBaYxFx4OKI+Miex0L4mRcYo5IKw==
X-Received: by 2002:a17:90b:3c4e:b0:361:4521:d311 with SMTP id 98e67ed59e1d1-364c309c2b0mr920821a91.18.1777516135395;
        Wed, 29 Apr 2026 19:28:55 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf2a71bsm987033a91.1.2026.04.29.19.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 19:28:54 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yixun Lan <dlan@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Inochi Amaoto <inochiama@gmail.com>,
	Ze Huang <huang.ze@linux.dev>,
	Alex Elder <elder@riscstar.com>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 0/2] riscv: spacemit: Add K3 PCIe/USB comb phy support
Date: Thu, 30 Apr 2026 10:28:39 +0800
Message-ID: <20260430022843.1090138-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe/USB comb phy on K3 is a big phy that contains multiple
standalone phys for each PCIe and USB controllers. This phy is
required to configure a syscon device for mux configuration and
calibration.

Inochi Amaoto (2):
  dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb phy support
  phy: spacemit: Add USB3/PCIe comb PHY driver for Spacemit K3

 .../bindings/phy/spacemit,k3-comb-phy.yaml    |  63 +++
 drivers/phy/spacemit/Kconfig                  |  16 +
 drivers/phy/spacemit/Makefile                 |   2 +
 drivers/phy/spacemit/phy-k3-combphy.c         | 250 +++++++++++
 drivers/phy/spacemit/phy-k3-common.c          | 398 ++++++++++++++++++
 drivers/phy/spacemit/phy-k3-common.h          |  27 ++
 6 files changed, 756 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k3-comb-phy.yaml
 create mode 100644 drivers/phy/spacemit/phy-k3-combphy.c
 create mode 100644 drivers/phy/spacemit/phy-k3-common.c
 create mode 100644 drivers/phy/spacemit/phy-k3-common.h

--
2.54.0

