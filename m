Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2ED2421A;
	Thu, 16 May 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715876108; cv=none; b=GLU5r8miuZg8Sq5BqDKevB9pSb0Dt7+hZ1JR1Hq87cIUn40C+XEJEO8y3gX+NX2etf0nImRZrzQZ+Lyx2nJ2lqP4oieNztHw1q0C7f5XH0gBAD+QKEk4geFfexTFpyAkm8nNTMJ2uq/dqfwVUWzEGqmk9Nl3yLg15h28FppsN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715876108; c=relaxed/simple;
	bh=C5txdxBhuj7rW3DWnSbwvCzPzbmF4xQ5STOkAZq83ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loYiG4FrZCoqwHXh3QMYVATPN7dLxpJ2zsn3SumGLD/jMtRcjrN0CA28pBrGn37AjsgmqOaNQEJIewxGysRkObs/5Cvfrj/pT5NAN+9Wxhudf03XIpy4Ycc86UbUWxE7ihaYSnBuWT4PzjVyUv6TyGGlfQ+M17BNLjOKtqh+Rhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JtYVC8El; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JtYVC8El"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF147C113CC;
	Thu, 16 May 2024 16:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715876108;
	bh=C5txdxBhuj7rW3DWnSbwvCzPzbmF4xQ5STOkAZq83ag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JtYVC8Elpkr080qIIwIffhq7Xabf/QhfcnqUPFWpxscSTASidGwxeAWdxwNUEwpQn
	 SSPfWjsKCa0RRt1mPnSkMUSd0TyiBWfIA69jJyrMDqeG4ekCfRGRRypHSBeeavbEpF
	 ds+m50y/663B0JwIW1wujM83A4h6g6sQumIfOYmo=
Date: Thu, 16 May 2024 18:15:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Manthey, Norbert" <nmanthey@amazon.de>
Cc: "keescook@chromium.org" <keescook@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"Stieger, Andreas" <astieger@amazon.de>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	"Hemdan, Hagar Gamal Halim" <hagarhem@amazon.de>
Subject: Re: Extending Linux' Coverity model and also cover aarch64
Message-ID: <2024051625-dowry-pacifism-b0b9@gregkh>
References: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77f6e6fc46232db82a3c63e93877c9534334e407.camel@amazon.de>

On Thu, May 16, 2024 at 03:28:16PM +0000, Manthey, Norbert wrote:
> Dear Kees, all,
> 
> we published an extension for the Coverity model that is used by the
> CoverityScan setup for the Linux kernel [1]. We have been using this
> extension to analyze the 6.1 kernel branch, and reported some fixes to
> the upstream code base that are based on this model [2]. Feel free to
> merge the pull request, and update the model in the CoverityScan setup.
> We do not have access to that project to perform these updates
> ourselves.
> 
> To increase the analysis coverage to aarch64, we analyzed a x86 and a
> aarch64 configuration. The increased coverage is achieved by using re-
> configuration and cross-compilation during the analysis build. If you
> are interested in this setup we can share the Dockerfile and script we
> used for this process.
> 
> To prevent regressions in backports to LTS kernels, we wondered whether
> the community is interested in setting up CoverityScan projects for
> older kernel releases. Would such an extension be useful to show new
> defects in addition to the current release testing?

New defects yes, I would like to know that, as long as they are also
fixed already in mainline, right?

Just send us reports of that, no need to get the covertity site involved
there, I'll be glad to take them.

thanks,

greg k-h
