Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59BC199A2
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 20:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cUtApX74"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uDdfThpdH9ql6Ca0BuOZZY+u/sUmaV3Rr9Jsf4ip26A=; b=cUtApX74xV9c/9Py7ccSIy3b6w
	v3rPhiOAfrVob6jj0FRvnqhtZMX6bb9iriJwUx639vDERxK+q+aGsQj1tBThkPJeaony6AoZmap+V
	ShBiy7o6C281trzUjCx1lkT5nSipNw/pS2bT0hfftpP0RmcG+JVdHmAme7Q4WC6kvnUo2AynVpGlL
	5r3TEZm9VHBaxuv03rKewdbxNNg27g0JKWhYl0KovrOvA/POvVL4c5TaO922raJkDtHajFVMZnGsf
	I6wieMPMb0HUXvDbA4L6F9TrPEh4P143QIm6MlmllqxbRiaiE1u9adKwUiIfioo+I3KQRppRWayOY
	jcpBfleA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPTqt-00Amll-0k; Mon, 15 Jan 2024 20:46:35 +0000
Date: Mon, 15 Jan 2024 20:46:34 +0000
From: Matthew Wilcox <willy@infradead.org>
To: mail@horotw.com
Cc: linux-hardening@vger.kernel.org, Jakub Wilk <jwilk@jwilk.net>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	William Kucharski <william.kucharski@oracle.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
Message-ID: <ZaWZqnD7XmP5HMA0@casper.infradead.org>
References: <69fa6015256613ed10aee996e181ebd4@horotw.com>
 <87il3ur1ik.fsf@gentoo.org>
 <ZaVi4ij0jgEz+isx@casper.infradead.org>
 <07c348caaf6b4c457ab4b452f53ed048@horotw.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07c348caaf6b4c457ab4b452f53ed048@horotw.com>

On Mon, Jan 15, 2024 at 07:21:19PM +0100, mail@horotw.com wrote:
> Am 15.01.2024 17:52, schrieb Matthew Wilcox:
> > On Mon, Jan 15, 2024 at 04:40:36PM +0000, Sam James wrote:
> > > mail@horotw.com writes:
> > > > Hey, I read that ASLR is currently (since kernel >=5.18) broken for
> > > > 32bit libs and reduced in effectiveness for 64bit libs... (the issue
> > > > only arises if a lib is over 2MB).
> > > > I confirmed this for myself but only for the 64bit case.
> > > >
> > > > I saw that this issue is being tracked by ubuntu
> > > > (https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1983357).
> > > > If this is the wrong place and I should instead report it elsewhere I
> > > > am very sorry.
> > > 
> > > See also https://bugs.debian.org/1024149. Unfortunately, I don't
> > > think the issue found its way upstream until now (thanks).
> > > 
> > > CCing relevant maintainers (per the Debian bug).
> > 
> > You know, my email address is all over that commit and the doofus who
> > "discovered the vulnerability" didn't even have the courtesy to let
> > me know.  I've had several private emails about this over the last few
> > days and I just don't care.  Who's running 32-bit code and cares about
> > security?  32-bit kernels are known-vulnerable to all kinds of security
> > problems, and I think this is the least of your worries.
> > 
> > This was intended to happen, it's not a surprise.
> 
> Hi,
> first of all I am very sorry, I didn't realize I should have contacted you
> first (I'm not the one who found the bug initially), I will do it
> differently in the future.

I'm not annoyed *at you*.  I'm annoyed at the guy who first "discovered"
it.  I'm annoyed at the people who are running around with their hair
on fire.  I'm annoyed at all the people who *didn't* contact me.

> Unfortunately, my knowledge is not sufficient to judge how bad it is that
> 32bit effectively has no ASLR support anymore.
> 
> 64bit is also affected, even though there are probably more than enough
> bits left there? I have since seen that both Arch and Ubuntu seem to have
> "patches" in place (https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/commit/3904bcb32cc58c10232fb618bf96c1b43b0bc9d7)
> in which they set the `CONFIG_ARCH_MMAP_RND_BITS=32` and
> `CONFIG_ARCH_MMAP_RND_COMPAT_BITS=16`, I'm not sure if this is a good
> result or if it will cause other problems.

Yeah, I don't know either.  Outside my scope of expertise.

I received a suggestion off-list that we only do the PMD alignment on
64-bit, which seems quite reasonable to me.  After all, I don't care
about performance on 32-bit just as much as I don't care about security
on 32-bit.
