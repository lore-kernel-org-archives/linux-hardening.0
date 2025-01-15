Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F67F14B959
	for <linux-hardening@vger.kernel.org>; Wed, 15 Jan 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736972474; cv=none; b=b1ZEJThdCaPX6bVd6HGWaq5yDIhNnmIFO5q3bXZjHBDg3FE2A0sow3MZVV3kpUSf++1g5EHMmsrJgK+lN+j2Qyvk+1AG+tLEyGGYH0KrTRbCrk/R8UzIhiQ2k+wydtriCEwlNqTIUmGYTxx3tAiJgvt5/2ID/1LUx0VYytcGzyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736972474; c=relaxed/simple;
	bh=t76h7oWE2NyZNKlT/dCW+ENVR4Gp5reIKOdsNvLninY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KGNRV5Q5oaDiJcH9QEOlpvCCDdgEZBtIntdRFtZtiiYhgZCzu2JSFp1tKow71pgmsU7P93l1Trth26RAru1Jb56Kvi7SXY160QbQEVfkQA/4oN93p3n/gcVutWM5mEycC4ac+Y3Zny89PtU7b/eq/RmD/HgZnv8xEnIL8J8bhvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ihqdf7d3; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ihqdf7d3"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3ebbde05f6bso6065b6e.2
        for <linux-hardening@vger.kernel.org>; Wed, 15 Jan 2025 12:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736972471; x=1737577271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuU0tELkRwTCqKfTqMT/vH/3knljEQASIfj0rHpGyCo=;
        b=ihqdf7d34EaLvimgP68i/Z3LozuGujJ5qSeAaCwQswjxPI1tPy2ly9ElziNWdU9769
         0z1XA32H9kyP5E0ocI3stLcf7ghGnw1zZOtbR/4/piFwDUV+Z1xpeAowJQUEm0P964tC
         wNR/fwQqHx1AopY5V3yTph3mVBXzkrVqALuk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736972471; x=1737577271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuU0tELkRwTCqKfTqMT/vH/3knljEQASIfj0rHpGyCo=;
        b=C8UrKvj/tezXY2XtCbeyE4rUOzZGIfiP6Br3VU2UFs3A3Y0BX1YrMYHT2A7083HVjj
         wVQDJ1mrt+zlkOaUazzHTSeHEaiy/mefhh27g6NIhHeGyYgSfjd1WPcENHau8TNmFRtO
         FwfgT75Lou/jCMGCmk6CieoSL5z3/32pKH3l3AuFXPxBz6MSAGtJh4Dz70NJqBHKqyrO
         H6DQms/nXxvRpT+6QDxGeM1jJpbTHm6LgOhqxWqZb+NzeUqZJh8CdbN78nGzWjw/ZgRG
         ACjU3Be7RWdUZcAwwl0Ay73r2nDI17h0GnUuZkc0TnnXCRQ6KPnsPFztPfftpxYyYnXM
         /6kA==
X-Forwarded-Encrypted: i=1; AJvYcCUiyLe2NXkq5Qyhwc2C03zad3HEav2jxEC9v2EM9brAclZF6DI+1Pasf/0jgr7hVsqtl6zBttktJ8ZGBafIDvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNp8nEkO+O++7RFjgluoTHRm2WcSilpAvY+Wo2xmin+5o8QQ9d
	YT2XZqrssJWbYSJGME6pbIRNxWqQpAf4CEJLH57LGn6tXGjB/0D5gRoyyj9jShvC0YR6RaWvEYP
	x5ao0A8cBHJWK6EsJsx7UXdfFcvYO6rgOb1Qk
X-Gm-Gg: ASbGncvgyOP/BlFx6GSSmFBHkC9weAlSBl2ypWp8K9CqjZdSqLFoNxdacRuku+j/GeK
	EaW1vByivu1XuZsI19cqAbNdK4X1+Chz1N9A1DA==
X-Google-Smtp-Source: AGHT+IFYULscnO8OLRjLdoopsIT/Yu+SMskS3aNdsTv/4h6I409ZfgE82m1VfX+kNSnpeufO7k6qiXUiPKJBvZ3Z3Yc=
X-Received: by 2002:a05:6808:ecf:b0:3eb:5372:980a with SMTP id
 5614622812f47-3ef2eea220bmr7100355b6e.9.1736972471635; Wed, 15 Jan 2025
 12:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241125202021.3684919-1-jeffxu@google.com> <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook> <a0a3b26b-2222-478c-a1cb-56514ec8d6ff@lucifer.local>
 <202501061647.6C8F34CB1A@keescook> <CABi2SkUfAoCbsknnXnyoFbCPOFRahDx+Vqz3ohnyf_G1p4eszA@mail.gmail.com>
 <CABi2SkXS9OOwP2BZGQOa=Pn+NoL1VmOJBJEn-6tWBBQwLtpYiw@mail.gmail.com> <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
