Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76511422DD
	for <linux-hardening@vger.kernel.org>; Thu, 13 Feb 2025 02:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739412600; cv=none; b=F4+5/dko/ErdNJ8X0Yd4iX8BbLmJPPcf/JncVVf3zGqL6dpS/geXJInX5CBwOubK8Krt1TXsPcgqR1QAgolr6GMBdSpUfdFr/Yu4bdseldOYQLUuwGJTSNxv3L4pOl/u/ptUDho26me0dXMcqp8dKwgzaBl4Dzq+ghB/o/6IoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739412600; c=relaxed/simple;
	bh=D/w0ZwtRtYcmWs37X8IYT8H9Nl48IrgHcsGVG2ENYnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y6xgcZYh9qaIlJW+ElBf/iS8YdMFkroB37b+UlBUlmn5uI3Fkel5k6ylXM7asDQbuJbt1jRbFUTLLuKf4yW6g1OtOb9wwznT/Gi1nTcOKwuWUr7WdVSsPTfw7GIAwzyquhfeXZbUUqvcsCB/os3kzYofI+aq6qiOnQ92BXChJ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1xCtbhy; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1xCtbhy"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so1998a12.0
        for <linux-hardening@vger.kernel.org>; Wed, 12 Feb 2025 18:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739412597; x=1740017397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2a2v0j0te6NIFTJGusW3Izof1NhUdtIxSDnUtBZIkAI=;
        b=U1xCtbhyaRT6u77bt9bia7yuJCMWYWE9sCWFvPiN4y76loaDY2x5GPMConBeSGQb9x
         SMZl79mhmg33BMmXbwkHKhoVxDqoT69KpHplc78iMRjPk+C+YG22qqEUCNT2BzR72RNA
         1YmH+RpOWl2IwAJ/YHAH/rlGlDjWPqFAXeykEdewbzrdgisBos6wSSnnY9RJqlMyxDw8
         AEkg83LTdfuJ1ruDzVvf7ICRZ0/Z2BqMqU6wvKKR++k7L06eF8Z/PRebhGHi94IwMhPf
         AiSQQIxOy1iMbbqzrO29a4gcXdA8GX1AxEDxG8CTDm3FAyMwLmJn9oqu5/MuYSIl7CGZ
         jvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739412597; x=1740017397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2a2v0j0te6NIFTJGusW3Izof1NhUdtIxSDnUtBZIkAI=;
        b=JEcGSkphQuSNq9G99Qp91EW6x1rRYcJMUoR+yfdHo8oVUQHKq1Rcoru5Z2c1F7xRfp
         msXqvrLl5ow/21k8Ur1uVIn2guzVKo5sBjE9PsYWnyzA6La7tY3tvGT2qxL+nIbNJvc6
         hPMg0SzqkUvpNLwld6tzii/Q8BAjE3eKVSy/Iilmdr+221X1jvbfLD+s8SCePJS5ps5a
         h8V1RFwzqD5pt5+YVOKHU6kBhxyU9WIfUSpglzfBJd8oHP5Ablh8+7HDYNrkd52rnr3w
         R90Trh2ccFLa+u09W6QK+KM32EfaK++mXOyldMIx8FHQmDmv0n+h9D7oaP/IjRZIbTlD
         8KlA==
X-Forwarded-Encrypted: i=1; AJvYcCUY7IUt2m3Lpp2C6NcF877GYiKFKiJmI97Be6xNTZwG7My1aKXIMwzs5Nt+fCIrPmdwNhsiw0CjF5Ifq/dNn20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLTA40GrKTTeFewHvHG/QFvozXro9ycJjZfnDFRe+AanavyU0J
	LRhVPqeaDnFad1laV4x7RJ6Y/HskUADcvK4w/4LHBfth6a8rN1rvuy4baXHT8I0IOYdYwVyhm1y
	9PA+2MRq7eZYOSajhiqVpJH5fDJKuZgTpKNx3
X-Gm-Gg: ASbGncs801tTh7Kk6dQxS+eorl98ZcffK/NM2t9RsifIupcT11RAwq1HXTsJ9KcwRiS
	DwkT9I73rQeH0vu87AYP2qyNEXUwV34U5otyFEdR2CmXZ7sZPA7FHXLe+RYSHTmE1gM+Ty9wQBu
	H/yxRryi05b3XiriFZrDp8Sdg0
