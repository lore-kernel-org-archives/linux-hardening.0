Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8D4A482C
	for <linux-hardening@vger.kernel.org>; Tue,  1 Sep 2026 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303615; cv=pass; b=rVo0mcM8edRzhVnI1nW8SIWvhH4F39ChkYBl9Pza0fLcr4KDnoPq7S6Zs6FCQQdmhHHqoywbLnqsEEg/GAYWNHRqm4C9wkfZ72vpnPRAk3m2Z21AHO/yIn0M5A85XBJBC7zPKeM6/nH+6UDVrt5+rNrY4w+aThC4g28BJNu9t8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303615; c=relaxed/simple;
	bh=1EohgyTendztVlDk+2uhEI24wsVVaL8E9Q/KpC4uNBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ak+QCwQip9CaQN78JuegBBS9VDUJokIbVSI/3mxPSo8we8cOAWH1WcQXCgfphHKbYRv8NylazjDCqPmWdD7OtL1p9cwZ7buHplhg7lIY/2qudzSKYn5a1y3wX4JnNB2NBZdTEA+ihGcEhabSXh+hh+3xSxb1wNm2eu32XqG8CWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BO5eB0g+; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BO5eB0g+"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-394f4397662so48728a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 01 Sep 2026 16:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788303613; cv=none;
        d=google.com; s=arc-20260327;
        b=TvJp44BOkU8x5fb21SOm93WJBv7Y/yoDwpNhgC/9TwM+NQbQzzxaSfo8yxuEnGleiG
         9Y3OaThIWAk2kkMLLSmXLQ66S+b91+7uXV8ooVhRJbgSKHDdF88swTII8OPdC+Mi7xGL
         lmtGQMJ8IiA80g9Z4Esr780Gml8XJDq4pLQReZKHs7RvPAdtEdUfXzzuz4ofrqCrxrim
         3mZVCH1II/kQQpamqNBFju1/uOgTRyrmUROB4cJoXPwKb5eYHFrDcrKhTE15I8mgjK5V
         vuhyV35Ld7v+rQtdcg/wgfgqj0oqbX2rRSnhrGk+cwDnuvQOVCK5jA0SyVWPxrEm3AOt
         EWzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HkZyz0DUc9IX+6OAto+PXMl+WtSd8or4pjnBzMTymto=;
        fh=W4mcMMhZvoD9lnt/iHi1VEYuiR+HuqcmltRKg5hU/k4=;
        b=q9vwoE6CKHIidAVBU7lYQIEVZktRa79IW+lEcrqpeVvfCqmNj9KDS8f5HTOI2vkvZy
         OLiNsUKMxIkC/bHrWuLxdnJwCnytqLYqpuMCk2pbJVe8Vbni2l/4Ya9osYrlDP/l6Fkq
         g4htkUArtch6fixq/pnt6L2X3jPslNnFs8iOGITlgDZxF2aaMrU3e5V96WjmuxPiUGbu
         1z5JDB2kYqaRx8ju3qLgRbO6tmsYWVn8xC8RmLMtVtIcv5mRUYHjy6/PsQdmJO+H5yk9
         Mkh0YImHFZY1jM7IGeY9IODMpXNo6xNqLtlUgHdOSacKx7a41RyI7EqIbUTJ+2ON7nQ/
         k9tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788303613; x=1788908413; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HkZyz0DUc9IX+6OAto+PXMl+WtSd8or4pjnBzMTymto=;
        b=BO5eB0g+tnxZVHVPRGmO8qWdaC0Pj61waUxjA74VN7qQTtW4H0ShrSqr8jIn1WdpIv
         jJxLGlSen3JumbU8sTuRChPCUDuUnOyk8vhCE63tuI4bzuddMDndIxk+CN28hpMIoxdy
         yc6R1r6xtClIliRKpjqh0T03lqk3UddKKH0aXA54u5WNHlBO64PVV88fTw52So/w5Fbw
         4OfdJQ54DOfy20X2wx85hpL5cQLQJ281hMGnaUJiczpSHnPSNCFjFxoVbeqJ2PZ+C/78
         O98mbs4OfQOPUv5/DWHAPCTAI+gGUhIFITi4fxzEvuKOt0CfvefWFfvVGMWk7dpbP65L
         aLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303613; x=1788908413;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HkZyz0DUc9IX+6OAto+PXMl+WtSd8or4pjnBzMTymto=;
        b=farZrwXmPKdWkda/8SnZ8N+jhhTRGPPu4A81eWBe2clktNVD/V6vtu36zIvu4cvusf
         p3nCza0S+SFvU20fRoI3g54K9I3EGK56jcdDTXF6mHXRcotqyfVnsdRxb1TdT24yCqia
         gjqdQMoS3Bgk/LMCYnM0hK0qKIonXGsRq24MPIT7+nALZJxnSnWg9ALrqzkIBRkcNKIR
         DPJxF3v44z1RU3sfj6EuDupFKZpyDAzeUPwTz0YcczOja4DCCJg7pf4Gn4CyZgl1lqd0
         Jo0nBJg/PCj0NKU6gTr/bGjcxFCQm5ZUEW1awF7krjA9Hf8zxBtqIcXYL+jikePn0dhQ
         myPA==
