Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072415250A
	for <linux-hardening@vger.kernel.org>; Tue, 11 Jun 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718140236; cv=none; b=cNBqFggBXQHXGicxY393JmilOtQZCAUvtYhTQSW9SMbFr/m4AZ9EXRm6ajwBnWy1l2D+ZL9Uiohq4FLdzv70RqXwfsG5AxuVREt/hRTqVlxwZMcp1vAEWcJx6b4NpQ36K0HaGRV6N4Bk/cukLsa5EBmXe+OTDUZRxtMgU/uViHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718140236; c=relaxed/simple;
	bh=FRYYoIedR0kq08TkvByDILBzLvdsSyczT5bls5QRdJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXXUOR4p37YqTfH7sldcyNhIzFYwt5ccM1kj2knWOlhaCidEL1Fnwhrqv3S4Djsat0WRgYUVLM3zTNiwL662iGMNd3iE1IvgSMfDKU6tr+6BDdzZ3NcThyIO28Q+nuCWvSuzl2PYEIT4PoFUwWhHzF7rbCkQ7qYXB8CyLDe4kI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RCZjFseK; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RCZjFseK"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52c94cf4c9bso1462184e87.2
        for <linux-hardening@vger.kernel.org>; Tue, 11 Jun 2024 14:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718140233; x=1718745033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRYYoIedR0kq08TkvByDILBzLvdsSyczT5bls5QRdJA=;
        b=RCZjFseKSbwqpBEmh3UnvnnD+Wkpn1IAEdeXI88b/rN0tOXTNvBZM6nqfFqMUDRBIU
         sTL3v7HJOJZDw0LvkhM4nvRRLybniA5GvGJgEAVPDnQBp6OoBlx0dVnwyaAQ5rKEtddq
         nbMJ9Mps+NVcqGLOUiumUf08fGpD21CfdQTrODuLrz//FlORnLS2ZSoLmXTly3wB+lb8
         dIgfY6OBHpLgSV0eI8y1tVCLR8/4+8DJU1usZrlGCTcbU3p1dyefpOhyaZPeCJ5e/Xgw
         IxAB9IFhEClcFnWVauyKi9kc9URM/YQz4gz1hLPD4Z6HkWUca2SShYhPMKSoPqJCzTcJ
         V8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718140233; x=1718745033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRYYoIedR0kq08TkvByDILBzLvdsSyczT5bls5QRdJA=;
        b=NMANH1BE7W+aK8CTfqn2jK1X4JjisWSRmNpI3A/cPiDpV6o7LSYVQLRuGxAx75Unj3
         b/+WRhy/i6qlPRs/EQ1mQ+IugJgVeZiaCEjYTk/0SxKcbuAeYRFK++S0qGA5ETeWsV0+
         A/x7ESgSONYWTo0keQFSIhiq/V9+/9V6exYcwhS1w5p0vF8YbfOsIno+K9jzqBDi+1Js
         UwFBZiq339KU4G3ByqU7b0uar4IdYwXj8FJwKyzMoCYk9Se7pXF5GYiBvTfpqn1LwjqH
         SQJdcFB98IRWTAy74l778hKEgudx84ro2m4oHjh88xwnHuRMaJGe6vJBnnwVwlRRBNLe
         Ergw==
X-Forwarded-Encrypted: i=1; AJvYcCW0iVGx96g0k/GrwTNSPVZe99MPLBmtAT6qk/jTP4/ghOmef5CylSJF4MK1Q0StIDjSUu/1xlvXLnJ1ZXUHPEpGpb3b3orbAjYdZbMNQCHg
X-Gm-Message-State: AOJu0YwLz1oy6z/Zf9PyzJESAeBuXLMK3s70HhPRoBZliDPoU3Hg111K
	2kNAcvbstZgSvi61kg9VrQmTsDLMRUuQKaE8YLMbojMgoikZXxDlF4CSAlOfiKY9ELnAWJfkZzY
	fDkqgKqTp6HvwjNM6OVykcWHNQgypD+50U3qK6A8aj6cOFXTj77U=
X-Google-Smtp-Source: AGHT+IEH2FsO7gj7PWwb7nNEVBFBx1qq0Ka8bimXvtn1oIaCKe0wtzgMvlBYcYgk/Uq8KKL56MLHAKwZBOk7S6uPVwI=
X-Received: by 2002:a05:6512:1150:b0:52c:95df:6dac with SMTP id
 2adb3069b0e04-52c95df6f65mr2638281e87.14.1718140232899; Tue, 11 Jun 2024
 14:10:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610152638.2755370-2-ardb+git@google.com>
In-Reply-To: <20240610152638.2755370-2-ardb+git@google.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 11 Jun 2024 23:10:22 +0200
Message-ID: <CACRpkdbc5ENohiFg4_mEfYk8A74UG2hiECCDfELnMu7ghKa3Ww@mail.gmail.com>
Subject: Re: [PATCH] crypto: arm/crc32 - add kCFI annotations to asm routines
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-crypto@vger.kernel.org, linux-hardening@vger.kernel.org, 
	herbert@gondor.apana.org.au, Ard Biesheuvel <ardb@kernel.org>, 
	Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 5:26=E2=80=AFPM Ard Biesheuvel <ardb+git@google.com=
> wrote:

> From: Ard Biesheuvel <ardb@kernel.org>
>
> The crc32/crc32c implementations using the scalar CRC32 instructions are
> accessed via indirect calls, and so they must be annotated with type ids
> in order to execute correctly when kCFI is enabled.
>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Fixes: 1a4fec49efe5 ("ARM: 9392/2: Support CLANG CFI")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for helping to iron out the rough corners on these patches!

Yours,
Linus Walleij
