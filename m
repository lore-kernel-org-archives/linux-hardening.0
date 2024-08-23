Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D016186287
	for <linux-hardening@vger.kernel.org>; Fri, 23 Aug 2024 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724420322; cv=none; b=r1is0Gm08OqJH5GEqME30VH9TKR+Oon6j/y2yCw/YV0T1wMjR4n3C/sgOmRLkd0oVgYrGk22zjSoHcfHXAhIJS/c8CNJ5d1VswwfKCe/zxUmFedgSJ4KAnZl0FP4JoitrJDoQEYpiy8DNS3RHaPgBExloKt3OXENK+K2orIcc4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724420322; c=relaxed/simple;
	bh=nX3RU8J5w2798ccsFI/vL6i5QIr7ymp12x6LvxDuWZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdR3aMuTrHKtVqVDwKUJMm1iuaDFJHhnvKBbi2fzGwAJC/RvaalzIEBVglziqcl/UZJjJEqf7eupH8kZ0KpTIAJC0Hc2n+yPqGQqrPOhS4QAdRkJ3Vc6HoaJdGOzkseEwSRDPXRA/TH66hOdunN0icFQxdvOOqp3n7DNkzxFEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OoDz97nC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OoDz97nC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C56BC32786;
	Fri, 23 Aug 2024 13:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724420321;
	bh=nX3RU8J5w2798ccsFI/vL6i5QIr7ymp12x6LvxDuWZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoDz97nCMHSTrlOAh9FnFGjhpC2N1aiPeFFcTC/MKabEldr1xq5WY6fWSRw1giDYv
	 6zaonPOf4/BZuIrWPM4S9+E691QiLKBiq0QDQ7YWNNg8Ftt6YpNWUguGYIYGrqJ7K4
	 slWk1On5mKqIPXYjAMBEeqhM08PLD3Hov44ZieCI=
Date: Fri, 23 Aug 2024 21:38:39 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hongbo Li <lihongbo22@huawei.com>, kees@kernel.org, andy@kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next 0/2] Add str_true_false()/str_false_true() helper
Message-ID: <2024082311-unaltered-grumbly-5c94@gregkh>
References: <20240823062046.3323694-1-lihongbo22@huawei.com>
 <CAHp75VdYbG32auRF3KgP15wA-5bDgTMTO24itTu1tdjdW3CqXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdYbG32auRF3KgP15wA-5bDgTMTO24itTu1tdjdW3CqXQ@mail.gmail.com>

On Fri, Aug 23, 2024 at 04:22:32PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 23, 2024 at 9:13 AM Hongbo Li <lihongbo22@huawei.com> wrote:
> >
> > Add str_true_false()/str_false_true() helper to "true" or "false"
> > string literal. And we found more than 10 cases currently exist
> > in the tree. So these helpers can be used for these cases.
> 
> Squash them into a single patch. There is no need to split these.

And let's see some patches that change existing code to use them, we
can't add new functions that are never used in the tree.

thanks,

greg k-h
