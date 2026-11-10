Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348091;
	b=mTXWXFzsIdbpgAi9aDqxKYHlzPm6U34qVcdAWZa2RM6HxZocq+Mf3vAl7jOGi3CHROq/
	 F1iLTeGHclWhGzsnFFVzHl/7qt/ooTLokoutn6JCwXN8oszM+sHEykkiu7CQ7g49O3882
	 JQm+sfTTegWMDfxZYCp5C0ER7Eh7jdn4e3y6nscEX/dUymTVPswQb8P9RF3MI1O41Q9EY
	 WACMdYGdhnhosug318BuvuRyVWqHEUiO3LjrGk9bkVv6NkugP8kRiSGKodzo3oGPlOUW4
	 wBKo8OPVw4aDNNZtl1BGu2cNhukWkfqI/R3P9stpmOjMWKtXb7j5Mj16/aA7kX7Cg7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348091;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bNQQ45hOmPJZU+OFlMWuY5PF1b1awPlhFrQtFxBJLDk=;
	b=jCuJBHmpdBCsakpD4KdEn5mfL/x3MrQr/WYkwg+hcAbNWYEisMbQUkGyyMhYr7WEKqM9
	 yihkUrU2Gqf9ffqf13z8m0UfbgaHruX+AE4/AofSkmOe27HkvZuOi62jMddKrkSHz1DB2
	 ljDBgqO7LAotLn1JNglsjgZj5V4sDK4lk1hSr94cCLGQeu8bMYtd6ORECOvdD7rKS5J4g
	 IFVDe1Lj7xGPTnPioYxzBukESdK7suW8VfykOszi7drSUAfxODNT94awi6hUpIECmdrzq
	 Y4kxFTFBW1XxpIlOJcZ3ZMkySm9iwvEyNEKLsFrkAwCGIR5ouWFPTc/Ib1WGVw6Bkyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=EMU63R0W;
	arc=none smtp.remote-ip=79.135.106.98
Received: from mail-10698.protonmail.ch (mail-10698.protonmail.ch [79.135.106.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56262606A321
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 22:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56262606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=EMU63R0W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794348087; x=1794607287;
	bh=bNQQ45hOmPJZU+OFlMWuY5PF1b1awPlhFrQtFxBJLDk=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=EMU63R0WF7yyCSkyXe0qA3k9L/LGbrpll3SfiJIvR2nSnM3I4ImqLzGzfxM36a4lJ
	 QNCXQOBLffi6h0ozB5iimlQxLC3YJh2nBJLnddi1h9P6z5GlvSd+SEe816ALxA3R72
	 KHPnWDx5mj9TPvGqtHnPdeWoi8AI9F/3+Ug7v2sX25LirbZG8SNlWyKxmAWkbz5XzV
	 8rKyiPsELLBarRGRIkcqNm03HHFtQJM0iCurQnja8a2sP8hEheqhbDb2D2h0JOeizR
	 EjrcXXfivFpgI0xnPIwWK5BfrKv5DGEM5XC0xmDyY3pZ9woKhYt2FNuHiRr2PnBUUs
	 hOrw577Z8fDJQ==
Date: Tue, 10 Nov 2026 22:01:19 +0000
To: "ghidoliemanuele@gmail.com" <ghidoliemanuele@gmail.com>
From: Rujbin <rujbin@proton.me>
Cc: "broonie@kernel.org" <broonie@kernel.org>, "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>, "gustavoars@kernel.org" <gustavoars@kernel.org>, "kees@kernel.org" <kees@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "perex@perex.cz" <perex@perex.cz>, "tiwai@suse.com" <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: soc-core: reset rtd->num_components after allocation
Message-ID: <t13cy0JX4ZGEYiW6JhU0y9gV5G1aJavVhofJLw7TS5l9fmiEqDD6IJSXG5jObsv2M21adiCt32gFQZhJpTKDW3FPOBD0mLWcHwG8dRttxOA=@proton.me>
Feedback-ID: 45446246:user:proton
X-Pm-Message-ID: ddbc061da96164f12a6495a0ba84e63f365e8f3e
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Emanuele,

Thanks for the fix!

I tested the same one-line change on my ThinkPad L16 Gen 1 (Meteor Lake-P, =
Conexant SN6140) running Linux v7.4-rc2.

With the patched snd-soc-core.ko, all 18 ASoC route errors disappeared, and=
 the sof-hda-dsp sound card was registered successfully.

Tested-by: Rujbin Nassereslam rujbin@proton.me

Thanks,
Rujbin
