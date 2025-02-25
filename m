Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750761632E6
	for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740522689; cv=none; b=N3UlxAVMAqZB7cO30d+8Rv1yzp/xZ6jkbBz/e+vLRnzZVMXmSQjKMFkR0JoLkOutwA4ucuCj93qzFATdqvs1llBs1FjEL37qEXq1dAMMotcCOoyUFIRYwTf5tNhci98S5qUJOvjQ9gr7AWRPPbNYWV+qwjV1tcstDlANYBYaf1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740522689; c=relaxed/simple;
	bh=6ixyMCqUzAUiFMlHIYc5wUruyG75kjSXWJ52Zs4Avug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaOR8IiojIdN+xlZZDMEOHKDRdB7F8miCTqSo04fgEky7uxbwLB+qnvprbH89l0KfcOBe2scLoq6eLlXh93PkdSUZklW9bBHlev569Qv0R9z6rTiPAWQSWgJkaZfPJ3gykVnyiI0UtdolwxOBoTTC8x2mrKqRd2IodkJO+kjvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZDvCyclB; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZDvCyclB"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72725e5cbccso606198a34.0
        for <linux-hardening@vger.kernel.org>; Tue, 25 Feb 2025 14:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740522686; x=1741127486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhVJnXoXNIW2rGxv8B6ZSncID97nXixrn2BTeKZTqPw=;
        b=ZDvCyclByWxsnqZVS908FvI1fIuti3yx+FWEIV9ytpOZJ8jXpOaY/o+h6xMV8RilyM
         7AcQawnzKjmO0oXPIjiu+qzUNJKgHOs458lM26oiDv5/4XWv0b44pvNGK2ogdDa1K2kY
         9jeQ9cPpGz95rI1zQecYYcUGT/ThNvJ5L1LD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740522686; x=1741127486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhVJnXoXNIW2rGxv8B6ZSncID97nXixrn2BTeKZTqPw=;
        b=Wp+aObhMShpQ2KNMOdM8Np7MulOOdyDy+iEUibyFUpBqUMNuOLMx4PElr9u0aQyVwe
         ItGF4UIZkTTaO+If1QTHRI+mXZBYRoP7u+XRDNlhUuuSssVc9vSgaB548UDZlV5ha3X2
         fpWl8/BiSkKStTN/nvnrifSqqp4U4vHh4JTdL3bi5T1cLniPSL1XsIAvoOW5dfBEw1Pc
         JY0LgHcX44AbI/RQNF0KQAtURK5d75MU8rqiVIblO3ChXMIi1GYr81cKJOGMzPGu13RJ
         NObx74hhxH5PIB9gyEBOk9+OnIxUN8OlokQR+gTxseSJeTxo5OxvxikU8N9hwnKooffO
         BPaA==
X-Forwarded-Encrypted: i=1; AJvYcCVmpqCbBQMzuHs1fUa8039iCGuX8HBACIWo2wefulNRLfh228gsjJcioW3bJ98ukKbOaDfFjJzXxAgEw0QlVpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/IX+sFM1ciHk3j38OEy1fbdLwsSzL9HWYydyYZAhiy9Y1XsRF
	IJiFWV0v4Ex6E8aN9Kyd3OTpwL21ABBJdWGzuqraT+O/84kEFXcQnbiGIOTZmCUg/I3191DyMb7
	QNisrMlFGzYcM00nLmWCOsyp3zFz9wzNBFA59
X-Gm-Gg: ASbGncvOzXgmCuCZBlRpipp4IosDjs6/nitFda10CuddNfl9XjlMZpCyqO0IQdEx1av
	+6feKvcx3wHnD424g8GyzoK4EO9T0AnxsSMYK6SEVGs6FWKsXy5B+I8pKauQ34STqSQUpcClcSX
	R/1padwt0n89M0/AwURTlvrvZ+xQnvNKSmTpA=
X-Google-Smtp-Source: AGHT+IHoaMAAgdkvcmv5t1AQw6jtQdqKZWncQLCcLVaz8sqam9zUFQ4TMcxQ/lXq3PaVotyYolINO/Z9y4l3VyM3fvQ=
X-Received: by 2002:a4a:e9b0:0:b0:5fc:f416:e315 with SMTP id
 006d021491bc7-5fd3c5e739cmr1951152eaf.0.1740522686604; Tue, 25 Feb 2025
 14:31:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224174513.3600914-1-jeffxu@google.com> <20250224174513.3600914-8-jeffxu@google.com>
 <7e1bfbf2-3115-408d-a40c-ae51a7ffffe4@lucifer.local>
In-Reply-To: <7e1bfbf2-3115-408d-a40c-ae51a7ffffe4@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 25 Feb 2025 14:31:15 -0800
X-Gm-Features: AQ5f1JoJSfGG8fQ3nGvTUL51w2Ec0D2tO9bUoVRzqnmWDbvkaEe5CXAEBzAgSss
Message-ID: <CABi2SkXcYnSOTPHy=VYCUGA9UpXSt_2fCqF8sWS8nxrah5ziPw@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] mseal, system mappings: update mseal.rst
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
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

On Mon, Feb 24, 2025 at 10:07=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Feb 24, 2025 at 05:45:13PM +0000, jeffxu@chromium.org wrote:
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
>
> Thanks for adding this.
>
> Similar comments to the Kconfig update - you are listing features that do=
 not
> exist yet, please just list what you're doing, specifically, and avoid th=
e vague
> 'etc.', we don't need to be vague.
>
OK, I will remove etc and list the known mappings here.

> As per the Kconfig comment - you need to be a lot more clear, I think you=
're
> duplicating the text from there to here, so again I suggest something lik=
e:
>
> WARNING: This feature breaks programs which rely on relocating or
>          unmapping system mappings.
>
>          Known broken software at the time of writing includes
>          CHECKPOINT_RESTORE, UML, gVisor and rr.
>
Sure.

> You also seem to be writing very little here, it's a documentation page, =
you can
> be as verbose as you like :)
>
> You really need to add some more detail here in general - you aren't expl=
aining
> why people would want to enable this, what you're mitigating, etc. from t=
hat you
> explain _why_ it doesn't work for some things.
>
The mseal.rst already includes below regarding the protection/mitigation.





> You're also not mentioning architectural limitations here, for instance t=
hat you
> can only do this on arches that don't require VDSO relocation and listing
> known-good arches.
>
> This is a documentation file, you can go wild :) the more information her=
e the
> better.
>
> WARNING
> =3D=3D=3D=3D=3D=3D=3D
>
> > +
> >  When not to use mseal
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Applications can apply sealing to any virtual memory region from users=
pace,
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >
