Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827462;
	b=VdN6vGYAqHb+se7ZtIBrEquAOD3b6iU3YvHtmI4voQBPqfa2S3FWtV/80vFnLWmU04wd
	 jftA0AgecBIbFvyn5H2nmMdLhtO7o74BktGoYCLFavw5gkfZBakY/xEZqGKZpt87vBVlG
	 Bf3DW9kf4FbHUS7b2Vqdvaud4Aq0pNcrawG/Mnj9J8k4RkB1bufDurLd2Qz9xxCKzS/+S
	 vhOupDMmezW77r2yj6Ey6AZBJ45n/HuVyuFGs1oeYGs7TFMpZgwxpBRTTVk8ETgosO5er
	 FMrri7LSCtI3PQSLCU7dR0ONwpZF+OJMIDbrknlcDdIEuHN4bK6Mnu6M4Nvzy5Z8FTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rzDRDu7/JODZwbuavobSKTv49NxzFkRfd84aGaTT9+E=;
	b=NbiyfVaIkRPRA1Zjp37w4yxmvsSWccLjxJAZpbIc8bQchSABxlycGQoKNmmgB56xFQwg
	 w7Us4jwvMCEl6AzhHuSbuS/XjFQ5b6C4dVesfp39m+rfgo87Tz35+TW9+33Y0Ax3FIv2g
	 4sZOBE9yoWn0dgyrzwOGjwrysswADS5TL5nb6tATQ1lRBzO+FE4uCdAjhgq/uXQ32rsv/
	 7EGTHTWYj19Mhx3b/bUrpQElAcHT9Gd0navlddC3R600zetw/swvazMN4Hlfpw3GV3TYX
	 ftvXaZo8yjCfhgu+OhVIDF2Qm/E8b6qlwQ7JjYb10PYU5GoC/hy23q33HPQd0IErA9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZtYDDyN;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE86083780
	for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 11:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39CE86083780
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZtYDDyN
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e9d7791b00so32963035ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 16 Nov 2026 03:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794827461; x=1795432261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rzDRDu7/JODZwbuavobSKTv49NxzFkRfd84aGaTT9+E=;
        b=FZtYDDyNbIjuUUoA3QzBBqqfv8lLw3rZlhyluQN2H52/PSXZFPJPkFTfUMsWLpVcZB
         +/f7W3mjC8sThyJJEcQQ91j2NdvFAztL1ncVMMk6UXuT9opRL/PYqTvivGY0P89LqggE
         Y1/qTrI6JWRwkjMo5niHIqxeAFeDgJoU37ZmlzjAZF8T4v0I0JsCPwDaWCUdyOBoZxEq
         +HQY9SQaicWAwcUlZKP4H/glriZRjHz2Z8mMw6cahYt8YTsJF5t/75KMo9oWAD+f6PbF
         PFW+qoQp8ahdR1jTbstdRagOq1ph7sTAUAOrkMuQuTON7rNiDbqbs2cF9esIAzxWDE3w
         o8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827461; x=1795432261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rzDRDu7/JODZwbuavobSKTv49NxzFkRfd84aGaTT9+E=;
        b=Di8MTIK4TWQEZbZC6udAb1hv3Y7vMaZcXuk9ZwnZDIH5t5T2TgY4I59FmhJL4WbstH
         sxLs5Gq4dIwOO0/xEOyty4RLZHZZqt3ypMb8xP2jwq55uagVq5L6dcai+AAQdp75qptt
         /hZZsOQNLuuhNlOvoAbN/EiPKvWNEjFmSZNK9hXkoGTt1OdsWvjhKL095cEfUeOeQ38Y
         LdMzWXnskpSq4c4U1yV/gnNbduHu9L0ypLZyL7t9TfKM2SujxYtavCdOSlgFxzkhm2kF
         RHqI+7Hg4BXbzH6H1h7AATL2aYPS4ap+khuByqVJLaip/gIc/9zM73IbtrLTX2AdI4wE
         y1yQ==
