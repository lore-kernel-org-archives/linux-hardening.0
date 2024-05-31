Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF9F2C1AE;
	Fri, 31 May 2024 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717189609; cv=none; b=jgKrzG4jr4VfSf+ClUUBTTnDdPhecDL3nE0N8oThWGO7njEtOGdkPLZlZC/SuStQG7Yhkh8MKYP2nUhVCrcH64yHyU6T98KfwntbnSBkgQSzroFd1EZjafZMym7azNmXIA54Twt6+vfEsBIzy20JO1fcfw7Xby5UvDfDL0IZveI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717189609; c=relaxed/simple;
	bh=wy7ME3NK+NpCINbYpHDrtrVy3m+OPYt3joS/LqYwsBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+Cu2Z1ithDBj0GWBze3ewWoE1mJGkIm4f0UULnTwq+4ufYJye/4DPoE7h4ApEXTvuPvbO/vFXtmUbc2mqP2MatL6lc7nDLVU7dEw76QAAh2s8UPWxcAfUb/ABv3bD9T24sIiCV7MTeY2SKH5zdwTduZzLwa4E8i2X6Uwt/T92w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZewBY5t/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZewBY5t/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A692C116B1;
	Fri, 31 May 2024 21:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717189608;
	bh=wy7ME3NK+NpCINbYpHDrtrVy3m+OPYt3joS/LqYwsBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZewBY5t/gjrzWBfnaqyXsvegO39ZktPzm+Cyll3Afn2d87/YSXcnGd6lqJWDbGopt
	 9lSE0QoRzfYavhED7N5Fu2Ug3FBtE3gVNMJFHYbTd0qqSYnrPMHKga6kksHET5fLH0
	 G/PYefNDRJlCqIgTMVo5bys/KF0qAXQIFg/0dlsiH5ZONRvJHNVMlRCj/JFna0w0IJ
	 Dkr9P3KnKnio5topk/oA1uuvOUfWr+nEx9tolQq5prm/5AsXxFd48FF/ozVu0d8R4C
	 lKZJAdoqpunIoX0cdCQNIHk0p5PuX7VRjqcVXtS6md1vYrLoK6zHe1fnEOXk6/V0pw
	 O5/jgLT4WFUMw==
Date: Fri, 31 May 2024 14:06:48 -0700
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
Message-ID: <202405311359.EFC7345EC@keescook>
References: <20240529-fortify_panic-v1-1-9923d5c77657@quicinc.com>
 <0d3f7c58-7fc0-4e8b-b6fb-c4d0d9969ce7@suse.com>
 <e42c4984-d4a2-45b1-b93d-7471000766b7@quicinc.com>
 <5658B525-6642-43A2-B14C-BC4AA916FBCC@alien8.de>
 <202405310951.56D9BD5C41@keescook>
 <20240531190816.GLZlogIGgpc5maOeLN@fat_crate.local>
 <202405311345.D91BF6E9@keescook>
 <20240531204947.GNZlo367G0YXVbOk1I@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531204947.GNZlo367G0YXVbOk1I@fat_crate.local>

On Fri, May 31, 2024 at 10:49:47PM +0200, Borislav Petkov wrote:
> On Fri, May 31, 2024 at 01:46:37PM -0700, Kees Cook wrote:
> > Please do not do this. It still benefits from compile-time sanity
> > checking.
> 
> Care to elaborate how exactly it benefits?

Because when new code gets added that accidentally does improper string
handling, fortify will yell about it at compile time. e.g, if someone
typos something like:


#define BUF_LEN_FOO	16
...
#define BUF_LEN_BAR	10

struct foo {
	...
	char buf[BUF_LEN_FOO];
	...
};

...

void process_stuff(struct foo *p)
{
	...
	char local_copy[BUF_LEN_BAR];
	...

	strcpy(local_copy, p->buf);
	...
}

or refactors and forgets to change some name, etc. It's all for catching
bugs before they happen, etc. And when source string lengths aren't
known, the runtime checking can kick in too. It happens x86 boot doesn't
have any of those (good!) so __fortify_panic() goes unused there. But
that's a larger topic covered by stuff like
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION, etc.

-- 
Kees Cook
