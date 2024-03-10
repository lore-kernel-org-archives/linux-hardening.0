Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0D81427B
	for <linux-hardening@vger.kernel.org>; Sun, 10 Mar 2024 19:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710099730; cv=none; b=MpHpKu0yKeol9dijFf46sMPEfXiL1WDZtW/NRxcwqtwqTNLPw3FE+FZ+7IOpnB7YUlt5CSmpeUxrCloECmKVrCM0sFYZdpnDC4pBZE98kFLSIaoiycnVredN3zQe5Vz08loQ2ZpyVps1fLyjiRbhnm5XcsINaW7cQv79HiT8h78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710099730; c=relaxed/simple;
	bh=xXfTV4GI3xnP2k8SPtzObSqxaymakeQpPF3auXEnEwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTOdBsG/TaqC+15aY4Id1tQn5In9vm/sR3841dp1TEMNAdls9PUtOqy5EscYKHzcxJL5Y5aYMgehnEOU4eFaWx8eSgzZE79aCWkEfx1MEFIRhZchUNoPcmfD78KOx6bPDBjkHAi9EaY1DSKH61Jzgt2DqECDGcoK2prV/sWgTR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eSHxJm9j; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eSHxJm9j"
Date: Sun, 10 Mar 2024 15:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710099723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cb7OKsY7pJ9Te/hhWi0i7nqCpNr5gLsM0TXwe5MbJsI=;
	b=eSHxJm9jvh4YY1rKRsZy9UXhw6N1OT5YboN9Hve5jsHATi2ski21RcYtJLhGKxV/d+DDes
	JxO6iUeNVTbRjc5EVGrKBiXFk0958xRzMaXQE1W+fXR0cylYK8n3XdywUICzV9DssAQtkP
	OH2zjTwYHtVAhmaL1oEb07OVZAvySLo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Erick Archer <erick.archer@gmx.com>
Cc: Brian Foster <bfoster@redhat.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, 
	linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] bcachefs: Prefer struct_size over open coded
 arithmetic
Message-ID: <rmna7gzrezwrhmrsgheswqsnc53nk6xiu5en6fg3ag44f3blps@otgd65u62umx>
References: <20240310110226.6366-1-erick.archer@gmx.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240310110226.6366-1-erick.archer@gmx.com>
X-Migadu-Flow: FLOW_OUT

On Sun, Mar 10, 2024 at 12:02:26PM +0100, Erick Archer wrote:
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> As the "op" variable is a pointer to "struct promote_op" and this
> structure ends in a flexible array:
> 
> struct promote_op {
> 	[...]
> 	struct bio_vec bi_inline_vecs[];
> };
> 
> and the "t" variable is a pointer to "struct journal_seq_blacklist_table"
> and this structure also ends in a flexible array:
> 
> struct journal_seq_blacklist_table {
> 	[...]
> 	struct journal_seq_blacklist_table_entry {
> 		u64		start;
> 		u64		end;
> 		bool		dirty;
> 	}			entries[];
> };
> 
> the preferred way in the kernel is to use the struct_size() helper to
> do the arithmetic instead of the argument "size + size * count" in the
> kzalloc() functions.
> 
> This way, the code is more readable and safer.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Signed-off-by: Erick Archer <erick.archer@gmx.com>

applied
