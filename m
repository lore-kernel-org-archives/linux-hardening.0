Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313213EA961
	for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 14:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779287874; cv=pass; b=oBXF5IEsZjl3tvV2YG9evSMXH4oyPhbF3gqsrWqWJ4gpgxAXf20bsfJLQevnIyjfsXRY/pIKECr+PcoupwvckWuFbQ1p/KdrsigbhWivfGAaIc7HxDAO/7Zj3Yoc8wld0ELmcElu3if+GXiZuciqD9xh3hpT8R2vtcHHWdBz478=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779287874; c=relaxed/simple;
	bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DMVHkXm6J52SqZ3ZKb9Db0Xso2o9n+8vVcXmu8zk/UrZMfTZTvp/dgOOULX1VYu6FQ76D59cmsOAi1eilEGah7scFG+rLuEynYvXO8MvHQpNnrYtIcgBFE8A/FJXaqNOjJkH6SdwlnO9Kw07EfBBdjQ/nn9IyHqeqo1B7iS/eFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYHsmFQi; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYHsmFQi"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso222a12.1
        for <linux-hardening@vger.kernel.org>; Wed, 20 May 2026 07:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779287871; cv=none;
        d=google.com; s=arc-20240605;
        b=Illy0SeJEDYLJJiif81f/oWj+qcunOMM+3eJwpIUa5izvuZoprm1/iberdfm5LQ0ju
         69XaFSO7RpGcVKRTWaTOEfFeNgfzqk+tfZ749tjcluMDyFhu1P0JpPOMKCJ91eYB0JK0
         5ITiia6jQeAsE7xOhkIscU3OFEeVoJL+JCuwSH5f1F2oLUTqAkFwxdp3UMlOQkBGey/h
         kZHvLmY887yJovCdGDnNkh4cJ/7b+mxxhTph5BoFEiGwkv6tcMSJvHg7s5TcnhJxVB5J
         po+XbrN5zaXD6DZADxq6IIW662mpmzd0BkhxcwanDbVuTmdbgA+udw738FQXhhE1mY/g
         Q1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
        fh=pguzChJl9WH5Xds5cD5VjO/pc+QL9Z3BAtsj/ZJk8Bo=;
        b=dmRUH4uRLSc/F7GJs8nd9mCYMfiGk9eZt+xwJDc4cV5PZABeRD48fbXIgFeyQpvVuu
         E47Sc0d5N61wF/38PFyx/r5a9T5hq112o6hhbdOZaolkaJemb2HSfvwn0V0GXVOOMr6l
         WPCJdjfLXrsqDB2rDveTPk/m0sX7xYJZwyMptJVUGYZiwDZ44yaXv6taOvHwrKpUYNX8
         bgTQvjNSRggXp6Xf+5KN9G6QCreiXr+d2HTx2PdsBeo89fc6Z0HIYhtFNsEV2ObqnrI7
         9CQh7+Rus2JhIS1BeRg8ksWzmFplUEvCHGmzA1FZgAQArJHmuaA95KBWusIbspV6biDf
         ufDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779287871; x=1779892671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
        b=IYHsmFQia1CXlsJhUuho/oXanT9EhHfvA2aIRz6gKg5Ls1Nrxs2+g8EiyQIjxw+55n
         O10VnD6rKYrXPIOcnsgqKXnk586VqhfWZJWbCasC9wRduIffZUDCUR8/fZbsgwQ3t0+D
         xISrV5tx7Zjf3Di8wN0Kmv6SjzrgQgHHqiOqjfHt7WOFvdlrUp6CcNUul9VwyZLG3oVf
         qB5faAAZdq7xxlgUFG49et2SWbiHTPncOrl46rrlvoCFhuSND4aCFDCv3K3zeErUoVfL
         U9Z8xMpVIAjhpa1pw4ZR5ah10egMnj2e7xKJ1NndlWi7Q+KGEuLdgEKrHJ4a5Wk8+jTY
         ayfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779287871; x=1779892671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMCFs1zvjoG3b53dxoyMBBFtJo9eaP34eiwKbZPLgFs=;
        b=ChnxBeDYBVxDQspY5rYHjai96A/wR5A4HNePHjnv0/5/Jng2dQsLksja8E3ItuRP14
         IVxLLMeb7cE1hue6EdYxR/CvlXVYBjxFGx73fo1uNTSWnmN9p1k//223rZJ6aUpqt8/p
         ftYdGyCN4f5zzy+O5gj4Ll7QXZaU1FK5TO+7bUeZCTbs6vsmKVdq7PVRUYGJ1rpe7S3K
         Htur/lPQwIi4YlzxPZ4SEeh52ByIG3L+QwvRIsmGez3Gu4KffUtcB83hZ1a8zSB3XHJO
         r7g9P/nmAS2Y/Pwt7/iqierr3V0nnNN+wpO17ZLjc8r6j+6RlYeZhGFNVJVsmu8nkBDb
         Qv1Q==
