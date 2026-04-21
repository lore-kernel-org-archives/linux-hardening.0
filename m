Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF05423B61B
	for <linux-hardening@vger.kernel.org>; Tue, 21 Apr 2026 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776742694; cv=pass; b=Wm4Wb9BABeOv/pq5V2EiDwjM2IS75twfNkM/G+2aO5/VbCLmBaTz8CaH6pAn10+967esF/zoM6GdFeZ6oeEmVmQ1dbUuvRyJPKgXQotODRjhGbbhSFDqU9jhoUUTV8JqpZoylGA6bq35+9t0xDoAe3QDgQo7MI5waDtcCMPjYJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776742694; c=relaxed/simple;
	bh=mKFT7rn+lf8y2NCobvHQRkP8qQoexlul1ItbreUJpDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SA7dawgA//PrSFNsjn2Hcs/ZiQyXobbHj2JRAoyMLLZJMpCxZFqLpL0BHCZwUTufO7jDFVHUWbxqNFjJ4G6iviKS1H1j2QjDQM9HPq0KC1WSjkTkdw68n3f2khJSAncs0VtyY3IyUaVidpe8XTDMYha9Fq/4W8LFCu/2oc2KSYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4/pw5DB; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4/pw5DB"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56a86f0a23bso3918629e0c.0
        for <linux-hardening@vger.kernel.org>; Mon, 20 Apr 2026 20:38:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776742692; cv=none;
        d=google.com; s=arc-20240605;
        b=HfsV6+yGb8z3k/vNyEVSZ6JrO6plNJE3gXSIlEJEjzGEbCxfywy18NeAQ9BQA0BIfa
         QoEZPWanCwOqSIFNlbH1+61EqRs56psReHycElAVGOzWw2LjwJ3DGgG0eJbu6i1HJbpT
         2lerIc0/fVnSHYL66z7pIvPVgOcM+qXtvutyPiNLlCEdO/rzvfqpDgIqllTWDa+AVWXM
         IdV9JwMausQb28zDty2lWRw+WvoQE881nIrIspNg9YZSfgY0WzrkLpPWLyz7i5J2bIG6
         suZP65SmKWik4bBELYE+UBrLtkJKmPQ4G038ajF1f7IFgzmT88lkUqcVUWoHKPys+66v
         t5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=mKFT7rn+lf8y2NCobvHQRkP8qQoexlul1ItbreUJpDY=;
        fh=gsSJIXzxr4R1r4LW1yk3gP0DcHkuvqGEyIO1nN67/zw=;
        b=EN0OcW117MB2UczLv5ir7JTgZupR1dNgoTDf6usDMUOazwU1SSP4Tp6TpjTlytuky0
         1VOdOb7eNWo3b9uTqVwmxaMWEt4LkZJYp52ONzgpC7ft3tz/d+J+eL5uyUP7lyLgCAZJ
         mnBDOkIvZfCq8Myl04/Z6yfy9rMnZTcUCyjV04dpcOPdtHVpuvQZSBuhXauN1uKkgwgB
         skci+mLDiKwddtfuxuicc/3byv4r9he0XioyXsXnOMd94wsbrTaNpccWDGhTlCR8Cymj
         nspspnE01JK+Q4EeaFCM3dcXCAtAcpRuN8no9jEG+9wWhih29eJLokx+G/txR2uHIT8A
         BDRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776742692; x=1777347492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mKFT7rn+lf8y2NCobvHQRkP8qQoexlul1ItbreUJpDY=;
        b=S4/pw5DBghS/Jxmnhodvy/IdnE6ZUKA+maKiVx0Ky2enrbmI3n04kMdfdAEzbbaT9k
         TcyONGAYSkqEYiJuJl2d012IAMS/TYO06HGcCFRJHYdf4ZkPoYHvdxDf7QBHtas+coiL
         mQpTjIVXKzk2PB1xEo3oRY9jSkbkRBSEpvSLMhR89ku4xEBqXLts4zhhVxIqQ0gOrKdn
         fbRigM0aYt+yG3MMsmLuSQ35CVWwSkv3Co4HK0ucCwhYHEyoNZPx7NcIVcEv5xI3VeDp
         j+lcusBeFEVwXNsUKhLhW5Fp4ZyGIHOflKTTFXJnkS7fJzOE4bQDsiwFErVQQkLm4Xub
         M//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776742692; x=1777347492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKFT7rn+lf8y2NCobvHQRkP8qQoexlul1ItbreUJpDY=;
        b=OX58ODqEsmmexxnyc6yXwErNdXsws7UfSOZbJ3LsjZlLMq5ubCq0fIq3r6rDWiCAq/
         EGWyutZDYa+64W/9VXdhNZSicqoD69mfDRCyRG6O/oQF/p7c8V9ez1oPWfrKpn0xSJPB
         jIMddrtAR3oJ1rfGIEhQUySKsgn3xm7m5+cJa9Fx3E5EvAK1bHTT5dDraD0zUT8lWEeb
         Qj7+zw0LJEXLHgWXUu4Ocgx5X67QReRt44fUMvT/HA9eMGEjBq5MEjG4RVvwv/dQiQoQ
         2rpokHDkYIYC0IFE8HSdAFNzdqkCRYNYM1nkbnPpQ9CFcWbEyLUnjSBY9uY0+gwNYlBN
         WDIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1c+lMHaOdbuedTrccS/+A9X5+SEzddU7CrczY9yRuhq9OXjNJ+3ULgyRRGzaU3oHKsHyYhl18KeASaClEg/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxRN5F2BCE+WBZfVUwVqYg290z5evr8mYqOW3EYBZgXzgYRrxD
	th+ib9ttyBV3gVTN3/DJHJta1hrNCd1tyjN9H4zS4oFxyTAM/K56ZorsWULLagb2hxkRpA5DKS1
	u9uF7OkjIq0Fa6mn3pT44QwILJR9u6Lk=
