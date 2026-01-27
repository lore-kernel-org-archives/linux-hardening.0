Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368032FFDE1
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526202; cv=none; b=Di9MRIE7zDjYAVzCkKyR62EKCqSULjhC11PehNdPgvGpDBZZhcWBPTjv16ZNBsbUHnCZK5FXH/yF41T0iGabl7qrpg1JnGxU93B6/q0qp0d0xixj8rdw9Z+l+MTStEQREPuGVmwJ3BaRDf7yeYXv9kuzete8fl57sb2Q+zoU67M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526202; c=relaxed/simple;
	bh=toaioy7hLQQ9iPo2VTW/lFiyxv97v9+epn9Qt7bs3K4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM1lOkq9tCVlJMyEJ/0XzipDjY37YIjDeTSrYMOEh5cTTJkOwoFnQyQbn12YoTXXwEqHpZ0XaRogBjMUHnl26pjlBMD9D9JFtNRh9PCRBSGuMwuuXqLRaDKmld4AO/Ggo9DbJZg/+GuzdBBu31GM7GDXkNKhwbrWfTycx8vDNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2EaOiuB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2EaOiuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10666C16AAE
	for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769526202;
	bh=toaioy7hLQQ9iPo2VTW/lFiyxv97v9+epn9Qt7bs3K4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z2EaOiuBItSilFMOrW3Eor7PjEw1XYAId3JLYRCJaJnpk9fVH+L7uTfbcydubXeWl
	 2Y5HD0Uj1zY6PDHFjqPsvxIo3NXmM90sDEaEcqqK0MwaSWKdiwdc8j0hGfGlfAdb3Z
	 0tE5MSg7Z80Gg4VMOP3jv0jJ+6694xKGO4G99Mg49FtuAIOkOy41Tm5Yikca/AZVbs
	 QwF3Ie6oDdzYGUesobPfL88MCOnFYG4ZNAvKWelMjdnwOx7Z5PAbaraazxp3krHXpr
	 u8KsY8CDWKu9pMIzX779PwxOrp2uPo0Rq1ei5E+n82XpPgBw7OxJxXxCCjaIqdoZhw
	 zjq43gLRM4oOA==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so2934557a91.0
        for <linux-hardening@vger.kernel.org>; Tue, 27 Jan 2026 07:03:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuHZ0Dm9OSQMO4gmqlHmPEJ6KwjvWyFhUMt6RmNOF69+rdGX4+DUbEh/4TU6C8xNbcxTU8FN3tc7sEM4WSUSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzop6eHzIJnjVMl1oTCyzA4IMVBwcJSHcL3KZSV1g43jS/a9bm3
	paLStMkWcNDJxBYS9xmKlFfxEgAwGnHPAndlNZZKlWYrcqw3pl7fHnMSIHmC23i3yvWVOpJgzpx
	UEDVTdIST64EjJMD1EIjDMlrfW38xVI8=
X-Received: by 2002:a17:90a:c88c:b0:340:9cf1:54d0 with SMTP id
 98e67ed59e1d1-353fecca19emr1732209a91.1.1769526201645; Tue, 27 Jan 2026
 07:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126092630.1800589-12-ardb+git@google.com>
 <20260126092630.1800589-15-ardb+git@google.com> <4965fa08-ce01-4848-bc30-5cc1b745683f@arm.com>
In-Reply-To: <4965fa08-ce01-4848-bc30-5cc1b745683f@arm.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Tue, 27 Jan 2026 16:03:10 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFskBM-LT_ifX5HpxgQnt1E5tt2QA_5fYuxPQBiSWSDZw@mail.gmail.com>
X-Gm-Features: AZwV_QhQr0Y-pb8zbIIn-c2LQYjEq4EXdEwxzxoW7Gst8GSBWzVqLdJq7MdLVtk
Message-ID: <CAMj1kXFskBM-LT_ifX5HpxgQnt1E5tt2QA_5fYuxPQBiSWSDZw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] arm64: mm: Permit contiguous descriptors to be rewritten
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, will@kernel.org, 
	catalin.marinas@arm.com, mark.rutland@arm.com, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Liz Prucka <lizprucka@google.com>, 
	Seth Jenkins <sethjenkins@google.com>, Kees Cook <kees@kernel.org>, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Jan 2026 at 10:45, Ryan Roberts <ryan.roberts@arm.com> wrote:
>
> On 26/01/2026 09:26, Ard Biesheuvel wrote:
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Currently, pgattr_change_is_safe() is overly pedantic when it comes to
> > descriptors with the contiguous hint attribute set, as it rejects
> > assignments even if the old and the new value are the same.
> >
> > So relax the check to allow that.
>
> But why do we require the relaxation? Why are we re-writing a PTE in the first
> place? Either the caller already knows it's the same in which case it can be
> avoided, or it doesn't know in which case it is accidentally the same and couple
> probably just as easily been accidentally different? So it's better to warn
> regardless I would think?
>

Based on rule RJQQTC in your reply to another patch in this series, my
conclusion here is that we can drop this check entirely.
