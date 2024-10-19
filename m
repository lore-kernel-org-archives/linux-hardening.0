Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F4623
	for <linux-hardening@vger.kernel.org>; Sat, 19 Oct 2024 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729296617; cv=none; b=RwG7Lge+cpUqI2NoI5biGWGeK+4Ocya8OTVBiZYkUOCRVczCF2KmEQ9J2HXwHN1d+UjpFOdjc+8/WSD4UsfM8Tuan/gerQ1zsQ0Zm5PsjI7GYdebptlamb0mMDhUGOdUF5N1h+a+5btQWWdirrE+YAgQSWix3wY35u84jekdz7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729296617; c=relaxed/simple;
	bh=9YE7dqGfVDQ/xH6Sdx54Ef6PxJ+cJabmZ9vzvXPouRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gDHnvzn8rlk0jI4tsBoLvkzZ12bZ7IHGELOepemywY2TYZoxd7KbWDInBi+UNdMfqHCsXIWpMNHs5B0gDO35PNqLIot6tedxsplM2S928pRNYZa2KC8lax2WFIKy1aZPpCT0AC01E/TTFlNDPtQ4U0pIqtXCu1PrIV1TCuhTo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fD7jR+Mt; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fD7jR+Mt"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-288fec398f8so178986fac.3
        for <linux-hardening@vger.kernel.org>; Fri, 18 Oct 2024 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729296614; x=1729901414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E22HImJZ028W/1sQ4maAbpjY4QAR955Gkk9SdRCpvUQ=;
        b=fD7jR+MtDCj3/nnkGWJvDef832IaUFNUGhQ3yI6u7ebatdSGu2CzvhD4WSk7PfIyVU
         9wFmFFIHFlB3DnMI9XuQFAATV42E1iwRA4Hf9c8YCGi0iVTV3SJFHRsVB1cuMHR7cv1U
         A4+yOyxc3W/LXOMwsAtQsTsA7wH+SfcndIrgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729296614; x=1729901414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E22HImJZ028W/1sQ4maAbpjY4QAR955Gkk9SdRCpvUQ=;
        b=mgg1o5p9wy1Zlv2qYcyEMlmCqojnF9qIXBikzHnQFKlTdWD3dirRZi0fKTbCqPWbtk
         JKAbzbm2rbJgtxwwdQVHTmyuB4XfQH+LAtXWjwsnfoBHSRxNdrGKoQuEYC2EBnO0+qnX
         YKiK/OxPN/vom9v5qrLl2bBfhj6LK795W9goN7keCTDY7Os4LbVOGdvZuDLr1DbYyQJx
         Lbzex3RrWOvQqFvWOTopE/iC/GdwEldVwBUzOh306UDxDjnUmBH6uMDi4J90pcsrmke4
         bIVVt2eYuKerJwnT6hFTvKth9JVf6uiRlkYz6fs0hc8izNa0i5Diyx4OGDC3kWFMBJAQ
         Z/YA==
X-Forwarded-Encrypted: i=1; AJvYcCUNAvotF+SgJueDS2P0ooQb2vewhkbR9QR78+4EcTxeTrcsQiVWMrN0S4yUjY9Cj8podg+GMHu0QIDJ6L7PuCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSlJul7t5YlKxngkrvFXYu169QprERZ+Eh1H0Xg9+bqnGF8B5e
	OhhizWMxk9bqXcoW1b8Vmj0gVZ8+WtRTId+fVtrXmmeMxcjHBidie1wmpZVZ5q570VMGgawiU43
	u5WAyetbXp4stfSSi+c5vi+QptUCmcoxABJv4
X-Google-Smtp-Source: AGHT+IFIihPyXoNPdentrsybY42eayzsimY1yFxEH7573nql2cE6j/C/m4TScAB/nVOH3efQdB/x8+eCEYm3oUOJiR8=
X-Received: by 2002:a05:6870:95a1:b0:27b:9f8a:7a80 with SMTP id
 586e51a60fabf-2892c55337bmr967265fac.13.1729296613985; Fri, 18 Oct 2024
 17:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABi2SkUgDZtJtRJe+J9UNdtZn=EQzZcbMB685P=1rR7DUhg=6Q@mail.gmail.com>
 <CABi2SkVEMRHV3swrbb6M5RA6GQpFVVx855CGwdQ1xiz3tygiqA@mail.gmail.com>
 <f9b9422c-216d-422e-94b4-d8814b0b277e@lucifer.local> <CABi2SkWAv4LXvR1Wb1e31eyZ35JfyieXhDOq1bp_ZvHPLLg-qA@mail.gmail.com>
 <e0f440b0-5a45-4218-8c51-27f848c0617b@lucifer.local> <CABi2SkWNRTCC0LzDSuzgjC1tO=KF==5FXUnPHOrPzEG5abAeDg@mail.gmail.com>
 <1f8eff74-005b-4fa9-9446-47f4cdbf3e8d@sirena.org.uk> <CABi2SkV38U-ZCAq9W091zYkOM1m5e-C27YmVXdTCi-t+p_W_fQ@mail.gmail.com>
 <a2652ed4-ea8b-4b56-bac6-6479b3df6c14@sirena.org.uk> <CABi2SkVF3OtRcq9cCgLh_hOjxRnWq0owypw++xodrEfm=dt_qA@mail.gmail.com>
 <6aefd38b-d758-4e7c-a910-254251c2a294@sirena.org.uk>
In-Reply-To: <6aefd38b-d758-4e7c-a910-254251c2a294@sirena.org.uk>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 18 Oct 2024 17:10:01 -0700
Message-ID: <CABi2SkUG8bhKQeHd_pvLw4y3ZY+Z8CvxZ_iV4YhTc+JQqe9TxA@mail.gmail.com>
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

