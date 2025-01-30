Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC63190058;
	Thu, 30 Jan 2025 06:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217645; cv=none; b=CYLBosKwDFM6Eq51JEdCJ9uuOf27+01HevFMTQBKNS/Kqz7ukTqmqcdh07LG6SttAi5pyAkYQ83P9rLcCcx8a2p2N7RGn//MJ/8Omjks4phlWsqSz0ilkMfZzegJxpNMbOHTFwEcMRt2anNPj8thNq1bc1jovufXBHg9C6/S6/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217645; c=relaxed/simple;
	bh=piqnWVU9aUejBh25VUCTtHqSvx12RW2XNfKQy/OkbBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJZ7RC5HvExE4DidveZg/2nRfuSt9qco2MNE2nKNUCSlu5e3yh+GNJkJQoGiHWFFsmeqDZ1gN1kZ2Nyu7eY9S6aCX6WNlwXG1hLXYyPezg/zz6GIMkucx4P7jTPHFJtkonKWeuhzUF7mH+kVlXo6bk4SBH9fk43fWwVYrWs75U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVSSnnAO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVSSnnAO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591DEC4CED2;
	Thu, 30 Jan 2025 06:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738217644;
	bh=piqnWVU9aUejBh25VUCTtHqSvx12RW2XNfKQy/OkbBA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LVSSnnAOS+vyGmBU+a7q4FlRjDkoqO7XbFhENgwC8vzzq6WOsV+30IHP2+g+g/4wU
	 Ic6JyOxN87Wtq0bxBHcncQXAsppKhgWFoksgNcKF3YZ/ZODueMKaBfnvopPw61TaPP
	 RAzIduM84+PzsZjorO+OJSbQUfXbuDIVnos9PnPw=
Date: Thu, 30 Jan 2025 07:14:01 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] container_of: add container_first() macro
Message-ID: <2025013030-unleaded-answering-165d@gregkh>
References: <Z5m76U5zh34WbeQY@kspp>
 <2025012955-hypnotic-patronize-8931@gregkh>
 <f6e24dfa-450e-4de6-87a6-6fcf7d83888d@embeddedor.com>
 <2025012921-dense-unplanted-952b@gregkh>
 <06aa1194-a7aa-4a5a-adb8-f6cd447d35d9@stanley.mountain>
 <2025012951-plenty-clang-1e2b@gregkh>
 <3979f87d-b7d7-48bb-b6ab-cd8165dbc3cc@stanley.mountain>
 <2025012940-hardhat-usual-fbc6@gregkh>
 <7f165e66-a0ff-48e2-a3f3-d5405a66c867@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f165e66-a0ff-48e2-a3f3-d5405a66c867@embeddedor.com>

On Thu, Jan 30, 2025 at 10:06:00AM +1030, Gustavo A. R. Silva wrote:
> 
> 
> On 30/01/25 02:38, Greg KH wrote:
> > On Wed, Jan 29, 2025 at 05:06:54PM +0300, Dan Carpenter wrote:
> > > On Wed, Jan 29, 2025 at 02:14:14PM +0100, Greg KH wrote:
> > > > On Wed, Jan 29, 2025 at 01:39:27PM +0300, Dan Carpenter wrote:
> > > > > On Wed, Jan 29, 2025 at 09:34:07AM +0100, Greg KH wrote:
> > > > > > On Wed, Jan 29, 2025 at 06:35:18PM +1030, Gustavo A. R. Silva wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 29/01/25 16:24, Greg KH wrote:
> > > > > > > > On Wed, Jan 29, 2025 at 03:56:01PM +1030, Gustavo A. R. Silva wrote:
> > > > > > > > > This is like container_of_const() but it contains an assert to
> > > > > > > > > ensure that it's using the first member in the structure.
> > > > > > > > 
> > > > > > > > But why?  If you "know" it's the first member, just do a normal cast.
> > > > > > > > If you don't, then you probably shouldn't be caring about this anyway,
> > > > > > > > right?
> > > > > > > 
> > > > > > > This is more about the cases where the member _must_ be first in the
> > > > > > > structure. See below for an example related to -Wflex-array-member-not-at-end
> > > > > > 
> > > > > > That's fine, but that's a build-time issue, you should enforce that in
> > > > > > the structure itself, why are you forcing people to remember to use this
> > > > > > macro when you want to use the field?  There's nothing preventing anyone
> > > > > > from using container_of() instead here, and nothing will catch that from
> > > > > > what I can tell.
> > > > > 
> > > > > The new definition has a static_assert() in it so it's enforced about
> > > > > build time.
> > > > 
> > > > Yes, but that forces you to "know" to do that in the .c file.  How do
> > > > you know to use this, and if you remove it or change it to
> > > > container_of(), it works just fine again.
> > > > 
> > > 
> > > I guess my use case is different from Gustavo's.  For him, using
> > > container_of() is fine.  We probably don't even need an assert because
> > > once you see a struct_group_tagged() then you know the order is important.
> > 
> > Who knows this?  The developer?  What are they supposed to "know" here?
> > I sure don't :)
> > 
> > Having some sort of "__must_be_first" marking for a field is fine and
> > break the build if that doesn't happen.  Otherwise this is something
> > that is not going to be used properly over time.
> 
> I'm currently dealing with this situation in the following way:
> 
>  struct libipw_hdr_3addr {
> -	__le16 frame_ctl;
> -	__le16 duration_id;
> -	u8 addr1[ETH_ALEN];
> -	u8 addr2[ETH_ALEN];
> -	u8 addr3[ETH_ALEN];
> -	__le16 seq_ctl;
> +	/* New members MUST be added within the __struct_group() macro below. */
> +	__struct_group(libipw_hdr_3addr_hdr, hdr, __packed,
> +		__le16 frame_ctl;
> +		__le16 duration_id;
> +		u8 addr1[ETH_ALEN];
> +		u8 addr2[ETH_ALEN];
> +		u8 addr3[ETH_ALEN];
> +		__le16 seq_ctl;
> +	);
>  	u8 payload[];
>  } __packed;
> +static_assert(offsetof(struct libipw_hdr_3addr, payload) == sizeof(struct libipw_hdr_3addr_hdr),
> +	      "struct member likely outside of __struct_group()");
> 
> "We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes." [1]

That's nice, much better and it is right where the structure is defined
making it more likely to stay there over time.

> We could probably create struct_group_first() instead of container_first().

Like this?

	#define struct_group_first(s, n)	static_assert(offsetof(s, n) == sizeof(s), "struct member likely outside of __struct_group(), please fix!")

And then the above would be:
struct_group_fist(struct libipw_hdr_3addr, payload);

Hm, use of "payload" here feels odd but you get the idea.

> Anyways, so far so good.  For some reason I was under the impression
> that you two guys wanted the container_first() macro.

I don't :)

thanks,

greg k-h
