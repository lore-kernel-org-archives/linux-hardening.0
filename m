Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D245672;
	Wed, 29 Jan 2025 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738130091; cv=none; b=OUi2JsaXiO2gpv66V2COJxbsl8wSdT9dFsAt5uWyXJ7j976QS38Vl1JQf85wtBAmHlXpNHf/QmDzo+JmYeecTnKPByF4jLrP8quDk9MgitvzFIghuruGK4NDr8Y1F86mF7OSXlOU5HUrb3+MFpI4IPLMGmU9L7erglCkZDcH2Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738130091; c=relaxed/simple;
	bh=18GbQ3as0Sjs2nvMjllY4fOkM96ykJ1lukSzLqM02uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvmIWgNNJTDi/LCBD5184LR0zxHlhebSrd9Y9Xp5dwImoBxYr26VljucEThSQotfuBKO8lIsnsvfGE039yXPF4TCyhZarx1vtd2sWKYmgTCKsDD+isvgojUPep71aQ0WDQ0rIpACyKtVVeCl0b1BtY0wIW+4fRPd9/hDZ60xU+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WJ1VOn14; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WJ1VOn14"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FD6C4CED3;
	Wed, 29 Jan 2025 05:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738130091;
	bh=18GbQ3as0Sjs2nvMjllY4fOkM96ykJ1lukSzLqM02uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ1VOn14oz1D0ZUYAGACamCmw18uAhjD4ShydSFCnu1PFr+EyCL9HFQVnmYfL1RZU
	 iaTb4S0qK97Lhy4liV3OambSh6aXuCG0FWq5Zn6BtulTazM69r046jTqeNuDS4Hcxi
	 mzgvUAADghoMTHtrWgOnM2sXBdeneG2OlEhOKmNo=
Date: Wed, 29 Jan 2025 06:54:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <2025012955-hypnotic-patronize-8931@gregkh>
References: <Z5m76U5zh34WbeQY@kspp>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5m76U5zh34WbeQY@kspp>

On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> This is like container_of_const() but it contains an assert to
> ensure that it's using the first member in the structure.

But why?  If you "know" it's the first member, just do a normal cast.
If you don't, then you probably shouldn't be caring about this anyway,
right?

> 
> Co-developed-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> 
> I will be using this in my -Wflex-array-member-not-at-end patches. :)

Confused, I'd like to see some users first please.

thanks,

greg k-h
