Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD7024A07E;
	Thu, 13 Feb 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476802; cv=none; b=I1q/7MznZvhIDJEhZCp3dS21AlKqznkSQmdK1hzY48FrPUD+8W113OJbtll412Yyedy0Ir9Sof2tRmWdyPImcWuI+f/CTrSigNrseF7/DV0Yc15sSHUHW3atBROm1KqsWGXloVI+Eorl6KnGK5OEkGDR1sJ70hHVOzvIemRsj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476802; c=relaxed/simple;
	bh=6A/tJxO/Tj0qrEAzN+EeAFZ+ugKQgrcetXab+VVZsmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LCFc9l7kd+BBQCyHV6dV5fxaI2czqD/9taEygvpxiI6DVGl8xtzj5100FIj0rLKr+AbDq815ptR6ls4WBH7PK5kHjUp8cJr56Uoa7tiBPAhO27lFd1wwgDSZFb5yE6bgiBDX5tyJuPtSOlVGwM6jAj8Izj4AgGJt5uHKVWws63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8zSjxz7; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8zSjxz7"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-86718541914so1259583241.1;
        Thu, 13 Feb 2025 12:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739476800; x=1740081600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A/tJxO/Tj0qrEAzN+EeAFZ+ugKQgrcetXab+VVZsmc=;
        b=T8zSjxz7+B6HdUxt5CPO09QQQABYMbYKSs7C83No36cqGWBR63gneX65fZToIQsekc
         V8qn6vbiSampkwOYTPSjBqBBOMsKYsdAgGxDg966+7Xi9AI2AERZDC0CiOAxkJUE2TGn
         XZoUcmP2tQg5KiZBi9LWJA+t1E5nYOSj2SBLbs64rvAhwMUb9CPt/fp38xHxEptfdHQW
         5X7SQQow4F4JLpNUBfFiEsBZ2R+AH5H2nkCZsKXHLrEQ/jZoxqMoXXNI5BaxeqCR+zGY
         q9DOVUMpMhZ5PmoRyMY3MiGTPjtA0nbbnm9nzTltFfCx1U9gbv3ja36ROVm5Hn7Lx5wH
         EWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739476800; x=1740081600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A/tJxO/Tj0qrEAzN+EeAFZ+ugKQgrcetXab+VVZsmc=;
        b=guvPmqGcCvJhXbgBK+g/0nO3Fc6V4NgLo2wKo6Jb/ptEQRR5pK2xhBi9uMdfgDog2w
         pEk4RX5+k51NEY1jd4I3sllPQ3Pyuk3PNnbbZ/7tEs8oy2Tyib8qXixY8ooXuOifoITX
         GsgvDVxX/TW8C/5SQMXTTdFaWfRrFDVct/319Fka07qjYRaQS+ou5wRRenQTvhBc0U2G
         RQBBKtnhJJxhpbRmyWRuFChpdQEgYBgJOsBVbnqSx6TSJbrJvUC/8DFUDF7DgCjXm32t
         wCJRx4lKP0J2StDdhNLFw8Zm8g0WTW3vAutNDpj44Fy9N1k4dhWcrt3VTfxqedUFP+Lv
         hzmA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9ne+1VHHmI6GNV8bMjwi9Bjw+jScYniUnobcGXvxp8+jCPmbkqt0p8C0HrjCcq4LO/+E79fQoubUYUBFPls=@vger.kernel.org, AJvYcCWe9YMHrX2hLPzt9eGaLryyCcSZrH1pYqRPFwAwMk9t4noQHNlVB/M1FV4uyc6GCFhy8+jESxUEfkIFWXe/@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFX+pOQFb/aCu9GwQ05MCDiNE4NNxty1cpptgKvT9hxYGhXej
	mHibm30dP2eJj/zXxSvO1Plp/rONtmUHl3Wnd1VXGojy+kqSH+z9+8Xi8sIY7v840JWzORbJJeU
	pmmCMWVocjRBiioQyFcYpQDk4AG4=
X-Gm-Gg: ASbGnctOoSAMiZXD4o6JSIZJYRhq+BLBb2Ss+yFKODQppm/ky25Niyigna1X8FWRn2v
	cOmN9INFOQ/+8KoSVIYvGa58mU9sjAGTZzUkm3Wnsw32r7JQ1AZ/YDLtqhNntqoSGL6JloFT8Um
	nJ9g7Sn1mkpRkTKAAJNUj2y/FpUdCv
X-Google-Smtp-Source: AGHT+IEO95cRIlLgN+fMIWfpOsxsRmwWcSyCKFAAZvLEYT9kzpmLQTi+dGvN2ibBkJmLjNqJiRwihu5i9SGiHmeJcgE=
X-Received: by 2002:a05:6102:3f11:b0:4bb:c5ad:af1a with SMTP id
 ada2fe7eead31-4bc04fba69dmr3372366137.7.1739476799879; Thu, 13 Feb 2025
 11:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
 <CAKbZUD0TAX8F9kDCEEvGSbcegDD4GLyra3ewtxncBbs45WJZ3g@mail.gmail.com> <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local>