X-Google-Smtp-Source: AGHT+IEGXYza8jPG+mtHgFh7992UjGTwtZVd3O5N+Wv7U028jj6PHsIgLk+pz8qLqg5Kbmp2XIFM5RlBBip4q7wXA0o=
X-Received: by 2002:aa7:c70f:0:b0:5dc:e07d:515b with SMTP id
 4fb4d7f45d1cf-5decb4962damr50168a12.2.1739412596550; Wed, 12 Feb 2025
 18:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG48ez09JuZPt112nnE6N=hS6cfCLkT-iHUAmidQ-QGNGMVoBw@mail.gmail.com>
 <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
In-Reply-To: <c46f5614-a82e-42fc-91eb-05e483a7df9c@citrix.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 13 Feb 2025 03:09:20 +0100
X-Gm-Features: AWEUYZnvdHs8yyFW6XYSqu5PjiO1JQQc7EpzD0iG3tCB0flG_c2hqhEyvARDM2c
Message-ID: <CAG48ez0h0wUS6y+W1HTOwN14V95gKmmFZ_2TamAX+JKTmXT=DA@mail.gmail.com>
Subject: Re: [RFC] Circumventing FineIBT Via Entrypoints
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: jmill@asu.edu, joao@overdrivepizza.com, kees@kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luto@kernel.org, samitolvanen@google.com, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 2:31=E2=80=AFAM Andrew Cooper <andrew.cooper3@citri=
x.com> wrote:
> >> Assuming this is an issue you all feel is worth addressing, I will
> >> continue working on providing a patch. I'm concerned though that the
> >> overhead from adding a wrmsr on both syscall entry and exit to
> >> overwrite and restore the KERNEL_GS_BASE MSR may be quite high, so
> >> any feedback in regards to the approach or suggestions of alternate
> >> approaches to patching are welcome :)
> >
> > Since the kernel, as far as I understand, uses FineIBT without
> > backwards control flow protection (in other words, I think we assume
> > that the kernel stack is trusted?),
>
> This is fun indeed.  Linux cannot use supervisor shadow stacks because
> the mess around NMI re-entrancy (and IST more generally) requires ROP
> gadgets in order to function safely.  Implementing this with shadow
> stacks active, while not impossible, is deemed to be prohibitively
> complicated.
>
> Linux's supervisor shadow stack support is waiting for FRED support,
> which fixes both the NMI re-entrancy problem, and other exceptions
> nesting within NMIs, as well as prohibiting the use of the SWAPGS
> instruction as FRED tries to make sure that the correct GS is always in
> context.
>
> But, FRED support is slated for PantherLake/DiamondRapids which haven't
> shipped yet, so are no use to the problem right now.
>
> > could we build a cheaper
> > check on that basis somehow? For example, maybe we could do something l=
ike:
> >
> > ```
> > endbr64
> > test rsp, rsp
> > js slowpath
> > swapgs
> > ```
>
> I presume it's been pointed out already, but there are 3 related
> entrypoints here.  SYSCALL64 which is discussed, SYSCALL32 and SYSENTER
> which are related.
>
> But, any other IDT entry is in a similar bucket.  If we're corrupting a
> function pointer or return address to redirect here, then the check of
> CS(%rsp) to control the conditional SWAPGS is an OoB read in the callers
> stack frame.
>
> For IDT entries, checking %rsp is reasonable, because userspace can't
> forge a kernel-like %rsp.  However, SYSCALL64 specifically leaves %rsp
> entirely attacker controlled (and even potentially non-canonical), so
> I'm wondering what you hand in mind for the slowpath to truly
> distinguish kernel context from user context?

Hm, yeah, that seems hard - maybe the best we could do is to make sure
that the inactive gsbase has the correct value for our CPU's kernel
gsbase? Kinda like a paranoid_entry, except more painful because we'd
first have to figure out a place to spill registers to before we can
start using stuff like rdmsr... Then a function pointer overwrite
might still turn into returning to userspace with a sysret with GPRs
full of kernel pointers, but at least we wouldn't run off of a bogus
gsbase anymore?
