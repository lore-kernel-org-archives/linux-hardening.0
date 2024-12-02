Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9471DDC20
	for <linux-hardening@vger.kernel.org>; Mon,  2 Dec 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169917; cv=none; b=T/unDIOfRgJmUynGIgweWwPUbXJ66Wn+DmRKARkh199RhDcxFl+RAJ2KGn8CSto5pSPBcECCoip7vo0zhGmTihmRnUnoohLwfYCnVLLJZP3akDyZv7oxU/Vt156N4s0gXsIz27L+HB76ljaKkgj5hrvSo1aqEDGm6ROJ8hJHsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169917; c=relaxed/simple;
	bh=MfTdxT/ee2Pn+lgv8IaKg+Ej2iFHm5rcJmdyskYTVQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X389UfKx1g0LGPPlcq3D6oKuNS9Bz3ym9WTYMPkSxG5Eh7ry0r296wJvx4bG+Ej4iXFBH3vhhnfWqLkm7UHt5I4BZVNkxi1eJ+PBvyB1T59TJYQWcTyCrIvm4ur9oYM3NDvWINWdolbQskPE8u3RhD9d56ru1M8XIk26xFF1yHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LKg4gutb; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LKg4gutb"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-71d3fc25a2eso552882a34.3
        for <linux-hardening@vger.kernel.org>; Mon, 02 Dec 2024 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733169914; x=1733774714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bf8kBob7N+zrqpvEKZnEpktIy618/JwhlZLNzkT+Qqo=;
        b=LKg4gutbro73CAL5JJnJuCX5GlhnF4H2bJBK4xOfKM7o/3Ntz01kV+4Ih/Mmsg7bhI
         XNi72tUpcXL5n1BKXMDW8Ko85OD7xTptCs8b8h+fiSW/bh1gXVMfHu60LM2Mbo7LrjLn
         AWukHK4qCI1ryAsHrtMI9UGXe9MaMs7yDrSXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169914; x=1733774714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bf8kBob7N+zrqpvEKZnEpktIy618/JwhlZLNzkT+Qqo=;
        b=K23prysSkY702rhod6dzOVaGrX5Luq3Z96R0BQdDO2LDO6zrqM0U2iZpNzFQ0QIyzL
         ZONr7+MvSWmZk+hw6hEG9TocYOd+9X8X7nCeeyvH2jJR0EjnrHmQjVFZZmrmRhb9EFvj
         IBDoWt/UCPA2Lt6wdEvRK20Uw06+1EkAiw6ebumE8PAjqP7ZLx+qCKmzfcQ6b2m60PKr
         e6Qpx2qeWI8roDjKZzutnUKCChvY0Q788Nu3SXb9HIjnQYv27borTzT4E777OYEQxWqD
         70Kyc760mLRDxbdOvUK7PP4wrotv7h+VDxskpJTOgiSqSGhOfK35uK6uKpZX7b/RgcbR
         s9RA==
X-Forwarded-Encrypted: i=1; AJvYcCV+FScRZOpaW3AEE0jMZHLUV76moROfYUnKhiT8ZEi2Yw3+SevWq0KhvLUZkQUQuDXDFF4QuuJZy6M0ZpyKaoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3v3JCnX9GI0FCczXlbOZIJuwpj3sdJZBWmi6jgR0M7WjLzB9t
	iee+Yu7i1nHDvCP+fM2Hjk/CMa2n0NFeX+qagLFObzZOOpb398xSR9JByjdpXG4sP5TZXK/oqK7
	F2KpALFFmsZgIeWCbBuljQ2Gk/Z+l0h9l/q6S
X-Gm-Gg: ASbGncu2Aa6N5pNP+OUSkbr+RwchvtoxEUgRpBy+BuycGN/xAD820P2JBcU2ZJi/3KA
	0viXfbT2sso7McmkIoXzKCNSbeof97YeBdrbg1COK0gW8uvL1NrxkcclQCIo8
X-Google-Smtp-Source: AGHT+IH3t9USd84fCmCXjOCzqCQ4JB1S5NtY4dFkzxriLvAmrlk197UYZRHaBgLaOYTA3iviLUIOVZJbObKsBSEcwsQ=
X-Received: by 2002:a05:6830:3106:b0:715:4e38:a184 with SMTP id
 46e09a7af769-71d65d02467mr5511046a34.6.1733169914339; Mon, 02 Dec 2024
 12:05:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <Z0Tgp4WBPvJiojqG@casper.infradead.org> <CABi2SkWkD90ghRHO-1eV9oA9C2sy6Sdzj+3Z-jLzrm6dVGDXvQ@mail.gmail.com>
 <37817840-66d5-4208-b5d4-5f941ea6b95f@lucifer.local>
