Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873A52038BE
	for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 18:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729274520; cv=none; b=ej42Q7WeIfb4ynW6LcWrMHuCJS+AOM7p225zp2AN8/jiWk6eyLYF2X8YM/nv9L3okrhEvG0RXfi4uOHp49HXNPFOrbot7UvIycdMDFhXW7zrBpM+kRNw/Hw2TKGR5rmRTJdZMb6KRcrkJ7FEVoobhJUpsCcFWEZz8HduSTYST5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729274520; c=relaxed/simple;
	bh=8rcchnUfthLl38vpr9Vp7U+3St9EqoU1pWs8x/Ug5SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VmHxmCT+n7JIH7NZHfQtvxSZe4l70ULHb+iDU1LTj/oyv6QPlgrj+jJ/qoXdsq8aT7gAnxfMPBob3z+hfyNovAUSYilnfN4NLMJoD7icH8xn4APqS+rMV7AT9RIV2OnmetC/ho2k/Z3Ek+msxwo0rxSTEMHveXruUKQNaHvmFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j2D9p7Sl; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j2D9p7Sl"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-288824e9cc4so302354fac.1
        for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 11:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729274514; x=1729879314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9OKp72oFdRRG8t+D/9JG91r+3KRfEXqiJBYSKDyOMOA=;
        b=j2D9p7SlxpG0hbJm6mWvncKT+FihaATtJrSuCL1ixga68Rrhe0SCto80r/CMKCp8WT
         sRdTIlz1baqqY5urpqWQ84KWyswMR6/C4SdZeAcLx/1+IVDA8FJ+wj00I7fMSyRx8f/t
         nKiDfZ19O1BMOFy5unW//n5EruUj6+f/aLpAk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729274514; x=1729879314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9OKp72oFdRRG8t+D/9JG91r+3KRfEXqiJBYSKDyOMOA=;
        b=jUCEOoecXhMhgUO94vNfOcKUcJ54JAutk4W7ECtOsw9yfZXfhx1yW25isH8zs6VDPE
         RUJIm9s9g4mBb5DzmTXQ7+esdQe31NR8zpu64lCEhHSAzhIknn/L9QMbZl4am/ugbCW4
         96fwUtvJRlSnRJX/F5C1rAT+/gORbpwJ9BTQXFbZ7p6zTNeoVvwAn9bA9vue7lBuTELu
         dk51SFoLJTIVdImjh0/JK0OciTZoofEa+nvDKNUg3KAs7k36lyetrYzj1se0tvgBVGYX
         qYYo6ALgshUCbtUcZeshklm9yQHJbsYyA90npy4PpabqJn9dJ4yWsmqLU4HeOpkOy5I0
         uNWw==
X-Forwarded-Encrypted: i=1; AJvYcCU7GXKFpnVCLmLDxabS/lEfEsYXNZKck2IAB5m7KFOcKKE32mJtFaEaX9ExnbQRcTbGh1fIxf0OPGKL8L1aKVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlXcynXpkGG4J2czS1Pb2gWoCBOOXThwCKO5F7DbDRLIkSUugT
	Rod981t/mhxnwEgKHd5arO+upJ1VsIxDAxFp1/hHsF2DMSaDSLUjqYxrJgCD7+58aOrG5JTRLJP
	uQI26i+CIaMKoKLXUeExsY8GpbthwhvRSfP3L
X-Google-Smtp-Source: AGHT+IGKPvjDV4dZmtSKWkrmR0IHyPkLSBZLU0gQOTWtc6F9ygGetic1QXOrzVfdzggME43tb3cFYb+uxSD7ggykO7U=
X-Received: by 2002:a05:6870:f115:b0:27c:df37:9e0c with SMTP id
 586e51a60fabf-2892c3426e3mr779683fac.8.1729274514353; Fri, 18 Oct 2024
 11:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e7ea2b84-8d10-40fe-a14f-837bca851ea9@lucifer.local>
 <fd927106-2fc3-4b96-8014-2c517229bc99@lucifer.local> <CABi2SkUpCf+aOa2sPED8CosG5ccqjFd7ouot8gXi9ECqsHiZhw@mail.gmail.com>
 <4944ce41-9fe1-4e22-8967-f6bd7eafae3f@lucifer.local> <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local> <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local> <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <c56aac50-83b5-45f2-8ddb-6980c22c059b@lucifer.local>
