Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CC939EF1A
	for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774905097; cv=none; b=d7UQRfusU4IRHAP0iySvadrAmT3Xk5OeoGJnX5xuss+RkJS56hDpEG3fEFRGN/FnGJa3Gusceut8lDOmUJD1dZHfSoOjYBArs5o+BfRyoRw5aIAGvLC9Q/b/OxK3v85ID0jYv9bljUbZwUzgMJKfp6pgUNN47ARfgRJZdLE4cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774905097; c=relaxed/simple;
	bh=WuW4P7HIvCgTqUS/kR2NzM6J7queKF9TF23AviiY0qU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIwniInZfNkhUlo9zBNxMKRxQSzTT+txrQIs+gKX/JNhEFg2gwIGxZJf91+h8TeLOcCy1LAb3E+yF+jOgem0REwRRuFXbparPElOqsjUxeNMDDGjbuwt/ww44pKt1R4Ne3zKDinBVAa0d9Ck3ivrTw68VSX9bW7qqmW46DS6AfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HKSgzPkU; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HKSgzPkU"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb14227cso65267405e9.3
        for <linux-hardening@vger.kernel.org>; Mon, 30 Mar 2026 14:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774905094; x=1775509894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=HKSgzPkUR6Ga3XxtxRJ6sEmp/3MMmp6aTkjsQEWk0y4gALZwmd9xr3krRCXrMwXxse
         SAnra+o7+prT9bp/EEZSOqV3bMZNMr7qJfnAWtEkomsNbEnhZibtQ3Ukg6a/9JkvITAb
         NqYe+4o9dzvAlIg4W+dHyclzLtflLYFMRTrJNTNiVoEVJbhFq+a6FIIl0nKUGPp3oLlr
         quNk2tN+EMK3Al/+7Ck9WlZypk3bnMmIpaMFiahlCs7jgfDQVG4KA6BaRg1IzabcSQ4y
         6poTSoSeRzBSj+GJnlInp+DuSbhxKAifG+KfgnkgA8Cf4cEZVz/J2RT1Zgj87edQCu+o
         2r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774905094; x=1775509894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jc4DvY2MQK88Yewja1MkoO8icKiZ2EexxdGEKN37R00=;
        b=G1iU7bOMI8zGNsztw9T77ZkWu6h4o8WAXF6vH4v2gIod2OmYPVMesO0Y2rB72IubtV
         wx6ReDfd2bHseivaPdw3QlINeE8ZjGU4DZLkszmQWbOfdH8Opoui3UqEcsfbdC80R1ll
         b43/YdfYLmxIeh7SMTkxVB3u+xjvwb/U4sf/9eyPpgpR1lz0WD/sds36/xCbkMLOO5/c
         tG+YWU9Il+mcfGrTPmJAI9zm4TrsAmpji2NkMAD4Ym5iz4tzyYQkhAbp1B8aZGqK7z4D
         bW5JxzOR+0kycZHi/K4no0ihkpfkPkOG6Y1cRdkH/QQYgUy5W4Fb02LFafkwOsKPLoiF
         km+g==
X-Forwarded-Encrypted: i=1; AJvYcCXGQpWtn71TmvnzdZiiSEUHL8tOhN0NErrR3HqqxFkOIdLpArxNC7wz1wqhFsFUqGYvhUiBat2icWmAKe4a6xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+JFfNam7zfySKbRkl6Ig2cg+rJZz5tZJNeh+Lc8FqaA1YrdWL
	oQeRVqE0E6KO7+4K111oigEJBGeZFZ71R8oiH8c/EvxgojGfS8xG8EbM
X-Gm-Gg: ATEYQzw077b1tmDxQuieyP3CqBXxJYfie+8t3wVuK8hy6D4wTRTwuDzDo87in6aV/wk
	z2x1F2TxVxcIGz6aTrS9B7u30H6YHV4Kyba+1xkx40lTvUv2UitvLRIvINiTbwtBfYADSVSTvMB
	XOx/U9asG939mlT+IiHSDV3piA9vQpN5OQRrkQYHaC5Uk8Q0DuAO2jl0NxvHC6Urkj8/Vlcifyk
	xOK4GQGs4hfJ6+GQuHrE2vaDsiaaSd3hkJ5bvyd5h2EDq5yaUGTcErpXm2MS6SVQyWrV9Fu1kBJ
	P4pJh2QlFD7vfejW5n3ROAZ7a7vsDEwYKzhz0BNlKtWgkbvuE6ro1o7eifusH9CIxh31xy1daAK
	x34rSFrSnjUURMz2o0OySoazQcIh5suVeGDYCY7ENS0paSpSnc3jp5sP0TNR49skTSsLPGsf0gs
	/hh9t6QNISCcp8y5u0slT/21QVATbl1Cp3NLx+xeZNJyfkkQm3HxmoZTpnGGLo
X-Received: by 2002:a05:600c:1d1c:b0:483:7903:c3b1 with SMTP id 5b1f17b1804b1-48727efacb3mr225543165e9.20.1774905093642;
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887ad8d58fsm1787525e9.24.2026.03.30.14.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 14:11:33 -0700 (PDT)
Date: Mon, 30 Mar 2026 22:11:32 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Chuck Lever <cel@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, "Gustavo
 A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 1/2] iov: Bypass usercopy hardening for
 copy_to_iter()
Message-ID: <20260330221132.1e1b1387@pumpkin>
In-Reply-To: <20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
References: <20260330-bypass-user-copy-v2-0-f236179e7fd6@oracle.com>
	<20260330-bypass-user-copy-v2-1-f236179e7fd6@oracle.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 10:36:30 -0400
Chuck Lever <cel@kernel.org> wrote:

> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Profiling NFSD under an iozone workload showed that hardened
> usercopy checks consume roughly 1.3% of CPU in the TCP receive
> path. The runtime check in check_object_size() validates that
> copy buffers reside in expected kernel memory regions (slab,
> stack, and non-text), which is meaningful when data crosses
> the user/kernel boundary but adds no value when both source
> and destination are kernel addresses.

I thought the purpose was to avoid accidental overwrites when
the allocated buffer was the wrong size.
This is pretty much likely to affect user copies as kernel ones.

OTOH the overhead for some socket paths is really horrid.
IIRC sendmsg/recvmsg does copies where the length depends on
whether it is a 64bit or compat system call.
These go through the full horrors of user copy hardening even
thought there is no way they can ever fail.
That is the 'control pane' copies - well before you get to
any actual data.

	David

