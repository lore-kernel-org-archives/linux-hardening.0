Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40222F42;
	Wed, 29 Jan 2025 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738156513; cv=none; b=fN0D8otDK77yYkjHqZ0y2Ntja2EHrJHJwhUwXpVluKUPf1CTgaaJ7vcwt9RZ6hJw7/6Kep/BEFHLPDglq+VSfI6wQxPxwR1fbpXdg6TS0gjNgzSVHBHzDBcgSp4ijqw04QWjLn2ZToSLbF+qgFw3VYSse8HgZ91I+UmUzksaJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738156513; c=relaxed/simple;
	bh=GT+eI2yLpaMK0HB4cN53JoAYkVwYbk6TEZhyDgbCAJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltk3raZbTrz0Oz06J3RmSygLfCqnoTfoGfcGopjycDWq7D9Y74GAkz4F5rBl52zT4feh8bHo7LIId1F+22MKH7RtRecvJVJvB5QKl8MPYglrD1whSCMG237itTRLS/VqBNTKxgCyCdJ6sRNzKFprMoYU76SU4cnu0FvyylFCRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aZEWpOXh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aZEWpOXh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF4FC4CED3;
	Wed, 29 Jan 2025 13:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738156513;
	bh=GT+eI2yLpaMK0HB4cN53JoAYkVwYbk6TEZhyDgbCAJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aZEWpOXhs6VdLrQa+SOMpBWMWKPUDyPyAMrb0ByPseneSoCIQDe+CR+YHTwiot5bh
	 G50ro9iNAcAr0jd2FI3F3nRrVbIBXx2P41lErnnTCr1Icgz5mg8dipJE2W6IbKLN8t
	 JXuJVoY/30PaDyFpRpTkYEXhpVO1qkRCSQTgWmR4=
Date: Wed, 29 Jan 2025 14:14:14 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <2025012951-plenty-clang-1e2b@gregkh>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
 <2025012921-dense-unplanted-952b@gregkh>
 <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>

On Wed, Jan 29, 2025 at 01:39:27PM +0300, Dan Carpenter wrote:
> On Wed, Jan 29, 2025 at 09:34:07AM +0100, Greg KH wrote:
> > On Wed, Jan 29, 2025 at 06:35:18PM +1030, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 29/01/25 16:24, Greg KH wrote:
> > > > On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> > > > > This is like container_of_const() but it contains an assert to
> > > > > ensure that it's using the first member in the structure.
> > > > 
> > > > But why?  If you "know" it's the first member, just do a normal cast.
> > > > If you don't, then you probably shouldn't be caring about this anyway,
> > > > right?
> > > 
> > > This is more about the cases where the member _must_ be first in the
> > > structure. See below for an example related to -Wflex-array-member-not-at-end
> > 
> > That's fine, but that's a build-time issue, you should enforce that in
> > the structure itself, why are you forcing people to remember to use this
> > macro when you want to use the field?  There's nothing preventing anyone
> > from using container_of() instead here, and nothing will catch that from
> > what I can tell.
> 
> The new definition has a static_assert() in it so it's enforced about
> build time.

Yes, but that forces you to "know" to do that in the .c file.  How do
you know to use this, and if you remove it or change it to
container_of(), it works just fine again.

> +#define container_first(ptr, type, member) ({                           \
> +       static_assert(offsetof(type, member) == 0, "not first member"); \
> +       container_of_const(ptr, type, member); })
> 
> That was the discussion at plumbers, Gustavo just wanted to use
> container_of() but I told him I was tired of code which assumes that
> container_of() is just a cast.  If we're going to write code with that
> assumption then lets create a different macro for it and let's make the
> build break if someone changes it.

That's fine, but it should be where the variable layout is, NOT where
you dereference the pointer as at that point in time, you don't know or
care if the location is in the first location at all.

thanks,

greg k-h
