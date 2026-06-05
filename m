Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2227C33B97D
	for <linux-hardening@vger.kernel.org>; Fri,  5 Jun 2026 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680189; cv=pass; b=q6LFHCxZ19XwkdlJFMLizUTeoI1SNpC5Ts0LZ99RZQl5KNelobnMW6hYkKhhsvJynFfUufPULbJ/aAdXMs83M+CFDXKDxcY4svcrOO3ZVn1uhCM7eoIK1QIdHJ1G6fwYyuQvLsADKldt/2JvPnoSxaPt7tzVd+t/qaHuY/QlhOk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680189; c=relaxed/simple;
	bh=i7KgJLF9GZ/FwqQM8eGgUNDLnwbwVyWRy6mn5814iEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXFQMAX9vd0rHSSB7nIyi7Do5lDtp90Y/QJ1ofEMXVZEY6o5wbnEEHutqwdOH8uvoqM2Ji7VHjiU7tn7powcPlC+YICS1kOGyUKiihaNtt7N1Kh5J31lp8POv64wvbmSZVL53N/IAJQ7Nds7vaa8QJHkYITHaWYpEwEEu8g4IE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDrf5ME+; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDrf5ME+"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304da3b4508so225990eec.2
        for <linux-hardening@vger.kernel.org>; Fri, 05 Jun 2026 10:23:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780680187; cv=none;
        d=google.com; s=arc-20240605;
        b=M6dJ5IEE46u5xf1cbSRXC8ituEn0sTpfbaGuiqqSjffTbxZ3PPYnsA5DbVrqvxQZ5i
         3UHAF1AigoU16lOvgi20vNzKO4+MpX9jf0UIieGgFXDO+pE6B+H/2MmiL9sCb0lTF0mt
         VeHK4GtAhji62iVXbODdxoYiZz1WkbW9sTA/Fp42WM8SDFxjnqLen1z2fXRsI7IwrRB1
         kv1htH+xSO+N6maVFu7LxlIw7iDupNYY82Rjj5/+J6ojWh3GSXDKy8nlb1LsCFsOtd71
         RPxtBEfU/1B/RCui+8f0PbQyl137Q1ixs9PNI1fqC7obxBReQY+e+OMjpn07cpCiDJc+
         fslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uSx8CCu2zO3nvn/ay1oOlG5l2f1ymr7/7z56E0ctASc=;
        fh=s01ysbu3/9DUwJSUt375MNKllN/KXaYD51ind9Z2wOc=;
        b=kLGYo7/9dS8MFyxB6hN5ZEbwD9ee0N9PhSikJBt8OTNq0yzWnyJ+5eB7Q2V+0vXvPB
         gHT+X4przbJyeb1QDERAYFqOtTUlIaP2an7MdsMBfhT3dX/XOKSBREUZeob/3TExp003
         4pAPj6NCG3vF3RmqoPkuYvrJwQGo3sQgbEctjYLEogmoJOccirQGrIynBZ9I0Ch4i/b2
         wIy89/vBXvM0qcGqxX2uAZBcLgRXJGfLZIafirvYXZEFWhduWCkZi3pCPm3mHnbB5lu7
         htzfoQQf0E9sRmos0ytPfDxgWKJ6X7ODO6Rv5PfSzl7zMZuscv7494QCA90yfRf5XR8U
         ea6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780680187; x=1781284987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uSx8CCu2zO3nvn/ay1oOlG5l2f1ymr7/7z56E0ctASc=;
        b=oDrf5ME+Uw9oOKiSlgKV+3uY7yFSRFQO4epLArS8lYZ701xu2n3dBKlXBhDKc2s9/I
         FPqXbEOzhAUx+VZYCDVwpucOUkSgj3tU9LUR57fpi8jPkIHPsqKrAWQO9RjwIEBZ7g74
         IHIqiAXm2iFnyV/B0gWHVdXw03KpAnnf+gchylsUPeCA8Yriqns4i0QxzONwHtfyjV4U
         Ck5w3+SXVHKlYbTepz4ZDA7FZni+HRC6Hr3jLn7xhjH0YKmF/jHx4md2ahGc2VmepvLK
         5shQyOngqVA4MFGB60bZNZqU4X/+J9iUfxWtcxEPP+raEUTsIzZ74Ne7iZ8tebQyiU2s
         TBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780680187; x=1781284987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uSx8CCu2zO3nvn/ay1oOlG5l2f1ymr7/7z56E0ctASc=;
        b=oxPJFSoDS93QW31x22SGeVCOwWthP1LId2L3lMTI/hu/4r6a1awVouE3wyLfqURlp5
         My7G86yIYt7QgfkjuOd0eBusca+hGsWJu/zPhy648HdFZ7UZ/ALeu06L/A9TXdZ5Dvnb
         jqGik1LTb6Q3dlJfII08/yrPMkMBHbnV2RUlx/eRpuDphkU+Cxw42cMQHxFWEjJj8Cc9
         Jya5Rqh0wwa3NqgmAggZIDNAls/El66wtoNogdaxsCdEp+Lr9x3j5G7fptoyySSjnWJe
         RUlA534IaAVZLsmhmxBlULptjuT1jNpDFPHh4IXbpyGuEbN84ZrhdcMlSPkQsIBXwNxr
         CHpg==