In-Reply-To: <5cf1601b-70c3-45bb-81ef-416d89c415c2@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 15 Jan 2025 12:20:59 -0800
X-Gm-Features: AbW1kvZgfXrbZ7PMETMTCkb5NK5ifYJXMGG7xqGRJlONYfsN-fJqyVIdlu6IzMU
Message-ID: <CABi2SkX--gf8XtzBd1G7wS6E=F51rFckP62V0GrONuXs1TCOcQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <kees@kernel.org>, akpm@linux-foundation.org, jannh@google.com, 
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org, oleg@redhat.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-mm@kvack.org, jorgelo@chromium.org, sroettger@google.com, 
	ojeda@kernel.org, adobriyan@gmail.com, anna-maria@linutronix.de, 
	mark.rutland@arm.com, linus.walleij@linaro.org, Jason@zx2c4.com, 
	deller@gmx.de, rdunlap@infradead.org, davem@davemloft.net, hch@lst.de, 
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com, gerg@kernel.org, 
	dave.hansen@linux.intel.com, mingo@kernel.org, ardb@kernel.org, 
	Liam.Howlett@oracle.com, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, Vlastimil Babka <vbabka@suse.cz>, 
	Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <0x7f454c46@gmail.com>, 
	Mike Rapoport <mike.rapoport@gmail.com>, 
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	Benjamin Berg <benjamin@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Wed, Jan 15, 2025 at 11:46=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Jeff,
>
> My name is Lorenzo, not Lorenze.
>
I apologize.

> I've made it abundantly clear that this (NACKed) series cannot allow the
> kernel to be in a broken state even if a user sets flags to do so.
>
> This is because users might lack context to make this decision and
> incorrectly do so, and now we ship a known-broken kernel.
>
> You are now suggesting disabling the !CRIU requirement. Which violates my
> _requirements_ (not optional features).
>
Sure, I can add CRIU back.

Are you fine with UML and gViso not working under this CONFIG ?
UML/gViso doesn't use any KCONFIG like CRIU does.

> You seem to be saying you're pushing an internal feature on upstream and
> only care about internal use cases, this is not how upstream works, as
> Matthew alludes to.
>
> I have told you that my requirements are:
>
> 1. You cannot allow a user to set config or boot options to have a
>    broken kernel configuration.
>
Can you clarify on the definition of "broken kernel configuration":

Do you consider "setting mseal kernel cmd line under 32 bit build" as broke=
n ?
If so, this problem is not solvable and I might just not try to solve
it for the next version.

If you just refer to a need to detect CRIU, in KCONFIG or/and kernel
cmd line,  this is solvable.

> 2. You must provide evidence that the arches you claim work with this,
>    actually do.
>
Sure

> You seem to have eliminated that from your summary as if the very thing
> that makes this series NACKed were not pertinent.
>
In my last email, I tried to cover all code-logic related comments,
which is blocking me.
I also mentioned I will address non-code related comments
(threat-model/test etc),  later.

> if you do not address these correctly, I will simply have to reject your =
v5
> too and it'll waste everybody's time. I _genuinely_ don't want to have to
> do this.
>
> Any solution MUST fulfil these requirements. I also want to see v5 as an
> RFC honestly at this stage, since it seems we are VERY MUCH in a discussi=
on
> phase rather than a patch phase at this time.
>
Sure.

> I really want to help you improve mseal and get things upstream, but I
> can't ignore my duty to ensure that the kernel remains stable and we don'=
t
> hand kernel users (overly huge) footguns. I hate to be negative, but this
> is why I am pushing back so much here.
>
Thanks. You can help me by answering my questions, and clarify your
requirements. I appreciate your time to make this feature useful.

Please take note that the security feature often takes away
capabilities.  Sometimes it is impossible to meet security, usability
or performance goals simultaneously. I'm trying my best to get all
aspected satisfied.

-Jeff

> Thanks!
