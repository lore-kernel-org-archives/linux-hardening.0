Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24347241C8C
	for <linux-hardening@vger.kernel.org>; Fri,  3 Jul 2026 02:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783044669; cv=none; b=EDUjB+5GM/T9UYfSsYY9awzg7XZBdK1DJD7iymiikE8SrckeozZHae0kCTJaDRgKAsyNHydkBJeM05PTS2F6W4Iy1dNeWbbHo/5yhlaLg08z+cbiVtrGnfhVgDEJ4+sfgVHQZ2TLTNHa4KTdDSwHmBMhPZxvbXho6OFhLB3NzoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783044669; c=relaxed/simple;
	bh=o2jlelQPxV+nzbfoQUAgtVkuNyE+WmmoaGnh8aaogKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Re2LKiGiI+mcZoIlykYcMR0rik7uULZrp+MXTIYYOzgqdqoqOB61h7Yk9p28WLXoB975zViP5CuiWlzU0PbLNBL+6vd+6t1SgCIx48W4G2OQqK5M7PoC/d+AwH72Bafyq0srLlZJORXHmKpUXAUiK+/keVzBca+9YibXLCrf+78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5gjNzG1; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5gjNzG1"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso79656b3a.0
        for <linux-hardening@vger.kernel.org>; Thu, 02 Jul 2026 19:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783044657; x=1783649457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9te5WRnB3/pnQ+/Q0S83oqHxAqp55SmkhfuxRe3M02I=;
        b=U5gjNzG1ZobA3lMW8WgFhjZgJ06XZN/Ydgm45lGGKjgCDP+N1OAdB21HTwzpJTUhHY
         jW8gHsg2W4Oms84EU0M3IhQ+GC+/wx4y/dy1DQ8O+g+VYhY07wWkw8LGo4N6hfejwt0d
         g1dleaiS9k+mseoilhV3E51/xr4xftz6HC88NmL8ZxopAuF2B8J4001N4Y5vgJRT7jAR
         z9+2/7vuilBKbuUSknwO6xpVyg0EdZG9UyPVG4GEocgV/qYPVFIoIAa2tR9ilzbUTj1N
         iSIbKV0YbwzMRFzIdWiP9seqT9EoI9ztzhmCM7ScVGj8ET0zJAKtpBKB6Mo2NEeShfEM
         sm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783044657; x=1783649457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9te5WRnB3/pnQ+/Q0S83oqHxAqp55SmkhfuxRe3M02I=;
        b=Zd9c0rk1TVi9B3uvsf5OJaPQIP6bEeeDlkupR1+v5wFlbmuz6XpN9LLd/pNq1b2tHo
         e+AXbT0YXPhbISNNT2RODv/6Lt5EF/VwwECpQrTHjSemklO1swES/hG3zEJgETQ85rjQ
         0QQS6+CYsGJkAdSNIhiq59+JPwyZoyogC2Pj+L/MNqHn48byJLTnMV/aoxHIJ10kcpUg
         Qi0IvWT8hLcSE+GJZv8YQpWIbq+KatOfI9LvuoxgiWI6AXlrX97vt5dFDAaY223duKRQ
         tcJHMwmcttmPaDzmw8iv41RZZtYhiSpMUTsUGC9LSQvLOaRY+fR8mV+HHSMvlLSJA3fP
         ziWA==
X-Forwarded-Encrypted: i=1; AHgh+Rq7l6uv5TvBP4cIngR04wOSXdXQAM3SEBhP3H8ZXrxrUheNT8ZsqPEuwjaa9D9HZdTq70/3F3KS0F9MvMF3PXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIC11z16ipyMfR4ofU7kIqSOHH4DWBsRF94PDzhvll9nqeYr+2
	VxmsmIPBghcSY+h4qWCJyE4Nx21Qm5VfsMIUdn5o2ylN/vYWBO1b5OIg
X-Gm-Gg: AfdE7cli/XvW4eQEW0tSOL4nBEfGLPh7JaeR6SaqM73j+cL97DI/UZNFeNXZ6F+7mQ5
	hqicWnQ480HryJpfTZWMQ1/oYGwGrTNsVU2zWCIGcMRTLkwjKm6jhK8ibUAXjX5vqdShRtnxXFv
	2ASdJ6nnYZASag17W/zcU2KviYjCwUtEDspGTLeIh3rmsPt5VgHCTK9UK9BPuy6ZKpYfer4LoWx
	ol2a0Q1MTzblF8dNv9kNt2ui9K3AGawzwL9sWBswXTiX6KIpfGwsD0mXoIjqT2EdE54Y2lySlGy
	/YKeGcFLh7tCiGPBD428KMkv2VD4NK1jnhTskVcof4TlJc5fzCEsWJT0hlN6pd2EC42Gtrw8EYd
	DZG2UuY5yOVTbmkgldSqW7kyrvXQvfYCd6Z72DOKzicwnRkMs3dRFQRKX7oD0KndQ0VEzaTq220
	YwkpsLwzPMmoQHx3bIBLXhLg==
X-Received: by 2002:a05:6a00:b481:b0:847:8496:1aa2 with SMTP id d2e1a72fcca58-847c0731433mr8687798b3a.27.1783044657351;
        Thu, 02 Jul 2026 19:10:57 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb9b0220sm2124478b3a.50.2026.07.02.19.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 19:10:57 -0700 (PDT)
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
	Alex Elder <elder@riscstar.com>,
	Ze Huang <huang.ze@linux.dev>
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH v2 0/2] riscv: spacemit: Add K3 PCIe/USB comb phy support
Date: Fri,  3 Jul 2026 10:10:21 +0800
Message-ID: <20260703021024.495433-1-inochiama@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Changed from v1:
patch 1:
1. Add extra description for "#phy-cells" and "spacemit,apmu"
patch 2:
1. Fix multiple spelling errors and copy-paste errors.
2. Make some magic number as meaningful macros.
3. Remove USB3 set_speed() callback as it is not needed.
4. Fix the wrong land data config and mask.

Inochi Amaoto (2):
  dt-bindings: phy: Add Spacemit K3 USB3/PCIe comb phy support
  phy: spacemit: Add USB3/PCIe comb PHY driver for Spacemit K3

 .../bindings/phy/spacemit,k3-combo-phy.yaml   |  68 +++
 drivers/phy/spacemit/Kconfig                  |  16 +
 drivers/phy/spacemit/Makefile                 |   2 +
 drivers/phy/spacemit/phy-k3-combo.c           | 252 +++++++++++
 drivers/phy/spacemit/phy-k3-common.c          | 391 ++++++++++++++++++
 drivers/phy/spacemit/phy-k3-common.h          |  27 ++
 6 files changed, 756 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k3-combo-phy.yaml
 create mode 100644 drivers/phy/spacemit/phy-k3-combo.c
 create mode 100644 drivers/phy/spacemit/phy-k3-common.c
 create mode 100644 drivers/phy/spacemit/phy-k3-common.h

--
2.55.0

