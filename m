Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnBLlceT"
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971559F
	for <linux-hardening@vger.kernel.org>; Mon, 11 Dec 2023 12:47:56 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3332fc9b9b2so4508529f8f.1
        for <linux-hardening@vger.kernel.org>; Mon, 11 Dec 2023 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702327675; x=1702932475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNFFKTdQ4QRGU3jiDsgZw6qRsjpUS+kZ+xjPJ/qMrTI=;
        b=EnBLlceTcSSyp37RP4ztHPHpitRX0yRJR5QhD3ot4GsLp+g+f/8eNOOeswU1ZSKGDZ
         piCx9vSg4FtLvebqSTp/N9SczyhTK69RfXM+8ksmJaGy/cvm7rEEN8YG/37/3B3Y+XSU
         TUl/QBtllRecfzYUi1AVR5KfmMedrdn1TEha/0pSa6ucKPvl42jxqF/nOWRa9RwawmTf
         gfPSxJJQ8l1X6VbuzYuN2C9FbEC7NX1f7+I5QdzDsnQQrfC6vBv4le3SbnKovWfupGqh
         jt6/UqNifdK/wgP/OG4efIotAD88WxVJbLvmA8ysXUbVe7ZCw0rCZTg4/3uhl0gYOA6+
         7AMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702327675; x=1702932475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNFFKTdQ4QRGU3jiDsgZw6qRsjpUS+kZ+xjPJ/qMrTI=;
        b=JZ4oSZaeN1Q9hcraOMIMqHq9kz2ebffKOW98cToTnt41EvttWlh005alEW4NuL/N9V
         gIioP9ucZQcES39JcSmzJljlRjGqVghwGIx3PQMEnu+JGAFj1P938LcS+q7jCGLMeJgw
         HtgnBymuHPx4pryaArpCqHKt5l48aOGvRjOg+n8q3OAevdVGnQnEeBvd+6RtkXtWfA8I
         t/zUAHNc8qhdv+8/oJxmBl3J7jVOCP7TpeWqRTyWNUQdY7Aw8kLiZPcYkwBYLkbFVXc6
         utKLfSDcmkVdjJK9zsqfe/g419AP/3qrgUZ+dhMbx+cLvZCasqznFO7KPg/k63NIGaIb
         DKYQ==
X-Gm-Message-State: AOJu0YxyAiAvjVpFOj90uRVCx9U5NjV3ESEDmXwplSqafhJ34kv0b20T
	zBpPEyfm/AwXoQ2F3gKE9xBe8pFP42SKx0sN0hsZkA==
X-Google-Smtp-Source: AGHT+IHwCiI9a280gfixWHYnlXadu2DnALRqwi1TkFx8Su2VU6cZ+QOy+Dz/bbRdlhSki6Dni8BtYfJKHIclqEDVHoc=
X-Received: by 2002:a5d:604d:0:b0:333:2fd2:7692 with SMTP id
 j13-20020a5d604d000000b003332fd27692mr435092wrt.131.1702327674923; Mon, 11
 Dec 2023 12:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205-libstringheader-v1-1-7f9c573053a7@gmail.com>
 <20231205130449.8e330a26ecbed1f7b5ad5d7a@linux-foundation.org>
 <CAKwvOdn+VTM+LY6ALcgaZTL57JpiKt5rBPMSPNXsgS3MCENhDQ@mail.gmail.com>
 <20231205132452.418722bea8f6878dca88142a@linux-foundation.org>
 <CAKwvOdn=og6h5gVdDCjFDANs3MN-_CD4OZ9oRM=o9YAvoTzkzw@mail.gmail.com> <20231205214359.GF1674809@ZenIV>
In-Reply-To: <20231205214359.GF1674809@ZenIV>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Mon, 11 Dec 2023 12:47:39 -0800
Message-ID: <CAKwvOdkC0oHWKGJ1Z6k_U9cwkjdcf=iweG-G78jXSJgWFk86Jg@mail.gmail.com>
Subject: Re: [PATCH] lib/string: shrink lib/string.i via IWYU
To: Al Viro <viro@zeniv.linux.org.uk>, Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, tanzirh@google.com, 
	Kees Cook <keescook@chromium.org>, Andy Shevchenko <andy@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 1:44=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Tue, Dec 05, 2023 at 01:39:47PM -0800, Nick Desaulniers wrote:
>
> > The tooling Tanzir is working on does wrap IWYU, and does support such
> > mapping (of 'low level' to 'high level' headers; more so, if it
> > recommends X you can override to suggest Y instead).
> >
> > arch/nios/ also doesn't provide a bug.h, which this patch is
> > suggesting we include directly.  I guess the same goes for
> > asm/rwonce.h.
>
> See include/asm-generic/Kbuild:
> mandatory-y +=3D bug.h
> ...
> mandatory-y +=3D rwonce.h
>
> IOW, sh will have asm/bug.h and as/rwonce.h copied from asm-generic.
>
> Still, includes of asm/*.h had been a massive headache historically
> and breeding more of those shouldn't be overdone.
>
> More painful problem is arch- and config-dependent stuff, though...

Ah, it looks like include/uapi/asm-generic/Kbuild also makes use of
this pattern using mandatory-y.

So I think we can handle this as a two step translation. We can tell
the tooling to 'nevermind recommending X, always replace
recommendations for X with Y <for raisins>', so:
1. any recommendation to use asm-generic/foo.h should be replaced with
asm/foo.h (always, based on those 2 Kbuild files, could autogenerate)
2. some recommendations to use asm/foo.h should be replaced with
linux/foo.h (not necessarily codified anywhere; depends on if there is
a linux/foo.h, will manually curate this list for now)

Orthogonal but some places in tree can be cleaned up to include
linux/foo.h rather than asm/foo.h.

Does this sound like an improvement to my mental model of the
conventions used for kernel header inclusion within the linux kernel?

Tanzir nearly has the above done (for 1, 2 we will probably need to
iterate on more).  We've also beefed up our local testing to test more
architectures.  I expect Tanzir to send a v2 of this patch (as a
series, with the fix for ARCH=3Dsh) later this week, if the above seems
correct.
--=20
Thanks,
~Nick Desaulniers
