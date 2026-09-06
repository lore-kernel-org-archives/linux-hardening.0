Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C727282F01
	for <linux-hardening@vger.kernel.org>; Sun,  6 Sep 2026 01:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788658365; cv=pass; b=McipWrmblM7sPx7yhhy47kQaK9uBr+Df8kHLNOrShigz9qHPXTLkmb7TxBsWE5bH6Pc1iQJdMDa6suUL76fKJO4NmSaqs/2KfGFMzWi2amW3C1Af1PUibYN0XU77RYvnhY9iGQdxMt4pBXR9Hw/Vg77hE/0t82X9S/mjC1kwItk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788658365; c=relaxed/simple;
	bh=XkGisV3Evjj7Mvd+zTCV+TdTT1vDp/RPTN9iZlFQXP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdyAw1u9C/1G/swPlusSUJQnYkfnwfU22DA5fwc/KYbL1MCq4dQSDUdj3ve+11aGgNh7bWEdXsivne7RJ7U7ZUCpIoOpctv9RZh3oqMklsDs88KpoTKymziCZlfqNhI+GXIIEo3J3bSg1MzKtFGZWTIrXZS5vkdEecJyEWGW6zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=hIsoI8dn; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="hIsoI8dn"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-84830c774a0so1973462b3a.1
        for <linux-hardening@vger.kernel.org>; Sat, 05 Sep 2026 18:32:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788658364; cv=none;
        d=google.com; s=arc-20260327;
        b=PNRPwybnIDukvkn4fRZKqSGDKhjfHFuCk214fq60W6Uqwb+1sjJvvRT2LXGmBc64Tz
         u/zJY5Um38oi1rYVrICA1UIyb60E9SHk1Jcu5Ytj1lxScH1YrCxyPwjCW49AFO1/ce+L
         WmafnTgC5/7vCKMI/sME4CEMEhy63tSUA28AJt9nKL7YxS/2MkVstJErX46sWLwjb/gO
         pbfxYzshD7/FkCy1wVy3323ZWO5f17ZRKvyue+8DUKCtKCP8aVdqDgb42XtPlxxmQwST
         8Nbc1ooL18fhUCQ3UvIMj2cH4wkF3JQUDCh2/Gh/XfGIDrTWHkCrN0Xk80I0p+bdluJi
         RXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5c69AaY32kskBXaaf974C8085cag74RfiCzN2LO7Q78=;
        fh=bPPTYA15JIlOb0kobQZfT+PmaTpiMv0hytYJGrKeAPE=;
        b=aQODdL2TmXlWqcVv6FGrtTYwhdtW3iQq1F7yjK8qkxZhQB80bLflPt3rhGGRYNwOEE
         uFSyAKS1tcvBaCalSaYbH9vAccM5e4RgDbZufwfHB/Po6zVdlrxkv1q2M9yGgG7Qx+i0
         ZEubqJR1IzpmmZLShzBvW0Wh/dbcrZCTGBF/HIb4f2+KnIQYEx5uQ7HF1kbCED/BMaZW
         icrhsApg7arBSEGMHsya5ZLzUty8zMjUenC75TG47isaQB78Ivh+APEY2v/E2fBdrsbX
         f6OWxFMoisAN/OLuqHrvli58nVIjfROa/qyxQ/IKH7nsFPlCrMn7x9tBb76pxVMUbwUM
         kMnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1788658364; x=1789263164; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5c69AaY32kskBXaaf974C8085cag74RfiCzN2LO7Q78=;
        b=hIsoI8dn3ooUJo2RoZBogUyaO4ghoK7cpiIxKv+qbMk2p3FE0hyf/WVGtAcTBmyCvT
         mKf3wmOGaWGy6vVRsIV64RifYQLC6cDyiWtbHw/QLc+YSDrrPHg1XKJ63BVjsSPzk8jf
         nuBYQ4mO3AraaXSKMw6RemPLy+s5fNdjVkueakCX+nhF46YxNWoDjbKf+BEm0PIBycYf
         ipbRUF9DIDLbWXgVO/i83JEfytBscS5QeDTwJnIkQ8mgq77qMvqAXLF9XBdQUlCc0UgQ
         TX7REpZqU1Z3BQUpAdkSXkktOfsrMJOK5wr81oCTDrclTfUSpQX3S+UY7nR+RtIILsI8
         urFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788658364; x=1789263164;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5c69AaY32kskBXaaf974C8085cag74RfiCzN2LO7Q78=;
        b=cVeRkDxMzEqQPjqzzXAEMgAOtF/1Fba4tz5z/k8PJK3W7u9ngRcMdzrKEgcm1axWvB
         JLFCXhZqKZ9JIUBI727krSPT5lEfR3Gb18qXMpoNvoNGlRIxk/J1cq82hymRQVr5A6X+
         BD0XKIBct763IgheFqArrdLBARFJLgk8zPgPH+3N3UYmHBk4HKREzkYblOa7Chf2higY
         nFQHSPAUjSSxpXTJ2OCHFQ5m0UUGnzymlT19ScvLtg0XJW0D/9UiNQY975MZjIM5HqwA
         Lg0oVNA7aTPzfcBh76hm3kE2tkgZvUtoSMFmodOeRbKgxlA1UE56vkwT6CA+9sZB/Rb5
         Q38Q==
X-Forwarded-Encrypted: i=1; AKwUvBzMHcKisvNBD4L+VYrRYeI8mEqWKoWr386h1lPzv20NA3LYinsGAuRYhCm3j/u5wdyBxn3klYNDzKJSNwTbNOE=@vger.kernel.org
X-Gm-Message-State: AFuF++nwjsK2TNZozJGaC3IIOisS5c10ULU+2NNOGZb5s2JwFumvw3ba
	jKfDXAPTBgkLRypXAQvThY8B7duXTsDd3AXs9uElyznsQu2icrcGIUSCobUmAjngHgzaiSpouTa
	cnNJmPFWDAqx2ylkc79DReXc1NdXh8H4Ndslq9JAZpS7OmsgUJXJt7PU4
X-Gm-Gg: AYBFou1VrvL9yeUPhVDjowpArNpvEci/DRxHKddsMSwdaIlg5YdygZCj06lDdyHM0z4
	uUsweSw1oZ+gUAMpcFPH70D/cyDu1NCzpuABly+IguiTKTnfRLVbEOxuGCiW4NhefL+5VOs9ZJx
	poOWE34SW7ZVf6XeA/YDgI9QPECSX/xbAdO1kMIZdzOLPymdjxj1vSywzJQiAcF3l/AdeiVwER6
	oNX+fYw50nNCwAMVLKaztTcxzXIw+k7tGKspXoSUkQc3DqIb6sxdtyvQVAg+nPNE4oSrfuSie3T
	GDPp0M51X8iZOM0CauV70oEVkEtUe7K8Oqzj0y3VKyqRvtIzSg1W2nL7bNjDJxvQ3vaUOvWRCgc
	L57i/Vo9XlQ==
X-Received: by 2002:a05:6a00:2c94:b0:857:727c:a1f2 with SMTP id
 d2e1a72fcca58-8616907f6e9mr21628645b3a.20.1788658363695; Sat, 05 Sep 2026
 18:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727233706.218446-1-xmei5@asu.edu> <20260727233706.218446-2-xmei5@asu.edu>
 <CAJfpegtvYJPBt=AcssH25mn5VDR3Gdkhf1PvuLR5HkJ=CmkYpQ@mail.gmail.com>
In-Reply-To: <CAJfpegtvYJPBt=AcssH25mn5VDR3Gdkhf1PvuLR5HkJ=CmkYpQ@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Sat, 5 Sep 2026 18:32:32 -0700
X-Gm-Features: AcwNN1UPXRzFZw8ZZGT_UcW_OJxAT5DgOQb9MbK7fu1zShy4ZYp6C_Z4xnhZ2ys
Message-ID: <CAPpSM+RgWtmFLUAMfCvCg0ek0z-fSLAjr-eCVYivv0z5tKNVxQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fuse: bound io-uring payload copies to the
 registered buffer size
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	Baokun Li <libaokun@linux.alibaba.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Luis Henriques <luis@igalia.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 5:28=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 28 Jul 2026 at 01:37, Xiang Mei <xmei5@asu.edu> wrote:
>
> > Store the registered payload length (payload->iov_len) in the ring entr=
y
> > and use it for the import and both bounds checks, so the buffer the
> > server provided is honoured and an oversized reply/request is rejected
> > (-EINVAL for a reply, and -E2BIG/-EIO for a request, matching
> > fuse_dev_do_read()) instead of panicking.
>
> Can you please update this on latest fuse.git#for-next?  It looks like
> some of the checks are already added by Joanne's patches.
>
Thanks for your help merging 1/3. I checked the latest version finding
there is some changes to these functions but the check is still
missing and we can still trigger the bug so I rebased the fix and
dropped the review-by tag. V6 has been sent for your review:

https://lore.kernel.org/fuse-devel/20260906012924.1928316-1-xmei5@asu.edu/T=
/#t

Thanks,
Xiang

> Thanks,
> Miklos
