Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF41AC8AB
	for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724945427; cv=none; b=t0H9JVcMiMmbWpVc7CrCjhGasnyCypH/i4q6CAs9PxLdEz1QZRP6Hnf7zijlDQk6Pd7A0m3fb9sZA0ActvWRdQ/w2uqmSQs9QqyF6Bpuvja27upzEqalud4FFQe0ASA/1nwDhWTdqjOLcPpxEHutmRFtFVqcZiyneYuPXc2NRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724945427; c=relaxed/simple;
	bh=ah5xq0XzWgR3wqwzNeXrdDAaDaOFMa4cDEh8tekvkco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7KmSvU9sybvO24ANFSJDXBAvlY0bIJFTJW8gwY24MTHROJ7l82BJKI9cMK7bX778v3kTRlSAl+o6VFsOaTW3DLbFXr45v5G1QVga3wOnldqYJANrGeNddw6NPhiiP2J46xhv993EDGRHfTKqh2k1Jtxv2sIMGApO/LaOoR7+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Gxth0b/4; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gxth0b/4"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3dc39305ed6so59436b6e.2
        for <linux-hardening@vger.kernel.org>; Thu, 29 Aug 2024 08:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724945424; x=1725550224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GfirTw1c0aIcYb4weoxcT30+5e5JZv0jxRwuMnAz9/A=;
        b=Gxth0b/4021iOeaKj1n0nQpVgr+Sgm7FXvOCMe9NhsRM8dRvlrl7IRiUnZkSOPzMfc
         lkaPudCPNmv9MaJOWtJbBx/zPtt+iWQI7nhbJbl8SswguqA1pMQpbedzFJBcqsMl9FhP
         qC7Al9NZe5IHiDUAtqLM4hjuTrXCn63aqPan4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724945424; x=1725550224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GfirTw1c0aIcYb4weoxcT30+5e5JZv0jxRwuMnAz9/A=;
        b=VRACbUXrnbGDSakF4cmObiSkxx8zM1zzbqMWhFuwY08ettZv5IHB05RZ/OTWvZINYn
         rR3oGPBQYnFnE6bB2z3A9+/nTcajx3P+SSAyh4pN6zdK50AYnEVFHoZRTwmF9/JdnHwW
         go3yBmSZTT8aw+buSWz/6hvjWBhG5rE0gXcsOSOjrtdabvDxjFexFWt7yUHAmYFKeFqq
         H3/R65uAVjfomPX1DsygAola6BTGl3dyE8Y9FgBMBG8Le3EbCrzXt9hAN6QPcAfg9W3k
         U82vNbSk8UtCPbAF/ONU/RTKoOwo8PckffIiuJqTlP1XnSZV2djCStSNfSC/cXh/u9Et
         H0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWnb2dnCWCpNB6zHAQ/ClEZbkV8djJq58RXT8xmHextBNzXZd7GurbDJGsVgMMQPk/OoeLuYo/4lKanZ9Oe/dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFkASBOAuRQe2glUT0pSmHcTObifophdQBtBFXbdeGMNRRqonW
	eBtrqNuycoxTe9KXJDmJhHVkQfxb18Xmtgq4LORM9Z1YAm9zFidQK6p5xeYZMHkAPMQjZL2po3o
	jmNqM83vlcF7huQGTvNIe8hEuVZmSP0UaaJ0W
X-Google-Smtp-Source: AGHT+IGEUawEh3mfQp6LCKeSaw+tM4JS/Jg17r0MLTtyYvI0UVg00MKhSKv4na3gy4ai0yuC2fEh+dcYDGEE1VVcg80=
X-Received: by 2002:a05:6808:34b:b0:3db:421c:1bce with SMTP id
 5614622812f47-3df05c28735mr1735969b6e.1.1724945423657; Thu, 29 Aug 2024
 08:30:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828225522.684774-1-jeffxu@chromium.org> <20240828225522.684774-2-jeffxu@chromium.org>
 <CABi2SkW9qEOx1FAcWeBLx_EA8LT2V_U6OS1GmEP433oA6t35pw@mail.gmail.com> <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local>
In-Reply-To: <097a3458-0126-48e3-ba0d-d7dc7b9069d2@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 29 Aug 2024 08:30:11 -0700
Message-ID: <CABi2SkVe6Y4xypBw0n8QbqKJgsfy9YRNJWvBZ3bjTa=-Z5Zn2g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] selftests/mm: mseal_test add more tests
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, pedro.falcato@gmail.com, 
	rientjes@google.com, keescook@chromium.org, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo

On Thu, Aug 29, 2024 at 8:14=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Thu, Aug 29, 2024 at 07:45:56AM GMT, Jeff Xu wrote:
> > HI Andrew
> >
> > On Wed, Aug 28, 2024 at 3:55=E2=80=AFPM <jeffxu@chromium.org> wrote:
> > >
> > > From: Jeff Xu <jeffxu@chromium.org>
> > >
> > > Add more testcases and increase test coverage, e.g. add
> > > get_vma_size to check VMA size and prot bits.
>
> This commit message is ridiculously short for such a massive change, even=
 for
> test code.
>
> > >
> >
> > Could you please pull the self-test part of this patch series to mm-uns=
table ?
> > It will help to prevent regression.
>
> No, please don't.
>
> This needs review.
>
> These tests establish a precedent as to how mseal should behave, this is
> something that needs community review, not to just be taken.
>
> There's already been a great deal of confusion/contentious discussion
> around mseal() and its implementation.
>
> Pushing in ~800 lines of test code asserting how mseal() should behave
> without review isn't helping things.
>
> Also, this is a really unusual way to send a series - why is this a 2/2 i=
n
> reply to the 1/2 and no cover letter? Why is this change totally unrelate=
d
> to the other patch?
>
> Can you send this as a separate patch, preferably as an RFC so we can
> ensure that we all agree on how mseal() should behave?
>
> Sorry to be contentious here, but I think we need to find a more
> constructive, collaborative way forward with mseal() and to act with a
> little more caution, given the problems that the original series has caus=
ed
> I'd think this is in the best interests of all.
>
> Thanks for understanding!
>
There have been two bugs I found recently on mseal.
One during V2 of in-loop change and the other mentioned in 1/2 of this patc=
h.

These additional tests will increase the test coverage of mseal and
ensure the functionality of in-loop change is correct, also help to
detect future regression.

If you feel it will take time to review the test case, please do so
and comment on the tests itself directly, I will send V2 after that.

Thanks
-Jeff


> >
> > The first part ([PATCH v1 1/2] mseal: fix mmap(FIXED) error code) can
> > be ignored as Liam proposed to fix it differently.
> >
> > Thanks
> > -Jeff
> >
> > -Jeff
> >
> > > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > > ---
> > >  tools/testing/selftests/mm/mseal_test.c | 826 ++++++++++++++++++++++=
--
> > >  1 file changed, 759 insertions(+), 67 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/=
selftests/mm/mseal_test.c
> > > index e7991e5fdcf3..4b3f883aae17 100644
> > > --- a/tools/testing/selftests/mm/mseal_test.c
> > > +++ b/tools/testing/selftests/mm/mseal_test.c
