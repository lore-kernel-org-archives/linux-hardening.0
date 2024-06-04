Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2A14A11
	for <linux-hardening@vger.kernel.org>; Tue,  4 Jun 2024 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717460993; cv=none; b=GRkPEUmTEGFbyzV9+DzL/nfCABg1MrB9S9YVS6VGkqchs2b6n7O0MeuEcVEPTf248N0E68eSh679qyWszzW8hGzAnPS6S85olllKP/Oj3X0oHvDvL0qzicBlAbKPrETvBEY2kJWtwoxQMBo1CdxxegTIchJCFMHikKyd+9nzd14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717460993; c=relaxed/simple;
	bh=tHNlljHyl4OWf1KxKCEPYA1CiqsKpPT13VLxPLbrxl8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OPlIVQQGvQremj2LMWuRBAuFLJF+QD5wW2wJVKArBradZltz6j2xqyJpySZycxlD6gKRxPhNyM7efpaTHcrS9/fzeH9A0kRvz6HRytzAprcqcuVaihfYWRecdlwwclD9aDJSdRUgaibcFRs/N2WbywvR3k4dIV4Sgl0mG+YncBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puxjbxBT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puxjbxBT"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-68196e85d64so3386439a12.3
        for <linux-hardening@vger.kernel.org>; Mon, 03 Jun 2024 17:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717460991; x=1718065791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QxIMQXFvRFWSOBKMLO/Pb11VLx9FgWxOAKpcjqg1q6M=;
        b=puxjbxBTG5z3Upww4V6uBpPm3gT6S16Fh/4hFzQnft+qQUhCffRGP8yUD+0M/Y0BTF
         t80sR1UETBui4VWEC5izZ6Y8k0lq81iM2k9DX2auu95AjbleBwkIMJ1kYn+iRVKjqtOJ
         TNN4BZQoewG55+6C5TOEBRUiCr5SyTNx7tpVYnQ/FTN5Bp6SapIJT+tu3hdu+PStimkS
         0RfRGfAImQnfZdDfSfHvC814+/YkuIhFCJBEShpWm3nJuvoosaIf+iNyskVf1kJiix9d
         BYFr2cgkFmIrb0Jmd88+P9eQ4EGysGGVrXi//MiWRpYOTrPBDwTLwfQQznIk+5cZfCKl
         coeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717460991; x=1718065791;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QxIMQXFvRFWSOBKMLO/Pb11VLx9FgWxOAKpcjqg1q6M=;
        b=o+OrmTcV2o3DMSBum/XkRXr0CN+nWXWO6hYpxA5Rbkicj5stdDFhSBPtMvv/PP3XAj
         zKh7bH42/1J71L4PGIbmlQFGWk0uORWO4Zlv+csl6f6uwOD9U+IIdspzgjJhpRN00pxb
         tzXvfvDEQSnOberCvI6SIgj4jQzBm8YJuvzp9000ThXg30ScWOuDm6G8vYQZlj8dr0cP
         5tSo4QWq37LJk0FD0Sa/ycy/5PkaeFfFJlFDIOxXKPnKtRbQmBFqFiiE6ediQ/ZTJ0ZT
         TGtpQwZpCgrxfIpmloCOXul9wJrMFIwMq+zU5HbJsZBkpHOly19C7aVxyn3J0gXZFGKb
         6YcA==
X-Forwarded-Encrypted: i=1; AJvYcCUwlXm+el7EL+xDt51suBcafJIR1E6fPaVlHlWqhTw6Esd5TdfN1nY//G8g8LgXJLsQk5SVSJ8sDmqgWj7+lR8vNQpamNT9Yz1CD+FKNB4k
X-Gm-Message-State: AOJu0YyIKCB/EDMkJ8plC6sX7qtPZQANNy4/uKVTI0N01CNUm4eXoNrl
	NjNaIJGt91mdOtbPJGadu+TdwvxHp7TZKUInpGAB6LCvHyUywzXFw0aZNbsL3bTDhPkwVJchjIR
	Y2A==
X-Google-Smtp-Source: AGHT+IENLGEaWbs37HwWar6l9tfsoGWg6m42nFsyoTQfIezFlKVeE9IraziAYhpEU9jmdwNYoPJqg3Pzh8c=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f7c1:b0:1f4:620b:6a47 with SMTP id
 d9443c01a7336-1f6370524bemr2945395ad.4.1717460990723; Mon, 03 Jun 2024
 17:29:50 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:29:49 -0700
In-Reply-To: <20240514.OoPohLaejai6@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net> <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com> <20240514.OoPohLaejai6@digikod.net>
Message-ID: <Zl5f_T7Nb-Fk8Y1o@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
	Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>, 
	Angelina Vu <angelinavu@linux.microsoft.com>, 
	Anna Trikalinou <atrikalinou@microsoft.com>, Chao Peng <chao.p.peng@linux.intel.com>, 
	Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
	James Morris <jamorris@linux.microsoft.com>, John Andersen <john.s.andersen@intel.com>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Marian Rotariu <marian.c.rotariu@gmail.com>, 
	"Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
	"=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>, Thara Gopinath <tgopinath@microsoft.com>, 
	Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
	Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
	"=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>, dev@lists.cloudhypervisor.org, 
	kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
	virtualization@lists.linux-foundation.org, x86@kernel.org, 
	xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, May 07, 2024 at 09:16:06AM -0700, Sean Christopherson wrote:
> > On Tue, May 07, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > > If yes, that would indeed require a *lot* of work for something we're=
 not
> > > sure will be accepted later on.
> >=20
> > Yes and no.  The AWS folks are pursuing VSM support in KVM+QEMU, and SV=
SM support
> > is trending toward the paired VM+vCPU model.  IMO, it's entirely feasib=
le to
> > design KVM support such that much of the development load can be shared=
 between
> > the projects.  And having 2+ use cases for a feature (set) makes it _mu=
ch_ more
> > likely that the feature(s) will be accepted.
> >=20
> > And similar to what Paolo said regarding HEKI not having a complete sto=
ry, I
> > don't see a clear line of sight for landing host-defined policy enforce=
ment, as
> > there are many open, non-trivial questions that need answers. I.e. upst=
reaming
> > HEKI in its current form is also far from a done deal, and isn't guaran=
teed to
> > be substantially less work when all is said and done.
>=20
> I'm not sure to understand why "Heki not having a complete story".  The
> goal is the same as the current kernel self-protection mechanisms.

HEKI doesn't have a complete story for how it's going to play nice with kex=
ec(),
emulated RESET, etc.  The kernel's existing self-protection mechanisms Just=
 Work
because the protections are automatically disabled/lost on such transitions=
.
They are obviously significant drawbacks to that behavior, but they are acc=
epted
drawbacks, i.e. solving those problems isn't in scope (yet) for the kernel.=
  And
the "failure" mode is also loss of hardening, not an unusable guest.

In other words, the kernel's hardening is firmly best effort at this time,
whereas HEKI likely needs to be much more than "best effort" in order to ju=
stify
the extra complexity.  And that means having answers to the various interop=
erability
questions.
