Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D76C21E097;
	Sat, 10 Oct 2026 13:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791640116; cv=none; b=OcU4sm3vF7Iblm6TrEBc7X9LOd0rrWoWaJ42/erW9XgvHX02yNOWzzd58Bbf4qRc5Uo3/dFyarN6gKt8uqvUEbYYPhmbd2I2NiG/kbNcMLr13yhQLf8tpenpMFtbtkZsTq6WCwh6zRXBoPpx2mJ1dLcFWGq84mIzc77I9U2q9L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791640116; c=relaxed/simple;
	bh=7ndRupAvhrm5NU6PjjNtzH5uxOCZ7UEDmhJMtQ/ew/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMnjqWpOEJxT25DQWVtYrUnA2zxMJejKH7uRsTO48BJFS4KrUddYOhbY6rTXXZP2QhFyz1qG4SvJcZvW5nX8Ww5liUseGM/IReESiu4Vuk0Jj6b0XfjBBoJijHnEkkjW2Q6eVwHLYyqykpn36F9gjHkhxpncMGIZknlsoVuAZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kchg4uY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kchg4uY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657C41F000FF;
	Sat, 10 Oct 2026 13:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791640115;
	bh=K9A8u5qFlvlQI2A8aU7UIzO52F42UzFC4ZL8I8LaFBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kchg4uY4rubNcwl9P0NUJC4L+ZOdtvi1f7O1QAnMxx+M2naLHBsupJ3EV9hfwuhIU
	 KehFkwCAWmf0pFnZdUeuFD96m9vF0iDOM8i0j1hs3Tvt4W0yyl/SpB8h53Fbh+tJID
	 OA9aKBI9pjrqgvZZDWNxjqDEOpHQ4/oG5b8ot6F/NWFrQ7IjDtzC6se3/q9OVCqbcf
	 iub46LA6ktd0Rs+xjKQgEW6yJx+Cgo4CdhurVwtltNlNsDs/+U5RmzDRfraQt9xfc/
	 B4ZY0kD4XMfs1iaKmJjG5WuvfxH1AV6uGcTbgHdAYaNQpTOPORF92cA6pmlORhYpw4
	 vpsfWwBFZTbaQ==
Date: Sat, 10 Oct 2026 14:48:29 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Manuel Ebner <manuelebnerli@mailbox.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Nicolas Schier <n.schier@fritz.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/2] kbuild: Give jobserver-exec recipes the jobserver
Message-ID: <20261010134829.GB1853402@ax162>
References: <20261010081910.stay.092-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261010081910.stay.092-kees@kernel.org>

On Sat, Oct 10, 2026 at 01:19:09AM -0700, Kees Cook wrote:
> Hi!
> 
> Paul reported a build failure on CentOS Stream 9 with linux-next[1]: the
> kernel builds, but scripts/jobserver-exec prints
> 
>   WARNING: Unable to reopen jobserver read-side pipe: FileNotFoundError(2, 'No such file or directory')
> 
> and rcutorture's build check counts the "Error" in that line. CentOS's
> make 4.3 carries a backport of the fix for GNU Make bug 58232, so
> sub-makes, like the top-level make, give the jobserver pipe only to
> recipes marked recursive, while MAKEFLAGS still names it. The new pigz
> steps (1/2), for the kernel image, the built-in initramfs, and the other
> gzip rules, and the older Clang LTO initcall ordering step (2/2) run
> jobserver-exec from recipes without "+", so pigz gets one thread and the
> initcall script caps its children at the CPU count instead of the free
> job slots. Mark these recipes recursive, as was done for rustc.
> 
> Thanks!
> 
> -Kees
> 
>  v2:
>  - 1/2: also mark the gzip rules that choose gzip through a variable,
>    including the built-in initramfs in usr/Makefile, which rcutorture's
>    kvm.sh builds and v1 missed (Paul)
>  - 1/2: update the gzip entry in Documentation/kbuild/makefiles.rst
>    (Nicolas)
>  - 2/2: cite Masahiro's earlier version of this change and say when the
>    script gets more than one archive (Nicolas)
>  - v1..v2 diff: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/diff/?id=dev/next-20261001/pigz-recursive/v2&id2=dev/next-20261001/pigz-recursive/v1
>  v1: https://lore.kernel.org/all/20261009062722.i.253-kees@kernel.org/
> 
> [1] https://lore.kernel.org/all/0ddb5e5e-f801-444c-aa98-0cfe814a3026@paulmck-laptop/
> 
> Kees Cook (2):
>   kbuild: Mark the gzip recipes as recursive
>   kbuild: Mark the initcall ordering recipe as recursive

I've kicked these into -next, I will formally apply them to
kbuild-next-speedups once Paul can confirm that it resolves his
regression. Thanks a lot for the assist here!

-- 
Cheers,
Nathan
