Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC50D531;
	Mon, 19 Aug 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724089520; cv=none; b=esfNAGdDZFUKmARO2byzZtCZ26x/Nc8rWEWv0erCGOdWCNHyrFjQqM9hwChTbpP1QggM4OgBt6OZJorCgCLz/jd0q0RV2ILi7U0wE5WYEFYyQZ6xpt/xnw/7ao/3oa0GpG+582cB5qIKjKerWtj6/2uhXzuRs1z3K9FmYmX/HkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724089520; c=relaxed/simple;
	bh=SOvjdwdzKexcjCgRD4ACwiyU6VI8QEka5cGCSmloRrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VNrUJyJbYKakYSZEIOzpp4SAGRCTBriPRSEcDPepCwXQg70AmeUd/opQlscC0RxPCEKLpyAETSF9dNX0gvBwXGSyacZ1fYrFYExTwg8b9dUApILGaD46BGvxM9sVBSkoTAB8Ev+XOcUNC48MaLWm3AhHrjpvmFvEadHpRc1bVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MV+C3g57; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MV+C3g57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5447C32782;
	Mon, 19 Aug 2024 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724089520;
	bh=SOvjdwdzKexcjCgRD4ACwiyU6VI8QEka5cGCSmloRrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MV+C3g57iyx9jNvBC23mhyRBbok+LJhTCzKcPJOT9R77fXmVkaKjzHPmPWNIqW8gC
	 AOnX19FnRBkZ97RN84ReSGHp5pK+/6nyNJy76W1aqM46KNawNue9oWLolJqTxGmk+7
	 vrnWKz3irU60yLfLLjyLs0hBH2T/Y1E62bulIoZY=
Date: Mon, 19 Aug 2024 19:45:17 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wen Yang <wen.yang@linux.dev>
Cc: Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: replace spinlock_t by raw_spinlock_t
Message-ID: <2024081925-opposite-pessimist-9b98@gregkh>
References: <20240819145945.61274-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819145945.61274-1-wen.yang@linux.dev>

On Mon, Aug 19, 2024 at 10:59:45PM +0800, Wen Yang wrote:
> pstore_dump() is called when both preemption and local IRQ are disabled,
> and a spinlock is obtained, which is problematic for the RT kernel because
> in this configuration, spinlocks are sleep locks.
> 
> Replace the spinlock_t with raw_spinlock_t to avoid sleeping in atomic context.

This feels odd, is it only an out-of-tree RT thing?  Or does this affect
in-kernel code as well?  What prevents any normal spinlock from sleeping
in your system configuration as well?

thanks,

greg k-h
