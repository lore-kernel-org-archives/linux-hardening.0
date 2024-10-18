Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12517E015
	for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 19:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279972; cv=none; b=ANh8vQhlorGtNYHq3B8JxatRHSp52XpuAFs1RvqoBYouoiKm9DBdO3ptFaur0iDDf1x2hwhlr5/GS51pvELnn2+9yAvZhLvFPe/VxGXYpHAh8V9TaGs2TfYwezCaw1B59eT/KXP0yEBPS/WF2IRMimrq152jq/VA7jXaBZ8/FCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279972; c=relaxed/simple;
	bh=B7xJeudKEQr3CYPi3UtHbVFs37By4lzyrFcH2pQyoCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE97RPif04WLZdZ3x+nTAiKLuPutLRLLPE5328TlGso3rE+654fE/JE5hgP4vy6LVooyJI8cv6VAOoBQn1Y7a9v+N3tPE4tC+NtohaRrzplWw+HN4skKntBMOAYpmIIkIXvFJRTdq2ubl6n3P3vNkMVKNn1PfnWatuRrOfQLOOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Oi11/AZ2; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Oi11/AZ2"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2884594d9f7so44448fac.1
        for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 12:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729279970; x=1729884770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gplWmfGOWe5Pq8fZbVA+dPlQSygIYBkNS0fSsl2L6Z8=;
        b=Oi11/AZ2wayVQcMc9u37JOzz53l3ij8B325AYM8fUo7Y8Qk+/2fdkqIdmnWkH7tWUv
         uw8ZVlEoH+i8p+zG1DDeXS0BjQ5TSIXf8kTEvBCJW2fEn7MJTYdB1fGF7LDIknRYn2Fy
         GYTa4PiM8KDmrM2i5io/0QdAEZG1r7FSB1xVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729279970; x=1729884770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gplWmfGOWe5Pq8fZbVA+dPlQSygIYBkNS0fSsl2L6Z8=;
        b=Vplud4NVMPSGPDZ1NdTfIaXVoM7uvEbRM5Hzm2XK6g4SMHCap6cGY3PDqwiT1T9FX7
         Rc9Xhxho3sLUNYHELvHjlO+12g8jrm8sVr2xl8642S+PGKh4PEqEyoduXyUumtVfOMlB
         abegi3OEZO4sx8iSCXL1KaoT7lzthSC4Ux15baSIhNM9rOsZRd/8ZzqDMKnbTYFF6gUf
         xGa0yHLtC55sdU7Wf4mUq+/F/NPN8ZLaPWXx00PHCBtwyB4/grVjWpAVo9ITgTwTDFLY
         jRqa4bEmmKwveU2QyCIoiwJs0whLCoAVnT1I0cUGafnbcuAKb27XPgfLMGDe/yfvkwSD
         gFEg==
X-Forwarded-Encrypted: i=1; AJvYcCVJbOitn2pXQeMtEAOzXuiNdr0wgfW5k0YQ3/uBnW4zHR2A/+DymQxBbt+jk3AZysBIOpBvGJLGaeyP/a2XH0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YynOlaWJ6ABe8TcpM/0xBq+7yGtdjTIf+vt4Gu2Jlhy6wbruz2s
	yOZlDCW3epeRxsynaCa+Cl3teTLtDAfFB6AgKK9w/bh9j4LosKgANL/JThV7jyd+01VEc560pIq
	jle7d1/sSAzJojgmdRhi3/UT5cYrstCsrqIEZ
X-Google-Smtp-Source: AGHT+IFVeKDD7KbSW5OcBfxhKKW+l7qGtWlzjoy4awnj9k9KumaMQ10QXXe1bakBP4FsadALWQQuMH8NVDjIEtvir80=
X-Received: by 2002:a05:6871:813:b0:278:2698:7721 with SMTP id
 586e51a60fabf-2892c3418dfmr810796fac.8.1729279969805; Fri, 18 Oct 2024
 12:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local> <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local> <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk> <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
 <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
In-Reply-To: <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 18 Oct 2024 12:32:37 -0700
Message-ID: <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] selftests/mseal: add more tests for mmap
To: Mark Brown <broonie@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pedro.falcato@gmail.com, willy@infradead.org, 
	vbabka@suse.cz, Liam.Howlett@oracle.com, rientjes@google.com, 
	keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mark

On Fri, Oct 18, 2024 at 11:37=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Fri, Oct 18, 2024 at 11:06:20AM -0700, Jeff Xu wrote:
> > On Fri, Oct 18, 2024 at 6:04=E2=80=AFAM Mark Brown <broonie@kernel.org>=
 wrote:
>
> > > The problem is that the macro name is confusing and not terribly
> > > consistent with how the rest of the selftests work.  The standard
> > > kselftest result reporting is
>
> > >         ksft_test_result(bool result, char *name_format, ...);
> > >
> > > so the result of the test is a boolean flag which is passed in.  This
> > > macro on the other hand sounds like a double negative so you have to
> > > stop and think what the logic is, and it's not seen anywhere else so
> > > nobody is going to be familiar with it.  The main thing this is doing=
 is
> > > burying a return statement in there, that's a bit surprising too.
>
> > Thanks for explaining the problem, naming is hard. Do you have a
> > suggestion on a better naming?
>
> Honestly I'd probably deal with this by refactoring such that the macro
> isn't needed and the tests follow a pattern more like:
>
>         if (ret !=3D 0) {
>                 ksft_print_msg("$ACTION failed with %d\n", ret);
>                 return false;
>         }
>
So expanding the macro to actually code ?
But this makes the meal_test  quite large with lots of "if", and I
would rather avoid that.


> when they encouter a failure, the pattern I sketched in my earlier
> message, or switch to kselftest_harness.h (like I say I don't know if
> the fork()ing is an issue for these tests).  If I had to have a macro
> it'd probably be something like mseal_assert().
>
I can go with mseal_assert, the original macro is used  by mseal_test
itself, and only intended as such.

If changing name to mseal_assert() is acceptable, this seems to be a
minimum change and I'm happy with that.

> > > I'll also note that these macros are resulting in broken kselftest
> > > output, the name for a test has to be stable for automated systems to=
 be
> > > able to associate test results between runs but these print
>
> ....
>
> > > which includes the line number of the test in the name which is an
> > > obvious problem, automated systems won't be able to tell that any two
> > > failures are related to each other never mind the passing test.  We
> > > should report why things failed but it's better to do that with a
> > > ksft_print_msg(), ideally one that's directly readable rather than
> > > requiring someone to go into the source code and look it up.
>
> > I don't know what  the issue you described is ? Are you saying that we
> > are missing line numbers ? it is not. here is the sample of output:
>
> No, I'm saying that having the line numbers is a problem.
>
> > Failure in the second test case from last:
>
> > ok 105 test_munmap_free_multiple_ranges
> > not ok 106 test_munmap_free_multiple_ranges_with_split: line:2573
> > ok 107 test_munmap_free_multiple_ranges_with_split
>
> Test 106 here is called "test_munmap_free_multiple_ranges_with_split:
> line:2573" which automated systems aren't going to be able to associate
> with the passing "test_munmap_free_multiple_ranges_with_split", nor with
> any failures that occur on any other lines in the function.
>
I see. That will happen when those tests are modified and line number
changes. I could see reasoning for this argument, especially when
those tests are flaky and get updated often.

In practice, I hope any of those kernel self-test failures should get
fixed immediately, or even better, run before dev submitting the patch
that affects the mm area.

Having line number does help dev to go to error directly, and I'm not
against filling in the "action" field, but you might also agree with
me, finding unique text for each error would require some decent
amount of time, especially for large tests such as mseal_test.

> > I would image the needs of something similar to FAIL_TEST_IF_FALSE is
> > common in selftest writing:
>
> > 1> lightweight enough so dev can pick up quickly and adapt to existing
> > tests, instead of rewriting everything from scratch.
> > 2> assert like syntax
> > 3> fail the current test case, but continue running the next test case
> > 4> take care of reporting test failures.
>
> Honestly this just sounds and looks like kselftest_harness.h, it's
> ASSERT_ and EXPECT_ macros sound exactly like what you're looking for
> for asserts.  The main gotchas with it are that it's not particularly
> elegant for test cases which need to enumerate system features (which I
> don't think is the case for mseal()?) and that it runs each test case in
> a fork()ed child which can be inconvenient for some tests.  The use of
> fork() is because that makes the overall test program much more robust
> against breakage in individual tests and allows things like per test
> timeouts.
OK, I didn't know that ASSERT_ and EXPECT_ were part of the test fixture.

If I  switch to test_fixture, e,g, using TEST(test_name)

how do I pass the "seal" flag to it ?
e.g. how do I run the same test twice, first seal =3D true, and second seal=
=3Dfalse.

        test_seal_mmap_shrink(false);
        test_seal_mmap_shrink(true);

The example [1], isn't clear about that.

https://www.kernel.org/doc/html/v4.19/dev-tools/kselftest.html#example

Thanks
