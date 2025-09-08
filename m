Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB77928371;
	Mon,  8 Sep 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757324019; cv=none; b=PHi46GLP6HbZny8dPDTIcYOqutax4q0Kiw0wNc4Xqkm5IogVhYa7+cJ7hlKNxYlMrp4ihUihRY8ALSemyAi2cyKxgUr1/B5+U42d2KvWR1QUfD3M11iQSbyB8GPXZCHJSTIr3oiYqN9Bce2L537PHyWdn9Rn2hIWNctjQTsjj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757324019; c=relaxed/simple;
	bh=4N7sU3JohQrUG2r7MiAGOsiUCYczh3I5Cl0N+2WODUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDpwCjWenNnryhvyaCXRCr6YtEmLK6CnkUj9gPXFtH4KYTWYx6O872oA5Cz4V5HSUgsQYUaiEmMjcuLfOaTR1fjtDMI63HYtuUTW28gVBQZpI2HYJDw8z25F+dk+rvB4BsrMzdLxHV227mEb9I7VZwenTQAHXrS8pjqe1CnrlLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LlKdvFJl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LlKdvFJl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-248f2da72edso8079325ad.2;
        Mon, 08 Sep 2025 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757324017; x=1757928817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GVCZ/gngEOLdEbcJ0f6AlVyVeJgk5mzDyv8QQ8+iNc=;
        b=LlKdvFJlspci8mwr/6zRY/DSvyNb+RSQMqlIbeIoi8aoYwoG3Z25smh/YzrAEUTg9U
         4mQSz7kmFV24KsxixXdW+BF9EQhklD1iUDiGZRjGvipLxnechQLSgnUMMIUOnBpAt+Rx
         XQuUmLnH9/s1amcMnzAW3np61h+aIsMaSXG5LyDjUYcikAV5vclOd5YnuWZJopGes9a1
         9uCIVsBv2i7Jn4kvbKK88GBBfsgv05E960+CzeUgnsbN9fUPLN/3qC1YamebEpNzLuS7
         E8irNEXrIRPjlTciGTyQz9I7+/No7eplPRL9J0uPS+hqwJ9D92Oky7GLDgOeCjKR4HHp
         VFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757324017; x=1757928817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GVCZ/gngEOLdEbcJ0f6AlVyVeJgk5mzDyv8QQ8+iNc=;
        b=QHcug7qfNr6RGFiPR8QH8Ub7TwtdtWoPo0yvewVLG0XOaL3zghc/AbP8X3uVeIB+y9
         3DxZwAMCV9QZIDcOD3inx1GymJE4dGqoS2Jt/XPwTYXnE4hY4YKxy8nrWMEIM9M4sh1F
         /rRzVinwsggGORklRzmapEFCmIkqnd6gEOlpQ+wOPmo3Jb/PxCz1vFByWQRcE1zRGnSy
         C1ZUTx6fW+ihvNskgvHLxheNQq29X3uh1thcqCDUBWDqDFC4DyCOu6na4aQ/X7yl3BHw
         6HW1KU0DEMi7Vj2r/rsE0b6zyL5EgYxodk/1kxNtD0z3V02ZIuwTMCASsL1Hpy+xzluR
         /F1g==
X-Forwarded-Encrypted: i=1; AJvYcCUKGvBj+89MMNm6rxtmoF9/e0v/TIvetyVQjSN0NJy7zHv6+PCw/FbcC0GqWZLV7gQxw5KP4oMwByzmDdBA@vger.kernel.org, AJvYcCVSOqnxvrd64XPWeTCvYmiB7bzw7N9GkQmDVgETr8sury92HnSOFEu9ZeMkxIOob0QcctPqiZ/NvRL1OGs2Aac=@vger.kernel.org, AJvYcCXRO/K9r8GST6jUqD6s8Yvp5P5gMOI5HzkEP0VsYgmESm10HJo58AAtWfTw63qtVY11SJ7E00WgPC+rrUIutGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioKFYBqFeSfSuMqXVp+nLP7dX87Sx+vVxUAFw9S6d7nmAk0b8
	t+67LLgPhp3ANmwM/pru6DugQKDgm/o5+Z02Td+HB9u6MFVeLkTc4AYAB6+/8jIXCMrpbrfqLC4
	EeKM0AmlUyH8CJru+K+r3OM/0vzgc7ZA=
X-Gm-Gg: ASbGncsgTT8mkwfniePAxiHYmGSlby+Zi9qV/rfwWWdNTSaOmtyHPJvILm2TVSEWT+X
	a3Fy7xDDDU1Z0x8d+shtt6gzoO39TyGU2wO4UsNLc6iq01TT1R5s8qqVQ0gnnX5uvf+S0epGkPy
	IT1frZu4B8EprB6oVQt1uxkfNRa1JuPsSp0WXWOyq9par1OK6Q/1pqOzD5mRdP89/qkZQ6uqaN9
	tn1tLpez56YWB660egTD5/4neWbyPTX0xP3NEa4DEvdlDrrqJ7HG4NARw8AMXSKN5hO3lTix3C4
	SOMhzDGJRauDc5MDJfM4efsTLQ==
X-Google-Smtp-Source: AGHT+IHZfNZ66eWTliRoWPygdmpq7QBeW3Gn6kptoT7wGKiJrnBL2SmaOm/t/QRgpwF3tV/SP7nh5rKQ7kQxb4RDpgI=
X-Received: by 2002:a17:903:1105:b0:248:dd61:46e8 with SMTP id
 d9443c01a7336-251715f3134mr50913805ad.5.1757324017041; Mon, 08 Sep 2025
 02:33:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908072158.1041611-1-bqe@google.com> <20250908072158.1041611-4-bqe@google.com>
In-Reply-To: <20250908072158.1041611-4-bqe@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Sep 2025 11:33:24 +0200
X-Gm-Features: AS18NWBzRHbQYus8Z8q_SFu3qyg1LAf-Mxx68bs57orZCsMPCs28Xd6Ew8qF2IU
Message-ID: <CANiq72msV_jLFDtA4LUk01W6WF_hJEivdeKyR14xmA6ocYx3RQ@mail.gmail.com>
Subject: Re: [PATCH v16 3/5] rust: add bitmap API.
To: Burak Emir <bqe@google.com>, Kaibo Ma <ent3rm4n@gmail.com>
Cc: Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Carlos LLama <cmllamas@google.com>, 
	Pekka Ristola <pekkarr@protonmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 9:22=E2=80=AFAM Burak Emir <bqe@google.com> wrote:
>
> +    #[test]
> +    fn owned_bitmap_out_of_bounds() -> Result<(), AllocError> {
> +        // TODO: Kunit #[test]s do not support `cfg` yet,
> +        // so we add it here in the body.
> +        #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
> +        {
> +            let mut b =3D BitmapVec::new(128, GFP_KERNEL)?;
> +            b.set_bit(2048);
> +            b.set_bit_atomic(2048);
> +            b.clear_bit(2048);
> +            b.clear_bit_atomic(2048);
> +            assert_eq!(None, b.next_bit(2048));
> +            assert_eq!(None, b.next_zero_bit(2048));
> +            assert_eq!(None, b.last_bit());
> +        }
> +        Ok(())
> +    }

For context, Kaibo Ma already posted a patch to solve that limitation,
so we should be able to clean this up e.g. next cycle:

https://lore.kernel.org/rust-for-linux/20250907201558.104566-2-ent3rm4n@gma=
il.com/

Cheers,
Miguel
