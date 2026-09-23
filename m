Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253B446052
	for <linux-hardening@vger.kernel.org>; Wed, 23 Sep 2026 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148007; cv=none; b=CnU2DE4LjAjwU4g4zEXOhoMFhGKFXyNJT5AHRxXpoVdw11Pqm/UnYQW0SAa8b9ZY5Dkl8uPbP/HUlEiiCyXburXS8RD5V6i3kDs/RHsvzCx2rF9rZ53VyfpeauVaDrqcmfJWsTQmfU7HoZ1N7GjXIHgHt9AJ1tl+MLhF574W03s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148007; c=relaxed/simple;
	bh=Z5HXik1TEpwNXoISK6jKd9g0KtaddSbZS8dem+QPyBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BPmM5v5d9GNv6LmzVBPeDUWXba3W0MZxIpIzVtHpDVh00baXWlYNagWXQ9IDb1iIWkw1jsLSsPBYQ2ETXx9pZGA9bnpeVMJgQDGiufOsw+Xhfio1nQKoEn0366nsIIiCB/tXf72dK6SFSM4MU4uu3YMsVzlsYIYHzp/tETNMNlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhvQCiG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhvQCiG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0F71F0089C;
	Wed, 23 Sep 2026 07:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790148001;
	bh=iV6tsPP7FMUE2ViOpQrvTbhHAu4oOtyI3MUTKdllcOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jhvQCiG6/YGN8Pxn++L5bTH238GbAIufSXR1wQdDnw4WCL5jU8ekiza+bTatAwGaD
	 4HFlhWZrhAy/kSBS8On3MqeaMk62iqd+u2+/ViQPmd/PzYBJnrF7/KTjtOQBuDpdy8
	 aUKoT71f7B25a+xfXfaNQhJCVB8ewTMS4rRXNjYOMHDr0fzUT+jJxelbxX8viRX2T/
	 joMGcTMZywAhL2obJ8w5cAFOzlIECDsLC5hYOt6etyCTPoEnW9eROjZlH4bUsRZpq1
	 EhxSPfzR9ZiI3lSx3zh0GRoCFZVKtXFw2hSDVqMsvwPoAh++0thI61AYPDlcaApa8S
	 hxcoENcM9x3PA==
Date: Wed, 23 Sep 2026 00:20:01 -0700
From: Kees Cook <kees@kernel.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: tony.luck@intel.com, linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com, kernel@gpiccoli.net
Subject: Re: [PATCH 0/2] Small improvements on pstore user experience
Message-ID: <202609230016.101B0479BF@keescook>
References: <20260922212532.98571-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922212532.98571-1-gpiccoli@igalia.com>

On Tue, Sep 22, 2026 at 06:19:00PM -0300, Guilherme G. Piccoli wrote:
> Hi Kees, Tony,
> 
> Here are some small things I've noticed in pstore usage that annoyed
> me a bit, so it's not they must be fixed - no bugs here that I can't see.
> 
> But the fact kmsg_bytes can be changed via mount option but I can't
> write on its sysfs parameter, or that I can set compression to like
> "zstd" even when PSTORE_COMPRESS is unset, is a bit confusing to the
> point I tried to improve them with these patches heh

Thanks for poking at it! Yeah, that PSTORE_COMPRESS=n seems like it
needs to get fixed. :P

> Thanks for reviews and comments, and feel free to reject them if in
> your opinion, they make things worse.

Sashiko has some notes:
https://sashiko.dev/#/patchset/20260922212532.98571-1-gpiccoli%40igalia.com

I fear it is uncovered some other (small) preexisting issues, but I do
agree the kmsg_bytes concurrency race is troublesome.

-Kees

-- 
Kees Cook
