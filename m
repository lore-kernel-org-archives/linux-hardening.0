Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4A78297;
	Fri, 31 May 2024 21:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717191248; cv=none; b=WZOvGQ4/7ISdqJMfnrj3ELFdtE6Uc57/FmzLOb5PID5b6LIRfcyMyBE0KfQu7mrdkN8MXWEKNYPits9k+YIKvMdadBB+Tn0NDhDoTOZyPu9RmuGG1HjwQBF1X8ScT3UJRak7OoAl9taQvuuVo78zHgvc4NvWiDHxm96amMldJck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717191248; c=relaxed/simple;
	bh=5XrG2J6SVqee4hIqh84eanP4nIKsw+RWFUhT9yYHKWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR1lui8dZq9IT3DH6pnsY2u/Obq0DTygTcTZWC7QJEsOQYMn6OYJLLB02lTmz4tfdqzvr0it86bfJodX9M1DiULcMvU5ZPvBGGcBDua9q7UfRNKAkXw9kCw992BdV+IWfgVPB7egIx1mRggI/wvgUDmEeB3iF+c46V2oaP8rtmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e780E88G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e780E88G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B24C116B1;
	Fri, 31 May 2024 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717191247;
	bh=5XrG2J6SVqee4hIqh84eanP4nIKsw+RWFUhT9yYHKWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e780E88GVClsTNDLNrUjuA7InVXijoPt9sB8FTQxLBJ2Yu4rUiFi5ZyfUrkGycrR2
	 TSfOaOtGvPtPNzL67W9XtsqvhT6onGlaDVyRQhCGKPfvqKbjlNbOrsaEJ1XuTuLppA
	 yqAVEfueuA7298ZtjfU8ibVMr+YUMKriyqBJCJIlRevOj7WmCuCYw5Eq1oa/jQkfEn
	 aCYn0r4s9pJYdMjZ+X912kxPeechU7Olo77Ly1DBBKbDJOtxh7GUvjHgzakmG8KlKO
	 1XK6tTMVE9JzT9NsBn1so59E7ccwBy4CLeasmfm9u2stuSBos289ifwvy+/UtE9De/
	 Wm/PG31j3vZNw==
Date: Fri, 31 May 2024 14:34:07 -0700
From: Kees Cook <kees@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] x86/boot: add prototype for __fortify_panic()
Message-ID: <202405311431.BF9FE3F7A7@keescook>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
 <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
 <202405311345.D91BF6E9@keescook>
 <20240531204947.GNZlo367G0YXVbOk1I@fat_crate.local>
 <202405311359.EFC7345EC@keescook>
 <20240531212009.GOZlo_CV0lxZ1xviQW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531212009.GOZlo_CV0lxZ1xviQW@fat_crate.local>

On Fri, May 31, 2024 at 11:20:09PM +0200, Borislav Petkov wrote:
> So I get an allergic reaction everytime we wag the dog - i.e., fix the
> code because some tool or option can't handle it even if it is
> a perfectly fine code. In that case it is an unused symbol.
> 
> And frankly, I'd prefer the silly warning to denote that fortify doesn't
> need to do any checking there vs shutting it up just because.

If we want to declare that x86 boot will never perform string handling
on strings with unknown lengths, we could just delete the boot/
implementation of __fortify_panic(), and make it a hard failure if such
cases are introduced in the future. This hasn't been a particularly
friendly solution in the past, though, as the fortify routines do tend
to grow additional coverage over time, so there may be future cases that
do trip the runtime checking...

-- 
Kees Cook