X-Gm-Gg: AeBDieu75uTG0XGOZCgUJI7nrhb042IHV/Mf/moBg/Rw5VmfQcPIxC677RltZjQGLfc
	/kHOr4TdFsRKcyhRSWmxzWpbWk+d7EArjg/q0aPcdgCAq0JUPdpeyXUTjMO3U5lFRmmb2+PhJmb
	HdTEHZ+CwcaYsbjNDn5wGwv9dlmhBITfbJ5S+H1Z/jHdtlk+BUnnd//qIe9Lh0RsFnSNxAd3Ekj
	eqWRZoHWDFWUSOW3hrDKw6etkT9pw848pBa1wRuLc2RoXyMJIW4HlNS5a4nJE5XktCCSI2K+5H0
	z4Oa0rRuy4ZBaEiT/OTF+1mu//KV8Nkz2paSWlv3X1onflSIH2w=
X-Received: by 2002:a05:6122:8d3:b0:56c:d5cd:1e7c with SMTP id
 71dfb90a1353d-56fa58856b1mr7843051e0c.5.1776742692568; Mon, 20 Apr 2026
 20:38:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407143306.78809-1-shuvampandey1@gmail.com>
 <20260419153111.90635-1-shuvampandey1@gmail.com> <CAHp75VcW0cexQk6Zg-RwKSMBpOxPa3YCAomK7PFXEGLQ0VkrMQ@mail.gmail.com>
 <150cda6feffe0826cfd43e5d8f0b4199b6268486.camel@HansenPartnership.com>
In-Reply-To: <150cda6feffe0826cfd43e5d8f0b4199b6268486.camel@HansenPartnership.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Tue, 21 Apr 2026 09:23:01 +0545
X-Gm-Features: AQROBzCeBvx0yCHMDdPakdU7RajGbQ86Qa117LyBUdiwSmvh7nLRWQEeICr3ieo
Message-ID: <CANAAWHKpYc5EJvFg9yMQ5JPhCt4_EGERi+9iG1j3TX-1GRqGQw@mail.gmail.com>
Subject: Re: [PATCH v2] lib/string_helpers: renormalize string_get_size()
 after rounding carry
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andy@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi James,

> Well firstly I would note that the original behaviour isn't a bug.
> ...
> However, if the desire is for this only ever to print out three
> significant figures ...
> Isn't right.

Thanks, that clarifies it.

I was looking at the 1000 kB / 1024 KiB cases as a narrow formatting
issue after the rounding carry, but that is too narrow a reading. As
you point out, the current helper is not based on a strict always 3
significant figures rule, and my patch only adjusts one carry case
rather than addressing the broader behaviour.

So I agree this should not go forward as a bug fix in its current form.
I'll drop this patch here and revisit it only if I can come back with a
better understanding of the intended semantics.

Thanks,
Shuvam
