Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F5843846D
	for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951107; cv=pass; b=nKJONSW2gSY5qa46w0RvZ5mbrFnQY62wLyV/A81Kj9wHtI4YqndQI8MbYdWx6V69YEC8OtQ/W+Mi3rXszUUeOPiRwusvJ2Kg/xCfV0uAKOUfSnjDirT5quM+anpITU/2Ha6Hdx3Sux0KBTx08WzdC5no3DpEqmEldERtlMCNXo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951107; c=relaxed/simple;
	bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INbuerRKDUBlJSaTawd0cgfiArect/FFIQDS/H/zxiiWtWAaFPXGR5n64dxmBcfh7mREf4qk7yfmSfLqjopvUD1QytPQA1+zAfVa9jlM2Q7C4r3O+xZtK4wqjOoTsrUp+/ihO4R9oqwZaB3N8MWDPQMv+2T6Qo8Oak0NMPqUlXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvYQ38bS; arc=pass smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvYQ38bS"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca5b707b78aso226907a12.0
        for <linux-hardening@vger.kernel.org>; Mon, 13 Jul 2026 06:58:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951105; cv=none;
        d=google.com; s=arc-20260327;
        b=mQrhvRMGaZam2zXFu8ZG6ELZatjvm22GkL7a5W+BWKm6pZMdCC5Gg8hrLDgHkCPcme
         w7ET2kDahO44a2cl9mF9Pvop4TKV6SMsPBmfMyLzykoBR3Nwd0jX91eqdccsTni7+Dj5
         rv0uxP/uRHWOMQb2CTjaD3ySzHtvaDyk73U42HtL+TTiijUUsrcjpYA5Rnwcgjy1v1S3
         ln/YceXT1weM3AsDYWhtxrssKf71ywMf0lBmYrhTCIu9j2vxveOKC1X5qsU2Vs5rdy6N
         LUZ9xp6Y+6Zx6rUW3FFZ5x3YVhlFBFtKRKfMn5CHlamFlG9PqjXoq+veiUNwmBpDgG31
         BM4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
        fh=c3/KuRAHAN2I9IJBaF92chVb3cj9dWdZDnTr11GV9hQ=;
        b=kMXrIcpDl8fZs1VbMB/9SR61A+gk9+efrYuBMxCbsaP+g4pqpuNLncY918dLJnr2Yc
         /6PJh4Gmwnr/ua7xMLNeXUTA6/vSYVUxUoOUlERQaUwFptEmXAthxpcVIDm9BMGIwKKk
         h6/c/N+EjiL7jRaLcpKySFsx+vExFb39veuDfOgvSGVfoiqIbajv7TfDeWQUxkCn/6xo
         A6P4wPierlAlEqlnjzFj813bqH84iuhrzgBJqINuRcGa3zT3HhYHLWLjCuwnFElKuW85
         BjVYRKMLay/YESeYsKFFJF0/K6VLc95d4J8PtGahM3xFF96A0gn2pVNeSF2BEBRgSq7G
         f1Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951105; x=1784555905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
        b=pvYQ38bS5izAb2wG43KIw1P5UZYxb9ft7hJA7sXGuPIk+dz86Pb8VD9ECUgHy+1mla
         d5j9N26TSt7b4oYsqANI0Mc/qtliamFi983eHgT0vJPctREasIMkOgCRGhGHJRfuXY+D
         /6nZCYJdRiNqHZBvgEoZyraCJbtazyb+hb03mnbKxg0EVVic5gtoOzCGrG9spdRd6AM6
         S47eg9rK9IRsythVWjFWxF2PInkXXhuBVJ+1y0zsO61H4ANJ5y23tRP1hMcpBhTyPvqj
         egFmm8XSRWiHIoWUpQsEKEW5yLs7/dx3DlCJQtohvCftiwDJF7DWG/o+6JyRTHV23S0X
         KZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951105; x=1784555905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AEzIPjQ4tONnmAeSycA4Zl8y6lQnr56Sy3u0tf5J2eU=;
        b=JHIVZEjjLhktWrwc/Cu0w9LAgajbm8PfI6Fobl1PXkMaXgFV6XVBJysEA/Mdvih4fr
         3mA9/VZkFQhRxADCYCO0K/Gh2tT0Xl35MEo73u0OVPjnjr5+sWUMYewGrNtq/GX/VXst
         34fLfNg6IwBIBKt3gMMf+B9sNIiD2kinMgYld8W8oFTTmAnV38oGWflse6seuvaB/wVo
         WXM54ZERd9rqXlXRlFR35AUP4zADEvt+y8H3vM9VALZhaKz7A77JlheP5tYX2Enn2oLn
         CBGu3BrfSpuGXOZVu6L5C0bu3MDj4Cq4l/WMK6v4fhaVURqacLfUhjbLNInjBNMygvGT
         /jSw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0qdHV0fRE7UeRT8PemGnX29+m72tMbJAYnfD4tNXs9TE/H8aoIE7uZYTr7OHXJ/74Vg54KUfwiTRYCZ75boc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5S3vQn/A9YfQIMR/LkERM5V2E7jNcDIPowPjICGb+VkYTAP2
	HcJatV3K6An+USTTfMzueBc1qrUfTQh+XsOdNTSDQm47mau8WtZKulnQ3rkOrexkmUSkA4MvX2R
	AIAAqRzjUNqMZ6tYYT5vEHRb5/VYZItI=