In-Reply-To: <37817840-66d5-4208-b5d4-5f941ea6b95f@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 2 Dec 2024 12:05:02 -0800
Message-ID: <CABi2SkV9=LPYfzO9eWZmTxrie_pqLEDmv0pcYHwtRcL4Teuzfw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, ojeda@kernel.org, adobriyan@gmail.com, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	hch@lst.de, peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, 
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org, 
	ardb@kernel.org, Liam.Howlett@oracle.com, mhocko@suse.com, 
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, enh@google.com, 
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 9:57=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Mon, Dec 02, 2024 at 09:22:33AM -0800, Jeff Xu wrote:
> > On Mon, Nov 25, 2024 at 12:40=E2=80=AFPM Matthew Wilcox <willy@infradea=
d.org> wrote:
> > >
> > > On Mon, Nov 25, 2024 at 08:20:21PM +0000, jeffxu@chromium.org wrote:
> > > > +/*
> > > > + * Kernel cmdline override for CONFIG_SEAL_SYSTEM_MAPPINGS
> > > > + */
> > > > +enum seal_system_mappings_type {
> > > > +     SEAL_SYSTEM_MAPPINGS_DISABLED,
> > > > +     SEAL_SYSTEM_MAPPINGS_ENABLED
> > > > +};
> > > > +
> > > > +static enum seal_system_mappings_type seal_system_mappings_v __ro_=
after_init =3D
> > > > +     IS_ENABLED(CONFIG_SEAL_SYSTEM_MAPPINGS) ? SEAL_SYSTEM_MAPPING=
S_ENABLED :
> > > > +     SEAL_SYSTEM_MAPPINGS_DISABLED;
> > > > +
> > > > +static const struct constant_table value_table_sys_mapping[] __ini=
tconst =3D {
> > > > +     { "no", SEAL_SYSTEM_MAPPINGS_DISABLED},
> > > > +     { "yes", SEAL_SYSTEM_MAPPINGS_ENABLED},
> > > > +     { }
> > > > +};
> > > > +
> > > > +static int __init early_seal_system_mappings_override(char *buf)
> > > > +{
> > > > +     if (!buf)
> > > > +             return -EINVAL;
> > > > +
> > > > +     seal_system_mappings_v =3D lookup_constant(value_table_sys_ma=
pping,
> > > > +                     buf, seal_system_mappings_v);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +early_param("exec.seal_system_mappings", early_seal_system_mapping=
s_override);
> > >
> > > Are you paid by the line?
> > > This all seems ridiculously overcomplicated.
> > > Look at (first example I found) kgdbwait:
> > >
> > The example you provided doesn't seem to support the kernel cmd-line ?
> >
> > > static int __init opt_kgdb_wait(char *str)
> > > {
> > >         kgdb_break_asap =3D 1;
> > >
> > >         kdb_init(KDB_INIT_EARLY);
> > >         if (kgdb_io_module_registered &&
> > >             IS_ENABLED(CONFIG_ARCH_HAS_EARLY_DEBUG))
> > >                 kgdb_initial_breakpoint();
> > >
> > >         return 0;
> > > }
> > > early_param("kgdbwait", opt_kgdb_wait);
> > >
> > There is an existing pattern of supporting kernel cmd line + KCONFIG
> > which I followed [1],
> > IMO, this fits this user-case really well, if you have a better
> > example, I'm happy to look.
> >
> > [1] https://lore.kernel.org/lkml/20240802080225.89408-1-adrian.ratiu@co=
llabora.com/
> >
> > > I don't understand why you've created a new 'exec' namespace, and why
> > > this feature fits in 'exec'.  That seems like an implementation detai=
l.
> > > I'd lose the "exec." prefix.
> >
> > I would prefer some prefix to group these types of features.
> > vdso/vvar are sealed during the execve() call, so I choose "exec".
> > The next work I'm planning is sealing the NX stack, it would start
> > with the same prefix.
> >
> >  If exec is not an intuitive prefix, I'm also happy with "process." pre=
fix.
>
> If we HAVE to have a prefix, I'd prefer "mseal.". 'Seal' is horribly
> overloaded and I'd prefer to group these operations together.
>
mseal.seal_system_mappings seems to contain duplicate info.

If the norm is against prefix in kernel cmd line, I will drop the prefix an=
d use
mseal_system_mappings

> >
> > Thanks for reviewing
> >
> > -Jeff