X-Forwarded-Encrypted: i=1; AFNElJ8IwCVjom6xjQq7ErQdl+Vvpd2F1aj2oJdVgN4O+hkH7dHzq2yBhfpAtpZgRAOL1OyeEQ4iwvBTOza0Ny9H8nE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze/pdel2BnQfkfWi+woA6qvhur35eKb8YQRFQK1aZONiizSfVB
	WdfumnZJJz8AXK/gCEvsFHqKdLeLB5otc6MA79HybUzLGeTBnDFhBhH4dqYgNEjosURRzQKzeGH
	TsGtlM9h55WLGRBy7WtI1iTcGlXLlku4=
X-Gm-Gg: Acq92OFiKNEa0he/X/g9InH4u64A45JNLkecMbg1uHW8o2atiCM66HEi7v1/obPo6mm
	wqurnXnwnu7N7xxhZGXaVUeWG/AmzV12UXgpd9glMye8X2quO2TYi6fHCYyKrxhpgjCQWwN69Hw
	zNvf4r7JihyN5N4NGFeyF5ObSQAMJdYXVMeBFMI7IsErNn9ftfi0cQ1hs0uZyNG29RwskSvfVjA
	QHtxZ5ZQ66Hw98tiDTGy9Q7ZaNK1vnCbafNGO+mq+KexnqKtHNmUj3gaj0qOH6so4+pFKi7Q3L2
	vHSzeMi9RPrV5cx2KA6fcckdicQpA7joiv+M94MT8Hev/8TPNi4M3eNULPorVLdqTUamWoCUtOG
	7XhoHkzDJYDvcV2qh7lZHQ/QKqdr0FKQ8Hw==
X-Received: by 2002:a05:7300:5723:b0:2ea:5057:a320 with SMTP id
 5a478bee46e88-3077af4a612mr1071744eec.2.1780680187196; Fri, 05 Jun 2026
 10:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org>
In-Reply-To: <20260605-rust-reverse-randstruct-dep-v2-1-93d38023b6f9@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 19:22:54 +0200
X-Gm-Features: AVVi8CeXM8Ynb9CW_RjnoK-g1D5_BN8EaZTX5irzVwTw1c48nPyBVyCslPxXk1Q
Message-ID: <CANiq72mmzfBg0_y+TMTsUUuO0cJFE0=n60-ttwOynai06_y=zg@mail.gmail.com>
Subject: Re: [PATCH v2] hardening: Default randstruct off with rust for better
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

On Fri, Jun 5, 2026 at 6:51=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
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

Thanks Mark!

Kees, Gustavo: applying this would help Mark's testing of Rust in
linux-next, which is important to keep.

An alternative would be to move forward with `RANDSTRUCT` support:

  https://lore.kernel.org/rust-for-linux/20260323130224.165738-1-ojeda@kern=
el.org/

Either the conditional (on the Rust side) or the unconditional
approaches (modifying the C side) should be fine, i.e. whatever
Kees/Gustavo think is best. The unconditional one would make things
easier on the Rust side, but it is a "bigger" change in terms of
impact. We can always start with the conditional one instead.

Cheers,
Miguel
