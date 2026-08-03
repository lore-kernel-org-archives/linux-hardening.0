Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E703603D8
	for <linux-hardening@vger.kernel.org>; Mon,  3 Aug 2026 03:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785728484; cv=none; b=aBMsl2V/ZF3RXgOiNBCi4tWgoV9TwZxwsRFsWBtfi9BBXenoNNsGomrIN9tJGyjNNOxkR7jMmvpOE7wWBPgGDrglJ4Bg5BXCWAtRU436KRCQWeRtzmKb0u6atOAyC6b67fCvZLG15kkEpFFjamuAtMOTwCEHCuBzUrKzeQpa6Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785728484; c=relaxed/simple;
	bh=NCMW4kQRyBWSj2E3oOTBkzWRrKKMpt0eKzLDMpatx9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LHCJ1g/PhQwe3sdbMJ0fXcS7lxEGnASxNIdGnsAG8D3P8qgDRh/IGXtq2cdF82uuiKwAgOBOU4R+401KKAJ6ZC8gtqvTjphM7X7tp76e63GbXxklq9xTmMDhdFy6MCefoYQqBc0xDv3IZzVOtxG1HzgdVMU2DSu7fSWlUE/tJG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=xnK6PMTq; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="xnK6PMTq"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38e08baf860so2544102a91.2
        for <linux-hardening@vger.kernel.org>; Sun, 02 Aug 2026 20:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785728482; x=1786333282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NCMW4kQRyBWSj2E3oOTBkzWRrKKMpt0eKzLDMpatx9c=;
        b=xnK6PMTqK146IzXA4PJD65/xzUYMlsQsTRsM3vQHESajUrVka74oq2zKaSAZHhWR6u
         Hi5tCIhz1hqbjkScLbKtyvYa8YPscLTwibI/tYHhhTMxMqgipa+xRdtVU9/yB0ThvIk3
         XP0HqvWIXZ1PWlAO3GsUkmaPQzBVGfnjFMc8FLDYmdmkuzYkcQD7wMzYgC1pt0018/P6
         SfRrtP5oP73JWVdYmVZp9/e004xJgJQWl3WKR2ft3FT2oBxuoN8kXV9SzpbWyu1nRmWv
         cJ+ZZlYmJOz6/GaCiJAoFphm8qQj5yV9NyLTp6UOa6XmiGrQen1Fg6YLV9marLubqsFY
         jEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785728482; x=1786333282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NCMW4kQRyBWSj2E3oOTBkzWRrKKMpt0eKzLDMpatx9c=;
        b=SdE65OjUijxpQPBHyll9NPiscNDLPGuKcT4AAQ9eO/jauASy+hVWrsEKFGy+v/LQ7a
         BOqufW7ukzMXWJT7dVrEvkLXhqu75BzmYT2jipcsb+E0swByRYAw2tQDL2PUYVC9+G7Y
         U5FconQx2a2ib82MoR/oRb7KYpfpFbfsLuJP7NoIx5etFF4HSUoSBFYR+8M/0pd7YaSN
         oJjoZ9xNiYif31l5I3iUil7ihgRP3HgMbSeyelI+XZlxhuLIZtJ1wjaG4ybFMpW8uJ9r
         QVw8j90aC6Bwoai303xZnCMql9NK03jsaHgg4+tzzV6F0msYY+KeAM4MCno3bWfPqWyu
         GTaw==
X-Forwarded-Encrypted: i=1; AHgh+Rplrrkme8aCihJ02Cpo9F2Fi1k4xGFi30ndQspy5+dGaVxE2Y3HJ86BGlKa6JlDMqlCfVg/iaGYJwkkEuzlPTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsgl1/fs/Z8LVSB2LAuB6K5vCyupuDJyByK77r/+ogR39m1Sl
	dea+Y/Y4GL2ImT74syBhMhrzPDDCaFwWd+g6KQnvTQyxFhuHmnEOW311TxNe5NjuZKk=
X-Gm-Gg: AR+sD107QCicqzpA40GU0XIKmsl4kY5VthfswDsbbKYa0uDdvf1oOYIhT91Gn6HT/r3
	lFz0Xi88Q5Jba23uBGBMwELQqJlixKR6y9pvAjY/DBATslGwkGu/qn73vm5BraUIR1mIumYjz0g
	ur8W9DG+w2WURhtJZCNgetvipwAsT4rq3tyFLO17kh7Panb3fzXyhNP1UoPjHUAIxtVeQpSBNo6
	Up0TPqb4EoTPJSPQd7JMxki2wpUXpODUo7hBG15aa04D5bMRHd9ecZbfUjg9nZv1HTqwP9Yen6V
	oze4+bPqfxMpXyAqqrSJSFtdf/rkaEa7En88/1a1uKhZVEsLCQRBP/zoux7tPGlR2C+gz6tBnMY
	1Xn/FMVw0MWy8Rm5Xc9Sm0u1QLoVzMBhtp0/mqvjlazxLCZnwenJA0znpd68aMVyszKlWwuQr6X
	emqjL6cZB0G3wrHuRPJ9M9ZJZfLn5nGRPy7yOMQyIxRpvdJgmBk0HI/df7SJNFJEC1J/jZ
X-Received: by 2002:a17:90b:50c4:b0:38e:447c:9a15 with SMTP id 98e67ed59e1d1-38fbc516655mr7151775a91.36.1785728481711;
        Sun, 02 Aug 2026 20:41:21 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bac654sm3299609a91.10.2026.08.02.20.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 20:41:21 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	sashiko-reviews@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: Re: [PATCH net v5 2/3] net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
Date: Mon,  3 Aug 2026 12:41:05 +0900
Message-ID: <20260803034105.2051552-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801094208.1937951-3-yhlee@isslab.korea.ac.kr>
References: <20260801094208.1937951-3-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does this bounds check allow processing of stale memory?

It does, and 3/3 of this series stops it. This patch bounds by the size
of the buffer the message landed in; 3/3 copies the tail of the message
into the queue entry and bounds by its length instead.

The bound in this patch never fires on a link with a shared v2 receive
buffer. It works out at 507 rkeys for ADD_LINK and 2046 for
DELETE_RKEY, and the min_t() above it has already capped both at 255.
I measured a 44-byte DELETE_RKEY_V2 declaring 255 rkeys: mainline and
this patch draw the same response, and in two of the four exchanges an
rkey read past the message was live and was deleted. With 3/3 applied
the response reports 9.

It does fire on a link without that buffer, where it becomes 9. That is
the out-of-bounds read this patch fixes, and why it carries Cc: stable
while 3/3 does not.

Best regards,
Yehyeong Lee
