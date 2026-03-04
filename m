Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461E9388364
	for <linux-hardening@vger.kernel.org>; Wed,  4 Mar 2026 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772662552; cv=none; b=rlKAWTsd68XSiQKwVxo2h3MpzKPRAhSUL5g95skP3F6N/+KacC3ZQO35JnIu7HuYYHhoD5HZ6HtovcgvjEGYZZbqVO/IIphET8QRTc3LN772e20x9brs/w8EqgY0YF8UfPPVxhRHcsWTZLdjnDdH51NOdIpKeqIplRsUxJWMXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772662552; c=relaxed/simple;
	bh=Xr2Uv7Qrue7J+YbHJotxLSTo31Rgl8CyMWw10D9CVD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtkowHirR5kZnn/Frj4zVcSTaZW7rdoavRtJl6B/EGNuZ9kwVTxglIbS4EBmTHoKH0QqOldEcWt5OHHnRMyWMn9UfwGcYs73XdrqEUX5tZ/VnCxPXPOkHWkr/RMtFxIokx2UYaa9fKxJ15prctXwMFUBcMgmlgrA/iO+4++eyYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwidQaKC; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwidQaKC"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82976220e97so632295b3a.3
        for <linux-hardening@vger.kernel.org>; Wed, 04 Mar 2026 14:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772662548; x=1773267348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pknTK9DovrvOWreCLiec4pXoC+apbckmLy6Og46MTYI=;
        b=DwidQaKC6fhP7aUXb/gKxUxBPtI1komewXiWTpPS17MrSuxX6TMU0WLtOfsog+8coy
         tBwkeHa3lHQgAiq4nRsrYOVJvl4AR4z8qBCRIpnUGKSBuVxMLY2oyEfmuIJtGIxDHvBw
         HF9gajPuYPb7d5ePdVR2DHaMh1qvLvAeGSh+ScuqOE7EbYwAYy400G5yd2/eMQcjtxit
         Drwex2ogUMvYiuxWB/PMPoC69E03pWEgQnPm05sL0ILDxKDM1v5VRC/NhIuACb7Gum7t
         uItcgQcxv3W9Uyi7eEOln1m+XwgrjoRt+veOkUMWaQyOdjob+KPkUKxxS+dneCYbtFeE
         kAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772662548; x=1773267348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pknTK9DovrvOWreCLiec4pXoC+apbckmLy6Og46MTYI=;
        b=cZV85Pwv6z5n9dxcJmVB5ly/Z56BTIfBomH7l/HKlF13Wxm/HiEqBYzR1NKKU23Yqm
         I1MY8euyi54W4SgE3PlsE51Yojf7o1oJHHvdXJxCITgmYBsE+9gAmr0aB7oeSqK9oa84
         gGttsyIQj+QIq6ATIEp2JqUCis4dj9j26nrhlgXheOJEDX79KSOQMB/0gRRsdiAgIGtu
         hhloMuAfNdT7s9khM7ztKtFCWu1stTEYNYg8tnjIFM35h+DB5pRWe9fBSpTWtSaUaODr
         5lNPMRIj2NVIjWz6N2l6fB9u3mGlPQD2DvBB1Z0MAs56NqjECCHISkEAnN1KD1xMu38o
         +zQw==
X-Forwarded-Encrypted: i=1; AJvYcCVren5qb/G/JZI+NBP0CM24MFyzieLK6HnjsPFAw7jeXrKz6zh9BRA2E0IAS/9Nfrpex6tsV6Wcyp3hXg/Fho0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaHk2+UrdilyuvobQofLEk/rpQ9esNIYkVmc4gbJnaQdX3grKl
	a5mOH0tShl6h9VVSVHD+hrrjXewfSJhtimH+sO+GKaDRZVOrbBnwHAr+
X-Gm-Gg: ATEYQzzefSXET2Xetg4GqQnk9OrNutIOY1ePJMN5nza1Ml5otB1MiLPLTtfFnU6YUad
	DbW7RXQWSE55NjjMNAk2dWQXv6X6WJmV+5SGsCnTW+hk99SLSTYH+MdnLpClkGrf4SzvIQwrWy/
	9yl+GkwieFzkECNLxdOdDsewTM8BDc4MWcZMZg93Yr4kX6HBTrvBRNSggixL9BZKcMWwxkH93fl
	Y75PMM1NXCBP4+r2aT+wokAXoRx6SDySR4qB0gRkD3i9ypfH/Up+8VsSVQxkyMi3WXpbC+33cS6
	y2TKkAUKbZMOuj++JvcNRs3Kkf3Pks6wK4bp38WWkQGGUInwUpsC2tNSeAkIu9k3LIavH9QJxmL
	XGmp5J84G83bbhStgS9deAaqLi+cspJ6AjVHqZvKbmp8P9DOlcBnLyUnvyLoy6i3WoOTQgICji5
	Ls4ajeacH4A0X+knisiIvd3/Yf1Qw9tSvNV7pdb8TbsNmRX241ESBqyS0tt3VLvTFp
X-Received: by 2002:a05:6a21:608a:b0:35b:9ba2:8cd5 with SMTP id adf61e73a8af0-3982e2036d4mr3459771637.56.1772662548516;
        Wed, 04 Mar 2026 14:15:48 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa6203a6sm17637399a12.8.2026.03.04.14.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 14:15:47 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-mtd@lists.infradead.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH 0/2] mtd: concat: use flex array
Date: Wed,  4 Mar 2026 14:15:28 -0800
Message-ID: <20260304221530.15018-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies allocation. There may or may not be missing frees here. One
allocation is simpler to reason about.

Rosen Penev (2):
  mtd: virt_concat: use single allocation for node
  mtd: concat: replace alloc + calloc with 1 alloc

 drivers/mtd/mtd_virt_concat.c | 19 +++----------------
 drivers/mtd/mtdconcat.c       |  5 +----
 include/linux/mtd/concat.h    |  2 +-
 3 files changed, 5 insertions(+), 21 deletions(-)

--
2.53.0