HI Mark

On Fri, Oct 18, 2024 at 2:05=E2=80=AFPM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Oct 18, 2024 at 12:32:37PM -0700, Jeff Xu wrote:
> > On Fri, Oct 18, 2024 at 11:37=E2=80=AFAM Mark Brown <broonie@kernel.org=
> wrote:
> > > On Fri, Oct 18, 2024 at 11:06:20AM -0700, Jeff Xu wrote:
>
> > > Test 106 here is called "test_munmap_free_multiple_ranges_with_split:
> > > line:2573" which automated systems aren't going to be able to associa=
te
> > > with the passing "test_munmap_free_multiple_ranges_with_split", nor w=
ith
> > > any failures that occur on any other lines in the function.
>
> > I see. That will happen when those tests are modified and line number
> > changes. I could see reasoning for this argument, especially when
> > those tests are flaky and get updated often.
>
> > In practice, I hope any of those kernel self-test failures should get
> > fixed immediately, or even better, run before dev submitting the patch
> > that affects the mm area.
>
> That's not the entire issue - it is also a problem that the test name
> is not the same between passes and failures so automated systems can't
> associate the failures with the passes.
I failed to understand this part.
Maybe you meant the failing logging  is not the same across the
multiple versions of test code, by testname you meant "failing
logging"

>When a test starts failing they
> will see the passing test disappear and a new test appears that has never
> worked.
 > This will mean that for example if they have bisection support
> or UI for showing when a test started regressing those won't work.  The
> test name needs to be stable, diagnostics identifying why or where it
> failed should be separate prints.
>
If the test hasn't been changed for a while,  and start failing. Then
it is quite easy to run the same test on recent code changes. I think
you might agree with me on this. The only thing that bisec needs to
check is if the entire tests are failing or not.

I haven't used the biset functionality, so I'm not sure how it works
exactly, e.g. when it runs on the old version of kernel, does it use
the test binary from the old kernel ? or the test binary provided by
dev ?

> Actually, prompted by the comments below about test variants I've now
> run the test and see that what's in -next is also broken in that it's
> running a lot of the tests twice with sealing enabled or disabled but
> not including this in the reported test name resulting in most of the
> tests reporting like this:
>
>    ok 11 test_seal_mprotect
>    ok 12 test_seal_mprotect
>
> which is also going to confuse automated systems, they have a hard time
> working out which instance is which (generally the test numbers get
> ignored between runs as they're not at all stable).  The test names need
> to roll in the parameterisation:
>
>    ok 11 test_seal_mprotect seal=3Dtrue
>    ok 12 test_seal_mprotect seal=3Dfalse
>
> (or something, the specific format doesn't matter so long as the names
> are both stable and distinct).
>
Yes. Agree that this is a limitation of this macro.

> > Having line number does help dev to go to error directly, and I'm not
> > against filling in the "action" field, but you might also agree with
> > me, finding unique text for each error would require some decent
> > amount of time, especially for large tests such as mseal_test.
>
> In these situations if it's a typical Unix API function setting errno
> that failed I tend to end up writing diagnostics like:
>
>         ksft_perror("open()")
>
> possibly with some of the arguments included as well, or something
> equivalently basic for other kinds of error.  This is fairly mindless so
> quick and easy to do and more robust against line number slips if you're
> not looking at exactly the same version of the code, sometimes it's even
> enough you don't even need to look at the test to understand why it's
> upset.
>
I understand what you are saying, but personally, I still think line
numbers are a faster and more direct way to failure.

> > > Honestly this just sounds and looks like kselftest_harness.h, it's
> > > ASSERT_ and EXPECT_ macros sound exactly like what you're looking for
> > > for asserts.  The main gotchas with it are that it's not particularly
>
> > OK, I didn't know that ASSERT_ and EXPECT_ were part of the test fixtur=
e.
>
> > If I  switch to test_fixture, e,g, using TEST(test_name)
>
> > how do I pass the "seal" flag to it ?
> > e.g. how do I run the same test twice, first seal =3D true, and second =
seal=3Dfalse.
>
> >         test_seal_mmap_shrink(false);
> >         test_seal_mmap_shrink(true);
>
> That looks like fixture variants to me, using those with
> kselftest_harness.h will also fix the problem with duplicate test names
> being used since it generates different names for each instance of the
> test.  Something like:
>
> FIXTURE(with_seal)
> {
> };
>
> FIXTURE_VARIANT(with_seal)
> {
>         bool seal;
> };
>
> FIXTURE_VARIANT_ADD(with_seal, yes)
> {
>         .seal =3D true,
> };
>
> FIXTURE_VARIANT_ADD(with_seal, no)
> {
>         .seal =3D false,
> };
>
> FIXTURE_SETUP(with_seal)
> {
> }
>
> FIXTURE_TEARDOWN(with_seal)
> {
> }
>
> then a bunch of tests using that fixture:
>
> TEST_F(with_seal, test_seal_mmap_shrink)
> {
>         if (variant->seal) {
>                 /* setup sealing */
>         }
>
>         ...
> }
>
> TEST_F(with_seal, test_seal_mprotect)
> {
>         if (variant->seal) {
>                 /* setup sealing */
>         }
>
>         ...
> }
>
> You don't need to actually set up anything in your fixture, but you do
> need to have setup and teardown functions so the framework can emit
> required boilerplate.  The gcs-locking.c test I recently added in -next
> is an example of a similar thing where we just need the variants,
> there's no actual fixture.

Thanks! This is really helpful, I think the existing mseal_test can be
quickly converted using this example.

(A side note: if selftest documentation is updated to include this
example, it will be much easier to future dev to follow)

Thanks
-Jeff
