Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD95441440A
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789069751; cv=pass; b=KXyzRjV5HXibR3Ppmas/EHN6oUA+4gFHBJskPriN9NkhyaIT7cbHQlYIfxAI+UIcPjOSC6lb8xB/PYyW1CViNXqNt6z4jJ3J10oxeF0IT1hpl7w19SaidyhAxt+G2MrM9Ybhb+u/Qbin9TXM1/SvAy0VPAs0HtRNkvIA8drZPlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789069751; c=relaxed/simple;
	bh=S5QyluVCeJaGYGDzXLLVWroaz+aSorb6LrOcEvmKFPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtxCrRzrebMGaeElChM6olx8bH4RZITch8Jp6CqO7B76CfV0sfC9anhbImeYQEumBmD9NfsfX/rMzHyka/6klynCFIzEeEYYZ384wjersxWi2fVSDG5T6sDfJvMYSNwO9bzhYoRyUH7u1NFH6O3JR5XiJDFlIsXgKjr4kIua6YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZBcng1IF; arc=pass smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBcng1IF"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-97e9adae64cso111435241.3
        for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 12:49:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789069749; cv=none;
        d=google.com; s=arc-20260327;
        b=XE7qOobNDhZW/FeOObL4/M0LMCyXgxeBnPg37jv3G2NlJod2L6SwGy47kzu5XJH6Jv
         IZJCf1Wzoif3r37SimDNgfcvlO4MdpEWDyYNHu/aXsJBSP6XuXbD4B7B7LbSUsS8NbeN
         WbsMMfURNzsGh+niBBXAksho0toJZ+OkFZLS2kuU43ZzSPtqTRYLCir2SXXAgHjIq/Kz
         PNtWr1XqlvdlV+0rveLf4HGfPQYDqfHj6kpmJEh4je7y3vXNa2N5Qh+UsoYFxMJ1rLnC
         ejRSTet7b0W36mbK84QppNkFV819KXDKOcLsEbUEme2COXjXMGPY+VajHHDYTXh3EEqZ
         Vrtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c0ksCIwXvtdjyIyjGDoU93CuaajQfyrtF2GSd2bTtEE=;
        fh=DCWnbyYChaIPOzYt1iOmizbcHCZhzp/lW2gD9GCBtWY=;
        b=pNIZRSAN+JnoyC3T5m8uqwTymhD6dQbuH8kMMQaQ8tLVcM6DZIbRhFPp1bMrVEYFkv
         +qU8CzLNIuw6idmnlI/Jgyl1NN52qnA37dCBNEf9fY4DvN8d5H0h8T5YHcUjMijetZyS
         RvHLzN6q1dUiJd7B30NutJY1TqyWBzZwELrz7Ba7JeAC+jjkKQYmpt+6UUCArk4uRrH5
         rDqwI0kFDbBR1xWneMCdPByvtK2oWZCYFyzm0EIZLcupyM4gkg28tLR0q50U9/5bIBat
         GZx0+Kp/gp7Ve3FCoPhjtLpj2XYN2CJsljYjVWVSjM9RWUwPiej97w7xoWXXsQvCdmJe
         HcqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789069749; x=1789674549; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c0ksCIwXvtdjyIyjGDoU93CuaajQfyrtF2GSd2bTtEE=;
        b=ZBcng1IFvBCykMS3ie3o1i6yoMhOoz/8lqeHCwRuk+UfqIRheTE4X17pvfk6KELjSW
         4/uHwNlyNEB3RyHN77Zc8185qXIJptJzIjX6j6yCFxlrL6BQ2MkHJpc8INwjZry5fxAp
         NmIglitex/durE3FqJc1cX2l9fL8zhuNWI5clrdQTN0FBphzzzSNWWO7eXocP7BVr5EF
         1ygepjNSitROspFCGzZNi3P5mo6ecQMV2Jod9RSQLnwTx/V/oKX3qPMuYnSepKhkJMIZ
         WwBDOkYKMteOoRHGL92vhO/VcC3Ed+GQdSA6dZjgFu9sI3shNyQv8chaQDiKtDP6f8qE
         q7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789069749; x=1789674549;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0ksCIwXvtdjyIyjGDoU93CuaajQfyrtF2GSd2bTtEE=;
        b=BYqriZlPiAyVgrFl2M9HhSHJ8OFMaXvBXqS3WKtyahzvmEhvGrT3UJSa7IibZYnOVh
         C5klGZ7hFqL8ttpHAMn6RlBNF/p/ibGzWm3z3c0eDrcnVgzjO/QYc0Od2nCyRD31E3CH
         jL51gLJnhrYQLOpZ3ME1ZaJU5HoeEgb20+l51NtvUGGDDn4rtcjhtm+tkT6AyUmIJDwG
         iNq2O9iIPxAUNKelrlmv7Uo5spzEZ6adCyvSqHl3b2wLQpM6pMF/NaZtJnpdZHtQAKHz
         n+jLYoUPSNNx1jXdcBHolosMzp1OL78Z9DCGrnL+NwIHby8vLtn9CJjymEBupWkpVmCb
         jtrQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6J7XH9/BPCth+rHPa0+m6fHgiEah6v8oRHoOsWrCl/391yc5Nnsxzfl4HvV3bx15o0lQa62YwRvvoboahkzA=@vger.kernel.org
X-Gm-Message-State: AFuF++mXVxUEZtpC6mhnoxUbLgcuxduELdaoUFeBWmI17RIE4GBwAQs9
	YEMEClWhLfA8c9C/QP9ioUPblaELrc4KVDBdCVbfxL9oneZOLfJ6kYFiVyEcOcyy6kdmwt7wmsC
	pU3Y0Hk5nOCiLUyrDMTS2H7Tq749cA1Be6ieuSQg=
