Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BED75801
	for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774453711; cv=pass; b=g/8lbz8PWUOPdKwf6coUe7ak9QpFkwsBm6Oe2PNUCrNPz1BaO0KvOVrWFyy5LG8qWm6w9YWqAV4SKDI6mfy+4LRoABJ/AYlmWoZD/7o6OccF/2Enj6JhAkqIzVZ8dH7OVempOlLqHTqjdMLzPScqpWp4DvYcZLhJPjJdBFac2Rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774453711; c=relaxed/simple;
	bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xnay0LqCe2fFellggO4NnW3hhZVUJV/7Mw7fdPkqO2vBup7xPs+fi66LObRW3e0ZxMYsdcth/8LqfuJ6pSoGfsqZeaL2s8+kWSBVGRSA1fn2RjuNVPp5vgfziUy27QoGoifaOKrusUbYpiZI67dUDnuNTs3ayOyA5C6kh1XNPpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9STyh2a; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9STyh2a"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so2911172f8f.0
        for <linux-hardening@vger.kernel.org>; Wed, 25 Mar 2026 08:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774453708; cv=none;
        d=google.com; s=arc-20240605;
        b=FlLlP3KCAeoFAghuN/zD5NEIlfUxCEpuScP0TbZIaxypgY0pAkzvJyF4waDXv1AkUm
         rpeatNupXxDhGm36VII8roe+Gj1wzJNEOgFn+LUsW4/dNvpCBpEdFc6E5h+dBzxrzloB
         kBghUBS4mgdreyjF8DI5rqoKwP1m4Pcctj9nko9FW+hEWKVDz8IPfJnpcmcCEjBYYGUH
         /nP/aMxC6aSomX6ueW5bLMozWwPqobEbtTUbooOozIRNhapEqoxUNi0AQNKz5ez9QdWz
         YNfpRupY87dVcNn56brBDtNz7bu6A28TfUiPYTFmSW7SS+1AucGU7ifwf8RqDLxC5lqY
         +eaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
        fh=ZRWn9kgBAdrGvMpx9zUOTA5ZowhgEzFR9TlGfHnL1ww=;
        b=IByCYEebZ7QECzju+kGsGP9H6TXZmaCdcWJOwIJiOPjOaUhVdHUmaHjIfiyTUF1chu
         WP8DEPdylJrketRKdB5No6S3dJFQ2Gv08v0+VCCI++K/cAzcV4wHWcoHzqkBfcD7w0A+
         N3C4uqZ6YpW7T0u+yGG3/qxJREc2lLI5BupWdfEMHW72Y8R7SUnh0MLvi+T3zPRodOH6
         TkXbxTSF2Shzrm8IPH7TaMLhmuovSwTiffx3HIHP7egu+7CsK7k/qwUtXRIWj8S04jFW
         oBE79ENRWgBlU5jn06/6HJaMn/WB9SNIVaR5HIhR4Rz9znfOIaeX846+fY04fxfnoaLX
         T4nQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774453708; x=1775058508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
        b=R9STyh2aUwHqe5sK9AbQlCJuK//hCu4NDTPPxpNa6Tg3Y5NEaY3PHqGySX+i/3rJKy
         zXDpaSASz/NZBkZUgQtnOMOrKRWgRW2ViwAyGz+GnViGLno6J11/YlBkYUwN4bLk3w4y
         dia/3Q7rRfqseflp/VMHTT7XTJkia5WDq8oCailSFBfYgtPby6KTDLBFNowTCKdxdjsB
         Hmibls5hdbWdoedqBjSFHcpXW1xjePl3zEywpBgBNAlszsLNinklEI4soIiG+y14fyUq
         1b1gRA+FdawYBlAz94kD0Ev1G6Y4mxmEyrya2R5wuL61sabGCTpBoyUqF6kt2iAjCv3b
         UBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774453708; x=1775058508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6q74GR28ypnI7CH3fIdh9EqfKHMj5u4vmkUR+OE3q0=;
        b=IpNn4J0K1EwW3afCB39r1QIwoeR+aAw7XAIvXVwvnMWnpOjHVaSGfG5OBaHZ9c1pqm
         uAl+7tQlTCXhEoG9K/d1x1pjcJH+on+/hpM0YSa7i6trhh6k8/uMAwhm5qL69JyJGxDq
         /ZPEALQaqwQDA+wLVENA8IyH6zNHPf3Q+I2MFDbu7vrM/R98mNjcZhf7CR4sePfIG2bb
         dS6OJ5XAl/4Mb4FyaR8tWVFPhSC3YofQueaAkraCeY1xzMoBuY1TyP4RRE/9LcnrtIkT
         2Sde4U3M/AJ1ZWiazct8bJaeWB8M3WWQGl8O/ANOtOCkc9fSSOZ+smT+nbIpOF9Tv5nq
         T9Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXmzi9gE/Km+BjRFVFXcCE4ZgyQwLYTUS1pDwTDdT2gs5Z+Gb2DjA+Z+Mms9RwODi815+P2cIPOMzQetHo8qnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD7IufbajYbOEVsGUz0glgma9HXBb6RvCXmUYW8pMDPjn/qtBz
	RKhEox69UXkQn18cAVvBPVmmpzIpbR1+pEFyxoqoozpvz36Hy3x0zf+d54br42/Z6dwvJlRc4ER
	R1kcbhV0Q0WQgEUkPWmPpG+wijQ/ggW8=
