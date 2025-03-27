Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B283618A6DB
	for <linux-hardening@vger.kernel.org>; Thu, 27 Mar 2025 19:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743103470; cv=none; b=Mj+t9yks4Ec2vb7ayQu1aAuOtG3K+0C+4bnExRHUh0mQCxnrf3ZHHBSIXmnm1pRMN8M+MvaVpwQHNP3Pi0PKwMQQ8x04F29VvR4Z0Zo2j3rXmfyluq5KC/6XX+buEn2yg+XRKda7cWYyK8UoGvd5J6cbtwHG8NECF5hrRAD7wBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743103470; c=relaxed/simple;
	bh=EsU3H4aCybFj3CLx43rBcKbIVPlgG7MXqQJVjEO3KuQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggMcYOWij4CO6SgZ6LgLT++aCpuNxFbezuVnt+Ab4pTFxb/9Yn8SjuJxz9qJi7r8QFgSb5YVSGIn7xrBP4l1OFD2fHE+ldw80mwD+uokwlf8Lnoyi4avz9VP71hz3lMxJqBTcKXua/HgiMZWudsfo/HlgtimaDzohYEk51cItak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vL/RMjfl; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vL/RMjfl"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e50bae0f5bso2892a12.0
        for <linux-hardening@vger.kernel.org>; Thu, 27 Mar 2025 12:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743103467; x=1743708267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsU3H4aCybFj3CLx43rBcKbIVPlgG7MXqQJVjEO3KuQ=;
        b=vL/RMjflV8cRT7eJ7K963GasLqW/4UcGH31b0L7iZEzDzWou0EhSEagEAyWiKtRJ0w
         M7qsMhnscqwIuBbNtaMRZnV2xToj2UXF4ntc2mU3tpKtODpE2iHpz6AQwe7qGVC/ZTwq
         Pvcu6RxdMKsohmVHhbh2l7AcogyCD/tXv7amLrwd9oepAXQRR9b5vdG4JM/S/0bslDUD
         dC92ya3QYJnMOO/KGgqypkn1NaawsQZecoHlSzNyRwvWhMy+mPVUEzbl1DWZHZM7z3SM
         8XcAWiXgvKsaTTUuYFCL/rv2V5bHrsnd2CsdfEHa/J0PY1rLqrSTPI5nMg9Uy/k4m+Vh
         dIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743103467; x=1743708267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EsU3H4aCybFj3CLx43rBcKbIVPlgG7MXqQJVjEO3KuQ=;
        b=Ok0g2vIrbet2fp3AypHrQKOJMG7drizCMr7KW3d8dslbifrfx9pGrRGOOJoBdc70wf
         uJQJDxvlkKt78qHeMInJJkg8d67ov8ltvcOooNtYvGZy1PiixDIDRLMfcW4Af0gwdCTz
         fgHtgdlII02oIljizekQDHtZDexHOPG498rlijeShMQe3bUA30RmvLXuIB2YnM105tZ8
         8ERW2ZqbRB6tElsgW6neDiK+5SxjFwn40KxqTyfX6y8E0zmKPrAIzXuTUgaA+xivbFHL
         aLIHeLE4MWpOJcfeZcPKiMH3AWvpj+WJjpMyQOrrgGidLDTQOEhcaNyZ5e3UQJndPXBP
         cKag==
X-Forwarded-Encrypted: i=1; AJvYcCUaSli3Ivu5kWTej4PeuuGBCPndRWD+aYA7bDLuyDUDypkO7o8W6EBe6+nvtV/5Mqy2vfHuczZzn37f3kxChaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqTXDCZprZPq7GYlRTUgrk/3CDWsMAZaoVAYAw/sEJmmXQiTM
	UwVGiqz0BqIkcV82TYoKEJ0jpmubE3ZlXVW/dFOzaopBtPAdDOvIiLgVrAK1hlIFH8q02hYChfd
	a4uFs/6EabwZHrPbPtIWs9iuqZhdnhmREhRhB
X-Gm-Gg: ASbGncuVG5YyFmuGh9FqD+AQFGDlQ19olHa1Wn0aFH7ELfnRslmSSudXtYDnsTl26RL
	fSI6V9cPAwgMvowXGjVEry0iP5lmqRZUl8914DvraRRPoyjlnAsgc+5KkW8dDBOe4bSCyA/Ypp1
	4netoUS28W6nIN/BJK6/cZHL5WpnLCgFvYfZVxpUwmJ4vvA0X65gD+xQ==
X-Google-Smtp-Source: AGHT+IGz2ptWnJMKCpVZRXSHC1BHv/EVsDD4zvp/wvpIFLl5pTpvPZXT6zLp1OS7qFkNx/ZO9sL+QD6VpMJEETNWsBc=
X-Received: by 2002:aa7:c7c3:0:b0:5e5:c024:ec29 with SMTP id
 4fb4d7f45d1cf-5edc24175a0mr19555a12.0.1743103466604; Thu, 27 Mar 2025
 12:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321202620.work.175-kees@kernel.org> <20250321204105.1898507-4-kees@kernel.org>
 <CAG48ez2-stu91bgZawx_AaypEuMnc5=nJQUiDzUCb+CbsJS6kw@mail.gmail.com> <202503220003.FABF5E82D1@keescook>
In-Reply-To: <202503220003.FABF5E82D1@keescook>
From: Jann Horn <jannh@google.com>
Date: Thu, 27 Mar 2025 20:23:50 +0100
X-Gm-Features: AQ5f1JoZQZxm97U6uQ_soQO_EMulXCDu3MvlZ-E2JGUgvp9Lprl8N4F8RaVkeC0
Message-ID: <CAG48ez04KBTTqPF9JMQu2uBde3SxUo-_=mwsxqr6B6+Fjyd57w@mail.gmail.com>
Subject: Re: [PATCH 4/5] slab: Set freed variables to NULL by default
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Marco Elver <elver@google.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2025 at 8:18=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Sat, Mar 22, 2025 at 02:50:15AM +0100, Jann Horn wrote:
> > On Fri, Mar 21, 2025 at 9:41=E2=80=AFPM Kees Cook <kees@kernel.org> wro=
te:
> > > To defang a subset of "dangling pointer" use-after-free flaws[1], tak=
e the
> > > address of any lvalues passed to kfree() and set them to NULL after
> > > freeing.
> > >
> > > To do this manually, kfree_and_null() (and the "sensitive" variant)
> > > are introduced.
> >
> > Unless callers of kfree() are allowed to rely on this behavior, we
> > might want to have an option to use a poison value instead of NULL for
> > this in debug builds.
>
> Sure -- we have many to choose from. Is there a specific one you think
> would be good?

Forgot to reply to this, sorry. No, I don't have a particular one in mind.
