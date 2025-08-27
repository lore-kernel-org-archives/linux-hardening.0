Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD732192E3;
	Wed, 27 Aug 2025 03:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756266068; cv=none; b=ifvzEQll63baNEsh0WiaLnic2Y8QYMZkNxOzlf0mLJxVC+PsdfEWrLW20zagz7KaQd4jQjP/04ASNuSRnx/xaLvxv2Nf1CWgS2WoI2erMz2uf87PqYzqTuCOj07GiH8A8Yu9VuoWm/MbADjG48viSZrongqkoxSFKxtN3bJaRQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756266068; c=relaxed/simple;
	bh=mYhR4hDG9DbVR34fVtQQOt59e7gIITeGVvG1SoehGpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpSfB0BbmH1FxNiK8qngEZl35Pae8uWHNTB0DTtXdIu/trLTjb0qHzdeIDzCOVF3QMtGpcULg8VAu8TxVdFy6lmtcyc+UoG+bMFzW8y8HRECUmL8EIb5nFQkDsEo9JFeBAOGTDAfRXyfyVZlqB1B2fJCx2CoZTrPSQU78XxmP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxvPw6HJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxvPw6HJ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4717543ed9so4293286a12.3;
        Tue, 26 Aug 2025 20:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756266066; x=1756870866; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7hQgakYGN92JM43ym9Xl9fivI9QPXuqHNitq7m6h9Q=;
        b=mxvPw6HJnB7lsO5WHcD9mXvYRwpUO+eb4KdltJB5O7lLjXS9MZty2MOlzZ40feHQbi
         GXvcgIZgQqiF/oxtbIOlkwUfb55Z2UTvOwNIrTudkmbAKzldGClRH/ygRebYRIbkcHig
         l1orhwck69iS85czg3ZknJ6Y6ly9DlB7zZm7nfPv9mi9VmKIP5Jn9ysHt6d7+Hxa4DJl
         tXpZjA1IKn6ZX98ChlUjMUx+63fI/gFD1/veS53qFh0PoXwxYrWJtU23VNObj2BOnyuh
         FH0RPpeFBoCoDa3JpaHgAq5zjvPnxovbAP8ixuidhHdNR1w1WjBFSMOoICaSq4RlL03Q
         Jp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756266066; x=1756870866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7hQgakYGN92JM43ym9Xl9fivI9QPXuqHNitq7m6h9Q=;
        b=nLP70g/QQPmeDyNfkKGrZzkTVCWcU7/urbGzCHgfLne7HyPWuq3qFsdUGWsuPmXxOS
         iwphFSd45B8GaPnXBKCI1GfzYd03+EAtMDapi7Gy+gb+YtFX3AfBe2x36lPTKprviOHT
         yqX8TO7/LgDXqgCbGtwTCLheqCAWdFV2AvBc1qM/FtIPW3Hb8Hmu/YozeTuIuxQmGBKF
         dIbwb4P3cJBikXMIvZCfSOvZjgCzibSOK82X3rYjbxd/FaJrrk3EGYfahmsGUmPLu8YQ
         oS+fOiVGGdvu15wTtoLldm//k/YjB5UR8eeplniiZJ6JV7mj7cOxiiAXVW61g2PGTg+Y
         tASg==
X-Forwarded-Encrypted: i=1; AJvYcCU2aS3xdn13s9QRnLsq6bz6pLu8XIpZKnSTLxymQaLXQqro37o52TcmIxMB/+jDfQN6S2NMUNEfumnSEBzP@vger.kernel.org, AJvYcCWrBVVMrJ1W1uWTvTDOuiJiRbLoeuBg2Wz/nsLIx/afZ6tqccMb1LMmHqeAjSxBjWQQfV1CpBR5vR/cEViWT1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxONdMKqdHA19SBBGtVyyDf3U3Ss5TQLWZCrq0Ilbx0BGqQ5BAj
	xWRYAftZVwlB7Cpby7rOW1PMiYQ9orJQ8jrRNZNhDLg4XaVEz3sB/3ZM
