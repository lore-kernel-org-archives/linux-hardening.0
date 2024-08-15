Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520B1465A3
	for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723753160; cv=none; b=fTIkIjkmWWyIjV8fWGxesat2WlqOutgZANuheVrau0Y1SN9yYE1kNxJEn5Jm0CwSr+saZKR1oTfiGeUCTmF8Rzaid8mCUB9ceabML7Z/vjXZqZ/Pxg/bPVYfeVFRf2U7oUKoxDPpVlRng2atHdBbhkY3EKuIBDdqxTaxNN8Cggs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723753160; c=relaxed/simple;
	bh=LVwFwpTl2ZOzkDsY/bNhjLNrjb1udDhhawkriq9D7Gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bCUsrDVbPxO1aN5IK79XZa7ovK60x69Hw6qF4htO5cLTZoLjTIqPcSbqG11dWN9wKo7DQ3O3AWzpuumMktgeAwxYxm4f6xWCtPAW81CwhCpXg45JUNs0dgFOBohyyrIjxXpH4WoBbCQZ6GxY0Szpdaarsi4kf+hqCBa4vlHcF3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fljmg4MK; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fljmg4MK"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-27003dcbfdbso743960fac.2
        for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723753158; x=1724357958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwwh+m11coKDQ807HOXz5WqEZXo+puG96j+/w4ULqco=;
        b=fljmg4MKz9ekjMaeJHDXfxN2ifBJSJ8m8lzSfLOXDY9MB1TSg9iGhFMV5riPpU+E+C
         cOtLDVx974CuLNpiXCMej5hv03VUGkybJbFe76tKMEQbAhvmyIFWAbC5ka5sL9UkKiaC
         z3uYaHXfqkTv6xhgrjA9sos/HvvTw49yzPd4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723753158; x=1724357958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwwh+m11coKDQ807HOXz5WqEZXo+puG96j+/w4ULqco=;
        b=TTlFBpOYVR9mhAwlgGpEFPo9Hwxl/yDobqBDuhtwq50XDTtsaVI7uSpRQDiT/I7fjj
         Bw3vJmfwbBVNTGIxAu/gnu+Ba0U8DyA/gBOkfx8ouCHNc6BrnVB5UC3c96TP2cT3m7qZ
         GhK7xUn/D3eBSNtNyeJhbmh09BdZsKjuReiydNeLHVzf4TOdvjKLWeCiWKlkrrYGI9ep
         Dls0JyKqIfmXRuSlSgjrvbQYNGcDMV1ggdX8PAvKtPASN3sVmwY1NjeMgzefErMCZ8O9
         QitZk8/+BNylBhPhsKJH/Yuc0TWwmLEBqSYE0uP4eR2SkSV/DVcDhPvCpRgHuXsu/92W
         sasQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdSIF26zSC2YJxMZC/ez+mAft2ojdGEdD4kklP+0+e98DGilZP+EJHoFxlg4LnXAJC+OLE8GmhgbBNJdExTaucQ6l5JWdmPsOcOXUKGf2F
X-Gm-Message-State: AOJu0YzE/Rtf+rxq3ALGG1AV93JzXl+jSdtlVRw8I1vryDOfR2233aVg
	wNIUPmw9L5wZz6ko1Y6Vm0idnZGz+VxQKy+adEAIzykfqEwn45ydYZhnhiGBRNr5WSDit/IHvZ+
	GQxQDvTUuXb6JoOUxU04bhHKs2ZbIMaF+2TrE
X-Google-Smtp-Source: AGHT+IFNZUYqv7nnkMo6SmetQnUTNabfc8VVktvAcev4smjCTJVffFUd4p8V3E9vbbtG9gJR0VoqONU46YFGJfKLqrw=
X-Received: by 2002:a05:6871:521f:b0:268:9f88:18ef with SMTP id
 586e51a60fabf-2701c380d75mr819022fac.13.1723753157780; Thu, 15 Aug 2024
 13:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
In-Reply-To: <CABi2SkX+3JrDk6b59vgvjb8XAkC7_p3-cSkFHOotra1Yh6dv1Q@mail.gmail.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 15 Aug 2024 13:19:06 -0700
Message-ID: <CABi2SkXtZLojx3AQU4C=41NtBPGjVB2+fv_KWziOqyXRQ8P7Bg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: akpm@linux-foundation.org, willy@infradead.org, 
	torvalds@linux-foundation.org, Liam.Howlett@oracle.com, 
	pedro.falcato@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, jeffxu@google.com, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oliver,

