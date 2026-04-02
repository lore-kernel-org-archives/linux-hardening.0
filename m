Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D0355F5C
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775099092; cv=none; b=pTGcy9hRrYsH9BwtyvhVNfiSM9e2K3myZ+TEmMd/W5OehK165rt16sg3X3mQz96wVC6479pwFrYyTdF2D+wVs1BZ3K6OLSzheJkQ2ctWkvNGiGZTv/DExd+d34Q0MfalcdMfNzY+KdvWxXQM+EiJ5R0CyPk7xSL3r1beaFaVjWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775099092; c=relaxed/simple;
	bh=lOIwL05Tz/flXBhzxXOkVqAstofU9cbqGe1LI+AkESk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g2z8ykCYYNM1s5EoBnVj/J3I/FdSb/Ha2LdCKGtykTetLG3HXIWW50SPteF8r0J6zzkusI0TNxak3YHu/RD+Bqo0vzehhnq1HMR8C/gnIMLqCKhd2i6gAvqMz5PPDhAKVp/8b9oEiiIVajV6Q12WaUnDJH8FClCvMMLnUxn/1jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cu9th0+2; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cu9th0+2"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35da9692ec3so324135a91.1
        for <linux-hardening@vger.kernel.org>; Wed, 01 Apr 2026 20:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775099090; x=1775703890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kHHx3XxBCiRn9ZL9C1k6EVrQcl+iP3VVeW/3ubciWys=;
        b=Cu9th0+2uq5EoV8xq4AEIuNwgMuHouv4NdTJgh1z/yddMjEWh/K/dZwY25PZ5xrwFv
         2l+dnMWxcINZjlF4RlTGBCZNunM5FGNplOv3ygv6mcV6fGca/IAJQG7DcP2RP0I2xfm0
         jXP2rzgbKRzhNCfx8dt8757A9AWij7nxScSTOBy/bDLHwi8K8CF/kf2LNJxYMI3qEMcN
         twnB/1toOjCOtWv0nQrcYHHAHBNDuQJ5fFhlQEnhHXUKQiiJgMaLYFeOYo1B1sOZs8vt
         coIgnMxf7YeeP5p77xXFKu9FT6ZBSYiEwClI0Ji1LbFLi7Tu/dG+B3+jnoHG5ABA+fcp
         +oSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775099090; x=1775703890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHHx3XxBCiRn9ZL9C1k6EVrQcl+iP3VVeW/3ubciWys=;
        b=ofoksqQ3dz8N6ISGUagoHYqPEqPiaDMaxO4S070jbmC3BMOkACZ1kW4Fiy2nHtWOlU
         W2+XCoPiBAuoL3mC21z8S1AsgJjuRav6TjnFnLStyrunGsBCP9m1Skj0DVkXw7dTk0HZ
         9cNDmnKNg9BEsiHw3LHU69ZpkLS+MGSPzUFGgqpXAFPFr1TeJMIO3wY0qPI+w/v9mtG+
         oM6m+mSRUL/uyMxJpkIoZ2kj0s1UZMhybMIJ9A9ux//mJPXuofQRzEeFMx4TNRwCQlk9
         gyQYf2Ax4NNKmk8PGhYQLEhU2FQomSFMY73fpzQb0cDC0i/YG7uIfXmD6B0qMBCbZTKH
         GbtA==
X-Forwarded-Encrypted: i=1; AJvYcCXkYKfTE3ts6Jvgxp6d1KGtPh817Z43Bq1Yl61AudHtRlPeweH3pNHfLYHPhkqN+yOzGwuMuEiMaNqj7dfyouI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Zt48DzvHMm4A8kLskpQu40v75BQYS8W1vhQtsVj9Nx75Tphu
	AdkjOo684+QaPuzOJa7uHnLlkQfPCrB+BebERG38ldW1DeJnntbQGS81
X-Gm-Gg: ATEYQzzuDgnQ/e8pBg6MIHOBDEf6YER/ZruLagJRZJ+DrAgs1gsMqKbWNvZs+sJ1ehg
	VyO4c+p3Pk5xbc6V3wqIHIaSW2k3V5MqY0D7yR4bWXh7GzjeUhcKJlHF6UoUhXWA4lppk8vllE2
	dH2Ryu2WpieQECFC0NSnPUG88BjgJIS2yAE556BSNMaU3mPIIx5GLFV3X2xpunnWYfZTR4xvJMF
	cEv99iKDwLWlvDeBlOhYDHfav07AGAPsnLO0eA87nZFvPgU99/VrcungSk3mGjNbEM/oSPCYxeW
	taEDYE50D/OMb3bELTdTAofWckEzdKsgbyUe+ydHM/BzlOvBkihVGAqoa2DSu60jAMVEV7VQovq
	5b/sLDBwbnINWIYxMKMTPQFqOdPjUFZ8Nvuka7oprPeWP1yOz0PUd9A4AuX+xdEkXgrGHkmt6QT
	u69zQa2CLQbDaYiuAEnjgZT6VDgEzZecKRURqBfkz0Wud6Hb9oRNVIoRg=
X-Received: by 2002:a17:90a:c110:b0:35d:a276:a880 with SMTP id 98e67ed59e1d1-35dc6eb03bamr5152954a91.10.1775099090124;
        Wed, 01 Apr 2026 20:04:50 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9379f3sm6395873a91.9.2026.04.01.20.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 20:04:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SOC CLOCK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 0/3] clk: samsung: use kzalloc_flex
Date: Wed,  1 Apr 2026 20:04:29 -0700
Message-ID: <20260402030432.101066-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch three structs to flexible array members to combine allocations.

Rosen Penev (3):
  clk: samsung: use kzalloc_flex
  clk: samsung: cpu: use kzalloc_flex
  clk: samsung: pll: use kzalloc_flex

 drivers/clk/samsung/clk-cpu.c | 30 +++++++------------
 drivers/clk/samsung/clk-pll.c | 56 ++++++++++++++++-------------------
 drivers/clk/samsung/clk.c     | 28 ++++--------------
 drivers/clk/samsung/clk.h     |  2 +-
 4 files changed, 44 insertions(+), 72 deletions(-)

--
2.53.0

