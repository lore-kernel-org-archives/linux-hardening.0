Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC180313E1B
	for <linux-hardening@vger.kernel.org>; Sun,  6 Sep 2026 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788727741; cv=pass; b=RTRVczkjH73FdUaN6wYGLfivKT11XlBDZQvv6t7f7DxraMmaFLGzPRBZEF5Rh/fXmqMGIXyvWcQCpJ3wFGcdPkUhIvfLftDBdSryZdNSwrp3emt9YP168cgwNcQYp6o+8Or+l23UQRkyDhdnIF6IhvhW49E7sGD+FK7gQK89jZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788727741; c=relaxed/simple;
	bh=L82HQAgQ+2CVzu0Q2LDItaAOLTBjlX7/PRc0nX33wE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T/DktgWgvN5c0b1ELOvvgFE9+l0sx9CRRnOyBq6pq7+vBPmFER+febIysHQcESBXiDS9BrDSetUW0ey/OY1sCcJjyigocnQtvXxSMKZbLkolmiyZFzy1QpsO0Ulw4uktQTTu/h6n5bxIlwpk37qL0iAZxQ+3TmDR8HRNrWTm210=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZk5KDXz; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZk5KDXz"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a2e9851ed7so26930421fa.0
        for <linux-hardening@vger.kernel.org>; Sun, 06 Sep 2026 13:48:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788727738; cv=none;
        d=google.com; s=arc-20260327;
        b=PJUjItbPCDVHRdGwQxwaZ54lXzuhb0D6eIs7PMd4xER6QhuGv2OkseAolsZ51a4ohI
         WcCKBGiAGjglz0mdogQpZd0+RnNB0Qbuil0JL+G1wVzBeDPNLNTukH7camQWMrw80CXI
         D8CJj5FTSn0MaAeHatY0vQ5/QS+kFIDsJpSwmZFedgSPvXxCrOU4mdZsDVWo6DpujEhx
         N7kZzHNP6by4LVAmSGEvVALd5DuMaojxuKFvst4bhIDmYVxYtok8mWJhejYBCKGA8I9t
         eFCFHT191iu9bEqBWTF2AHegQCOhEPw5OEbifTafgfKsGhHGjepE8YnZIjOS0qn2/yAh
         gIJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=L82HQAgQ+2CVzu0Q2LDItaAOLTBjlX7/PRc0nX33wE0=;
        fh=fNG1LCfALk9scs3JV2yqBovcPEu8OzJ2IOe1YAMWykU=;
        b=YNVyNwPwlnmMb3KBnU/FAl2UXleDKH6Y2cC8WoQJM4P/eZukQBg4fc69uQk4NgOTyQ
         CFCCzR+AQvJZrOI4rN2pYtxRfPOFgCaUjRGYNAqGIcooNvNAcm8FQgLqMaACpEIu6Gci
         BhL3+j8ARXqLD3Uwzbp0CjRJlO6lPnunHpDa6iDI9ljpjJHLk7CKyyDlEFJbFcdd8o/m
         txHoTZRGauMd68LpzTQYqN8M2rA6NuzX66UVcM2XcRcTpV2TCgbjqKFud7mX0zNpb4Uc
         VulTrf7CZR4z7tSnFhmOE0H8ytRd66yQS+36b68PDPdhEySmy3u3ZfItU+/D3xZtSSdS
         6CUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788727738; x=1789332538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L82HQAgQ+2CVzu0Q2LDItaAOLTBjlX7/PRc0nX33wE0=;
        b=cZk5KDXzUETzj8RP8JTI9IkiZEty11Uz/+7XcIxIdfsEdrw4wen89Gvqxcjc26irGP
         Fon3+vr1MngpXMTwXeyjEcQ/OIjz/vDjLR4EvT0P01TeWgBxnT5Vw8YMqu4W0H/jhdvQ
         NxR581SALe6XyO0zhxuz4HJsnq684Pa3R8coRqaEntbIVbOsW3iGgpACx9bWFpW7sGSA
         tm8x5uY55U6S9aHUX8RCXDpAXtzWEZdtW5POhbJn/VNYNBs2ulN9Rk6Igx6Fdr/9CKMR
         sZ+4lZxRH+JwaR0hpUYqpxWgS/rftIxaeGgUwjgDkNUUuhuuXe3xLtc8KpIjPlEPwZY/
         GSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788727738; x=1789332538;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L82HQAgQ+2CVzu0Q2LDItaAOLTBjlX7/PRc0nX33wE0=;
        b=FRBIYwVxGWPjXUDiJBC6G9ejtItLWlesrPSjYEW1bH0zNz6PrcX6b1sdCNlY+7GJxm
         FZzZ49vBWIagIbE4NM/jNcfJh7F+rnXm03rRmwE+U05Nc3mg/ee+tO+Gzc42CY3hzEng
         JdQCrmtMZBDenFM7/FZgSQkrF8vT/mPbeMW6cyLW0Grjt6n7R6ebm/ikhz6pba95MBa0
         Wy0OIUNl9dkXGBGATEVUpkUUqPRfYXq6PVzn75kMfcFItsanraLmQsUbmnISXvWEImDa
         euSOWZ+0olOyReoDAEF60vNAvwBdY/h3f7Bll+wIZVK7Th8WlbFTgdQ+20QSQYoRzYlA
         XxLA==