X-Forwarded-Encrypted: i=1; AKwUvBxHDDRVEqzoiftY2zlKAVxpnvAniEg1BiJQwpxMv4t7o1/NNNlbx1jDjRJSsaRZsu+p77+7AwQb1pA46dX5ddo=@vger.kernel.org
X-Gm-Message-State: AFuF++kZue1qJYo8sNGbXAhUqP1p7e5Z1NHCUwWK9KDkBifFJgM32+iz
	dV4ZgkhX18mzfp3aEvfYiMs19gAgo5sSMTYhtc7vpXlYOwuOWLtqHBEt9k9OIT7HACcB4NRWsgt
	yCgaGg/dlqi+7hnSa5+SKl7TDx8MEkL0=
X-Gm-Gg: AYBFou2tchFa332wpbS+reRr0EsGHmKhIL2HukA53PiRHX6a774cXvdRB0NgWAENlD/
	nzVMwHFSx2gJZerzJGzE8Ku93+xXxiwN8krtN1lbFdtHFsDkASTgqDM36d1TTK+gVaVALjO22FP
	g4/4IDwBAx5FDftLooqZEvJfDy6ufNMxbXTRMRnUpZVSgIf+DWKpcw6V+mDqZ8eFDZxD4NlZj+s
	xi1BNJbH2IKI74iP2kB4oL4I4kp0dXZDNuNCEDkvf0oLVrrN9IvaJfz35zlS2gO4+9JoAUSoD7p
	CWFv1wrtgfBWTj+sQ3bHGxA/5f3mxp1hK8GHW/MSAkNRsg1J9Ug1J/mglcKN7RDxmPJBkM+bzI3
	JWk5w5Fsc8p/C6Cv19K9khTUdyn/gWBwfJKcE95p1I15N1YVs0LfOmQvZ/coh
X-Received: by 2002:a17:90b:590f:b0:398:bac7:72d0 with SMTP id
 98e67ed59e1d1-39aee222c37mr234130a91.5.1788303612233; Tue, 01 Sep 2026
 16:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
In-Reply-To: <20260901-rust-reverse-randstruct-dep-v4-1-3bfa19efe1fa@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 2 Sep 2026 00:59:59 +0200
X-Gm-Features: AcwNN1V6mJqATHgXTZuy_n_fFgcdcAsp6sZqZ6O99j8lAs7oSu_PsUpXZ9i9pWM
Message-ID: <CANiq72nOk-gbd+C9oG5y5RKrYhqNx+BLcwS-8u-uHxUjVTwEtA@mail.gmail.com>
Subject: Re: [PATCH v4] hardening: Default randstruct off with rust for better
 allmodconfig support
To: Mark Brown <broonie@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 12:52=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> Currently randstruct does not support rust so we have Kconfig dependencie=
s
> which prevent rust being enabled when randstruct is. Unfortunately this
> prevents rust being enabled in allmodconfig, our standard coverage build.
> randstruct gets turned on by default, then the dependency on !RANDSTRUCT
> causes rust to get disabled.
>
> Work around this by disabling randstruct by default if we have a usable
> rust toolchain and rust support for the architecture, circular
> dependencies prevent us directly depending on !RUST. This means we might
> end up with a configuration that disables both rust and randstruct but
> hopefully it's more likely go give the expected result.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

I thought this was already applied:

  https://git.kernel.org/kees/c/3844a38c9c4a

  https://lore.kernel.org/rust-for-linux/178733378275.2181196.3186172911325=
132761.b4-ty@kernel.org/

But it doesn't seem to be in -next -- that branch isn't merged there I thin=
k.

Cheers,
Miguel
