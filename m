Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3F4C8F;
	Thu,  9 Jan 2025 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736441507; cv=none; b=J812STS7irILqNr9vsHsmCNS4niiGMHY2MscLjT7UuYHDliRoH8wGJdwAgnut5DpV/X5+rpCDM6RmGgtMtkmQWYdTdQ0COk01aCKuUe4rJtWbKbLpUWnTG7UfLhzW9yXzBYwG87Ftp2ioFJ6tkmrxGxRonuy2oGpMTy/h/dg7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736441507; c=relaxed/simple;
	bh=wAt1V4OmdUBqn+fpxgrDGfhV5zdTbxWpA2JYnCCrjhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJMcHZXGk7JggOV9rRB4EhQJudihjIp54joxn+yv70sVXknqWjWU5aqCFmD5v5cpJ1pnxpP0LlOjWgqpxUpQkbNoz4mr55i9HFxMyme1YDJYzEWIUwhbV3UsRSO09R0Nz7WrE6xPxZ6tdw/x5gWnZM7V6otQAXwh/tcJbM39VXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh6+6M/N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh6+6M/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32792C4CED2;
	Thu,  9 Jan 2025 16:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736441507;
	bh=wAt1V4OmdUBqn+fpxgrDGfhV5zdTbxWpA2JYnCCrjhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eh6+6M/NevPjIyyh72LLGv0s/vxUonGKmtm0a34KPXcMjmJ4aZdSljVeorNNqppyf
	 irb6S2c/gG3iX/lEqGZRTkflk1lLbLZTsdRlAO7NYnZ8Rpq8IUXW2iLzKVkha+UIrx
	 sSMMtm3osiTQsVhgifaZjX0eXYxY7iciY52hTokF5EmcnLnYVJzGi66Lxlz7k/00Hu
	 0ERzjJfY12PCsFVycJRrBZHso1W0Oh5e1Y/AlGGR0bTh7087A1o2sQrMFn3hbgAwU2
	 WulxxFQkKKLqyqxKGi8EVQw16WjmV1UqX2IUVWJlOTh9rbVwzSXvxMRW7/YQFcff13
	 W8BnH/VI8I7eg==
Date: Thu, 9 Jan 2025 08:51:44 -0800
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
Message-ID: <202501090850.F23EBEBC5B@keescook>
References: <202501091405.a1fcb1ed-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202501091405.a1fcb1ed-lkp@intel.com>

On Thu, Jan 09, 2025 at 02:57:58PM +0800, kernel test robot wrote:
> kernel test robot noticed a 17.3% improvement of vm-scalability.throughput on:
> 
> commit: 239d87327dcd361b0098038995f8908f3296864f ("fortify: Hide run-time copy size from value range tracking")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Well that is unexpected. There should be no binary output difference
with that patch. I will investigate...

-- 
Kees Cook
