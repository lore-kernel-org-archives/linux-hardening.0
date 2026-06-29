Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCB3655F1
	for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753698; cv=pass; b=OTc+66JhbN2l5iVvIK66Xq/96xX/Rm7clGe5iQR0kVEVidCICgN3fmgY8H9x29L7pBwwTNHd3a6tVVqSOoLFVz/hMB9FP87cf816tWpL0WBYD2qHB7UGhAQ41hC6UdPUcU0iPSMcwb2EIV7aWyAKYtGNDt0b40/niVDmqx9V83I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753698; c=relaxed/simple;
	bh=/4Qmn70nDZq36m22arIwXF/TWVSWeMjlYJlgHiPxw+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEJLGEgnDPcsx9l/QoD2FgYDmtweNV7+rwqMLVmEwkrp47N4BO7o2Hj+FkIjSc8NWu58jxLsoP4aEDR46uhc1q+Zb5N+7bC9mVHQFOH/bNL62IgwyZUxjmlASJtxU3shVcwnBfl+KSsJKrQvHjVgZL4hVHIDejfQUglsWvAwkoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=r1WmMTMO; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="r1WmMTMO"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c95a0c0aa2so25183885ad.3
        for <linux-hardening@vger.kernel.org>; Mon, 29 Jun 2026 10:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782753694; cv=none;
        d=google.com; s=arc-20260327;
        b=X7fs6YegK0IXc8X47UOlh1bwLzHh1Uh3ugdpmr0F85r9/2Ig0jwLkes2duzDSpfudC
         JfEci0JQulawRhXI3rHs9vhDFc2k8Y/fIlrRZOtroGWgX71lC6gybYSwQPPTkX5rHOIG
         9jYQzbo3wY6HtaGN+D9DIQL/jm0qwE3X7NobYAkH9wivNibCPdSzBlkuBnVr337xpdL8
         e+eA6jvKRHd93+uovDwvSSQctsb9OX80oKmLg6GdAcIIUg+j9bR0HjceUXPPAEQm/I96
         H6+XGWTLVi8yOqsLLr5KYeJ8pvnzHcYzb4vMMmO/5eoc5ELtSimXgew+dEwsBnMR1Xcu
         QwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nXmU7N9KWmAg5ZvphtB/jXefjrQWssfZEA+qOsBjMSA=;
        fh=KEn/GIuyxUr/MHjTbeM4SztGoVs0Njuo7Yuv/52nB2I=;
        b=LNUZnlDQbpyryGR76cmMSVewSzQnpjTC653AJHgOA+yFU4RDKkH4SrD3s1WUmErGSc
         ZrQkKxtppRL/3FxqmEukvZtKt+HTvMJDGOJ/RtSLczD7zcqrvVpEW9T039/c1girkSHk
         OZCs0okBY85RBOfSXPYA35M2T1mIO1Db0hJiOUKBFAel8+/2O4MHeZLerUDnR0vBwRRd
         LarEkdSPsqyx3CV3Jm+drGPiiMzwEHUwKMDACoMA5ud/tYUJ81Iaz+4/JPczE1zbAE30
         d0GzhcQ4Htn80xcwo33et/lsITiYnqv/LYUqfOifD40mMkk9Tmce0bS4CkhaoWQPe5/e
         xXYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782753694; x=1783358494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXmU7N9KWmAg5ZvphtB/jXefjrQWssfZEA+qOsBjMSA=;
        b=r1WmMTMODA773wccg2jgG8c+2G+he4Nap03lCkFIBchROVvnLWqoixGJcbJ5XNRXYy
         2aOEqEOsTseQk7Ehuvx2nYTy43ZS5b/n8Q9OMPG3eTbwLxJhGhkXJocfUGMzoF5pB+P2
         3/Ua1XPgcR+3AkGDEZIZEjbddt2lvC33U7gLvkHykfD9bZ5I8tF9SSUvugoO5vn5iUl5
         8eCdz4tslDVVxlZ13JDfnAGxUghxDovxbZUHynQ+nk/CL+LMW/tpQoi+vJ+vCPbVjiJs
         QypxhAmBPw0VsnDgJV45xacJBmfmUp+62DNDHJphe387O6KkNk2fDqycCzE83hb/zCt9
         c47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753694; x=1783358494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nXmU7N9KWmAg5ZvphtB/jXefjrQWssfZEA+qOsBjMSA=;
        b=ltYh2ZFl5pYeOM1vI/c/Cz5vJfEls9Qo+YZfpQ3BK9s/iuV6/F1NzNCEh9nwZ19xdL
         lkK6zzTKWltihK606RAiv4GUabEVwNvQQiMc5cOfPQ59YXsOC+E4HyQjiHkfAtNe8QtS
         d7E1cNU9ZHF52GhygZG+Dq3HC2RDYRh2U8p+dLPNE/+qS5mOwbv9/3Ir2MIa+ckkBI+Z
         8JrHDCJR6PpfvNO7N2QMlQeYjpCkHZCC6HAXp2RGd6O4awVy/gSOaoafAqH3m79L/sD3
         YFJrXaEET1YiUo78MZFhF05kukiHbSEjeuAzIAS9KxsDJvZf4qcQV3zzYK1pOfL+yrZo
         SQEg==
