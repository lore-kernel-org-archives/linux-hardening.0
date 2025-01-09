Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB638B677;
	Thu,  9 Jan 2025 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455087; cv=none; b=Wh9aGDy16dQXpiMURUPmbyuumRBPW0px/AsxWPCsl7TCF/lKH4r+m/5uZPlS/vtSwV0aNNl+BONnNf2LUCZvqvYTcvc++mGHjrR1qcngvpZgRtHU0I59WPJAVCpdoZnl8Ze0TRkZ3UMnrIin1mcu/dQicIdMQFA1wOyvFOZC7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455087; c=relaxed/simple;
	bh=UIAmARS4u6GHb3dKOMkmAdBRQpFp2uamKgKi4apFGRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCvUD3fHxdjbpgdrx/nIQCF3uQyip7jjjZBA0WrQ2BUqAel+wC94Sfhl9d0vYbRUXhAdSOP+QhnWOVN+7odnfPbM+jzTzcEPWVfsgcgwhGGmB/u5nvY9ZQ0F5oS/kN/ypuO+Gixj/B+0/6RJs69XnnKIZC8sVQTj/Xj2ZkNlH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi0FH30d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi0FH30d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A719C4CED2;
	Thu,  9 Jan 2025 20:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736455087;
	bh=UIAmARS4u6GHb3dKOMkmAdBRQpFp2uamKgKi4apFGRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hi0FH30dQyXTAPkShl3sxdLQZJqqu8gxhpr3WAYh2gzMG1Op25VXKtYDXVlqW2ZQj
	 GNRZqLiCfBVUq2CxwFTuUWgsws9uAjnwfj7ADzHaO+9oPmyJBUNWEjGKUrw/F+ffRR
	 PDHP1xPf48bJ4cHRcKyeQxSAyat+wKJ3gBNDE/IR1uDb6ptc18bVAZazU7AUrx4ota
	 +dWYMEJZG8LkJRYWUe6hVvq7IN7xddKmp+l/mUvJwFabtRQ6wCG0CEHo/3wDoEuyEX
	 R78BuUs/fmamSXW7mZtj+WSmwtpK6+lLstwoR0+E6bXO7gJhQ4FHJs5C1sCWTTAlI5
	 MFUXVoC3a5abw==
Date: Thu, 9 Jan 2025 12:38:04 -0800
From: Kees Cook <kees@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [linus:master] [fortify]  239d87327d:  vm-scalability.throughput
 17.3% improvement
Message-ID: <202501091236.E3EDA2188@keescook>
References: <202501091405.a1fcb1ed-lkp@intel.com>
 <202501090850.F23EBEBC5B@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501090850.F23EBEBC5B@keescook>

On Thu, Jan 09, 2025 at 08:51:44AM -0800, Kees Cook wrote:
> On Thu, Jan 09, 2025 at 02:57:58PM +0800, kernel test robot wrote:
> > kernel test robot noticed a 17.3% improvement of vm-scalability.throughput on:
> > 
> > commit: 239d87327dcd361b0098038995f8908f3296864f ("fortify: Hide run-time copy size from value range tracking")
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> Well that is unexpected. There should be no binary output difference
> with that patch. I will investigate...

It looks like hiding the size value from GCC has the side-effect of
breaking memcpy inlining in many places. I would expect this to make
things _slower_, though. O_o

-- 
Kees Cook
