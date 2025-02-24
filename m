Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5BE1F5FA
	for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740431211; cv=none; b=UZa0ZAQqEhZVCmW0HLpyNzEXR2SozhRsN3EWSyVL/XDLflXvuuGTq075jftbFdsmMbAiVro3/vz8KW0+g9pFCBNuKM3+JNXzLa6gzI04IpCBhniG4pZlCOTrpuLwcYqE7cktsfXc5MXOUWupx8xKA+2QIQGncLy+0xa4TyGmuHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740431211; c=relaxed/simple;
	bh=+B5pyJ1CO+Mbeuf4lA1Ny1LCGYQD7A/x64IGnU8BklI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=u//V//kckZNUeeCIqr4gWI8ioMlzjdmkWO0Ji5EEaMeC2srKjFXW1hJaiUE+qIU2nnDOhwdG+sFvreeKizyMlB+/htruraeIpIabpOha+uSEp+lq3CojYGAxUhNDbvQbuKIM29kBe+3MMR9wwMrYfMVT2Q1XpMY85z1z7iDbNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZqjNn8qH; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZqjNn8qH"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7231e264735so624742a34.0
        for <linux-hardening@vger.kernel.org>; Mon, 24 Feb 2025 13:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740431209; x=1741036009; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOE07JAo0aeO2qkwqR37ZGgXUL5hffDQBvOrMvHkhEM=;
        b=ZqjNn8qHs17DuTKR2HglsnikE1NGwywe2WbIWpBpLI7cS+HM1PP2Apkbb6Y7AKNAIr
         b/qpGBQBoTES/ZKvYHv6V1qDZTKzDSfVlUBVFW1iq7nU0oyRGWm9BSU+JmyXQEsncWHv
         fYxvjNwzf0DsJETff4UgTAOfPEy27z69WtRf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740431209; x=1741036009;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOE07JAo0aeO2qkwqR37ZGgXUL5hffDQBvOrMvHkhEM=;
        b=Q1oK90Vjusc8uoOtBb5QeRSreG0DhiIvF2qWUggWLHlXKBGapLXSA0YB2rXucMaDId
         n+LloyzvbbcDVjXgT57WdgHCb0JPhygWTM1x8VIGoOA5a3ds+dWRhH2ST/smTcLH291Q
         tZ/JNlKyozsKSnZYhXeHM2R7aKEjCnj8KROGRC94LkcFyXdHF+EugdUAlfMO/0jwm9aZ
         yq2CkD8eexUkVMn1jtBSlPjtP/dOzztloBB0XWwMVjLO7iZGExq4jGvJibGQTJ5p2VKC
         UnesW3bBRRcyQSOXem3ndKDl7w5egf7q21oLyLmhQQ5EOqKyyXpu5fJsBlm9ROONfVe4
         apPw==
X-Forwarded-Encrypted: i=1; AJvYcCXidwCh5AbcRZkoYecy7WbVbga8EBct1h6I4QHhXs05om3T1p5B+TANwwgE/mUBhdnZEoBHvfCxJTQxBpDWyPc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6tKdNs7G6UXX6rq++QK5Y1F1/5QitceJPl0Q08YVaq+jPIO5B
	7tf1+nqhXK4fAwFOEjwngu8V8kYCeiLsjiRtjh2leUd2yQiQT7zZ6gxzMili63CFARVlfIHWbXc
	h11k7sCGerONSqn8CPa4Q6sAVc/q2wMDfF+Ps
X-Gm-Gg: ASbGncs2yglQD5GGvQc4CRG7neDfswXawlYcnxRJNZyVwZBhaPwPnriMrunHvyADZ4S
	9+qUmHkMTFc/OdD+wJqOkFn2dPBHRz8w6T2YBcPwnf4P/hrpGASepMJrKJrTuAYC2LpPen87WVJ
	nyhfH7mozecH1EAEq6JM3b/SeyoHpOiA0q7QYd
X-Google-Smtp-Source: AGHT+IHwxUED7fRonpMySFdHn9FWsxFw+fOcub3O2dyBPDgDK2zdI7zlIRb+ojdTim+vpIhqeKMskqA8xjkLTVVSLO4=
X-Received: by 2002:a05:6808:201a:b0:3f4:19c3:8cc0 with SMTP id
 5614622812f47-3f42469ef19mr4033878b6e.1.1740431209155; Mon, 24 Feb 2025
 13:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-8-jeffxu@google.com>
 <rzhfepcwdwiq6khrepv7x7gpgynek4p54fhx4enqgyw7nubegc@uydhglfx67gp>
In-Reply-To: <rzhfepcwdwiq6khrepv7x7gpgynek4p54fhx4enqgyw7nubegc@uydhglfx67gp>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 24 Feb 2025 13:06:38 -0800
X-Gm-Features: AWEUYZmrz_kKxIc5fJOxGGLkQwCE8hjxnIZdH2BjY5NJFECiClfbmfOlu_08FTY
Message-ID: <CABi2SkVLOWEZ6vkUwZyQspz8aqBZ4yhfob-SmscA5RhNv_vS-Q@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org, akpm@linux-foundation.org, 
	keescook@chromium.org, jannh@google.com, torvalds@linux-foundation.org, 
	vbabka@suse.cz, lorenzo.stoakes@oracle.com, adhemerval.zanella@linaro.org, 
	oleg@redhat.com, avagin@gmail.com, benjamin@sipsolutions.net, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, hch@lst.de, 
	ojeda@kernel.org, thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:26=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * jeffxu@chromium.org <jeffxu@chromium.org> [250224 12:45]:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > Update memory sealing documentation to include details about system
> > mappings.
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  Documentation/userspace-api/mseal.rst | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/user=
space-api/mseal.rst
> > index 41102f74c5e2..10147281bf2d 100644
> > --- a/Documentation/userspace-api/mseal.rst
> > +++ b/Documentation/userspace-api/mseal.rst
> > @@ -130,6 +130,13 @@ Use cases
> >
> >  - Chrome browser: protect some security sensitive data structures.
>
> Did you mean to drop this line?
>
Ah, thank you for catching that.

-Jeff


> >
> > +- System mappings:
> > +  If supported by an architecture (via CONFIG_ARCH_HAS_MSEAL_SYSTEM_MA=
PPINGS),
> > +  the CONFIG_MSEAL_SYSTEM_MAPPINGS seals system mappings, e.g. vdso, v=
var,
> > +  uprobes, sigpage, vectors, etc. CHECKPOINT_RESTORE, UML, gVisor, rr =
are
> > +  known to relocate or unmap system mapping, therefore this config can=
't be
> > +  enabled universally.
> > +
> >  When not to use mseal
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Applications can apply sealing to any virtual memory region from users=
pace,
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >
