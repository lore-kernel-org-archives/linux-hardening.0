Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D973FADF6
	for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 14:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363338; cv=pass; b=Sm3uTqbaUsz/0BpbYMppR8OtUisA4WuNWTsju+fNARFJCe1glZJtkmBYeSGP80VZIBeklB8rjgHLTLNzHwtr3c6cBAtmkyFRBXAs3wZiypEOj1iEjXilnifxKHiN6x22iNot4X8wZuVdM/Ie5mKK9kCz6Op1vHj5sH1tLOKKs0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363338; c=relaxed/simple;
	bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EvLucoosQrIy2ZpAZHIwG9MPuvXZjaYbO1tlv4J5vUi3vmteQDzyW/pXs5xgsdeC0CiAoO7O9m4kj8m1YgjKh++UygZ0yrHGN2ioN9KmczSy8LEnMbBTiHffTiIMSwLMhL5wADtHjqF4ZbOtJH70QLG6jWUrtHUPtnwQeNqvktE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=If1AlV2C; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="If1AlV2C"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-486fe655187so51417605e9.2
        for <linux-hardening@vger.kernel.org>; Tue, 24 Mar 2026 07:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774363335; cv=none;
        d=google.com; s=arc-20240605;
        b=EN8eyA6YJAoTzmT27Ed3sVMNbWTUwVb++5yCVFMrcbDUlE84ZwHG4HzPchH2IdY98B
         gYJMkyegl4E4osELo1H9OUjtyenc61JA4PwIg9LY0S4QMuYUqSjdqjjgLpg5VWoGF0Js
         COp+xWO4XfoU9l7u6X5IzNMg55A9D4Ob46UuwCa+TSvjlgn8AsYelBbtQ1RWlXo85l1J
         y2lieXRwgx+cBUQjB3yW/MegZGFaM44bCUN/JhEPNP4Op7e/517k2jcRqnbwRS7Hmy4S
         yNdFJo1N5nq0Qo0FuHTcFHtm+BapTj09Yqj1PFsrSs6AcUpo81pZ97kAL6g2shwPq9YS
         WGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
        fh=vdlmm0KzuhSHBRBEDBynVpSgHGwzgXi0PYam9CMnzBI=;
        b=ltWYgdhOWye08aBzcTFK565Sqiul5d++/StGVJcslrV1KMKgbSt0pPr8t9/LyFMUcL
         cAQ6EvZNwug8CUICQa2IQau6xze41SZ6UDJ6KNx4+QtylVsRzJs0X4QfOhWSFb8uxaUZ
         KNLOiX/JLbu/iuWuR+b3bcxTjRV5iLTWjL5zpBq7IatQgLIDk9DCK2RCj6D9XF+W1z9P
         xVivWoJ0DwpZQVzgl4upztJZvTcnPJGDUdONpJvU0YiNBmQwFuw3/vfBk2WWtmAlgtgJ
         BxSF4u/QXa+8BIxNDSc/8gzDpedBT56FG1qHt9ctd9eycpOdE5ftHqoS2/gv6hyWrlSk
         leHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774363335; x=1774968135; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
        b=If1AlV2CEAbeG7fWh//nwAEAFH9XDJxIGv1UVVQF1+ocV/9pNywOhj5BnueBxVBwih
         PEccSlnPTjbgvEKoOA1A26J438YnWj864anbytEKm3owPA6lbARuwOrphKDwtuNAF0O7
         Mip4CTNeG4D77YZ+qZldsq1W37icY4s6usxtWpoZcfkvWX/LzdZzNxFy3X95bRnYoV2X
         FdHzMbjc6adZEgp3GFkSFeLj8PGF7hV90KtwtPWnmsUyYa9tH23Fqgdbk8yB5jzMvywM
         PRnv8vYjx9b6BkNT4tO+WS9EyLBYF9Ki05ViXzAKIipFia+NO3Nkf8Xe/nq3HXIPyqek
         ZmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774363335; x=1774968135;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EJJwrBg03w0qylq/CHDsteukON6L2xX2lFGJ+zhUWN4=;
        b=hddx4BDsfazUSOZQumx/drfCbXPnDf6c75iGoo2ie9f6Zeh78bQaZYSHkD9qGIcjry
         9aBWKw5bPu/4ge3gI4QkMkDE9cZ9kETzv/7eW4jeNoCWvDzgxJWPvZ5vrKA26oud/bJN
         XZ5j94FZ7+ppJ75R8cDWKQJPGTT2hdoOwx2PddGMtd6z3XPbghcMFLvqKLxeklUQCiz0
         UP6H11XMQL1T4/zwkYF532j1GA31Z0PIhElSar0hLx+TTPCRTwrOkkzMpEHxXbDd5rmh
         ZjZWty8hzssUbB3P8txnULr4DYjlRRp/OwQF5Wwaw2WM9Ko+lG7jkpauM/GaJG6kIzu/
         b4uQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0jzBGQ9BTdE0hJzNDzCSMci6B0nGJg28MQlHqDoQj8+HyR04Hnu8r2zlonCKJcM8dfq0hM0jVmPTLVQyEOwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfD+khsXLpJdNZvE4QR2q8wrDgyNnAJ6SC4nR2uNASrkv9HxhM
	ky0X8Rm0Jx7rjkapEo3WyaGSZ/XZwHNTxTTVNJTqRgecZxcT+F4l40JjCg03PYWdKmpUc+F1lsE
	YtKJocvJLyRWG9dFknbWF6Ij7w7j4sUM=
