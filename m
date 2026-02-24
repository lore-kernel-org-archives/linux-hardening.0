Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71BA2FFDE2
	for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 23:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771974403; cv=none; b=gnPwN8URM8c0Lbs84D3UyOCBdXWvT6tfvBPtzatqHbwnARYlFow7Mj42BjZC5jaIiA6C+4y1nUDJkNSznDZfV97bwMxgy1W4yFxo96TXZ8tKhEhMw1MjD0q0xxwU4hcLBLhX5fGmsKayGWIZWnMLTiWq1E0xgYXfEY+SdSpetZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771974403; c=relaxed/simple;
	bh=A4LHSP/FTFWxupGlq1bnECf6E6hsobcTrNUS0LVBR2o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8mPXOa9Y3uRrfX2znlAXMjjLEwhH5M/dT3xAKpHGhFZUecmhHvAHu80eE1K2vasU9RQekKHTnyWiU5mIQYzRHS0HxKCKEzsDcEALBB9CT8eM8VVjS5Qbyb5huSF/8yS/cg6qJcUzgeLpzdGUNT6uFBmWv8/5cQCKWE313fXq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFm1o69M; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFm1o69M"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso49007925e9.0
        for <linux-hardening@vger.kernel.org>; Tue, 24 Feb 2026 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771974399; x=1772579199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8rwrn/QPCZdFh+0pKkte8IyiM/p1Y0Q9LAts5L8c8k=;
        b=AFm1o69Mid/FOsat4an1aG0KD/keq+BRfUZBe2sdC3UrDcyvGf/TYSnsFvPfF1ulgJ
         7TF9sR/nX09ZUWmO2vsXR6d+vEngHt66TgyKGZOUuTr7dd49E7OeoxPeUUwg2iAqFapm
         BiESq9Wp5uY8zMLShf+gjNXkxkIj0EutmpSYWSp7ouaTx3CpJEgyyRb/UQyhYvrNnhrK
         KvG9RWCoWtNflxzfBR/w6A80hA7YnGz6I0hG5Y+SIUJ9dn+OuOcZQf+RsLoA/7vUdWUE
         O0s5UEVQ4pVoHGtTQwYvJj9j2fv5/cN7H5/8Ua9ZCYu9n1imVigqV2OGNz/OGeM9FQ4w
         vYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771974399; x=1772579199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+8rwrn/QPCZdFh+0pKkte8IyiM/p1Y0Q9LAts5L8c8k=;
        b=vxcNN/o8mPAxvdiNAgC5iFxtB6zMpa9zj3Yfh9blI8vZShm/dKW3km3NBQ5rSLOC/8
         fB9K+cgW/W667sZAzSlju8qKBWKbXk2+QhamRyYz0H3FAirdqrhM7WV7gKXpEQWeXTiI
         2vBjdfrF207MbE9j0/S1rA1bQ4h4x5bw5LrrneY3hdA+HIr2JzMllu4ZLMey8nNKV/dS
         LL9SX0W8BmM9hfrEofTAlqcGpkaUrAI/JIeJ834B6wnhNLkB0dsqD/Xw/8MtJRyfJzGJ
         2znPsVUaj8Bfjlcgo5YA/JcjuwDASREm3J/o17M2SJ6xrtPsksMtart4GIOdMOcnpGQw
         QzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo/C1UeOt7GRfxm/HzAquezYrEbCHRlfouMB9+vEdVjZdUJWa9aUdUby5EkQvJw4E27sWAvfaAXrHdt2uhRJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAcYZ8BnJY/6XJhzyRDsc+nSfmOg0CXEoVSV6nssZtLC14N7gx
	GjsHGwWrtCvtfp9CnhuCoQFzdMK/S3MWngHnNkwxCBKFD5df0KJKH9Mi
X-Gm-Gg: ATEYQzyKxeMGrLt4/11jvCOh9dy6mf2XtLr6adneSZX4cvkSFOeCtxmw8QJ1fyk3vph
	1z6RC+wGHW5NkV/DNmF4bqimL8m8nQojKI5mC4KWruzSQxkgLSxYLkWXznGfzJkWPcouMXxeLNo
	YjZVvWDTEXBJXzn/HtB7fY6msrT0aFP/F1GX/NX2OHgHnteTVwM546dO9J+d2Qq/EUpewnpTv65
	8QddttHLDjoAH/0yD3X1hlItBBDcnuL/Dqm77ZZVaGmCLCuOycSUwlntJ3F75QFKfudX6Jdt7QE
	PGnWshyrvc5RsV0AagXcOjx8ypYN25Iav7cv84Zz0HG4Js6ifzN6dIDhOOafBG/wqQxkX2I15TG
	l+Q431MEnw5Snf4IYo03fl1RPQQM6+aNzFBgHcpl3lzOFUboR0CHIU3zx7sQOB2g8AZr0Mi1nF8
	88w2qE9JZ4ypHhEdy2JSsmyjXXbPBPK7m4jlH+8OydU4pnf5jTLMSjY0+r8EMCnbuctqOUEg2Fb
	ck=
X-Received: by 2002:a05:600c:8b02:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-483a95aa31dmr234688615e9.1.1771974399425;
        Tue, 24 Feb 2026 15:06:39 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd6854c7sm86477705e9.0.2026.02.24.15.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 15:06:39 -0800 (PST)
Date: Tue, 24 Feb 2026 23:06:37 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Fuad Tabba <tabba@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Kees Cook
 <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH] lib/string: Fix UBSAN misaligned access in
 sized_strscpy
Message-ID: <20260224230637.38f93836@pumpkin>
In-Reply-To: <CA+EHjTxgX8RpVxdf1rrri8m_=oG-0_KpYzhEKaZXXOr2UXWegQ@mail.gmail.com>
References: <20260224170427.2296592-1-tabba@google.com>
	<aZ3eKyVXPd-Fvcst@smile.fi.intel.com>
	<CA+EHjTxgX8RpVxdf1rrri8m_=oG-0_KpYzhEKaZXXOr2UXWegQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 17:54:07 +0000
Fuad Tabba <tabba@google.com> wrote:

> Hi Andy,
> 
> On Tue, 24 Feb 2026 at 17:21, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > On Tue, Feb 24, 2026 at 05:04:27PM +0000, Fuad Tabba wrote:  
> > > sized_strscpy() performs word-at-a-time writes to the destination
> > > buffer. If the destination buffer is not aligned to unsigned long,
> > > direct assignment causes UBSAN misaligned-access errors.
> > >
> > > Use put_unaligned() to safely write the words to the destination.  
> >
> > Have you measured the performance impact?  
> 
> Not directly. I verified the disassembly for both x86_64 and aarch64.
> On x86_64, both the raw pointer cast and put_unaligned() compile down
> to mov %rdi,(%rsi). On aarch64, both compile to str x0, [x1].

What happens on cpu that trap misaligned accesses (eg sparc64)?
put_unaligned() exists because it can be horrid.

	David

> 
> > Have you read the comment near to
> >
> >         if (IS_ENABLED(CONFIG_KMSAN))  
> 
> Not until now to be honest. However, are you asking whether
> put_unaligned() breaks KMSAN? I don't think it does, max is set to 0
> when KMSAN is enabled, this entire while loop is bypassed.
> 
> Thanks,
> /fuad
> 
> > ?
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> >  
> 

