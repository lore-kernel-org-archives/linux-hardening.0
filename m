Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F9E2BB04
	for <linux-hardening@vger.kernel.org>; Thu, 15 Aug 2024 03:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723693559; cv=none; b=afpar4fJ6pX78CiJC0kS9bRX7bokBtT8TxoFc90YOtTcxgGhoRE7WWRcs1acR7DgJxHV/4mQEu58glQ04oZ6TE08FKL+Ml/AuM/5EWr7jiZ4zS4/mYAZkVoxBkMgUept9Sdh2WQNoFZHUZEqq2B5LQlRRPKDpGpsZjyRhiWW3LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723693559; c=relaxed/simple;
	bh=mH7zE/jCgQZeM/kxZ3PCBMpoYXP8P2pcTozWixqUyHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JsNYEHby4X4z7oNXZMDSrX87U657U4JQHn10JTkllTlBiOo7skhoB54ZgPwWmKeRs9SJfW3O2imQmD2OkV2S4rQc9bQ05sHrbTfsRvtqGgP4UiQhw19GrIo27j1xTl8SGaEx62ddW7gxqW7KkP0DoQocsFXYlFiE+voEOFZSIfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LvugTs+j; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LvugTs+j"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3db14cc9066so349759b6e.3
        for <linux-hardening@vger.kernel.org>; Wed, 14 Aug 2024 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723693557; x=1724298357; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TesR0iaPHv+pQXDwuhp3Ea2WallNLcprPIy2NI2Saw=;
        b=LvugTs+jpTU5ewS4/Q0Ai4mycbaaglRtyY3ED5OufohcqYK2PolC/T8fK6SYr5Z5nN
         BOikK3/cS8R/NhMIDVPoyfIAwOFtr/ek+nFbJglmwlAPEFNQnMxZvs1zbhRtmEEUth7q
         YfAFjpsyWC2yrVcIPlPGjM2MrE/KlE/HD0Mss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723693557; x=1724298357;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TesR0iaPHv+pQXDwuhp3Ea2WallNLcprPIy2NI2Saw=;
        b=OEMhyEj+nHfy86eeOSwVG5VTrg6NFXOhKiN1iknt2091goyaAXBLexzosG5It4ZtOs
         i/BOjoEs9DWPtvohhpX/LeASde1qF1v1XbClciN3QURJ/6fBVGaGqeg3uVp77IUocFLg
         EWDFNOEKd6klHE7RxmutzAlDKK4q4S5L6L61/l+LoVOn6x0V5uk5+ISwgk3MuQeIJg3m
         R1MdraiJrqDIz9WoSlTSWQWbjxvnYjDazzjzWEePon+Mqz1mN140K3MXoqXFVRuQ23zq
         hGsmC+FOt/SX0WTjKjGQt6rM2Bjmq/PXAsmh23QhgKDHyGWTv2v4B0BgmJfL4lmNWtMh
         hqVg==
X-Forwarded-Encrypted: i=1; AJvYcCVJTDmONrJi5nJVYf9JGIweopjyEMBubmENrvdgWUU71pTvdEWVskuWL7I8+ESyFle0MkbyOzySrBFu9PtcFnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyMCQtiB3jPtyYJycfToxjl5+oiT0BLrnjHkhTE3c3BeDtFls
	rDvu+MyLZ0BxX38WR2sWhgks3CnhI3+m8L51+6ErbI/MVzzMxFG/Pgmp4mFtiZIFHUacBSnPXL8
	S74N3Dc+Al71Wo9TgK8VOemAJbhToY472mziX
X-Google-Smtp-Source: AGHT+IG/UY7m5KF1rwuDldmERWQ0AsiTHKeHrxEPwTp6C4SOyAl/Y7SgDW/UdHJ6AXFGvkl3b5/OLN3SrL3fX5uC0tA=
X-Received: by 2002:a05:6870:71d2:b0:268:bb3a:cfc0 with SMTP id
 586e51a60fabf-26fe59d8a6cmr5803059fac.1.1723693556523; Wed, 14 Aug 2024
 20:45:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814071424.2655666-1-jeffxu@chromium.org> <slrsrycj73xrph5o2poicpt4cogpqw36bbwi5iqykvyce4pve3@suldmmv2mmo5>
 <CABi2SkV2LcrkYOGzkGm80eYw-mhPNN=Q=P3aKGm0j8_gAwXjog@mail.gmail.com> <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
In-Reply-To: <mlwues5aus4uie52zi2yi6nwlaopm2zpe4qtrnki7254qlggwl@cqd42ekhrxez>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 14 Aug 2024 20:45:44 -0700
Message-ID: <CABi2SkVrk-MyMGVDzRZi++7tzCu6k92Vz4hyaVHY2nbYDxd97g@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mremap refactor: check src address for vma
 boundaries first.
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Jeff Xu <jeffxu@chromium.org>, 
	akpm@linux-foundation.org, willy@infradead.org, torvalds@linux-foundation.org, 
	pedro.falcato@gmail.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, jeffxu@google.com, 
	lorenzo.stoakes@oracle.com, mpe@ellerman.id.au, oliver.sang@intel.com, 
	vbabka@suse.cz, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:55=E2=80=AFPM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
> The majority of the comments to V2 are mine, you only told us that
> splitting a sealed vma is wrong (after I asked you directly to answer)
> and then you made a comment about testing of the patch set. Besides the
> direct responses to me, your comment was "wait for me to test".
>
Please share this link for  " Besides the direct responses to me, your
comment was "wait for me to test".
Or  pop up that email by responding to it, to remind me.  Thanks.

> You are holding us hostage by asking for more testing but not sharing
> what is and is not valid for mseal() - or even answering questions on
> tests you run.
https://docs.kernel.org/process/submitting-patches.html#don-t-get-discourag=
ed-or-impatient

> These patches should be rejected in favour of fixing the feature like it
> should have been written in the first place.
This is not ture.

Without removing arch_unmap, it is impossible to implement in-loop.
And I have mentioned this during initial discussion of mseal patch, as
well as when Pedro expressed the interest on in-loop approach.  If you
like reference, I can find the links for you.

I'm glad that arch_unmap is removed now and resulting in much cleaner
code, it has always been a question/mysterial to me ever since I read
that code.   Thanks to Linus's leadership and Michael Ellerman's quick
response,  this is now resolved.

Best regards,
-Jeff
