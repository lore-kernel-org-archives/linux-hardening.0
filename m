Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86533221D80;
	Sun, 20 Jul 2025 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753042363; cv=none; b=EyoZOE9w2+Ca0i63G5fUVJhV1scjbMyRxJlhg1jIM8AKg57g+YInDhhmzX8qP7zMJP73s20TDDoEiuLtLCoeyp/09qwwiArd8ZI3I4T7s+rPNUf1ldaZ4o9nJ9kuPn5krMNdGJV6SYBtwPuIcDSA8NqRsU5tOhaPm7YrLzVIE7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753042363; c=relaxed/simple;
	bh=SpnUeWa4iBYi5sLuPFGfCFkry72Jp5Kw04SeOFJYdQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AH2g5PD4wFdETkodU5Bis5XuqsIbm8DeL3D92PZz3QUlfJeYqnduKKZ1rnnVdzwDrEcyk12HxhSMUybNARyLOT2K89gSXo1+oE+qqiJW1u3eMJu9kYKP0+8jcH8VBSZyOvaMAr9SU7lASgXyRB7e0q3QAg2bO2SQpmh88I4GwwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZESzMS72; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZESzMS72"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-31308f52248so558867a91.2;
        Sun, 20 Jul 2025 13:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753042362; x=1753647162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=etzXpykV+IAsHrqvhUJ2iZLlQ0JMugH8eiLxcqfvD5k=;
        b=ZESzMS72goW9yAYY0N8FGSxoaFoBsj6d/PmfDRE900yN7e4Q1T0E5Src8wUIvYvRuS
         zv/fWMgROC6hwTwKuMtyhT1rL4qrU7NBcY6gcpSyHqpaMy5SukbBnYpQna/ge+wxRkpO
         8lRZ2TC5UJzA26wGBMs2TvkBGy6jA/mAxlIDyrzDqqOPxIShvCVfSbMuIywNEnM7Gy+j
         QHQaYq9LC/9re3yHmwJDuX+bqQ3Ta9tffC2QHh877r+az/MllFybXV6FTrsQ4qVO4rIR
         tkwRaGivGJl2IlxMI9tMc1nHRyfDDxySm3U7ctVezEZTV85noY0w3xmZSIlGt5s7gzrS
         oLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753042362; x=1753647162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=etzXpykV+IAsHrqvhUJ2iZLlQ0JMugH8eiLxcqfvD5k=;
        b=vjUkGvmQQI4QtcUnpc/uzsuMqn0n0SH0gFrf5iw/jsmJZ9Dy1hj9iRqnFBr7U6X0Te
         s2zao7p9wYart7M7AfU99fP+74z+lUyVW2awBkI95KSHAOE5EwWY/RN35S2+IBNo6v6f
         OBboloTLIiqoO8mjlKqIxHfhYiyXuBaudBsNlSz8Jw3MoUrMFmEhQWebXOYkP/zYwQCX
         1JuQXpbU8Bw1Jq7Xfx1iZjHp04oDars39uzRMVFz0ZYp8cfRgBoqy5NznM1xGs4csd3V
         Gy/QbxdUyyroEYRwjk+kylNuDV31LUrtglHOh+vV5e3SV0i1s1odrvtNXXj8+drhWs4Y
         hb1g==
X-Forwarded-Encrypted: i=1; AJvYcCVGWb+Pkddlmk2fC6vFm7GYLq6k02RhXR6AqlS1Xq4rCruYai0NaZakfu/01t29av675UFGR0TYziAEEIOr@vger.kernel.org, AJvYcCXC9jU1CWKMPbWm2vnDiuEbva+gRL1YkRoFjXKgTyfelvjDrTNWBlSfDk6HNQbnXTHmXLFUv6uVkjwkSL503QM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBV7i+hu95SRjPG+rtXjdDy9ESOF4kbwa0OZxAaCu6SKlwZeF
	RDjr+/U3OEUudEJh2r4/OXtYKAzUS0a7nQhmWAFvUcusWjibOA0vq77ZbI/f9AvOpzZqcuaKC+K
	QdVTLKIJXpgc59aPXPOVRXB5X9KYEpplU9XyeBao=
X-Gm-Gg: ASbGncsRLFMN0njDKczHj6752H/3itb8NkKWmOKv1Bskil3y11cbj2I7JJRYkSjjBy5
	B7spuy3/L0VTCF5TuKzvFcmiwFupaRbsaf2VVoAhocseeX5KR09Feu2wWySBwuEaAYVpP11RKGv
	XfbjP8xJIpHsCHuuoB+g9+N0Bjj5GZriwixsjR3l1GSzNshVw9gbfw1BeDy+NbdL4dwDewiUQhU
	zIx1dfn
X-Google-Smtp-Source: AGHT+IHaf2vQgbbOXGHUrdq4gopF+bBKLxRIRv2pUm1D3d9SJ9v/Cu2UvI6qDhehsJ9HXQbSIbNKuJLWbXt1J/Bgey4=
X-Received: by 2002:a17:90a:e18c:b0:311:a314:c2dd with SMTP id
 98e67ed59e1d1-31c9e77394emr10209840a91.4.1753042361675; Sun, 20 Jul 2025
 13:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085300.work.146-kees@kernel.org> <CANiq72kPmb+7Ygk_Qvsiq+22EJVSPjjwn4whdLuTGCPwvTAssQ@mail.gmail.com>
 <CANiq72nqg79xB=iV4GCH8XCak2jCn+XxUX4Hm1s6n5L=5cLuvw@mail.gmail.com> <CABCJKufPphD3en91N89yekUam4Nv7+C7YPJMv7h2SmZcyhGhdA@mail.gmail.com>
In-Reply-To: <CABCJKufPphD3en91N89yekUam4Nv7+C7YPJMv7h2SmZcyhGhdA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 20 Jul 2025 22:12:29 +0200
X-Gm-Features: Ac12FXwyfbcRSAsV9U7kTZFZ9-dp7QOJairlY32p58YOVbnTtpCxcLWD7oKvd_E
Message-ID: <CANiq72k6ggtS-TCnws0xY8K-w=+vjGSjaXR-OO5YG=DGAjnsug@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Add __kcfi_salt
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Kees Cook <kees@kernel.org>, Bill Wendling <morbo@google.com>, 
	Andrew Cooper <andrew.cooper3@citrix.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 6:48=E2=80=AFPM Sami Tolvanen <samitolvanen@google.=
com> wrote:
>
> I would definitely like to see Rust support for this too. Otherwise,
> we would have to drop the attribute when Rust is enabled to avoid CFI
> type mismatches with C code.

Thanks for confirming -- added then to:

    https://github.com/Rust-for-Linux/linux/issues/354

I will ask upstream when it lands in LLVM.

Cheers,
Miguel
