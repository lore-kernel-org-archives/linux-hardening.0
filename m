Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F45548E0
	for <linux-hardening@vger.kernel.org>; Fri, 16 Aug 2024 02:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723777180; cv=none; b=a4OCMMtTg8E9kwb8M1TrT/0KNOgSW/9ciaWG0d6lHr7zQmZsl8UtkgzwpJ2J9obIi6nMdSiDRrVsb0LjP9T1Irkk7Df6Ho4vJwQfe6Y9Pia5bE0klsoK+muvzZnqpDp9uh1YFhW5Q0WLCeu6kQHXE8F8Zp9QQUvR8QEl5GCNakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723777180; c=relaxed/simple;
	bh=YIXetCV4S/EKE1XpPNeennj8Wps8sutrd3UN5ar0Z2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZdLFSvqABcZfcbCNAND46z0n3wVoUxbgFnYKqwp7BxLU38jKNudCHJOqepI8lU5ingFQXipB31NjmgKUmKHDpSEFCgOw7ozIo1JIH4X8WyFK3m1IulspFLbVSCQM/pHVZMPKEzqK59JBtDdFrTSvXMG6GzgkcuPYuaIxYB8FdpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jsGxm+RR; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jsGxm+RR"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efce25f36so393e87.1
        for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723777177; x=1724381977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRAxn9udby9Ekvy/JHFcZ+oOinR59nIxNeFf8Orxanw=;
        b=jsGxm+RRzzXHQ6mqX+4jbYgoONVPV8xct3rTMvYBVs6a/3EmlDSy0Rex1aoCIr+neW
         zvPoxkNil2l61ofUGZ/3kheo23gQ6C1BBehIDsJpFKXSF5WelsKgII/uizZwEubRT/7s
         cOKp9WUUMYTWxMeqYJg7SRR8chQ+Ivrkgrf0/ipfxi0AZ9WXXrMBQj7EsTWW0RSshRf3
         V63P33FvbmXPDxDgi2euXfUMueUap93FPy+ksZupLgRMCK8DNASexeYZ5jXc9QVmBwyr
         V8jJhtE6YIOtuJqEPZ64P44iA7BW8HmrESMfh/CZ2EjQjJGMXdoN7kVymCYPBH3wE30R
         NPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723777177; x=1724381977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRAxn9udby9Ekvy/JHFcZ+oOinR59nIxNeFf8Orxanw=;
        b=GNtcnnUri2MzDS3csdnA5TbDFtXHf0UBeO5K1szu3Li+bD+UD2iL++fylDMdi+NlbS
         V2udMzTn4sUBsZ1HMj0AkE0WlqK9Ms6m6e+SdNnVDfwoKtatoV0TY3Jm1yfVfOMgzjQv
         uHFyJtjhuJWizTFjaK98pDHKcoab+x50i12DFPmvbC+UfFXKXZD4Bu0pCnLi4KXjUOgY
         G9xIth4gpoMeN/jQmVGwctdtRBV5JJT99zWCbrMw2wRme1kttvVNnrofLZAUJw7GaXsr
         CAG2PjBZ063kRkwhV1LzO20EM7j5+rfD+9I6yhytO5Wg2GwEcPNRw4zQW5/acxJM/IOe
         OACA==
X-Forwarded-Encrypted: i=1; AJvYcCVelIMZz849wf1+hb/vwQfo00Xol/oNezGUqus8xmH1rP5tArHB8/fQZfYG/a8Wum8BxXxgKgTiB9XRBN9Iz0M6zfxp2ScGXp2N9abCilco
X-Gm-Message-State: AOJu0YxcuB4oClodWXObKQzY8n7Bb7SS+ENCAA3rwanKoDSuUcwsMlTl
	H9Y9606bppPU0tMJ8s0LItV6o6a0S4qYn4MAsbflae8fnBfUDwIRS7LtchBKEKeaULY7QrNX923
	pJhT5wO1WPib7hn1ycYw4BuMpr2vpFqfqbutK
