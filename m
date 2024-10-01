Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BFC1CC141
	for <linux-hardening@vger.kernel.org>; Tue,  1 Oct 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727792040; cv=none; b=Wpyahha+Vm635eKJROsDDaVt6n3mo52DVh9vOvHhOhZv8npN5Sjy2KPjaOsFhlaNDTLmkQydio1ZIJc2x108xuLY1a78VY32C7otO1oenw+4eL0RKcH9F3MIejPu3vSYA6LiFOww8mL1w7qFLSVWsonydvs/0KjByY3OTU/RDA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727792040; c=relaxed/simple;
	bh=+FKUddij/gxQNpHjW2/b65NyFWE/k6zemBV6DcE0H+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T2X9GxNLuwRoA6GTCK9sUpxPwvkeVHh5Rh3lD4fyH7BJGA9qs8/KtwTAD0hSnNypy8PByRpK4NrTXLEeCXj4n9rTbouon3/oX/hGSKkQ5iY6IiLA+wpVDcoXTWqUzi5WvpD4i1FTxLFfE9oBHSHaIWfP5o2cifCwtGjoZPmORQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dyogwqtd; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dyogwqtd"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-27b7a1480bdso2310118fac.2
        for <linux-hardening@vger.kernel.org>; Tue, 01 Oct 2024 07:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1727792038; x=1728396838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXNRv4R5VmvPOl/Xct8Si1vB9z90P2avYuEV2rget7M=;
        b=dyogwqtdJI+LlS0daZLSNAMAJ90w8SGN41+FrMpOhYZreH7cjHVHH67oHW3PpW9vAZ
         BV+V51kLsIqgZO/tvdA1fJvgA1fOlDSB7XVLvmCZ2rG5OOhkJ/7Pqy/ePb+tSZ8P+5R6
         zr/q8Y1+540E7zboQjbw8oMap3Th2/iskpg26WwPoqV4seBHdJXJzEMY1gBDQnutqhAm
         +23MPgfegtZJGVwVq/BGfYJ22e9t25xG5w94P3n9GG5Vf2pITUBMIjxR5avLZfuuGBBE
         kK4G8B/nTV24q2plJF6TQDdaAf76qa09aESrb1ta2LiV3cp/4PeHBVz7YJAxP3uMwD3k
         QLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727792038; x=1728396838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GXNRv4R5VmvPOl/Xct8Si1vB9z90P2avYuEV2rget7M=;
        b=je1ioyKhe/OCoZrTfWqL5FSW4VTIllFxOuqkPrJt6eziW/SqWKls36gRX8XIX8UVzj
         b5XMwKFzKlz0pHCpoVv4HDjaUp60rKz5mAFtq3ZsUoRh8n0qArwtpcEaBofNt3y4s4Hl
         EWtvTLHJIagFIks0Ju+7vBh97U1abRe9l2Q90DBx2CWUhv2gQcQ0b63TMrgxeV+WoKWZ
         jqA6+o9cd1Bobj25CYgvM2HEFaoqy7H0Ii/6cN90eYAoQFMmkbVr66BaZRRAKIKVrTg9
         7MqPUGABBwGKCzpVFtXN0vf1mPSVJx+/qJ/vfOdrLTF8C4huzhsWFPKieaGlpuPaTIwH
         d9vw==
X-Forwarded-Encrypted: i=1; AJvYcCXSZ38quA5jSFdhLWClEdIqr+7pn5LF30bxBowKkjMOatdFb6wdAvlGsTbcjPWRhy5iR9N8XFOwC0XXTNvkKPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0n6VQi85BbqSpv/Ikdm0PRtO7W22Pkd63noTArFm/+t9SFkZ
	upyJar6s31CZiwz8LsA741uOvdOJTMqBxjEnapAjR8Pq9mkMz6e5huUlhq66uwQm8YE/MfoRovh
	teQA+r+Eur+KVZ4n6UdB74G7UhfEmG1zxk/MQ
X-Google-Smtp-Source: AGHT+IFMGvyp3IY12n2ve9jQjiLs86OcN1H193F2bZNg+PAFq+kScDkFEWvxGnsgYNZpsi7YFM4vdBKzpoYT5KslJgA=
X-Received: by 2002:a05:6870:5b88:b0:261:1f7d:cf6e with SMTP id
 586e51a60fabf-28710c45c43mr8810649fac.41.1727792037867; Tue, 01 Oct 2024
 07:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928-maintainers-security-kconfig-hardening-v1-1-c8c64071cc02@kernel.org>
 <1923f716100.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com> <20240929210004.GA1300946@thelio-3990X>
In-Reply-To: <20240929210004.GA1300946@thelio-3990X>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 1 Oct 2024 10:13:43 -0400
Message-ID: <CAHC9VhRqevog8t4+D=t+d7+bvMs9jrW99Kvd_JF-1LSH0YN2VA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add security/Kconfig.hardening to hardening section
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 5:00=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
> On Sun, Sep 29, 2024 at 10:20:59PM +0200, Paul Moore wrote:
> > On September 28, 2024 8:26:28 PM Nathan Chancellor <nathan@kernel.org> =
wrote:
> > > When running get_maintainer.pl on security/Kconfig.hardening, only th=
e
> > > security subsystem folks show up, even though they have never taken
> > > patches to this file:
> > >
> > >  $ scripts/get_maintainer.pl security/Kconfig.hardening
> > >  Paul Moore <...> (supporter:SECURITY SUBSYSTEM)
> > >  James Morris <...> (supporter:SECURITY SUBSYSTEM)
> > >  "Serge E. Hallyn" <...> (supporter:SECURITY SUBSYSTEM)
> > >  linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM)
> > >  linux-kernel@vger.kernel.org (open list)
> > >
> > >  $ git log --format=3D%cn --no-merges security/Kconfig.hardening | so=
rt | uniq -c
> > >        3 Andrew Morton
> > >        1 Greg Kroah-Hartman
> > >       18 Kees Cook
> > >        2 Linus Torvald
> > >
> > > Add it to the hardening section so that the KSPP folks are also shown=
,
> > > which matches reality over who should comment on and take said patche=
s
> > > if necessary.
> > >
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > > ---
> > > MAINTAINERS | 1 +
> > > 1 file changed, 1 insertion(+)
> >
> > For the sake of casual observers, the reason James, Serge, or I haven't
> > merged anything in Kconfig.hardening isn't due to any malicious intent =
or
> > lack of appreciation, rather it is out of respect for KSPP and not want=
ing
> > to step on Kees' toes.
>
> Right, I did not mean for this to come off in an accusatory way, so my
> apologies if it did. I merely wanted to codify this arrangement so that
> patches get picked up or acked by the correct people in the future since
> I had to send one earlier and I noticed it did not match reality (with
> the data to prove it heh) ...

No worries, I had hoped to make it clear I wasn't too bothered by this
with the 'for casual observers' remark, but I guess I should have been
more explicit.  I wrote my original reply simply because I've seen
people take snippets out of context far too many times and I didn't
want anyone to think there was a problem here.

> > I've happily merged KSPP related patches to those subsystems which I'm
> > tasked with looking after and I plan to continue to do so.
>
> Always happy to have as many KSPP allies as possible :)

Hopefully the LSM folks can consider KSPP as an ally too ;)

--=20
paul-moore.com
