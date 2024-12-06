Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD11198A06
	for <linux-hardening@vger.kernel.org>; Fri,  6 Dec 2024 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512537; cv=none; b=bizWjhPI/mSN7p/ji62giKxj+ddwScdoJ1UgeVsDjVfpqHbU8uWlqdCz10zqtOgwOZY65MZDW+0dbsjDEhtPM8KqtMjm1fVKe+LuQUhWsYxHYPzifjcxptOH3LlisigMpy1mLbP/FzLcHpj+1vg1/9nlIrko8jUXAnCbh3cERoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512537; c=relaxed/simple;
	bh=ajFbm9bK5cqvgCLi6MJ1DB1DDERcm8YueHpowSShf5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qV6M847hHL3Er3MqxGi/01USPcMwLjvYdKpH+Nryc5vhYKv0nOo+RgDkjQzS717R5DhLk1gxpJ/dwnD6DYPkhPzuZAv5Efd7dfGhG+bcrYAHhOdvG2jvLudJsZgz8DbFNkCCbd2ZP/fcVNgIFqpIAJsxbXD6Hd8WfcA3oDa6Uow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NsgeBjVW; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NsgeBjVW"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso699a12.0
        for <linux-hardening@vger.kernel.org>; Fri, 06 Dec 2024 11:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733512534; x=1734117334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7YKnxexLJ1+TaE4HafZ+vrLntQPWzQ2qCK8DJmplRQ=;
        b=NsgeBjVWj5B+A7QFFE9mZxckWwricz98bTaZaAMlVF4M+rQ2gDPPWrPH0kzZGP3inL
         t9Fno5IYndOuzYXsxPT5iYqGaD3XeH/lT5x0x7GaEsVwXUGpcKLmLPEZR4pt4OACCdup
         +ExWHhZLUKDjXGh/msp03efbFLU2l007NZTlwUlYiZj5BDXbK4Rg91gawYfyxmgidOxO
         /dTy6Rq0mCx/s2tTYqt66Yf8zL9iTcF2B1ECJuHv2JPpCrs44LTrpeh5msqqFlMmgmWU
         6tYz16JBhiAkWghW8Rqt9GGMdS75pY5UwBdghZRZV4OgQdWpm7lvnEQksvDPLRdMGRtq
         l0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512534; x=1734117334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7YKnxexLJ1+TaE4HafZ+vrLntQPWzQ2qCK8DJmplRQ=;
        b=pN9kXa8BuPDdv9/utWLEeHrHNGlWrE+xj8caohOjg0ub1AZ/8s2JDPPQITQ4SduEUl
         EvcjyuUHZ19JWL971QZQNSWFhq8z+92M0nDoXZx0lKO69c9bL30WFg97Y2REtWHSIl/e
         oeDrHzoj7UhVVHqYxMeK3fQ1QoTt14Rkg1a2myq4TLiK8XwtYKQwKosiVLq8ewjeLQKH
         NC9LEq2idKm7bFVDP4E30KKRTQkmME1BFjjdRVum4GekTHiFNJXqlJEtpcWdm46yq50F
         fE9PPRBwvYzuT0QT0gcnQf89WCvp+mRBQSsa1MSZ2G6SBJz6WoAzl1RAkOLEzsMgx8Jl
         5YQQ==
X-Gm-Message-State: AOJu0Yy2xHSStwclySCfzMYhPzwxSE7KkyzJXVkyWvFxFentOezZoBLQ
	KobCG6cecz/8IfMcHpmF+g+65diNb4F/yYAVal0F2KDwlvbrTFYHmLU8cRGhnoAPyUOvvcnUr5g
	K78hLSyhnaOXuVK+CnORSuAUFY83k9Ic21XYZ
X-Gm-Gg: ASbGncuwGwWKMt7n1/4O2a/0kr15PttAxazlKe8CfjWginOqImDHxVgCuWYlVDIPJ/2
	yX1OHJwDa8oXabLZr5pBvPMaWoLgwDWEf+w+650IoNCM/fmm4Wc2GcVn93WU=