X-Forwarded-Encrypted: i=1; AKwUvBxVmoaJQfBHtyCmkRWAvnupQU+/DBmsIe+rwSZgW4ZzsAIfaBmBcSO0I7Woi3AzVT0B2BvAxNGQIR6dTrqxIVo=@vger.kernel.org
X-Gm-Message-State: AFuF++m8BwfkiiHFnGhl6i2TRt8QkwqHBGk+0BNKnwSpGpIMWF7o0IOC
	q6gaNc2UH/8i1rfvu4bGLZ+1WY/RQnF9rcTB8BXBWJewcqL8GT5TLNjRS+98bCfB8zg6SD/oEdN
	ZvsKkHpgkFBeVyiuCzKjUVySeGwzs/O8=
X-Gm-Gg: AYBFou29ssQ20+ir9BwpwGtVY/oXT6zLY19sHwqGXzdt4C1ujFLxmxTf/lt3n1bD/ty
	AoSNSJydh/WQ+OOX2mOsFDGOyIvdLjlmSo6eHVWxob69/fBIz4ZIgt2N1idqQg3elFo55JopzSR
	6On+NKXmrkdrEtvB1v58wIC04mpwZuFuAltzZNk77xTK2sgM8GKJus6OQy3TJ3PXxRphregJWTR
	ds+4PvRkvpPzljRBk22XfRK4O++965SWP/PVC50XfmfTI+dTVSctxTaIYq6NGTTLGEJ2fllkEJr
	BzxyYSjNHhfv0g/U0wkbcjfPpWWXvnYYtyU+UlGQ0KHJS/BuwnOZXFJrBWCPqCvtEUqXbxMb2Fd
	CM2s=
X-Received: by 2002:a2e:bc0d:0:b0:3a1:5172:c287 with SMTP id
 38308e7fff4ca-3a371b1c774mr20550341fa.5.1788727737292; Sun, 06 Sep 2026
 13:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-arch-kconfig-options-v2-v2-0-83e8245761a2@gmail.com>
 <20260905-arch-kconfig-options-v2-v2-21-83e8245761a2@gmail.com> <CA+=Fv5SC4qL76Fe_wk50p=8a069mKJ8ZAyUHMrP82DgvoHAsFg@mail.gmail.com>
In-Reply-To: <CA+=Fv5SC4qL76Fe_wk50p=8a069mKJ8ZAyUHMrP82DgvoHAsFg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 6 Sep 2026 16:48:45 -0400
X-Gm-Features: AcwNN1XRBHy89Hz-biLi2GuAv1p3kMnxoZpJdzyZFQd3kQ2qcC8_lvRB8_pS3ck
Message-ID: <CAEdQ38F9KRFWj4BuzWYvbN9xf5brhwfUZuj2DC92iR-b+2fhFw@mail.gmail.com>
Subject: Re: [PATCH v2 21/22] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, Kees Cook <kees@kernel.org>, 
	Marco Elver <elver@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 4:44=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi Matt,
>
> On Sat, Sep 5, 2026 at 9:30=E2=80=AFPM Matt Turner <mattst88@gmail.com> w=
rote:
> >
> > Implement the perf register sampling interface for Alpha. This enables
> > perf to capture register state and user stack dumps with samples,
> > supporting --call-graph dwarf.
> >
> > The perf_regs enum exposes the registers available in pt_regs: r0-r8,
> > r16-r28, gp, pc, and ps. Registers r9-r15 are callee-saved and live
> > in switch_stack, not pt_regs, so they are not included.
> >
> > A switch statement maps perf register indices to pt_regs fields since
> > Alpha's pt_regs layout is non-contiguous (unlike architectures where
> > direct array indexing works).
> >
> > Assisted-by: Claude:claude-opus-4-6
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
>
> I think this patch still needs kernel-side work in addition to the
> matching tools/perf support.
>
> HAVE_PERF_USER_STACK_DUMP makes the generic perf code obtain the user
> stack pointer through user_stack_pointer(regs), which on Alpha returns
> regs->usp. However, the interrupt SAVE_ALL path does not initialize
> that field, and do_entInt() does not snapshot USP. A profiling
> interrupt taken from user mode may therefore attempt to copy the stack
> from a stale or uninitialized address.
>
> The proposed perf register ABI also does not include SP. A DWARF
> unwinder needs both the sampled stack contents and the corresponding
> stack pointer, so this cannot be completed solely by a later
> tools/perf patch.
>
> Would it make sense to drop this patch from the current series and
> submit the perf support separately, including USP capture on interrupt
> entry, SP in the kernel perf register ABI, and the matching tools/perf
> support? That would allow the rest of this series to proceed without
> waiting for the perf interface to be completed.

Yes, let's drop this patch from the series.
