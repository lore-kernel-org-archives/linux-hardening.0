Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477918021
	for <linux-hardening@vger.kernel.org>; Mon, 15 Jan 2024 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PW/IUjkd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=WS8y6SUEc04QHFhGEGQ39dj6zwqeCrM39wd3kpLvyWc=; b=PW/IUjkdt3kfQs1mEDi7rlvmp8
	on8Aug6QxLDeBZ3JCEsnAMiuhJF07OitIm++3VSF8N6YJbljNJ6R9xxyp3GlrL3j3PGxH7QWEoLga
	4PHKKF8FBFv/1sG87YtjyeCfjDi1meRCc0rSXu6ShKT61mpjvRIfQyS6b1ZE9YK8YdMhNjTc3hjAD
	KLYVT72VzXkZTiPr5NrLZpSJGOxxx4FVj1ZgoZfwfD3XdnPxTjuqoTCoGxUfsc1DC4wtHvlQ7Rrqo
	UssZuzwELHFPE7FmzJyOglcTb173WACcUqvPMz0gJ7kGG+W8Ap4Fhe9cmcSsIjR9UeNDDskoqw7tC
	mTT8YmOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPQCh-00AGHj-0c; Mon, 15 Jan 2024 16:52:51 +0000
Date: Mon, 15 Jan 2024 16:52:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Sam James <sam@gentoo.org>
Cc: mail@horotw.com, linux-hardening@vger.kernel.org,
	Jakub Wilk <jwilk@jwilk.net>,
	Salvatore Bonaccorso <carnil@debian.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	William Kucharski <william.kucharski@oracle.com>
Subject: Re: Limited/Broken functionality of ASLR for Libs >= 2MB
Message-ID: <ZaVi4ij0jgEz+isx@casper.infradead.org>
References: <69fa6015256613ed10aee996e181ebd4@horotw.com>
 <87il3ur1ik.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il3ur1ik.fsf@gentoo.org>

On Mon, Jan 15, 2024 at 04:40:36PM +0000, Sam James wrote:
> mail@horotw.com writes:
> > Hey, I read that ASLR is currently (since kernel >=5.18) broken for
> > 32bit libs and reduced in effectiveness for 64bit libs... (the issue
> > only arises if a lib is over 2MB).
> > I confirmed this for myself but only for the 64bit case.
> >
> > I saw that this issue is being tracked by ubuntu
> > (https://bugs.launchpad.net/ubuntu-kernel-tests/+bug/1983357).
> > If this is the wrong place and I should instead report it elsewhere I
> > am very sorry.
> 
> See also https://bugs.debian.org/1024149. Unfortunately, I don't
> think the issue found its way upstream until now (thanks).
> 
> CCing relevant maintainers (per the Debian bug).

You know, my email address is all over that commit and the doofus who
"discovered the vulnerability" didn't even have the courtesy to let
me know.  I've had several private emails about this over the last few
days and I just don't care.  Who's running 32-bit code and cares about
security?  32-bit kernels are known-vulnerable to all kinds of security
problems, and I think this is the least of your worries.

This was intended to happen, it's not a surprise.