X-Google-Smtp-Source: AGHT+IElYlBNREfqiZtIPEZ0AoFhO5dJI6xcw9xcSYAg6cDhIC7rFrPCr3zdIfmomIG/xUNduJKYL+dryW/WkRiwaII=
X-Received: by 2002:aa7:d507:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5d3db4b972cmr3792a12.1.1733512533171; Fri, 06 Dec 2024 11:15:33
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206101110.1646108-1-kevin.brodsky@arm.com>
In-Reply-To: <20241206101110.1646108-1-kevin.brodsky@arm.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 6 Dec 2024 20:14:57 +0100
Message-ID: <CAG48ez1b8BBquEB1BJEg+KsPdPyZLPuD7uToUH3ZdN8F0r+U9w@mail.gmail.com>
Subject: Re: [RFC PATCH 00/16] pkeys-based page table hardening
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aruna.ramakrishna@oracle.com, broonie@kernel.org, catalin.marinas@arm.com, 
	dave.hansen@linux.intel.com, jeffxu@chromium.org, joey.gouly@arm.com, 
	kees@kernel.org, maz@kernel.org, pierre.langlois@arm.com, qperret@google.com, 
	ryan.roberts@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 11:13=E2=80=AFAM Kevin Brodsky <kevin.brodsky@arm.co=
m> wrote:
> This is a proposal to leverage protection keys (pkeys) to harden
> critical kernel data, by making it mostly read-only. The series includes
> a simple framework called "kpkeys" to manipulate pkeys for in-kernel use,
> as well as a page table hardening feature based on that framework
> (kpkeys_hardened_pgtables). Both are implemented on arm64 as a proof of
> concept, but they are designed to be compatible with any architecture
> implementing pkeys.
>
> The proposed approach is a typical use of pkeys: the data to protect is
> mapped with a given pkey P, and the pkey register is initially configured
> to grant read-only access to P. Where the protected data needs to be
> written to, the pkey register is temporarily switched to grant write
> access to P on the current CPU.
>
> The key fact this approach relies on is that the target data is
> only written to via a limited and well-defined API. This makes it
> possible to explicitly switch the pkey register where needed, without
> introducing excessively invasive changes, and only for a small amount of
> trusted code.
>
> Page tables were chosen as they are a popular (and critical) target for
> attacks, but there are of course many others - this is only a starting
> point (see section "Further use-cases"). It has become more and more
> common for accesses to such target data to be mediated by a hypervisor
> in vendor kernels; the hope is that kpkeys can provide much of that
> protection in a simpler manner. No benchmarking has been performed at
> this stage, but the runtime overhead should also be lower (though likely
> not negligible).

Yeah, it isn't great that vendor kernels contain such invasive changes...

I guess one difference between this approach and a hypervisor-based
approach is that a hypervisor that uses a second layer of page tables
can also prevent access through aliasing mappings, while pkeys only
prevent access through a specific mapping? (Like if an attacker
managed to add a page that is mapped into userspace to a page
allocator freelist, allocate this page as a page table, and use the
userspace mapping to write into this page table. But I guess whether
that is an issue depends on the threat model.)

> # kpkeys_hardened_pgtables
>
> The kpkeys_hardened_pgtables feature uses the interface above to make
> the (kernel and user) page tables read-only by default, enabling write
> access only in helpers such as set_pte(). One complication is that those
> helpers as well as page table allocators are used very early, before
> kpkeys become available. Enabling kpkeys_hardened_pgtables, if and when
> kpkeys become available, is therefore done as follows:
>
> 1. A static key is turned on. This enables a transition to
>    KPKEYS_LVL_PGTABLES in all helpers writing to page tables, and also
>    impacts page table allocators (see step 3).
>
> 2. All pages holding kernel page tables are set to KPKEYS_PKEY_PGTABLES.
>    This ensures they can only be written when runnning at
>    KPKEYS_LVL_PGTABLES.
>
> 3. Page table allocators set the returned pages to KPKEYS_PKEY_PGTABLES
>    (and the pkey is reset upon freeing). This ensures that all page
>    tables are mapped with that privileged pkey.
>
> # Threat model
>
> The proposed scheme aims at mitigating data-only attacks (e.g.
> use-after-free/cross-cache attacks). In other words, it is assumed that
> control flow is not corrupted, and that the attacker does not achieve
> arbitrary code execution. Nothing prevents the pkey register from being
> set to its most permissive state - the assumption is that the register
> is only modified on legitimate code paths.

Is the threat model that the attacker has already achieved full
read/write access to unprotected kernel data and should be stopped
from gaining write access to protected data? Or is the threat model
that the attacker has achieved some limited corruption, and this
series is intended to make it harder to either gain write access to
protected data or achieve full read/write access to unprotected data?
