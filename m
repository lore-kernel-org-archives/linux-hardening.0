Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C01C5F27
	for <linux-hardening@vger.kernel.org>; Wed,  3 Jun 2026 03:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456094; cv=none; b=naxLxbY+roa21VFFCcCicr1WFlTnrNheYkhsg9xPh43CFybnPbfx1PfwwASmWzjQwGDGVSd/ev7bq0rEE2d0/IYUW1In5Gv/k1RTzqvFQ/6olOQxEahGAJYG8FeD5f+rwI9zbn1SmFdr8mpeJRZsSD+osfTsv+s7A8Q+Pvrhqv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456094; c=relaxed/simple;
	bh=DS2KjsxpIBAcucsz1q8RcEDoe7sdgP1JDn5kIURjHks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SuwilqdOGJSFZ2s8BRJm9PtY8njI9HlfgFcfkpjX0/fDIfbFIq/JsVqBgFzhcAT2HK2hR4hkI7hbJ/AJxODw5zfUqQfoZIYO2xfxDrSSr2kkrWr2Pz4JfLB3FTf1Dw9P+WcBrejFN/4+mh+ULTWpuYujkxoZSVZdHEtXoJjt1kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApqJlwAB; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApqJlwAB"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-36d98b9aa9aso2903016a91.3
        for <linux-hardening@vger.kernel.org>; Tue, 02 Jun 2026 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456092; x=1781060892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SzR8b8HqOe9R9dNLngX1HGRIqKkTWTema1bE7iFLv2U=;
        b=ApqJlwABKJyNWYT9Dmkz//cBZUyDVMfSOwZlkm4T12JL5yZGbSjriHpKvzTyzZlrv5
         0wkNu5lEpvJOVCyolsoyC2p337YoooFzD/BXhnROQHuKYilFZMltr4KP3vpfrXzc9YXq
         mVkZmFPk41YARpMw3cwSJF6NcJXWSjJlPFZXIeuUErkDskESZJjk3DhJ2g2ZTlyRTUFg
         v2MyHyt0KO13CTm/Namo2zNAT/h99OSzQdZV6kKgSiPPMR287kVyQWsucyS43JK8mwDE
         axcpYNf15I9lXV/f3lPJoniD9+cSk2lunWF2sjpPoJtiH1vq15/SK/00McrG9Pj19rB5
         uBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456092; x=1781060892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzR8b8HqOe9R9dNLngX1HGRIqKkTWTema1bE7iFLv2U=;
        b=TzpKKRBhnENqtWBcA3/8LjOf9Cy2J+64C8Jt3xkF0NIkCwjrS8JAvcPzVNuEILgBbf
         F9vH7MitmI87iFcXx0bHUz6dRFgGctI9YnaAP+wEVrM4BUJAnCmRgA6zcm01rWDAWX6o
         pBwTRD/+rydWjPrfzi5+NvdQdcoMDeJOie04r6GATNh7IqPXCw/cfuVTBa9lRCS5S/7L
         lnapejCxoZ7AteBMDiYaykSomoU4yibzYB6GuFpneeHYz5v0+zOqAKXx77PTknKkR1eZ
         Jyv+1PXf3qWV1M9oZvXODxbPMpp8e2gl+syWmhGhkMofrKbwhfJvtnoIgQQdg4g5kP+5
         8wkQ==
X-Forwarded-Encrypted: i=1; AFNElJ8q3PTzradFhf6yJjJvwWdsQTTZ63UePCw8+mPQGBh1/zW2JReRyrhKin3/HFjysDPo8eVdcQHLTjyr/GjUkXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDpBk9QbSnZcIzdPgNaLKOoI/+xv7NNKdz0ho54TjxfAGm1PxY
	SsYCpnmqK49SxCLWbecV8B2gQxbzFYUWN6YvQ3zaSkFULI/bzTR+EjrC
X-Gm-Gg: Acq92OEjv0tqq9FP7tC7U6ygLR+6UNlVkthmfrA67d4U9t7PdzQZB47khVfmvacU7j5
	8nknZ0IoC79jtDdAjQHYHstywr+/e6Qg82eXBgK7v8GthsX3tDi445rfefQEl6c5TQdHWI4KoYG
	SvNm9JUg0EeN1GMFfVg9LggOQc0VIGdIAuc2Czvo1rfnZ5FaC/ZthDEvFpWsE35uD5N/HqH62Jm
	GK66jpKXZp85wb7SAuaoOrMBNkXNsvj+xj8DgdbMPenQiYiumxxg/T4Br2uGaIW83ycJ02oKES4
	kvc/P82GN96wM59boNbAcE8DuAOMLZbDs9zxihqez8BgG7cNULJnJ3oxHdB7ExLpmGFQrhCt162
	IS2oMaG2rrkTw1P6ppWecF13Mpnd78265yZS9LGBx6tEyFsdG0S0QRv4EPZOAeNmFkhCqC9O3i0
	SzZ2fqxynbCdAKiGnkM8f9chmU2ShNmvQKF0he4aq508o7bUxT3ABatbATWT0RelwlRN6BuZMTT
	frZBe5Q28QLrpVmvXTed7hLecOpbCSuXCgsN8Y8E8lakg==
X-Received: by 2002:a17:90b:3f90:b0:36b:71e6:3de8 with SMTP id 98e67ed59e1d1-36e34770907mr1461244a91.24.1780456092659;
        Tue, 02 Jun 2026 20:08:12 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:11 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH v3 0/8] dmaengine: ti: omap-dma: probe/remove bug fixes and cleanup
Date: Tue,  2 Jun 2026 20:07:46 -0700
Message-ID: <20260603030754.288757-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix several bugs in the omap-dma driver's probe error and remove paths:
missing return after failure, CPU PM notifier leaks and missing RCU
synchronization, channels freed without stopping hardware, IRQs left
enabled during teardown, descriptor pool destroyed too early, wrong
interrupt register used in remove, and a flexible array conversion.

v3: Address remaining review comments:
  - Split CPU PM notifier fix into leak fix + RCU sync
  - Add missing return in probe error path
  - Guard IRQENABLE_L1 accesses for legacy platforms
v2: Fix sashiko comments and add extra patch

Rosen Penev (8):
  dmaengine: ti: omap-dma: fix missing return in probe error path
  dmaengine: ti: omap-dma: synchronize CPU PM notifier removal
  dmaengine: ti: omap-dma: fix CPU PM notifier leak
  dmaengine: ti: omap-dma: stop channels during teardown
  dmaengine: ti: omap-dma: disable IRQs on probe failure
  dmaengine: ti: omap-dma: destroy descriptor pool last
  dmaengine: ti: omap-dma: fix interrupt handling in remove
  dmaengine: ti: omap-dma: turn lch_map into a flexible array

 drivers/dma/ti/omap-dma.c | 122 +++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 48 deletions(-)

--
2.54.0