In-Reply-To: <c56aac50-83b5-45f2-8ddb-6980c22c059b@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 18 Oct 2024 11:01:40 -0700
Message-ID: <CABi2SkUiazcOnGZxVyb21jCa1gzOaQ1NPzjGJVX5a3kw1BBE0Q@mail.gmail.com>
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

HHi Lorenzo

On Thu, Oct 17, 2024 at 11:38=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Oct 17, 2024 at 12:49:40PM -0700, Jeff Xu wrote:
> > On Thu, Oct 17, 2024 at 12:00=E2=80=AFPM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > On Thu, Oct 17, 2024 at 11:47:15AM -0700, Jeff Xu wrote:
> > > > On Thu, Oct 17, 2024 at 11:29=E2=80=AFAM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > >
> > > > > On Thu, Oct 17, 2024 at 11:14:20AM -0700, Jeff Xu wrote:
> > > > > > Hi Lorenzo and Muhammad
> > > > > >
> > > > > > Reviving this thread since the merging window is closed and we =
have
> > > > > > more time to review /work on this code in the next few weeks.
> > > > > >
> > > > > > On Fri, Sep 13, 2024 at 3:50=E2=80=AFPM Jeff Xu <jeffxu@chromiu=
m.org> wrote:
> > > > > > >
> > > > > > > Hi Lorenzo
> > > > > > >
> > > > > > > On Sat, Sep 7, 2024 at 12:28=E2=80=AFPM Lorenzo Stoakes
> > > > > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > > > >
> > > > > > > >
> > > > > > > > I also suggest we figure out this FAIL_TEST_IF_FALSE() thin=
g at this point
> > > > > > > > too - I may be missing something, but I cannot for the life=
 me understand
> > > > > > > > why we have to assert negations only, and other self tests =
do not do this.
> > > > > > > >
> > > > > > > My most test-infra related comments comes from Muhammad Usama=
 Anjum
