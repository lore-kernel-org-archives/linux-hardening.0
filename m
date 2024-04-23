Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9613E470
	for <linux-hardening@vger.kernel.org>; Tue, 23 Apr 2024 23:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915442; cv=none; b=YGMmyXdRo60KsfbRlIe10nVJlr6+zCoyare6wlnIzoutGrfQzH7aQUoZxA7/IFhUQIsj4lQykKVIpibtUZyecV5k2d0Fx/rUMSGZoxfRSvorPs3w+ByUIswdwith8THk0M3ilZ40yiVnaRDSP56dBfa5YLnvirib3Wj/yFtxY0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915442; c=relaxed/simple;
	bh=ikZqLASnUD5BrgYBEPLKj4B+w5S2wpgaP0n66J2xSLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1FVACMBbMiyPHNxkPqOcquuFfNzqQ91rbzJ4MwHQLU7SW/xcgWOvDGtnGAYxPhixXfuVUkhuukUHB0ElnE4v3QKqNLQPY/Eevs8MhG3++0sbyih8xH0+2hQEB15/p8Dvmvkse8hBS/3OmyJEG+ytSIjcfh2gfqZbhpqDW0msac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TbOyZxd0; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TbOyZxd0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a559928f46so4125090a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 23 Apr 2024 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713915440; x=1714520240; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8oQOmoluKhr1R+Ar7Ae5lF+M+nWQtjuLiRMks0qxRaQ=;
        b=TbOyZxd0DIOwoJYNva6LaAnVLo8TsbjNSYE7DqvtJH31OL9GRPJwjPMRrze7KQc3ji
         3B80BDYlX1/EvruWnFHOE/9W3K3HIOXYDGkbnCI+P6hMVBiDLvqCrYUYYUEdzsc4YT1i
         EFEteQCKRGz/85lendmGr7fv2qz+xprb83vSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713915440; x=1714520240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oQOmoluKhr1R+Ar7Ae5lF+M+nWQtjuLiRMks0qxRaQ=;
        b=DXAqhElUoRLe3C/JB+NqHV9BEaF2QomUEGp6OnOsneqQs9O5KYRcfgsWVHJGnliPfx
         maEY5EWO15DcwzUWL29CmX0kNOyZGnHV80gDiuRZLLn64uuA5rIl9rvUKIYYvfQsk8Zs
         MMS2DNVB6m40EKZqldYaWYwctHfxCbGcI0muacysbfs/f9eWZprUI4qq7DnaFhD3Or4b
         Kpx/GSW2e2Y6qjkZ72x9fdVm+WjQ+1LVrfAUdMhYqGUildUWGN25KgWV2Qtbk3G0iw6K
         ehzqX9TH0WQAPXMCp83s5ayCZzUp6sHpj7EkT9xYwIOHQlOb+8m7/YrMBsfVwSgYSOs8
         Al8w==
X-Forwarded-Encrypted: i=1; AJvYcCXFiNiSVozAA4H1Xb/KS16fhg4I+xJikpt7zBJEy+Jz8ncJ7xs7d16DdnPNwOWUGK1v/xrl1FFvzOdThJQdQf7RrR1nQfUs3+/koYvlNoOo
X-Gm-Message-State: AOJu0YyqvHmW53CrwN4otgs443bQjLW9OzGanEFqp9qx/bR9zxLs29hr
	EQSUZo+AOszibfeNhmAEojHwA38IwpFVj9QXZf6gfvXr2gTPs4NcHNfZaEHEPg==
X-Google-Smtp-Source: AGHT+IHDkobZHch1s5O+S0fUWwcd6UP6yxod9NgVQHFZPNzzaoj/pjZPW5c+t940wYewU3d9rnZJkQ==
X-Received: by 2002:a17:90a:100f:b0:2a2:97ce:24f5 with SMTP id b15-20020a17090a100f00b002a297ce24f5mr823646pja.35.1713915439966;
        Tue, 23 Apr 2024 16:37:19 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i8-20020a17090a718800b002a2e6152f55sm11740139pjk.25.2024.04.23.16.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 16:37:18 -0700 (PDT)
Date: Tue, 23 Apr 2024 16:37:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>, bjorn3_gh@protonmail.com,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	justinstitt@google.com
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
Message-ID: <202404231630.20B2693D@keescook>
References: <20240411230801.1504496-1-boqun.feng@gmail.com>
 <20240411230801.1504496-3-boqun.feng@gmail.com>
 <Zigj-lY5lnBSKuib@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zigj-lY5lnBSKuib@boqun-archlinux>

On Tue, Apr 23, 2024 at 02:11:22PM -0700, Boqun Feng wrote:
> On Thu, Apr 11, 2024 at 04:08:01PM -0700, Boqun Feng wrote:
> > Currently since Rust code is compiled with "-Coverflow-checks=y", so a
> > normal substraction may be compiled as an overflow checking and panic
> > if overflow happens:
> > 
> >         subq    %rsi, %rdi
> >         jo      .LBB0_2
> >         movq    %rdi, %rax
> >         retq
> > .LBB0_2:
> >         pushq   %rax
> >         leaq    str.0(%rip), %rdi
> >         leaq    .L__unnamed_1(%rip), %rdx
> >         movl    $33, %esi
> >         callq   *core::panicking::panic::h59297120e85ea178@GOTPCREL(%rip)
> > 
> > although overflow detection is nice to have, however this makes
> > `Ktime::sub()` behave differently than `ktime_sub()`, moreover it's not
> > clear that the overflow checking is helpful, since for example, the
> > current binder usage[1] doesn't have the checking.
> > 
> 
> Ping. Thomas, John and Stepthen. Could you take a look at this, and the
> discussion between Miguel and me? The key question is the behavior when
> ktime_sub() hits a overflow, I think. Thanks!
> 
> (Cc Kees as well)

While working on the signed (and unsigned) integer overflow sanitizer
support on the C side for the kernel, I've also run into timekeeping
being a questionable area[1]. I *think* from what I can tell, it's always
expected to have wrapping behavior.

Can we define the type itself to be wrapping? (This has been my plan on
the C side, but we're still waiting on a finalized implementation of the
"wraps" attribute.[2])

-Kees

[1] This is strictly WIP, as I think fixing the _types_ is going to be
    the more sustainable solution, but you can see some of what I was
    poking at:
    https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=devel/overflow/enable-unsigned-sanitizer&id=284464817a59b14f00d397bfbf1bf05683ed2f58
[2] https://github.com/llvm/llvm-project/pull/86618

-- 
Kees Cook