X-Google-Smtp-Source: AGHT+IFMi/6G2XsQqWJDVUCZfW2i6sTX4SSy604sCDsTUe0V3lq0tzEHuMILXCOVPEhBFl5gbtv/dUm6XIBdPaWbnBY=
X-Received: by 2002:a05:6512:39c5:b0:530:c2ef:db2c with SMTP id
 2adb3069b0e04-5331ca481e8mr40488e87.2.1723777176519; Thu, 15 Aug 2024
 19:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
 <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com> <Zr670gX13gKJOtG9@xsang-OptiPlex-9020>
In-Reply-To: <Zr670gX13gKJOtG9@xsang-OptiPlex-9020>
From: Jeff Xu <jeffxu@google.com>
Date: Thu, 15 Aug 2024 19:58:57 -0700
Message-ID: <CALmYWFvEaYZHBDy74V4gmEExTuMpYg3G+qGUvjL5WtpSVrVqRg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: Oliver Sang <oliver.sang@intel.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mpe@ellerman.id.au, vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver

On Thu, Aug 15, 2024 at 7:39=E2=80=AFPM Oliver Sang <oliver.sang@intel.com>=
 wrote:
>
> hi, Jeff,
>
> On Thu, Aug 15, 2024 at 01:19:06PM -0700, Jeff Xu wrote:
> > Hi Oliver,
> >
> > On Thu, Aug 15, 2024 at 11:16=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> =
wrote:
> > >
> > > On Wed, Aug 14, 2024 at 12:14=E2=80=AFAM <jeffxu@chromium.org> wrote:
> > > >
> > > > From: Jeff Xu <jeffxu@chromium.org>
> > > >
> > > > mremap doesn't allow relocate, expand, shrink across VMA boundaries=
,
> > > > refactor the code to check src address range before doing anything =
on
> > > > the destination, i.e. destination won't be unmapped, if src address
> > > > failed the boundaries check.
> > > >
> > > > This also allows us to remove can_modify_mm from mremap.c, since
> > > > the src address must be single VMA, can_modify_vma is used.
> > > >
> > > > It is likely this will improve the performance on mremap, previousl=
y
> > > > the code does sealing check using can_modify_mm for the src address=
 range,
> > > > and the new code removed the loop (used by can_modify_mm).
> > > >
> > > > In order to verify this patch doesn't regress on mremap, I added te=
sts in
> > > > mseal_test, the test patch can be applied before mremap refactor pa=
tch or
> > > > checkin independently.
> > > >
> > > > Also this patch doesn't change mseal's existing schematic: if seali=
ng fail,
> > > > user can expect the src/dst address isn't updated. So this patch ca=
n be
> > > > applied regardless if we decided to go with current out-of-loop app=
roach
> > > > or in-loop approach currently in discussion.
> > > >
> > > > Regarding the perf test report by stress-ng [1] title:
> > > > 8be7258aad: stress-ng.pagemove.page_remaps_per_sec -4.4% regression
> > > >
> > > > The test is using below for testing:
> > > > stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --=
pagemove 64
> > > >
> > > > I can't repro this using ChromeOS, the pagemove test shows large va=
lue
> > > > of stddev and stderr, and can't reasonably refect the performance i=
mpact.
> > > >
> > > > For example: I write a c program [2] to run the above pagemove test=
 10 times