> > > > > > > (added into this email), e.g. assert is not recommended.[1] ,
> > > > > > >
> > > > > > > [1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e5=
8f336b6@collabora.com/
> > > > > > >
> > > > > > Specifically regarding Lorenzo's comments about FAIL_TEST_IF_FA=
LSE
> > > > > >
> > > > > > Muhammad Usama Anjum doesn't want assert being used in selftest=
 (see
> > > > > > [1] above), and I quote:
> > > > > > "We don't want to terminate the test if one test fails because =
of assert. We
> > > > > > want the sub-tests to get executed in-dependent of other tests.
> > > > > >
> > > > > > ksft_test_result(condition, fmt, ...);
> > > > > > ksft_test_result_pass(fmt, ...);"
> > > > > >
> > > > > > FAIL_TEST_IF_FALSE is a wrapper for ksft_test_result macro, and
> > > > > > replacement of assert.
> > > > > >
> > > > > > Please let me know if you have questions on this and Muhammad m=
ight
> > > > > > also help to clarify the requirement if needed.
> > > > > >
> > > > > > Thanks
> > > > > > -Jeff
> > > > >
> > > > > Right this is about not failing the test i.e. equivalent of an ex=
pect
> > > > > rather than an assert, which makes sense.
> > > > >
> > > > > What I'm saying is we should have something more like
> > > > >
> > > > > EXPECT_TRUE()
> > > > > EXPECT_FALSE()
> > > > >
> > > > > etc.
> > > > >
> > > > > Which would avoid these confusing
> > > > >
> > > > >         FAIL_TEST_IF_FALSE(!expr)
> > > >
> > > > FAIL_TEST_IF_FALSE(expr) is the right way to use this macro.
> > >
> > > But you don't only test position conditions, you also test negative o=
nes.
> > >
> > So it is not a problem with the MACRO, but where is it used ?
> >
> >         ret =3D sys_mseal(ptr, size);
> >         FAIL_TEST_IF_FALSE(!ret);
> >
> > Take this example, it would be
> > assert(!ret)
> >
> > The syscall return usually returns 0 to indicate success, where a
> > negative comes from, but dev should be so used to (!ret), it is a
> > common pattern to check syscall return code. e.g assert(!ret)
> >
> > Or do you have specific examples of code that caused confusion ?
> >
> >
> > > 'Fail test if false false thing' is really confusing and hard to read=
.
> > >
> > > I struggle to understand your tests as a result.
> > >
> > > I understand 'fail test if false' is expressive in a way, but it's re=
ally hard
> > > to parse.
> > >
> > If you just read it  as assert(), would that be easier ? (or you don't
> > like assert() ?)
> >
> > > Obviously it's also misleading in that you're saying 'fail the test _=
later_
> > > if false', which I hadn't even realised...
> > >
> > > It's well established in basically all normal test suites that:
> > >
> > > * assert =3D fail test _here_ if this fails (actually a valid thing t=
o do if
> > >            you assert something that means the test simply cannot
> > >            reasonably continue if that condition is false).
> > > * expect =3D the test will now fail, but carry on.
> > >
> > > I mean you work for a company that does this :) [0] this is a very we=
ll
> > > established precedent.
> > >
> > > [0]:https://github.com/google/googletest
> > >
> > Let's use expect as an example, let's say I create a new Macro:
> > TEST_EXPECT_TRUE, which basically is same syntax as
> > FAIL_TEST_IF_FALSE, I'm not sure how it is different: you still have
> > !ret in the code.
> >
> >  ret =3D sys_mseal(ptr, size);
> >  TEST_EXPECT_TRUE(!ret);
> >
> > Or is the FAIL_xxx_IF_FALSE pattern more un-readable than  EXPECT_TURE
> > ? maybe ..
> >
> > > >
> > > > It is same syntax as assert(expr), e.g:
> > > >
> > > > man assert(expr)
> > > >        assert - abort the program if assertion is false
> > > >
> > > > FAIL_TEST_IF_FALSE is a replacement for assert,  instead of abortin=
g
> > > > the program, it just reports failure in this test.
> > >
> > > So doesn't at all do what assert does, because that _does_ terminate
> > > execution on failure...
> > >
> > I don't know what you mean, the test case will fail, but the next test
> > case will run. This the point, the mseal_test continues to run all
> > test cases to finish, even if one of the test cases is failed.
> >
> > > We are writing unit tests in a test framework, let's use very well
> > > established industry practices please.
> > >
> > > Also note that you don't even need to reinvent the wheel, there is a
> > > fully-featured test harness available in
> > > tools/testing/selftests/kselftest_harness.h with both ASSERT_xxx() an=
d
> > > EXPECT_xxx() helpers.
> > >
> > The EXPECT_xxx() doesn't take care of reporting though,  or maybe it
> > needs to be combined with FIXTURE_SETUP, FIXTURE_TEARDOWN. I haven't
> > spent much time on those, but on brief look, it seems it is for
> > repeating some tests, which doesn't exactly fit into what I needed,
> > e.g. the sealed memory won't be unmapped.
> > It is possible that those tests can be adopted to use test fixtures,
> > but I don't see significant gain for that.
> >
> > > I've used it extensively myself and it works well.
> > >
> > > I'd basically suggest you use that. Though moving existing tests to t=
hat
> > > would be some churn.
> > >
> > > On the other hand I really can't accept patches which are totally
> > > unreadable to me, so you'll need to fix this one way or another, and =
the
> > > churn is worth it as a one-time cost to be honest.
> > >
> > > >
> > > > Is this still confusing ?
> > > > (The FAIL_TEST_IF_FALSE is already a descriptive name, and the synt=
ax
> > > > of assert is well known.)
> > >
> > > It's a super misleading name as it says nothing about _WHEN_ the test
> > > fails. Also the syntax of assert() may be well known but you don't ca=
ll
> > > this function assert, you don't reference assert anywhere, and you do=
n't do what
> > > assert() does so, you know, That's not a great example.
> > >
> > > The semantics of unit test frameworks are very well known, and alread=
y
> > > implemented for you, and also do not require you to do unreadable dou=
ble
> > > negations for no reason, so let's use those please.
> > >
> > As stated previously, I'm not sure whether the test fixture is
> > benefiting mseal_test at this moment.  But I'm open for future
> > conversion when I have time for this. For now, I like to get those
> > tests in so we can properly detect  possible regression for memory
> > sealing.
> >
> > What will help you better review this code? Would the below help ?
> >
> > s/FAIL_TEST_IF_FALSE/TEST_EXPECT_TRUE/g
>
> Jeff, you're falling into your usual pattern of being unreasonably
> argumentative for apparently no reason and I really don't have time to
> constantly respond inline when you're just ignoring what I tell you.
>
> You do this on nearly all code review and this just isn't working. If you
> want to effectively be involved in mseal you need to LISTEN.
>
> The more you do this the less patient everybody gets with you and the les=
s
> likely your series will ever get merged. This is not good for mseal or
> anybody involved.
>
> On this issue - either use sensible macros that YOU ARE DEFINING, not
> assert.h, but YOU, that allow you to evaluate whether a condition is true
> or false - or I will not accept your unreadable test code.
>
> It's that simple and I'm done discussing this.