In-Reply-To: <7545d5eb-a16e-4cc8-a9e3-5431be01aade@lucifer.local>
From: Pedro Falcato <pedro.falcato@gmail.com>
Date: Thu, 13 Feb 2025 19:59:48 +0000
X-Gm-Features: AWEUYZnnvu0UeOQwhhCdIYitvKbnr-kOi8j-etdFPfc3PQhlVh6nUZJWVPm76sA
Message-ID: <CAKbZUD3kaYEqQFU1TWfJWvtV02ESaMb0_ygadGgeAKo-b+GRcA@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	avagin@gmail.com, benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, hca@linux.ibm.com, willy@infradead.org, 
	anna-maria@linutronix.de, mark.rutland@arm.com, linus.walleij@linaro.org, 
	Jason@zx2c4.com, deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, 
	peterx@redhat.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	mhocko@suse.com, 42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com, 
	enh@google.com, rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au, 
	aleksandr.mikhalitsyn@canonical.com, mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:02=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> (sorry I really am struggling to reply to mail as lore still seems to be
> broken).
>
> On Wed, Feb 12, 2025 at 12:37:50PM +0000, Pedro Falcato wrote:
> > On Wed, Feb 12, 2025 at 11:25=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 03:21:48AM +0000, jeffxu@chromium.org wrote:
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > The commit message in the first patch contains the full description=
 of
> > > > this series.
> > >
> > > Sorry to nit, but it'd be useful to reproduce in the cover letter too=
! But
> > > this obviously isn't urgent, just be nice when we un-RFC.
> > >
> > > Thanks for sending as RFC, appreciated, keen to figure out a way forw=
ard
> > > with this series and this gives us space to discuss.
> > >
> > > One thing that came up recently with the LWN article (...!) was that =
rr is
> > > also impacted by this [0].
> > >
> > > I think with this behind a config flag we're fine (this refers to my
> > > 'opt-in' comment in the reply on LWN) as my concerns about this being
> > > enabled in a broken way without an explicit kernel configuration are
> > > addressed, and actually we do expose a means by which a user can dete=
ct if
> > > the VDSO for instance is sealed via /proc/$pid/[s]maps.
> > >
> > > So tools like rr and such can be updated to check for this. I wonder =
if we
> > > ought to try to liaise with the known problematic ones?
> > >
> > > It'd be nice to update the documentation to have a list of 'known
> > > problematic userland software with sealed VDSO' so we make people awa=
re.
> > >
> > > Hopefully we are acheiving the opt-in nature of the thing here, but i=
t
> > > makes me wonder whether we need a prctl() interface to optionally dis=
able
> > > even if the system has it enabled as a whole.
> >
> > Just noting that (as we discussed off-list) doing prctl() would not
> > work, because that would effectively be an munseal for those vdso
> > regions.
> > Possibly something like a personality() flag (that's *not* inherited
> > when AT_SECURE/secureexec). But personalities have other issues...
>
> Thanks, yeah that's a good point, it would have to be implemented as a
> personality or something similar otherwise you're essentially relying on
> 'unsealing' which can't be permitted.
>
> I'm not sure how useful that'd be for the likes of rr though. But I suppo=
se
> if it makes everything exec'd by a child inherit it then maybe that works
> for a debugging session etc.?
>
> >
> > FWIW, although it would (at the moment) be hard to pull off in the
> > libc, I still much prefer it to playing these weird games with CONFIG
> > options and kernel command line options and prctl and personality and
> > whatnot. It seems to me like we're trying to stick policy where it
> > doesn't belong.
>
> The problem is, as a security feature, you don't want to make it triviall=
y
> easy to disable.
>
> I mean we _need_ a config option to be able to strictly enforce only maki=
ng
> the feature enable-able on architectures and configuration option
> combinations that work.
>
> But if there is userspace that will be broken, we really have to have som=
e
> way of avoiding the disconnect between somebody making policy decision at
> the kernel level and somebody trying to run something.
>
> Because I can easily envision somebody enabling this as a 'good security
> feature' for a distro release or such, only for somebody else to later tr=
y
> rr, CRIU, or whatever else and for it to just not work or fail subtly and
> to have no idea why.

Ok so I went looking around for the glibc patchset. It seems they're
moving away from tunables and there was a nice
GNU_PROPERTY_MEMORY_SEAL added to binutils.
So my proposal is to parse this property on the binfmt_elf.c side, and
mm would use this to know if we should seal these mappings. This seems
to tackle compatibility problems,
and glibc isn't sealing programs without this program header anyway. Though=
ts?

>
> I mean one option is to have it as a CONFIG_ flag _and_ you have to enabl=
e
> it via a tunable, so then it can become sysctl.d policy for instance.

sysctl is also an option but the idea of dropping a random feature
behind a CONFIG_ that's unusable by lots of people (including the
general GNU/Linux ecosystem) is really really unappealing to me.

--=20
Pedro