On Thu, Aug 15, 2024 at 11:16=E2=80=AFAM Jeff Xu <jeffxu@chromium.org> wrot=
e:
>
> On Wed, Aug 14, 2024 at 12:14=E2=80=AFAM <jeffxu@chromium.org> wrote:
> >
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > mremap doesn't allow relocate, expand, shrink across VMA boundaries,
> > refactor the code to check src address range before doing anything on
> > the destination, i.e. destination won't be unmapped, if src address
> > failed the boundaries check.
> >
> > This also allows us to remove can_modify_mm from mremap.c, since
> > the src address must be single VMA, can_modify_vma is used.
> >
> > It is likely this will improve the performance on mremap, previously
> > the code does sealing check using can_modify_mm for the src address ran=
ge,
> > and the new code removed the loop (used by can_modify_mm).
> >
> > In order to verify this patch doesn't regress on mremap, I added tests =
in
> > mseal_test, the test patch can be applied before mremap refactor patch =
or
> > checkin independently.
> >
> > Also this patch doesn't change mseal's existing schematic: if sealing f=
ail,
> > user can expect the src/dst address isn't updated. So this patch can be
> > applied regardless if we decided to go with current out-of-loop approac=
h
> > or in-loop approach currently in discussion.
> >
> > Regarding the perf test report by stress-ng [1] title:
> > 8be7258aad: stress-ng.pagemove.page_remaps_per_sec -4.4% regression
> >
> > The test is using below for testing:
> > stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --page=
move 64
> >
> > I can't repro this using ChromeOS, the pagemove test shows large value
> > of stddev and stderr, and can't reasonably refect the performance impac=
t.
> >
> > For example: I write a c program [2] to run the above pagemove test 10 =
times
> > and calculate the stddev, stderr, for 3 commits:
> >
> > 1> before mseal feature is added:
> > Ops/sec:
> >   Mean     : 3564.40
> >   Std Dev  : 2737.35 (76.80% of Mean)
> >   Std Err  : 865.63 (24.29% of Mean)
> >
> > 2> after mseal feature is added:
> > Ops/sec:
> >   Mean     : 2703.84
> >   Std Dev  : 2085.13 (77.12% of Mean)
> >   Std Err  : 659.38 (24.39% of Mean)
> >
> > 3> after current patch (mremap refactor)
> > Ops/sec:
> >   Mean     : 3603.67
> >   Std Dev  : 2422.22 (67.22% of Mean)
> >   Std Err  : 765.97 (21.26% of Mean)
> >
> > The result shows 21%-24% stderr, this means whatever perf improvment/im=
pact
> > there might be won't be measured correctly by this test.
> >
> > This test machine has 32G memory,  Intel(R) Celeron(R) 7305, 5 CPU.
> > And I reboot the machine before each test, and take the first 10 runs w=
ith
> > run_stress_ng 10
> >
> > (I will run longer duration to see if test still shows large stdDev,Std=
Err)
> >
> I took more samples (100 run ), the stddev/stderr is smaller, however
> still not at a range that can reasonably measure the perf improvement
> here.
>
> The tests were taken using the same machine as (10 times run above)
> and exact the same steps: i.e. change to certain kernel commit, reboot
> test device, take the first test result.
>
> 1> Before mseal feature is added:
> Statistics:
> Ops/sec:
>   Mean     : 1733.26
>   Std Dev  : 842.13 (48.59% of Mean)
>   Std Err  : 84.21 (4.86% of Mean)
>
> 2> After mseal feature is added
> Statistics:
> Ops/sec:
>   Mean     : 1701.53
>   Std Dev  : 1017.29 (59.79% of Mean)
>   Std Err  : 101.73 (5.98% of Mean)
>
> 3> After mremap refactor (this patch)
> Statistics:
> Ops/sec:
>   Mean     : 1097.04
>   Std Dev  : 860.67 (78.45% of Mean)
>   Std Err  : 86.07 (7.85% of Mean)
>
> Summary: even when the stderr is down to 4%-%8 percentage range, the
> stddev is still too big.
>
> Hence, there are other unknown, random variables that impact this test.
>
I could not repro the 4% degradation with my test machine
(Chromebook), this can be entirely due to the specific test and this
test machine.

Do you think it is possible to do a few more tests ? This time I like
to have a larger sample size (100 run)

stress-ng --timeout 60 --times --verify --metrics --no-rand-seed --pagemove=
 64

Please run the test for each commit following the exact steps, e.g.
reboot the machine, run the test, get the first 100 results for
sample. Please don't select or drop any unstable report because then
the data will be biased. If possible, please includes stddiv and
stderr for the data (or raw data if not possible, and I will do
post-processing)

for 3 commits:
-> this patch.
-> after mseal feature
-> before mseal feature

Thank you for your time and assistance in helping me on understanding
this issue.

Best regards,
-Jeff

> -Jeff
>
> > [1] https://lore.kernel.org/lkml/202408041602.caa0372-oliver.sang@intel=
.com/
> > [2] https://github.com/peaktocreek/mmperf/blob/main/run_stress_ng.c
> >
> >
> > Jeff Xu (2):
> >   mseal:selftest mremap across VMA boundaries.
> >   mseal: refactor mremap to remove can_modify_mm
> >
> >  mm/internal.h                           |  24 ++
> >  mm/mremap.c                             |  77 +++----
> >  mm/mseal.c                              |  17 --
> >  tools/testing/selftests/mm/mseal_test.c | 293 +++++++++++++++++++++++-
> >  4 files changed, 353 insertions(+), 58 deletions(-)
> >
> > --
> > 2.46.0.76.ge559c4bf1a-goog
> >