X-Gm-Gg: AYBFou307r7i4QQNfQvkwLqvS9BMzqvnreA8e2BzOg8VO3EyB2fs+NjAWmfo4A0j/m0
	sfgT5pX9iCydQ93xryhyGuvsmM2rmiXyAktbKNPgabr4PevKYzeVgqoJb+dhHQaG60mDEBXCO73
	NYzH2ISe3LCoIa7qDvH2M9ZuytO2qsUzxXlO2EAakh5jr68ERybH5LRiw5TOKnuWQEuKkZ99MPT
	dTB1nZfDbcND1kaBV8gfOEseTmc9xjGuNXciwZJSh2RSymOtLwxhrobJt7Bu3Bhy17RnCR1MA39
	9d092Y/eFrUPqdWPHSL9yo/cOqrEtAIzLy8W/BoSBw0a2E/aDfMIOrX4FOH3sOU1fNuaZ0mWdY1
	4bTLk7TbrwRmt6FOC3H0sxzlD6S+PPT2k1p/ZuUr7ke8CWKS8ksvN
X-Received: by 2002:a05:6102:6402:b0:790:c7bb:43fd with SMTP id
 ada2fe7eead31-792a93b09acmr1242358137.8.1789069748029; Thu, 10 Sep 2026
 12:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823123549.1120133-1-morbo@google.com> <20260823123549.1120133-3-morbo@google.com>
 <20260824083538-d0eff358-e1d4-4af6-9e61-d4d816783266@linutronix.de>
In-Reply-To: <20260824083538-d0eff358-e1d4-4af6-9e61-d4d816783266@linutronix.de>
From: Bill Wendling <morbo@google.com>
Date: Thu, 10 Sep 2026 12:48:51 -0700
X-Gm-Features: AcwNN1V1PayGvWHzKjDrmg88i9kvWNJySD9iq9lUAMBCtIxwSRTkDSXpz02lxUY
Message-ID: <CAGG=3QXojhEsqvk-L5vT3w37z_VO+p1=8vrJCJ44sTz_V-YRGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib/tests: Add KUnit test for struct stack_trace
 __counted_by_ptr attribute
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Dmitry Antipov <dmantipov@yandex.ru>, Petr Mladek <pmladek@suse.com>, Kir Chou <note351@hotmail.com>, 
	codemender-patching+linux@google.com, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 11:41=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Sun, Aug 23, 2026 at 12:35:33PM +0000, Bill Wendling wrote:
> > Add a custom KUnit test suite 'stacktrace_counted_by' to verify that th=
e
> > __counted_by_ptr annotation on the 'entries' field of 'struct stack_tra=
ce'
> > behaves correctly.
>
> The implementation of __counted_by_ptr should be tested by a dedicated un=
ittest
> for that feature. And I am fairly sure that already exists. It should not=
 be
> tested in random subsystems.
>
I'm looking at `tools/unittests` and...what in the world is it
supposed to be testing? It looks like it's testing absolutely nothing
of substance. I assume you want there to be a test that runs and
produces a stack trace triggered by an invalid access, right? I'm
unable to find any tests in `tools/unittests` that do anything like
that...maybe I'm missing something?

-bw

> > The test verifies that 'max_entries' correctly limits and validates acc=
ess
> > to 'entries' when CONFIG_ARCH_STACKWALK is not defined. If it is define=
d,
> > the test is cleanly skipped at runtime to prevent compile-time or runti=
me
> > failures due to 'struct stack_trace' being undefined on modern
> > architectures.
> >
> > Assisted-by: Gemini Next
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > ---
> > Cc: Kees Cook <kees@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Brendan Higgins <brendan.higgins@linux.dev>
> > Cc: David Gow <david@davidgow.net>
> > Cc: Rae Moar <raemoar63@gmail.com>
> > Cc: Ryota Sakamoto <sakamo.ryota@gmail.com>
> > Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
> > Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Cc: Dmitry Antipov <dmantipov@yandex.ru>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Kir Chou <note351@hotmail.com>
> > Cc: codemender-patching+linux@google.com
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-hardening@vger.kernel.org
> > Cc: linux-kselftest@vger.kernel.org
> > Cc: kunit-dev@googlegroups.com
> > Cc: linux-hardening@vger.kernel.org
> > ---
> >  lib/Kconfig.debug            | 10 +++++++
> >  lib/kunit/.kunitconfig       |  1 +
> >  lib/tests/Makefile           |  1 +
> >  lib/tests/stacktrace_kunit.c | 51 ++++++++++++++++++++++++++++++++++++
> >  4 files changed, 63 insertions(+)
> >  create mode 100644 lib/tests/stacktrace_kunit.c
>
> (...)
>
> > diff --git a/lib/tests/stacktrace_kunit.c b/lib/tests/stacktrace_kunit.=
c
> > new file mode 100644
> > index 000000000000..7ec48edf84fe
> > --- /dev/null
> > +++ b/lib/tests/stacktrace_kunit.c
> > @@ -0,0 +1,51 @@
>
> (...)
>
> > +}
> > +#else
> > +static void test_stack_trace_counted_by(struct kunit *test)
> > +{
> > +     kunit_skip(test, "CONFIG_ARCH_STACKWALK is enabled, struct stack_=
trace is not defined");
>
> If the test requires a specific kconfig symbol, then depend on it in kcon=
fig.
> Putting all of the code behind a single, giant ifdef is pointless.
>
> > +}
> > +#endif
>
> (...)