X-Gm-Gg: ATEYQzxODM1frotaJdkgxPvvKUxBXUiYc2rtzeqPCfpet2I5TIBFfnnY9L9fpny/duD
	UiPQZdFD8SxMtND2UbR7YTUCQZcZtNK8AkmNysSs9QgESxUnZERo6S28auJfYUR/EmNCHlu/QTn
	q3JkRIucHp1r4u+6O/eiAh5OC0xwpK7dkgCOz7Ctz1hcTmmBxvFpA6nWldBYeUTsqMtWoDG0m+K
	gWX4uQmieLASG1zNDMk7DLookyKQkVfHI87AuOVSg/Wt86dK3X2xtvXrb35NWCaMj7/CjOujIuE
	4rk/KxttmYiuKyHgbg6ia6aJ8Z1IS3vze/86ZxSFQWSxqykMkB/8GvZEneuh5V3LwyRHj57XevQ
	KAp6eF4NxBqOOxEwNZFwmyD7Gx7+EBJfX/S2Y
X-Received: by 2002:a5d:584c:0:b0:439:beb9:5a96 with SMTP id
 ffacd0b85a97d-43b88a88a42mr6126841f8f.31.1774453707977; Wed, 25 Mar 2026
 08:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
 <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
 <D53376BA-4772-486B-A18A-6858C1732723@kernel.org> <CAADnVQLA3K6v_+_7-+BDVEeZ2N=6229FL6Ko=3ywDWsPVOPLcg@mail.gmail.com>
 <202603240919.D248D71B48@keescook> <CAADnVQK+hMnUkv5TfOGfiVR+nf59bBX+zaHOvcp5zSZTpdJB_Q@mail.gmail.com>
 <202603242109.171584E8@keescook>
In-Reply-To: <202603242109.171584E8@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 25 Mar 2026 08:48:16 -0700
X-Gm-Features: AQROBzBhIPVcTb_sCgIW7TYVTP8HJyUSk4-aSn1FI2sOIl1gLgUg1BW_DiJK3tY
Message-ID: <CAADnVQ+RfMaNDgoyCZ6gUJX-c+_XYG-_mFEuNM5xJANFs9USbw@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Replace strncpy() with strnlen()+memcpy() in skel_map_create()
To: Kees Cook <kees@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 9:10=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Tue, Mar 24, 2026 at 09:31:09AM -0700, Alexei Starovoitov wrote:
> > And please keep ignoring it.
> > It's not broken. Don't fix it.
>
> Okay. I'm confused, though: what's your plan for when strncpy is removed
> from the kernel?

when it gets to the point to be actually removed then we will deal with it.
Until then it's a witch-hunt.
memcpy(,, strnlen()) is no better than strncpy.