X-Forwarded-Encrypted: i=1; AFNElJ/iFCGvGUM1ILcDI5d99ZJCOJTgBWxslaHZa3KAr1EsTRLVLxdaH0HZD+RHvImeBY8jz0b3I6MG+YiL04ciPnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2H9DLE6vlfstGQ8PmgtvCoTNDKDP1KlkOp79Ai311F0/yUj3R
	d8OlEglrJ1uw/zLaIUxu/DCbGP/mS6NtRNjL4/a1g+Eo43sjyLrnqDJ7+xWw7lSbEqbTwZT5YEZ
	JNM33OgVMadcwiKPdd85HQwNrz/xF3KT02IOYh+jS
X-Gm-Gg: Acq92OG7fwNPPJVbnoucwQ3byEzBn2F+bStqBOmnI8pBHcmPmi20/soCJLv27sLRAb3
	9vSX9zIAM+tWYq9Gy04x9jF9bfZPUfVr93PNlmJ8S3+0PYFaCtSA7j4TKLU2PHWloGnzjdyYnDL
	xCr3o3X8B0g1H1u+vTxUeRmyKFEtsZo6Lv433nQ/OVsqVZ/AYr42fb/NNwEAii9qRCmBKO5HV3s
	v+H7bcKVoLIi5UY4NpYwkORNUjIBadLe/930pvnlIsDkLO9aDcO2iUkWMWQUhTa/0u8uOUX20CG
	8/U72pSwGg2E56Rw7b4KbPTfK7UaUc+gcp4x8mw2OvqSrtR3/p+lGcYQDMQ=
X-Received: by 2002:a05:6402:d0:b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-6848ae091c3mr263359a12.10.1779287870810; Wed, 20 May 2026
 07:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez2++gA+Z9GVmNOG5-+NNicjmti3nQ8xhVJuXM042WfwZg@mail.gmail.com>
 <CACT4Y+bzkW0fjrUcbG+6XfTsw9_0sGfYN+9myHtC72dZT7gvNw@mail.gmail.com>
In-Reply-To: <CACT4Y+bzkW0fjrUcbG+6XfTsw9_0sGfYN+9myHtC72dZT7gvNw@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 20 May 2026 16:37:14 +0200
X-Gm-Features: AVHnY4JdoSHTr01XEaHyQuaQze9A_sGnydtK3RAXhZIwV8GUqbo1qEqHkb2In6M
Message-ID: <CAG48ez2KxGKH69m1TG2DwQkm5mZXQdxTkLL0_wqOgo3S7cTNOg@mail.gmail.com>
Subject: Re: [RFC] hardening/fuzzing project idea: KASAN redzone before skb_shared_info
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Network Development <netdev@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	kasan-dev <kasan-dev@googlegroups.com>, kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:00=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com>=
 wrote:
> On Tue, 19 May 2026 at 21:19, Jann Horn <jannh@google.com> wrote:
> > For debugging/fuzzing, it might be useful to have a KASAN redzone
> > somewhere between legitimate data in an SKB and skb_shared_info
> > metadata, accesses into which would cause KASAN splats. Maybe we could
> > split sk_buff::end into two separate members for "end of tailroom" and
> > "start of skb_shared_info" so that a redzone can be placed in between?
> > Or let debug builds store the skb_shared_info in a separate memory
> > allocation?
[...]
> Hi Jann!
>
> There was a related issue:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D199055
>
> Not sure if it's better to include this into the existing issue, or
> create a new one here:
> https://bugzilla.kernel.org/buglist.cgi?bug_status=3D__open__&component=
=3DSanitizers&product=3DMemory%20Management

Ah, thanks for the pointer. I have now filed this as
https://bugzilla.kernel.org/show_bug.cgi?id=3D221554 .