X-Gm-Gg: AfdE7cn067kOon+DOnUt+qqwNx4+wDJ5ZqS43oDVoZjoR+BXGm5XaoWnXKTilvosfG8
	fvDiueKof3NQRv9k54koKXuwhlXfNGK1lbiZ1eMr5Tx4UdjUUfaAJbYiQqUAz/dxeiqOsJ4YUmG
	WJDO/OvdcsogCNEsIPt2YDW9a2d86lS2RO4y0yUy6DE10aId15t6K2JEN5H2QALVyYDz4Ij1VvS
	0MYUSjam8lqfif0msyNTUY45c6WpY+MHc7wMfbFS6Ut1//1ZqCzR4EChnDWGGO2whwPzLPACiab
	RlPF1UtZI4rE/svAy59mUQ6wP9S3rj2+QxZYw3Azdoq1LP9lK41tuR65vJMvWg+QfRO8BCaCD25
	jJ3/UvQgDznT5
X-Received: by 2002:a17:90b:2685:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-38dc781f3d7mr7088440a91.1.1783951105371; Mon, 13 Jul 2026
 06:58:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-rust-reverse-randstruct-dep-v3-1-e4e09c50014e@kernel.org>
 <7cdb2407-924c-44a1-8c68-917efadd4e92@sirena.org.uk> <DJXHTB615I2J.POTXT6L2LM5K@garyguo.net>
In-Reply-To: <DJXHTB615I2J.POTXT6L2LM5K@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 13 Jul 2026 15:58:11 +0200
X-Gm-Features: AUfX_mwVZ0NryDxFqhvpTqzVNlCtwM7HgnYa0pfBRDhjq9-oYDqBTVV0BB9Vf7I
Message-ID: <CANiq72kNYRBW88VwYyDX8_2b1L7dLv_gDwgE5SruMELR7KPmig@mail.gmail.com>
Subject: Re: [PATCH v3] hardening: Default randstruct off with rust for better
 allmodconfig support
To: Gary Guo <gary@garyguo.net>
Cc: Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 3:55=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> I thought Miguel wants to add support to properly support RANDSTRUCT with=
 Clang?

I am happy either way, i.e. whatever the hardening folks prefer, but
regardless of what we do, I think recovering the linux-next coverage
is a high priority at the moment.

Cheers,
Miguel
