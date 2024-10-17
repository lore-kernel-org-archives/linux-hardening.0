Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B8A218D72
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729190853; cv=none; b=hyyLulvLkoz4o2z9coR70PF6g5toxOhE0AaTX3OeKDDy04/P3E890JitJeuVEjuwLbnJUOodtGnJWZ9KFq6LC4JfactOaCEivlRE4bu2BAmOZRwxuQBr+muELGmVlBX6MZSAacueOLWvsYyCXADObDlDqcdolygWqrlPF0ExTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729190853; c=relaxed/simple;
	bh=sTU+Q4SmI7eiwg9JNAXqdxPxcJv34tZtDWxgDyCK/H8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VxRX5an9ozi+8MuDm1woWsMW1HcjAtoUz5CCWKVdlXDDuak99HRl9s01qQHX+2VNsioRCFaJZcNtJFSjf3drC805SIOKfFv7AQ2ZvD+/dydvCtvzvjSiYo61kliazZm+Ymh5K1f9maR7HQ+/JjU4UAaAKvKG/Jx8xCgD3XrT3T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wc/dJn2m; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wc/dJn2m"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2886681064dso101746fac.0
        for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729190847; x=1729795647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xz9ukrGeZskaQB9yt/h8UcekXyqlQc0oC5gnfYFoitY=;
        b=Wc/dJn2mXGyU2q1WmchIqmtm8gTzPTrnoKAkCUhnDdrhwQJSUlkNe0+IbGubO4KLc1
         V5SmCKnbFARdDIIMGfeR/ogfuJO8mRVxZJG8ggPhEpA69tspLmD1EzSbXjpn6HFqFUWE
         gYlHjuOmBqV1ULbuctPafnS5elrVg6eyyWhM0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729190847; x=1729795647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xz9ukrGeZskaQB9yt/h8UcekXyqlQc0oC5gnfYFoitY=;
        b=bNLccYhqEnClbzDCJ/UbsyuflWU1+0omJxcvFEZKJXLLaz9sGdHzq+x8ApBz2j7PPF
         LPgrtLjKNPYHi1oj7kQ6EjxR9wKy/c4l2/ZxHLKSqlBpvab7siPUGHEd/Ji6shvNjyE+
         FYJIBBCtFFC3z81N4rStbUrkgQxworhv2oJgmpGSDzY/bIMQvuZuG3IzOdDSo9a+6aPn
         ZPFmII+1thoos2WYv84webXg0y2aSs3cd3DOQmvWyqxbQ9PM7QWxXBN5JGEsuLYhRsNB
         3JVB/MdAUv/Uk0E6M6dQ+D+5odmO4KyBVz9wV/VwURtFrkgiIXLjbbzWRFbHZdS/HbGs
         SI9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhPgoowlFWEuhPCt29WugYzab66LZvjVrBUEfLA8Xp53ZNaGprI6uKYbAk38TTTV2MGWbsjnxHoxKDR0vqBa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQARSjYo/4vu6SVHY+5AisZ+LFthBzKRRgCw5TJQspybPBBucD
	12U7yx0d0BbPtQHHO0Rqa0sGNzX9fKBPx1qxPHrvDC3zzghPsiEcPXUnOTnDHKMo/6cON8DWXfW
	W7vhXgB3qpaE2OhxuOf3s9BtLQy/NJYftziCh
X-Google-Smtp-Source: AGHT+IHnPnMKVN7xETiLGgLh9nYMnnwfKNJyUoWQMiSO1nxymCwBZOclTUBjKAnm5eGb14csK/tlMg1ClzuBDfswtHY=
X-Received: by 2002:a05:6870:64a1:b0:286:f523:4d76 with SMTP id
 586e51a60fabf-28929452e7bmr90753fac.6.1729190847169; Thu, 17 Oct 2024
 11:47:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830180237.1220027-1-jeffxu@chromium.org> <20240830180237.1220027-5-jeffxu@chromium.org>
 <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local> <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local>
 <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com> <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
In-Reply-To: <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 11:47:15 -0700
Message-ID: <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, akpm@linux-foundation.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pedro.falcato@gmail.com, willy@infradead.org, broonie@kernel.org, 
	vbabka@suse.cz, Liam.Howlett@oracle.com, rientjes@google.com, 
	keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 11:29=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Oct 17, 2024 at 11:14:20AM -0700, Jeff Xu wrote:
> > Hi Lorenzo and Muhammad
> >
> > Reviving this thread since the merging window is closed and we have
> > more time to review /work on this code in the next few weeks.
> >
> > On Fri, Sep 13, 2024 at 3:50=E2=80=AFPM Jeff Xu <jeffxu@chromium.org> w=
rote:
> > >
> > > Hi Lorenzo
> > >
> > > On Sat, Sep 7, 2024 at 12:28=E2=80=AFPM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > >
> > > > I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at thi=
s point
> > > > too - I may be missing something, but I cannot for the life me unde=
rstand
> > > > why we have to assert negations only, and other self tests do not d=
o this.
> > > >
> > > My most test-infra related comments comes from Muhammad Usama Anjum
> > > (added into this email), e.g. assert is not recommended.[1] ,
> > >
> > > [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@=
collabora.com/
> > >
> > Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FALSE
> >
> > Muhammad Usama Anjum doesn't want assert being used in selftest (see
> > [1] above), and I quote:
> > "We don't want to terminate the test if one test fails because of asser=
t. We
> > want the sub-tests to get executed in-dependent of other tests.
> >
> > ksft_test_result(condition, fmt, ...);
> > ksft_test_result_pass(fmt, ...);"
> >
> > FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
> > replacement of assert.
> >
> > Please let me know if you have questions on this and Muhammad might
> > also help to clarify the requirement if needed.
> >
> > Thanks
> > -Jeff
>
> Right this is about not failing the test i.e. equivalent of an expect
> rather than an assert, which makes sense.
>
> What I'm saying is we should have something more like
>
> EXPECT_TRUE()
> EXPECT_FALSE()
>
> etc.
>
> Which would avoid these confusing
>
>         FAIL_TEST_IF_FALSE(!expr)

FAIL_TEST_IF_FALSE(expr) is the right way to use this macro.

It is same syntax as assert(expr), e.g:

man assert(expr)
       assert - abort the program if assertion is false

FAIL_TEST_IF_FALSE is a replacement for assert,  instead of aborting
the program, it just reports failure in this test.

Is this still confusing ?
(The FAIL_TEST_IF_FALSE is already a descriptive name, and the syntax
of assert is well known.)


>
> Things.
>
> Hopefully that's clear? Thanks!
