Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BFD28FF
	for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720712502; cv=none; b=QFoQK8dpOPviroEWoDy12QE6O0AjV2CbYzjWRofeEtqG43G5j1gNp3VAqZO6xbIVymu+KJyKPcSjFwGZNe9OKH4MpE2+JfSBfT2qXDKuI/BZJAoj6fPUWGvdxfVoJMh1lW2qdizDMdWKMavXvrtITtWvlsF1pDewdXgFEz1rBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720712502; c=relaxed/simple;
	bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=alLwOf7IlJ4KEdXXERHuJDUdi9L1cGnubO4PQgVQA7jT5gQ+ocdMx8PaoopjH/U5wRFVQH/8yIopOW4qm/JftyAoJ71PzbWAS/8Fmo0HQFsdi3aXpNnaplo5e3Q2Z2Yy3zRlV8AUjP1haaopzKEm3Jb0Tw70joueoZPdXS3FM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brWeXE3S; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brWeXE3S"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266f796e67so70815e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 11 Jul 2024 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720712499; x=1721317299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
        b=brWeXE3SDJ+uVb9dBB2XMSlzt8/Kt+uPdTnVW5lWs1eRQe9Hg1int2wXMEUbNTTXfn
         1RH5FBKOCxXIagdOLezHUGdc7b9/cCUqNcAyNVLwqvAnWt7UGsrhEqNMPyW2ScPkEMO3
         1wHjUe1OpIPZV0BjAsLYJ92n0vkiOVgoD2zMKFRNf6JJQnMC2IkLeg/n+yffvaI+W1PD
         eIAA8Z16JlkMnA1EL4D5a31Xuwu0QzxuGFFa+itBSciwh7iNUa7AvFfVEP6KLu56b3qd
         b674/XlOm4sDPm7T9XKgUpafqVJ4CI6cR2EQrsLsHw0UNBPTmVmuC/uepBC1z3cfFv5Z
         oSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720712499; x=1721317299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h74SYtaDurtWVMNe12MxjW2lrtvwlW5PQSKC1xWTX6k=;
        b=XPQoLHB+8omPfXmtTz6VNWXMe0zLAulh68OtQounXswebwB2B+ZJfza2cXfkGLXzIh
         5fFAK7DX+mBbM7nJQ7MCVovrlHcs5TvUAFm3vUAbZ9CpK+sbK5ApuSh3wIoOx+kQ0xC5
         ULDKStH4nkoaOAbDDBsSy0IpYUHGN/LKLNxJCJldgC+ur3fFfUkWhmleIyinigqTVvpi
         L5JUEh5vc7oBfFVp0/CyyImtBkUCf91txtJk/zbbSb+GkFWjFANV7HFA7GVTNPpf33av
         oygVfcO2Safd6JuSeHHSv0Gzg+K2ccQFckeLgkOr5h7mFpFBl6Oev6V1BVbVU7OZeN+a
         Upgg==
X-Forwarded-Encrypted: i=1; AJvYcCXa8qEPI6Cnhmjd+8gahlF1LFzHSaI1GgirfU3p65ifrci+sIOPC9hU+Flfiud9IBAKI61hGHTCKexyXz9ec/Af00IDoeMHc6W66WeWDz19
X-Gm-Message-State: AOJu0YwVxitzdZ0QPv35IgqSc+7eCfJ4t21H+F1ZrsLwZJzy5smi+/xi
	D561J0sJFYN5/muR6S+IXKw52gTjyAbm98dP46kuBOlmqz9H69rlMkSucktm/pxHIrCWtvB1CnK
	EXmT3zN3+RCw64MZ9kStxOctkR1XamXd43qiH
X-Google-Smtp-Source: AGHT+IHqsH8u6qwFJLBhhqu6nDqLgqH34jJy4y2QgSKBLi1LsZ+No2szVtZGkUHRDFSFjzp+JHcGZ7kloKTfhDAvrLU=
X-Received: by 2002:a05:600c:4f08:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-4279976a51bmr1709895e9.1.1720712498599; Thu, 11 Jul 2024
 08:41:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709125433.4026177-1-leitao@debian.org> <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
 <Zo5uRR8tOswuMhq0@gmail.com> <CANn89iLssOFT2JDfjk9LYh8SVzWZv8tRGS_6ziTLcUTqvqTwYQ@mail.gmail.com>
 <279c95ad-a716-415b-a050-b323e21bec31@intel.com>
In-Reply-To: <279c95ad-a716-415b-a050-b323e21bec31@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jul 2024 08:41:27 -0700
Message-ID: <CANn89iLfpHam2pcha0R3Y8OBZiwsevDEM-kbhzB2Vv5UYgC7xw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device _properly_
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Breno Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, keescook@chromium.org, horms@kernel.org, 
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, linux-hardening@vger.kernel.org, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Borkmann <daniel@iogearbox.net>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 5:54=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Eric Dumazet <edumazet@google.com>
> Date: Wed, 10 Jul 2024 10:04:39 -0700
>
> > This is because of the =E2=80=98const=E2=80=99 qualifier of the paramet=
er.
> >
> > This could be solved with _Generic() later, if we want to keep the
> > const qualifier.
>
> I tried _Generic() when I was working on this patch and it seems like
> lots of drivers need to be fixed first. They pass a const &net_device,
> but assign the result to a non-const variable and modify fields there.
> That's why I bet up on this and just casted to (void *) for now.

Right, I will clean things up in the next cycle.
