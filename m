Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D752E13D24C
	for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 19:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729194598; cv=none; b=MF66B/vC3YsBBwv1pYf+fhdWv35Y4EECIjpgbwTKKy78NrjVooo8HbBhc4Sl0l0NYMv4pPdX4+SLrkk2l1XK6ZGxYbxd6ZuSOFngWQIfr6ROfRohY4bjEI+OwXdIByJ49RUIvF7RC3Eq7RAVXm8sbaNMBbcZhu2qsxw49nMoiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729194598; c=relaxed/simple;
	bh=bzdp5xZJdhFDkGLVZGcwCXO8VJj0Rya3P/ni8hAFAOQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgsnwuNK6eVgko64YqTRApe9IROzJjlRF7opKtXi7eRH3pyHQmKKW57Dm1HrnxYJzsnzu+GIPnvmk/Y+HDbXK4Gvf+yMn55PFrORVFdA7LJikV1s0anMXtYbNGIrei+etMihJAL0xXyAotD5LdQxiHexlcv7ZcunmgDjpHR895c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WeEWIk8d; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WeEWIk8d"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288b33cbd04so80959fac.3
        for <linux-hardening@vger.kernel.org>; Thu, 17 Oct 2024 12:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729194593; x=1729799393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XkO2r3zzUNqzUbdoVFCuN5G5HuPfrDJEkzimPq4G1w=;
        b=WeEWIk8d6yuRNJmEJZjqzUdzdB864oEZcWVzwnrPlNXPAF5dt+VP+Y1HGVtYX2d4Oz
         XzmFkkxpkbNqXB0cKmpZZJusY8nLw6J/wAQwqoQaGb4+uD1Hqv4nwd5nvSDU/PYrfMwL
         m1xlU0EsorBiJDgt5wY6ixXstMOLPkT93NO7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729194593; x=1729799393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7XkO2r3zzUNqzUbdoVFCuN5G5HuPfrDJEkzimPq4G1w=;
        b=cRlN8nbEp3yohP+rTJxV+Mytp6O0IHaMi2hZmuX/mXpprvudAvfjZ43YYUiK+3d22O
         uzvCcViM/hraGxui6wF/xPreYV4l86HeluVisMncSSQeQzEnHSWNZ43Rt03nWGeoBspD
         MLQ0mCsJ2HogQtTc6jI59v1FiWStG89vzMNrqyzEbOe3QY/lq/4FE4ofVD3R91ah2fgj
         TtM3gYNRFHQULT7ap33UU6IEckn3CjMACGTfssT/xJ1EOLxd637XiOIOxKBhxPghjxnd
         Pae36gd2lWrC7OXDRFPZ1ygkxi+a9XJGVAfm61l7qWTV8zwgzkHRBDHYzCbk8ccTmuhT
         qs5w==
X-Forwarded-Encrypted: i=1; AJvYcCWVWQon/Ty1mO8F9ZwrF97RBsAhTnpko7MSlkXJCpeva5DV4iSK5UgIoap7iTodaok6a/U8O9O28pQSuEd6GZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuGF6S+DeLN68igiyR/Cd/MsX1IqKG/PSu1vRNW42Ea57G1rNL
	GOPM0opkqu2WH9gJj3eqJdNaYxJen2lYBd4tAfAxtluMkWML/diRMlZztbT1+bZKHEKDf+2lI03
	8bK5OlDJFNJ+a7Rt5MKs/rGSNZG/xYmJgkxl7
X-Google-Smtp-Source: AGHT+IEm/koDWIdypp8c7oq3Fku1eryn80Mc4GgdMntt4UDONrJNKs6/3s0FNzVqndj5P3G6PpGYxGY+1ORX2XtKfNw=
X-Received: by 2002:a05:6870:f115:b0:27c:df37:9e0c with SMTP id
 586e51a60fabf-2892c3426e3mr7600fac.8.1729194592767; Thu, 17 Oct 2024 12:49:52
 -0700 (PDT)
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
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local> <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
In-Reply-To: <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 17 Oct 2024 12:49:40 -0700
Message-ID: <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
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

On Thu, Oct 17, 2024 at 12:00=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Oct 17, 2024 at 11:47:15AM -0700, Jeff Xu wrote:
> > On Thu, Oct 17, 2024 at 11:29=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 11:14:20AM -0700, Jeff Xu wrote:
> > > > Hi Lorenzo and Muhammad
> > > >
> > > > Reviving this thread since the merging window is closed and we have
> > > > more time to review /work on this code in the next few weeks.
> > > >
> > > > On Fri, Sep 13, 2024 at 3:50=E2=80=AFPM Jeff Xu <jeffxu@chromium.or=
g> wrote:
> > > > >
> > > > > Hi Lorenzo
> > > > >
> > > > > On Sat, Sep 7, 2024 at 12:28=E2=80=AFPM Lorenzo Stoakes
> > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > >
> > > > > >
> > > > > > I also suggest we figure out this FAIL_TEST_IF_FALSE() thing at=
 this point