X-Forwarded-Encrypted: i=1; AHgh+RrAhPOput4FrVyfkxSzEbnaqsFVje6b0ftZoGmCewv0AvYH/wAL+cb6Qn3aXGpp8QdC1o7yM2D0xXiasyAr9cA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrD4nzQ9QHWEIBwI91JfaH3rPwoHQngoSVaHHeO2QgCWhYK0FJ
	UdG5fc+9PeopozHNrXttY71sK0il/CI2Ti4DPsPoh+6bbmDt3LecpYLeAzYju2Tsi0NPfanf9/w
	d831BQi4Vb5FZuO/yDIBNfVXElU4KrZ588PdLRxzn
X-Gm-Gg: AfdE7cl6TysNH/wYR8NA3DZ1yRxOYfWlkL+CAJl/WyOBkORZmx+zvJAyT0aOU3BOGsK
	aeYWXz0HMpTrXXgH3hli5LF4Dwwx3+m1Hrj+33Xt2mKuyjnR9XpHSifPz4CTdGZc7HReS8K7GM2
	V5F1ml5S/omXij/Nia6oNbvHe5R0fv40ok1SgIdxpvTFW1TFtbZiYDx6V9n5DCqzxq2M4Vn2dd+
	QavWhPhGY/VKuzsL2B+danwdSgU2Aej1gAqPhI/3BzwjJi4FLTSJJcMVz/aSPBw/8+VCRlCCf4j
	wV3IXBkB92m44odX8STGRXSK1C4rv7+IWCyJUbs=
X-Received: by 2002:a17:902:d2d0:b0:2ca:26:195d with SMTP id
 d9443c01a7336-2ca2d53dd40mr2407385ad.11.1782753694022; Mon, 29 Jun 2026
 10:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626173444.2252041-1-xmei5@asu.edu> <aj7UNceukU9zYeGH@pedro-suse.lan>
 <CAPpSM+RVFDOYJFT2iwgNYdjbwqF-MmrbYizpLYksd1SLb5bT9g@mail.gmail.com>
 <499a4e15-34a4-421b-946a-c855199fdbf9@zytor.com> <akH34ycu5-q2Yc_D@casper.infradead.org>
 <3c4094d8-ae5e-4ffd-b28a-0c10db50296c@zytor.com>
In-Reply-To: <3c4094d8-ae5e-4ffd-b28a-0c10db50296c@zytor.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 29 Jun 2026 10:21:20 -0700
X-Gm-Features: AVVi8CdDH6df1uqA9evZfvzbBY7svtEDKcDmc2IfSbHyvrdoUr7AcMeuMxGI6qE
Message-ID: <CAPpSM+TA6ECyCO4J3c9CrezbApMO66Fm5u8z6djDaFj5Wtagng@mail.gmail.com>
Subject: Re: [PATCH] mm/vmalloc: widen guard region to defeat ENTER-based
 stack pivot
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Jennifer Miller <jmill@asu.edu>, Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>, 
	Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>, Yan Shoshitaishvili <yans@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2026 at 5:50=E2=80=AFAM H. Peter Anvin <hpa@zytor.com> wrot=
e:
>
> On 2026-06-28 21:43, Matthew Wilcox wrote:
> > On Sun, Jun 28, 2026 at 07:09:37PM -0700, H. Peter Anvin wrote:
> >>
> >>> 2) `enter` is not rare since we can take part in the instruction.
> >>
> >> This sentence doesn't parse.
> >
> > They mean that we can jump into the middle of an instruction, and it is
> > not rare to see a 'c8' byte in the instruction stream.
> >
>
> OK, I see the point now. The main difference is that ENTER doesn't requir=
e a
> REX prefix, whereas ADD/SUB/LEA do (otherwise it truncates RSP and everyt=
hing
> immediately dies as a result of SMAP violations [you are welcome].)
>

Yes, Matthew's explanation is correct. (Btw, thanks Matthew!)

Xiang

> This means that an offending bit combination is far less common.
>
>         -hpa
>