Thanks for your time on discussing this.

Please, if I may say, when presenting your argument, keep it technical
and avoid personal attack. Using personal attacks rather than using
logic to refute your argument is =E2=80=9CAd Hominem Fallacy=E2=80=9D [1]  =
and will
make it harder to get your point across.

[1] https://www.txst.edu/philosophy/resources/fallacy-definitions/ad-homine=
m.html#:~:text=3D(Attacking%20the%20person)%3A%20This,who%20is%20making%20t=
he%20argument.

Additionally, The mseal_test was reviewed-by Muhammad Usama Anjum
during original RFC discussion. IIUC, Muhammad Usama Anjum has domain
knowledge for selftest infra, and I have relied on Muhammad=E2=80=99s comme=
nts
and implemented all those comments.

I'm not saying there is no room for improvement, but it should happen
in more respectful and constructive ways. In any case, I hope we have
common interest  and passion to  get more test coverage to avoid
future regression.  Given that we had 2 regressions in the past during
code reviews and a pending regression to fix at this moment in memory
sealing area,  the benefit of additional test coverage is obvious.

Specific on FAIL_TEST_IF_FALS macro, during the course of this
discussion, your comments have started with, and I quote:

=E2=80=9C Why do we not have a FAIL_TEST_IF_TRUE()? This is crazy.
  Would be nice to have something human-readable like ASSERT_EQ() or
ASSERT_TRUE() or ASSERT_FALSE().=E2=80=9D

=E2=80=9CThis is beyond horrible. You really have to add more asserts.=E2=
=80=9D

TO my response:

=E2=80=9CASSERT_EQ and ASSERT_TURE are not recommended by the self-test. Th=
e
FAIL_TEST_IF_FAIL wrap will take care of some of the admin tasks
related to self-test infra, such as counting how many tests are
failing.=E2=80=9D

And your question:
=E2=80=9Cwhy we have to assert negations only, and other self tests do not =
do this.=E2=80=9D

And my response:
"My most test-infra related comments comes from Muhammad Usama Anjum"
(added into this email), e.g. assert is not recommended.[1] ,
[1] https://lore.kernel.org/all/148fc789-3c03-4490-a653-6a4e58f336b6@collab=
ora.com/"

And my additional  try to clarify about your question about negations:
=E2=80=9CSo it is not a problem with the MACRO, but where is it used ?
        ret =3D sys_mseal(ptr, size);
        FAIL_TEST_IF_FALSE(!ret);
Take this example, it would be
assert(!ret)
The syscall return usually returns 0 to indicate success, where a
negative comes from, but dev should be so used to (!ret), it is a
common pattern to check syscall return code. e.g assert(!ret)"

And I offer an alternative approach for macro naming:
"ret =3D sys_mseal(ptr, size);
TEST_EXPECT_TRUE(!ret);"

Which you didn=E2=80=99t respond to directly.

Given the situation, I think it might be best to let domain experts
from the testinfra team, such as Muhammad to suggestion a better
replacement for this macro.

Best regards,
-Jeff