> > > > > > too - I may be missing something, but I cannot for the life me =
understand
> > > > > > why we have to assert negations only, and other self tests do n=
ot do this.
> > > > > >
> > > > > My most test-infra related comments comes from Muhammad Usama Anj=
um
> > > > > (added into this email), e.g. assert is not recommended.[1] ,
> > > > >
> > > > > [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f33=
6b6@collabora.com/
> > > > >
> > > > Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FALSE
> > > >
> > > > Muhammad Usama Anjum doesn't want assert being used in selftest (se=
e
> > > > [1] above), and I quote:
> > > > "We don't want to terminate the test if one test fails because of a=
ssert. We
> > > > want the sub-tests to get executed in-dependent of other tests.
> > > >
> > > > ksft_test_result(condition, fmt, ...);
> > > > ksft_test_result_pass(fmt, ...);"
> > > >
> > > > FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
> > > > replacement of assert.
> > > >
> > > > Please let me know if you have questions on this and Muhammad might
> > > > also help to clarify the requirement if needed.
> > > >
> > > > Thanks
> > > > -Jeff
> > >
> > > Right this is about not failing the test i.e. equivalent of an expect
> > > rather than an assert, which makes sense.
> > >
> > > What I'm saying is we should have something more like
> > >
> > > EXPECT_TRUE()
> > > EXPECT_FALSE()
> > >
> > > etc.
> > >
> > > Which would avoid these confusing
> > >
> > >         FAIL_TEST_IF_FALSE(!expr)
> >
> > FAIL_TEST_IF_FALSE(expr) is the right way to use this macro.
>
> But you don't only test position conditions, you also test negative ones.
>
So it is not a problem with the MACRO, but where is it used ?

        ret =3D sys_mseal(ptr, size);
        FAIL_TEST_IF_FALSE(!ret);

Take this example, it would be
assert(!ret)

The syscall return usually returns 0 to indicate success, where a
negative comes from, but dev should be so used to (!ret), it is a
common pattern to check syscall return code. e.g assert(!ret)

Or do you have specific examples of code that caused confusion ?


> 'Fail test if false false thing' is really confusing and hard to read.
>
> I struggle to understand your tests as a result.
>
> I understand 'fail test if false' is expressive in a way, but it's really=
 hard
> to parse.
>
If you just read it  as assert(), would that be easier ? (or you don't
like assert() ?)

> Obviously it's also misleading in that you're saying 'fail the test _late=
r_
> if false', which I hadn't even realised...
>
> It's well established in basically all normal test suites that:
>
> * assert =3D fail test _here_ if this fails (actually a valid thing to do=
 if
>            you assert something that means the test simply cannot
>            reasonably continue if that condition is false).
> * expect =3D the test will now fail, but carry on.
>
> I mean you work for a company that does this :) [0] this is a very well
> established precedent.
>
> [0]:https://github.com/google/googletest
>
Let's use expect as an example, let's say I create a new Macro:
TEST_EXPECT_TRUE, which basically is same syntax as
FAIL_TEST_IF_FALSE, I'm not sure how it is different: you still have
!ret in the code.

 ret =3D sys_mseal(ptr, size);
 TEST_EXPECT_TRUE(!ret);

Or is the FAIL_xxx_IF_FALSE pattern more un-readable than  EXPECT_TURE
? maybe ..

> >
> > It is same syntax as assert(expr), e.g:
> >
> > man assert(expr)
> >        assert - abort the program if assertion is false
> >
> > FAIL_TEST_IF_FALSE is a replacement for assert,  instead of aborting
> > the program, it just reports failure in this test.
>
> So doesn't at all do what assert does, because that _does_ terminate
> execution on failure...
>
I don't know what you mean, the test case will fail, but the next test
case will run. This the point, the mseal_test continues to run all
test cases to finish, even if one of the test cases is failed.

> We are writing unit tests in a test framework, let's use very well
> established industry practices please.
>
> Also note that you don't even need to reinvent the wheel, there is a
> fully-featured test harness available in
> tools/testing/selftests/kselftest_harness.h with both ASSERT_xxx() and
> EXPECT_xxx() helpers.
>
The EXPECT_xxx() doesn't take care of reporting though,  or maybe it
needs to be combined with FIXTURE_SETUP, FIXTURE_TEARDOWN. I haven't
spent much time on those, but on brief look, it seems it is for
repeating some tests, which doesn't exactly fit into what I needed,
e.g. the sealed memory won't be unmapped.
It is possible that those tests can be adopted to use test fixtures,
but I don't see significant gain for that.

> I've used it extensively myself and it works well.
>
> I'd basically suggest you use that. Though moving existing tests to that
> would be some churn.
>
> On the other hand I really can't accept patches which are totally
> unreadable to me, so you'll need to fix this one way or another, and the
> churn is worth it as a one-time cost to be honest.
>
> >
> > Is this still confusing ?
> > (The FAIL_TEST_IF_FALSE is already a descriptive name, and the syntax
> > of assert is well known.)
>
> It's a super misleading name as it says nothing about _WHEN_ the test
> fails. Also the syntax of assert() may be well known but you don't call
> this function assert, you don't reference assert anywhere, and you don't =
do what
> assert() does so, you know, That's not a great example.
>
> The semantics of unit test frameworks are very well known, and already
> implemented for you, and also do not require you to do unreadable double
> negations for no reason, so let's use those please.
>
As stated previously, I'm not sure whether the test fixture is
benefiting mseal_test at this moment.  But I'm open for future
conversion when I have time for this. For now, I like to get those
tests in so we can properly detect  possible regression for memory
sealing.

What will help you better review this code? Would the below help ?

s/FAIL_TEST_IF_FALSE/TEST_EXPECT_TRUE/g


> >
> >
> > >
> > > Things.
> > >
> > > Hopefully that's clear? Thanks!
