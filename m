Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF2310620
	for <linux-hardening@vger.kernel.org>; Wed,  6 May 2026 23:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778110733; cv=none; b=t7/xffVfPQZN8mqMJu5i5rKkQ7xDrm0xsf99DGcUyvZdZ8rQeGdOphzBaq9bzXugpqY8NX/Ki0F7ymB9tgKvo8BnyIhekC5NvvJfUrNYwy4fWP3/GBH4s+lsaqGOUvVvqidvNzhYpt7qmBkDFCpEBfLv6Lr1qmNgikrFiAFTobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778110733; c=relaxed/simple;
	bh=9zAPeymXTdpKny4POpd108mMRvmh/gvrm8KrmFAoFzI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWraoS3z9MQ56jn8+RV8I+bTxlyuyHNLTTNQmWjMoTj+NCEUAVe0MLnYbn58mjNVc5sk570UhA/6UOwJp94GmxBE24/Hy/TfqfHzMuwFd9ngUcP+2QnrN+xzHMlfyzZ5lYm1TCVvnkVbfWjb+SlLy16EN8yvqImpQIwzuybLLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoL71SZe; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoL71SZe"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2babfd18435so158815ad.1
        for <linux-hardening@vger.kernel.org>; Wed, 06 May 2026 16:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778110731; x=1778715531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVEIaKDdrM7xZJUVR1McqNtSIVMO4TpYRcIh7aYsrl4=;
        b=EoL71SZeCun8eAZ0U3LnPTB+JXJx/+KqBBNQ6OtKSCbiStSsH6Hzx2Lm8W00gyihwb
         1qOLpT0uQ/xS/kjzT/iWe92JWZT4cQeJ9DUybN9Z7oQfg+Z41uEvyf6C3Dt80cGBONK7
         bHX2Q7+5ihpc10rSjbbTE7ruZeaDkUbINYGC80cHqa2zcXOykdZEfKaP7VOveWCJVItl
         jfJiM95wpOOsx4Q64TItROp/Ef9BEPLFF4+qKcQelsMSKqbggWMv2rR1qxnlr0JuEgcf
         zxALSTV9nS2w/tuQp24Jq3Irn1F1PQZLJLLAyOMecbwy1jqsolditHF0om2Id5y2Tz9y
         5POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778110731; x=1778715531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVEIaKDdrM7xZJUVR1McqNtSIVMO4TpYRcIh7aYsrl4=;
        b=BHVOkgIZvGoWKELyQ+HTsGGp0Y2lyTUyrd6LqPzaT38Q76lOKMRt0nfjBsRAqbb1dE
         MikV0G7sY0u5yTG8O+nr6f97ZKtC2owNS7ReHIDuLwYlG2G9jGU9olRoj0mpNaldcTov
         3qdvcVnPIQlcXfzGBDC+R5ydwky2k9IFiDmCOsCbpVMZzlR+SpRBNXUGa3HQkFduMUMY
         nx2ClJGNRFgv/Va/g0lmtp6s8UtXIA6xMC3BRgzDmSQpKqYMrlfgHPCog/dMXw5DO4My
         8/uvRDT1CLFyXqMcCUgM9eDh7n3eQ6v1ZtSK28m1oRvkTrdsqqt0h6qdaEbQw6TKjEsu
         mgew==
X-Forwarded-Encrypted: i=1; AFNElJ/eIyo0G2/akO6TmcChuNDQlScO54sQvrSSDyxwetnXnE+yrAGGtk4yf5poaodrumSLKzdj4CgpQoyz+dK0wLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbvrSH0SjA+KkWCJIcLDu3448Q+HShxS7Dmt7T2i1NgitcrAcA
	ro//VrcwrE6CpvUPx4YNjp805rcEZcZs4mIbylkrRzRtSbPxFNg6d8dZ
X-Gm-Gg: AeBDieuuH7Q/2MnYpSl5hfxv7pfEY1zTqPYszOygTdhOQCEuTonCP8xvBH1xNBA1nJ3
	dFs98rj/yfC1fgFW2d9OvjRpk0hfJYH369sRb4mccQO7e6m+ctTAuMHxlUvvjtcPGwR4ciRSKt6
	A0TVmsbhhxtCO5FC77VdpYHN0wEw8D0mgBGHxDVKH6jOrbjt1/k+gqQl4hA6P+hQBdVqNiTEOoh
	3udSTCbIbb5bt/mY+hE62p+P+eL/6ddBJfbD4vKMizWuwpekIJfc/FVpi98hNghIawIOuMLuEcT
	XLy1D+xOQ6lSckZcB3zFv8dKVy60AvMJFm0KhD8gdJ/vKrrolBvNIOJWqW2Am7wtf+Pk3k5TtU4
	+1OTFp+FCSd7/VYXaxQccFJgeLdIHgKmmmdp2+B1TrE0eJECQqb8xXvXwZ7EVYQVH2FRdA0H43w
	AdDaRRRxuVJjrrzYeZFFLVuZeOC0fJvS8ehPdWdYIT4sTWedFG3lT8kkZqE5dgQdLU6lUDbE8TW
	/paZT17ErI1WsPWQj0ib2end9n719b6KNd8vwOSvQROrA==
X-Received: by 2002:a17:902:f0d4:b0:2b4:61cc:37a8 with SMTP id d9443c01a7336-2ba78e4cbbemr36383825ad.17.1778110731188;
        Wed, 06 May 2026 16:38:51 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babaaef08bsm3471805ad.28.2026.05.06.16.38.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 16:38:50 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-samsung-soc@vger.kernel.org (open list:SAMSUNG SOC CLOCK DRIVERS),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2 0/3] clk: samsung: use kzalloc_flex
Date: Wed,  6 May 2026 16:38:30 -0700
Message-ID: <20260506233833.178357-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch three structs to flexible array members to combine allocations.

Rosen Penev (3):
  v2: fix compilation and reword descriptions
  clk: samsung: use kzalloc_flex
  clk: samsung: cpu: use kzalloc_flex
  clk: samsung: pll: use kzalloc_flex

 drivers/clk/samsung/clk-cpu.c | 34 +++++++++------------
 drivers/clk/samsung/clk-pll.c | 56 ++++++++++++++++-------------------
 drivers/clk/samsung/clk.c     | 11 +++----
 drivers/clk/samsung/clk.h     |  2 +-
 4 files changed, 47 insertions(+), 56 deletions(-)

-- 
2.54.0