X-Forwarded-Encrypted: i=1; AL+hErG8UIWUgGEJ0ZR0u60q3iP8OYXYuMB/nOCKyqz/v/rB/ABfCDKBWWAiJVRbNZEbEaK0r5Y/l8o6narovlrrHfw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4T0lowAcKoaSpV45+0LO8BeN6ntMOISUrSlBoZJ4R+hlv1i27
	wNLEknKzrJkZuGXMS01hkUzjaFUxrn4pPhmk3N7d26FWq6VoYc6BvibU
X-Gm-Gg: AZFdTZdBn9umQKwdhmnSuxNyb64+FR0Ag+/NSjL638yw50vR7Ghfkf/XUVm679pDOZo
	ykOtv1yXiA5UEbiKKlqBU+Veyb4wdobYGW/NP2lqacHTv6SRUKd3x39LMbA/r5EzKYWWBN6x89Y
	i0bdGIb+Oo7BTqaTS/7RTzj7faEaWoKYmv8frLEUheBQnhupCFd+wrBdmGcQsQWgk1YlKRmzWdc
	W91oj1HZiROSReq+r3pEBp2L0MW+tS6IUEyBCxObrz+K1P6k06HCu1dpz6CSgaybDIC2AXT1+v2
	p2C6WyBUFAK9sUm8nAKu2jzIDDse0EbWcfpUG1I03cz4XKRZYhgvULOEbAHaYTa7G+GZYzdvV14
	EX3FJi6JrrhHKlGwMJ1UaPCx35jnX11jtyV+tPP5+GSonFQcUIJPRlK+SCBOaaoVCP+eD3JNJIQ
	r9/HECvnXLsJVlIAH1Rx7VTOIvWuoMVqDhCXnRefsW5dw9zTL/qI/bfT023bq78yQjk/54XTKUJ
	4504hCTLxDm6eHOMF8A2ST6mtC1BXQ+Fy3v5wHQuWyVI2qxBRylgXQ8u1jU/tPHdWLAvUYIfvbr
	emptjxMa0vkVNExif8kZjJ1Soo/+AhSjbbGtR5VFAsD67eqsrkdlbmkkUiFi4ItHF3I2nhHyn6M
	cSHLRLxXB6nAJlzA=
X-Received: by 2002:a17:90b:588b:b0:3b0:9984:18c9 with SMTP id 98e67ed59e1d1-3b1b09f37ccmr8454898a91.11.1794827461360;
        Mon, 16 Nov 2026 03:11:01 -0800 (PST)
Received: from localhost.localdomain (vmi2317719.contaboserver.net. [84.247.152.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b1e9ef15sm9162815a91.0.2026.11.16.03.10.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 03:11:00 -0800 (PST)
From: Lian Wang <lianux.mm@gmail.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Jihan LIN <linjh22s@gmail.com>,
	Kunwu Chan <kunwu.chan@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v4 00/18] mm/swap: introduce priority queues for swap device allocation
Date: Mon, 16 Nov 2026 19:10:30 +0800
Message-ID: <20261116111044.28724-1-lianux.mm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAMgjq7Cq5OQWdompBbEpyJTG3PhtdSLFUdb_Dtht3qH+u5HVhw@mail.gmail.com>
References: <cover.1794666741.git.lianux.mm@gmail.com> <CAMgjq7Cq5OQWdompBbEpyJTG3PhtdSLFUdb_Dtht3qH+u5HVhw@mail.gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kairui,

On Mon, 16 Nov 2026 11:52:30 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> Thanks for the updates!
> 
> Nice, but what does n/arm mean?
> 
> It's worth mentioning that the global cluster cache is gone, so tiered
> allocation will have a much better performance.
> 
> It seems the sashiko review is all green, which is great, let's hear
> what the others think about this.

Thanks for the feedback. By n/arm I meant the number of runs per kernel:
12 builds for each memory limit, and one BRD invocation. I'll use a
clearer table heading.

I'll tidy up the cover letter to make the motivation and scope clearer,
including how removing the global cluster cache helps tiered allocation.
Once I've collected the remaining feedback, I'll fold the changes into
the next version and drop the RFC tag.

Best regards,
Lian Wang