X-Gm-Gg: ASbGncvjPZRTJBlCTosNxyOFPozWbIfGHIUisqApWnwe+OZzUEzTboZg9xsmQYEf6MC
	2a+UoUctWCDIjTmoI3JNUtelktA9X8TUjSYgcOlZKSrsOMzSa3cZNYo6O6gm89vOK+oihjUXGz/
	p4s9hiXakbPeRjVR93+6419DHeTlxH5k3yMH4Z2iqsZW6YP/YvkfSIfT9vu2DgDSmnER6eVxu2Z
	ssnHCSDtn0mm5ihh1+Fn92/xbtt4IMhcnqBLpZa+CkIADH0VoG77AwH7Tetv9Es6yHhFLnfO+fw
	1SqbbK6Ng6eB2L7/hpF9UI/Du9aFeAEt1xZ7we+m03pfNreLu9NPcsS/zFLXlwpDn8ijyvdxKnk
	LSmVWI6q6ly+MEeuuuB6Gvhm2UvagnG55
X-Google-Smtp-Source: AGHT+IEJfoCSb3DI07rprjVPxQ5PK2rDzT96h9Gj0pmdTGWBTR1HDwbCJwoFIgVFU4rX5YFZ1j8hKQ==
X-Received: by 2002:a05:6a20:2590:b0:243:78a:8278 with SMTP id adf61e73a8af0-24340d72bc8mr28593728637.48.1756266065948;
        Tue, 26 Aug 2025 20:41:05 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401af16bsm11876114b3a.54.2025.08.26.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 20:41:05 -0700 (PDT)
Date: Tue, 26 Aug 2025 23:41:03 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Kees Cook <kees@kernel.org>
Cc: Rasmus Villemoes <ravi@prevas.dk>, kernel test robot <lkp@intel.com>,
	Vineet Gupta <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] arc: Fix __fls() const-foldability via __builtin_clzl()
Message-ID: <aK5-T0C6MA5hbdRr@yury>
References: <20250826034354.work.684-kees@kernel.org>
 <87ldn644d0.fsf@prevas.dk>
 <202508260955.2DE50A3FB@keescook>
 <aK5eNDa5H-PNGHpj@yury>
 <202508261911.ECB628656@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508261911.ECB628656@keescook>

On Tue, Aug 26, 2025 at 07:13:03PM -0700, Kees Cook wrote:
> On Tue, Aug 26, 2025 at 09:24:04PM -0400, Yury Norov wrote:
> > On Tue, Aug 26, 2025 at 09:56:06AM -0700, Kees Cook wrote:
> > > On Tue, Aug 26, 2025 at 03:08:59PM +0200, Rasmus Villemoes wrote:
> > > > If __builtin_arc_fls() simply doesn't qualify for attr_const for
> > > > $reason, I think it would be good to have that documented in the commit
> > > > msg. If it does, I think a gcc ticket and link to that would be in order.
> > > 
> > > I already sent the patch to fix it. :)
> > > 
> > > https://gcc.gnu.org/pipermail/gcc-patches/2025-August/693273.html
> > 
> > I'm OK taking the patch if it fixes real problem for you, but it looks
> > more like a GCC problem, right? Is Clang also affected?
> 
> Without it, KUnit testing of ffs/fls fails on arc. Clang is not

That's a solid point. Can you please notice it in changelog too?

> affected. Even with the GCC fix landed, all older GCCs with still fail,
> and since it provides a improved code generation for arc, it seems worth
> it (compile-time-calculable values will be emitted instead of always
> running the arc instructions).

Yep. This is what I meant. Once the fix is landed, we will not need this
code. When the minimal supported GCC version will become greater than
one that has the fix applied, it will be much easier to spot this hack
and drop it, if we mention that explicitly.

Something like that:

    #if IS_ENABLED(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < XXX
        if ( __builtin_constant_p(x))
                return x ? BITS_PER_LONG - 1 - __builtin_clzl(x) : 0;
    #endif

> > If, say, Clang is not affected, and you expect that newer GCC versions
> > will not be affected too, let's protect the new code with a proper
> > ifdefery, so that it will be easier to drop the workaround later?
> 
> I think the codegen benefit is worth it as I have it.

That's I'm surely agree.
