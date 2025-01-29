Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B7156678;
	Wed, 29 Jan 2025 16:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166996; cv=none; b=cBgYUOkjEtuYk8ZWG/KsRuoh1AZZibP1vqlJUGvu6mG7EoZ1f0jt2swb9F40pc0LPM86thnS+UvsdDI/kb1yEpqT55Ok0IAz5xP+rCmIpjlFsm3XZN6iqWF1sOxnnJFsVn1rcu6B80kptiazxnpzGW85yFNR2MycH8LU1k+qeYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166996; c=relaxed/simple;
	bh=47hGXtsL3yH+9X6h8n8mRguN/T7WJWfu5J4RSN27yr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/8Qpv2KUaygGTl6E7BBsT21AGA2yfKse282l1XvmQJ7/54/pkHUtjg6V2YrOar27ex6mxKqVCDN66vN50OkQB64h+GxDGlDZKQuerVDyA+g00omedvXcWPJU/nM+/HPM5k6ZaiSwie1KyJTkKZQ/eLF+ffVLXa/yJlZiZezv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=10QtRB9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="10QtRB9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072D3C4CED1;
	Wed, 29 Jan 2025 16:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738166995;
	bh=47hGXtsL3yH+9X6h8n8mRguN/T7WJWfu5J4RSN27yr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=10QtRB9nSPxKWpc+v9mNvZgx7/bOmAXigXyUOgzOfjU2GWlGd+UesmCsgzmEzSzEy
	 Z7h8ykn+CJrqOdXkh63TKm2sYmdPJ/F7KMqsiULKmwM+oYiTgOVu8+EWl4VbG6Ji+1
	 Dz6D1g3U3kgHDlDNoHVUnQI/1ZyuRDyPOpJt1i0I=
Date: Wed, 29 Jan 2025 17:08:56 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <2025012940-hardhat-usual-fbc6@gregkh>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
 <2025012921-dense-unplanted-952b@gregkh>
 <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>
 <2025012951-plenty-clang-1e2b@gregkh>
 <3979f87d-b7d7-48bb-b6ab-cd8165dbc3cc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3979f87d-b7d7-48bb-b6ab-cd8165dbc3cc@stanley.mountain>

On Wed, Jan 29, 2025 at 05:06:54PM +0300, Dan Carpenter wrote:
> On Wed, Jan 29, 2025 at 02:14:14PM +0100, Greg KH wrote:
> > On Wed, Jan 29, 2025 at 01:39:27PM +0300, Dan Carpenter wrote:
> > > On Wed, Jan 29, 2025 at 09:34:07AM +0100, Greg KH wrote:
> > > > On Wed, Jan 29, 2025 at 06:35:18PM +1030, Gustavo A. R. Silva wrote:
> > > > > 
> > > > > 
> > > > > On 29/01/25 16:24, Greg KH wrote:
> > > > > > On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> > > > > > > This is like container_of_const() but it contains an assert to
> > > > > > > ensure that it's using the first member in the structure.
> > > > > > 
> > > > > > But why?  If you "know" it's the first member, just do a normal cast.
> > > > > > If you don't, then you probably shouldn't be caring about this anyway,
> > > > > > right?
> > > > > 
> > > > > This is more about the cases where the member _must_ be first in the
> > > > > structure. See below for an example related to -Wflex-array-member-not-at-end
> > > > 
> > > > That's fine, but that's a build-time issue, you should enforce that in
> > > > the structure itself, why are you forcing people to remember to use this
> > > > macro when you want to use the field?  There's nothing preventing anyone
> > > > from using container_of() instead here, and nothing will catch that from
> > > > what I can tell.
> > > 
> > > The new definition has a static_assert() in it so it's enforced about
> > > build time.
> > 
> > Yes, but that forces you to "know" to do that in the .c file.  How do
> > you know to use this, and if you remove it or change it to
> > container_of(), it works just fine again.
> > 
> 
> I guess my use case is different from Gustavo's.  For him, using
> container_of() is fine.  We probably don't even need an assert because
> once you see a struct_group_tagged() then you know the order is important.

Who knows this?  The developer?  What are they supposed to "know" here?
I sure don't :)

Having some sort of "__must_be_first" marking for a field is fine and
break the build if that doesn't happen.  Otherwise this is something
that is not going to be used properly over time.

> For me, it's code like I mentioned which does:
> 
> 	p = container_of();
> 	if (IS_ERR(p))
> 		...
> 
> And I did see you suggest that people re-write that kind of code, but no
> one is going to do that.  :P  People know that container_of() is just a
> cast in that case.  It works fine.  It's just a bit ugly.

It doesn't work if the field isn't first, so no, it shouldn't be working
fine, and that should be flagged and fixed and never allowed to come
back again.  Can't we do that with coccinelle?

thanks,

greg k-h
