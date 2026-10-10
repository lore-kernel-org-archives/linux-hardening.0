Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067CE2AEF5;
	Sat, 10 Oct 2026 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666528; cv=none; b=DmqyjiD8kY8IwVz+Plr/JiS6UD1jFdEkmFXAPrqWsj0FQza/m1SdQ2ealV/vJM00JMVLR1f85ZfMwV2PwgH5jZpOOeQfCZQHfl/DuOG5iTNj96wLRD3ZYm21mNxXV17V997mc7qTs/yTf0wSDpXOCUp52hybDOpzrnQI9bueN3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666528; c=relaxed/simple;
	bh=zR0MYiMtWR4J634UzrSDQI+HARueQIp2D1/bgzkzGqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkuaXILxw+r4csLrzMTabLhJ9IFHYgeEl4m+JN2AdjiKMUXHe4ZYyjqbwIa+M3haDERTuzZzQ08woXOjzP7alHpFA7oLtmOIFV+0kakG5e/+1PH1jxTmc1AhxmXulr5OKvoxI1Daan400dsiOCxq6srBhbQyDf4gawJDIjSwXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkci/2C0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkci/2C0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C841F000FF;
	Sat, 10 Oct 2026 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791666527;
	bh=fq7htODWvxFwI100NAeKvMIRizcluxexsgRn9rBQlIo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=Xkci/2C0ILcP8o4Lctbpf0DHnhR6I9TMXrcFT6kpMmjc7hkH/NHCXkYVJomQf28MI
	 1xjDSzoGh2+u/JubTW/bE8IE8T9FnXK3Jk3wd/49gldwPhs7LRLoJBR2n0T6wR9uJv
	 kl6fh9bKjKpAJhk5wfZXrIRoKObucR5xDG1vMAqTIj9/kz5+OgdJUbesrUYLvEvcxp
	 5DuQPoZ4geW+NFv1v9+iL39df/nUCf3aQrJj2rZJ1i30hMLaD5vWx9Dyy97HndSZfI
	 O9C3IXWLIhZskFazXbIN1ZQHagxr7CjeVj17EXwRVWqK4ctIatiYBBacnodZhz0r1q
	 zYby9v131yQKg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 46C83CE397D; Sat, 10 Oct 2026 14:08:47 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:08:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 1/2] kbuild: Mark the kernel image gzip recipes as
 recursive
Message-ID: <757de98f-2c40-44d2-ba1a-80507c1807d8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261009062722.i.253-kees@kernel.org>
 <20261009062733.3119731-1-kees@kernel.org>
 <7fa8e996-d015-4f8d-a197-3f8901e0b31a@paulmck-laptop>
 <202610091923.FE842614D4@keescook>
 <7109f423-7249-49fb-a923-2824711fe197@paulmck-laptop>
 <20261010082817.eddb2f-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010082817.eddb2f-kees@kernel.org>

On Sat, Oct 10, 2026 at 01:28:50AM -0700, Kees Cook wrote:
> On Fri, Oct 09, 2026 at 09:27:57PM -0700, Paul E. McKenney wrote:
> > 			foreground	background
> > 			-next	Fix	-next	Fix
> >
> > 	make -jN	Bug	Good	Bug	Good
> >
> > 	kvm.sh [1]	Bug	Bug	Bug	Bug
> >
> > [1] tools/testing/selftests/rcutorture/bin/kvm.sh --build-only --allcpus --configs TREE02 --trust-make
> 
> Thanks for the details! IIUC, the difference is the config, not
> foreground vs background. kvm-build.sh adds CONFIG_INITRAMFS_SOURCE,
> which is compressed with gzip by default. The usr/Makefile target picks
> that compressor through a variable, so v1 missed it. Your plain "make
> -jN" builds probably had no built-in initramfs, so the kernel image was
> the only place where pigz ran, which v1 did cover.

I don't feel quite so bad for not having any idea why running "make"
from kvm.sh would make a difference.  ;-)

> Hopefully v2 has all the missed targets fixed now:
> https://lore.kernel.org/lkml/20261010081910.stay.092-kees@kernel.org/T/#m3b466b33f835119bfbd0c1b3c48d2a8a87f31691

It does work for me, thank you very much!!!

							Thanx, Paul