X-Gm-Gg: ATEYQzyMGxCYrA8Skxqfv0y21+tP4SFfeLcVI1uojdogz9l644IMNSZxC0EcK8co16W
	y5SygzWF/gzo0TdiQoDTvWiEXt4lS2GiOlcjtGcHs8wWxnsgzfZBpFRQHSIlaVSHXrnVUw0LA/p
	BDrclK5mzd1zg3GlwK+usV6LlYDKg6VERrBJerODl/4EjyT+UFmXAl2mgHgYLTU6rm+50Pz2BQY
	grJRYHAUPBuL2koZpft3oF4waObFsNnOjZWxOXSjkdGVBAHEjBN1PtA8mFX96jT3y5IxVuL+u/V
	KqMKnl6cy44ix4ydyWipg5MZtLU8r3QIyxZduHPxSzzcEkuu5UgSL2RHMMiPGE7po11cVvTWyzn
	1fWZL6PUr15xzU8zdt2VFyhKBAA==
X-Received: by 2002:a05:600c:1913:b0:487:1fc:14f9 with SMTP id
 5b1f17b1804b1-48715fffe21mr584595e9.15.1774363335176; Tue, 24 Mar 2026
 07:42:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324040535.work.851-kees@kernel.org> <202603232224.C1555BF@keescook>
In-Reply-To: <202603232224.C1555BF@keescook>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 24 Mar 2026 07:42:04 -0700
X-Gm-Features: AQROBzDGuRSiN3hT9ODz0-PK-04DEkgU3eXT4KkiYPJTEFTkJ07mFjqnANlESZk
Message-ID: <CAADnVQLhWURvQ=gBYQvuEa3pTxabYQYhrPm9QG0gbxL9ee=vng@mail.gmail.com>
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

On Mon, Mar 23, 2026 at 10:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Mar 23, 2026 at 09:05:39PM -0700, Kees Cook wrote:
> > While the original strncpy() would have copied a full 16 bytes from an
> > overlong name (producing an unterminated field that the syscall rejects=
),
> > but this wasn't a reachable state. This replacement will instead always
> > truncate to 15 bytes and keeps the NUL terminator, which should have no
> > behavioral changes with the present code and avoids potential issues
> > with future over-long string literals.
>
> Hm, I got a failure report, but it *seems* unrelated? But nothing else
> fails that way recently, so I will try a v2 with the "unterminated at 16
> bytes" behavior restored and see if it passes...
>
> test_progs_no_alu32-x86_64-llvm-21:
> https://github.com/kernel-patches/bpf/actions/runs/23472955268/job/683004=
40546

Don't fix what is not broken.

pw-bot: cr