> > > > and calculate the stddev, stderr, for 3 commits:
> > > >
> > > > 1> before mseal feature is added:
> > > > Ops/sec:
> > > >   Mean     : 3564.40
> > > >   Std Dev  : 2737.35 (76.80% of Mean)
> > > >   Std Err  : 865.63 (24.29% of Mean)
> > > >
> > > > 2> after mseal feature is added:
> > > > Ops/sec:
> > > >   Mean     : 2703.84
> > > >   Std Dev  : 2085.13 (77.12% of Mean)
> > > >   Std Err  : 659.38 (24.39% of Mean)
> > > >
> > > > 3> after current patch (mremap refactor)
> > > > Ops/sec:
> > > >   Mean     : 3603.67
> > > >   Std Dev  : 2422.22 (67.22% of Mean)
> > > >   Std Err  : 765.97 (21.26% of Mean)
> > > >
> > > > The result shows 21%-24% stderr, this means whatever perf improvmen=
t/impact
> > > > there might be won't be measured correctly by this test.
> > > >
> > > > This test machine has 32G memory,  Intel(R) Celeron(R) 7305, 5 CPU.
> > > > And I reboot the machine before each test, and take the first 10 ru=
ns with
> > > > run_stress_ng 10
> > > >
> > > > (I will run longer duration to see if test still shows large stdDev=
,StdErr)
> > > >
> > > I took more samples (100 run ), the stddev/stderr is smaller, however
> > > still not at a range that can reasonably measure the perf improvement
> > > here.
> > >
> > > The tests were taken using the same machine as (10 times run above)
> > > and exact the same steps: i.e. change to certain kernel commit, reboo=
t
> > > test device, take the first test result.
> > >
> > > 1> Before mseal feature is added:
> > > Statistics:
> > > Ops/sec:
> > >   Mean     : 1733.26
> > >   Std Dev  : 842.13 (48.59% of Mean)
> > >   Std Err  : 84.21 (4.86% of Mean)
> > >
> > > 2> After mseal feature is added
> > > Statistics:
> > > Ops/sec:
> > >   Mean     : 1701.53
> > >   Std Dev  : 1017.29 (59.79% of Mean)
> > >   Std Err  : 101.73 (5.98% of Mean)
> > >
> > > 3> After mremap refactor (this patch)
> > > Statistics:
> > > Ops/sec:
> > >   Mean     : 1097.04
> > >   Std Dev  : 860.67 (78.45% of Mean)
> > >   Std Err  : 86.07 (7.85% of Mean)
> > >
> > > Summary: even when the stderr is down to 4%-%8 percentage range, the
> > > stddev is still too big.
> > >
> > > Hence, there are other unknown, random variables that impact this tes=
t.
> > >
> > I could not repro the 4% degradation with my test machine
> > (Chromebook), this can be entirely due to the specific test and this
> > test machine.
> >
> > Do you think it is possible to do a few more tests ? This time I like
> > to have a larger sample size (100 run)
> >
> > stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --page=
move 64
> >
> > Please run the test for each commit following the exact steps, e.g.
> > reboot the machine, run the test, get the first 100 results for
> > sample. Please don't select or drop any unstable report because then
> > the data will be biased. If possible, please includes stddiv and
> > stderr for the data (or raw data if not possible, and I will do
> > post-processing)
> >
> > for 3 commits:
> > -> this patch.
>
> what's the base of it? could I directly apply this patch upon the commit
> what you said "after mseal feature" as below?
>
> > -> after mseal feature
> > -> before mseal feature
>
> could you exlictly point to two commit-id?
sure

this patch
8be7258a: mseal: add mseal syscall
ff388fe5c: mseal: wire up mseal syscall

> >
> > Thank you for your time and assistance in helping me on understanding
> > this issue.
>
> due to resource constraint, please expect that we need several days to fi=
nish
> this test request.
No problem.

Thanks for your help!
-Jeff

> >
> > Best regards,
> > -Jeff
> >
> > > -Jeff
> > >
> > > > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@i=
ntel.com/
> > > > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> > > >
> > > >
> > > > Jeff Xu (2):
> > > >   mseal:selftest mremap across VMA boundaries.
> > > >   mseal: refactor mremap to remove can_modify_mm
> > > >
> > > >  mm/internal.h                           |  24 ++
> > > >  mm/mremap.c                             |  77 +++----
> > > >  mm/mseal.c                              |  17 --
> > > >  tools/testing/selftests/mm/mseal_test.c | 293 ++++++++++++++++++++=
+++-
> > > >  4 files changed, 353 insertions(+), 58 deletions(-)
> > > >
> > > > --
> > > > 2.46.0.76.ge559c4bf1a-goog
> > > >
