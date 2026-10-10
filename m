Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB282AEF5;
	Sat, 10 Oct 2026 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666434; cv=none; b=qgXn5mIrGBjhb8dG8hCXesSXj9tTv3eGI7uufOZqv7vCXJdbIF+v0miT/NLh4QykD8yUHp8o/jv5dQBX1+ahf9bmueYlVm6DnlDCoF6s7/L0G4JJcrvq7CwBt1KYsL+zemt2r+VOwjh5eqyYvY/VxIAJoOn/vPqJZ6+W7cml8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666434; c=relaxed/simple;
	bh=MWZiC3YF8lC1P/vq25ned+nViiOEFs1+9yT1a2pIu1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6w7v3R+4zkETcdvRu35Ltfiosm37bchBj5Oy7Hu/b153N02a/WcFIHFmQgpACEFEGyuz1qn/oArtyv2navo5mFYswsItVKnKMp2Mj/hrRzbrcgCIjU5uJ9aHxnnHHizkJIhllYLokfg3WwM3aCn/Bc5g8+HzGFw17WbBil/08k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XA9iqnjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA9iqnjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DA61F000FF;
	Sat, 10 Oct 2026 21:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791666432;
	bh=30R/GaKM4NcrAVJrORuimlAImIftgrnprkvMkO/yUgg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=XA9iqnjIx/r6wwwwda3prpgPyj/69mnTZ8cbORV5B4zzBQx+fgSyvmqh7TXiwYyAv
	 yH1CFblXaja1iFKTNaTzKuI6uZr5mIKhTVIlMA82x4BAVukM3Yjs4WU8kARRn0Mj1X
	 C7wZ8/dkrmUWBef3Vp08Mw2utIleVh6MNyYLzHzMEmOVE80EK71ZxpVQWqInuKPDy4
	 d9nwLWeW5KYn7BXgWcuW5lPfxBRjIQ23VdnvBrUb/d3ZdQHpZ/KLzI5mlGwOxUHun1
	 Sm+3aJP/5y3szWvdvYblhR1m83TTjiVMYgVXHB+rigrqkaPwtX+ZN9ehCT9H8s1BTC
	 ZnjRlq8kK69nA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C57A8CE397D; Sat, 10 Oct 2026 14:07:11 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:07:11 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicolas Schier <n.schier@fritz.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: Give jobserver-exec recipes the jobserver
Message-ID: <69b782ee-69c3-410f-8bcd-01a7be5d9295@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261010081910.stay.092-kees@kernel.org>
 <20261010134829.GB1853402@ax162>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010134829.GB1853402@ax162>

On Sat, Oct 10, 2026 at 02:48:29PM +0100, Nathan Chancellor wrote:
> On Sat, Oct 10, 2026 at 01:19:09AM -0700, Kees Cook wrote:
> > Hi!
> > 
> > Paul reported a build failure on CentOS Stream 9 with linux-next[1]: the
> > kernel builds, but scripts/jobserver-exec prints
> > 
> >   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> > 
> > and rcutorture's build check counts the "Error" in that line. CentOS's
> > make 4.3 carries a backport of the fix for GNU Make bug 58232, so
> > sub-makes, like the top-level make, give the jobserver pipe only to
> > recipes marked recursive, while MAKEFLAGS still names it. The new pigz
> > steps (1/2), for the kernel image, the built-in initramfs, and the other
> > gzip rules, and the older Clang LTO initcall ordering step (2/2) run
> > jobserver-exec from recipes without "+", so pigz gets one thread and the
> > initcall script caps its children at the CPU count instead of the free
> > job slots. Mark these recipes recursive, as was done for rustc.
> > 
> > Thanks!
> > 
> > -Kees
> > 
> >  v2:
> >  - 1/2: also mark the gzip rules that choose gzip through a variable,
> >    including the built-in initramfs in usr/Makefile, which rcutorture's
> >    kvm.sh builds and v1 missed (Paul)
> >  - 1/2: update the gzip entry in Documentation/kbuild/makefiles.rst
> >    (Nicolas)
> >  - 2/2: cite Masahiro's earlier version of this change and say when the
> >    script gets more than one archive (Nicolas)
> >  - v1..v2 diff: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/diff/?id=dev/next-20261001/pigz-recursive/v2&id2=dev/next-20261001/pigz-recursive/v1
> >  v1: https://lore.kernel.org/all/20261009062722.i.253-kees@kernel.org/
> > 
> > [1] https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/
> > 
> > Kees Cook (2):
> >   kbuild: Mark the gzip recipes as recursive
> >   kbuild: Mark the initcall ordering recipe as recursive
> 
> I've kicked these into -next, I will formally apply them to
> kbuild-next-speedups once Paul can confirm that it resolves his
> regression. Thanks a lot for the assist here!

And it works!!!  ;-)

Tested-by: Paul E. McKenney <paulmck@kernel.org>
