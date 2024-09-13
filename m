Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC23191F6E;
	Fri, 13 Sep 2024 23:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271097; cv=none; b=kI4FwwpaWGzdH2zhR/p6A18BX+4sxpwFekSg0oUBhkPDH7wL6zBKXZ7+LNMqQ5gCMgiK2hj09lg1gY7zb3kY0jaJxYeCG9fgO0JhsQvLa7wGgasZqrSp++X2WoBLKSBwdfcMiW7GQ6Tk7an9SCwySkez3LPCMwihGyE8D5mqqzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271097; c=relaxed/simple;
	bh=XyB5Qm0LZ2L+O6pUS21aicFSjImojVfxPf2aok6rhUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjgqRCQsIpDY7VowWCeTeUIKLjlV7kL+I2NN/Hb9XKzR9BIPdSAUffMCpsBEEBWIOH2w9LhC8sva+BoghzrlC/dghb+gT1wCthdHpbEGjvSYEIWr9l4fhWZyKmaXOe1uI+ZLH4VpxO4W0JalwVszMj9x1nJYL8B4Zvq6Fs9Mo9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDyQGwY4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDyQGwY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6F07C4CEC0;
	Fri, 13 Sep 2024 23:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726271097;
	bh=XyB5Qm0LZ2L+O6pUS21aicFSjImojVfxPf2aok6rhUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDyQGwY4os7PgFYQXvxbnnaT3ZmnOeaiI1Hk6KQs3e1IlrSi7/ZppWf8rzsncFi0q
	 alqEq3Ps7wegPxGECYY6YDfs54E7EBaW0rH+WnKpjuRcMeX1RhgryWW6A8wyIAHNJb
	 nKAJ6G8RhAx77HEVTWg4Jzol4vHK/I2K2Th72EcYYOGAYSErdYUFQ7wSEKjaL58PqW
	 lqJFKD46LaWuVg5nKKswasGJmrFBrZfB0PIc11JYxn/vXzJfqoLP7/PTmPgducCDQ9
	 UPRkjOJngtFA80YZsI2lWbhpkN/4byeYZqNekeY/E+EibEel+8wQti4y6TqrdDCLjM
	 xAZ7ynEOUG6Dg==
Date: Fri, 13 Sep 2024 16:44:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: kees@kernel.org, gustavoars@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	mcgrof@kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bill Wendling <morbo@google.com>
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <20240913234455.GA1842841@thelio-3990X>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
 <60B48C52-12A6-4810-8C8C-9CC1C1E77E68@toblux.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60B48C52-12A6-4810-8C8C-9CC1C1E77E68@toblux.com>

On Sat, Sep 14, 2024 at 01:32:19AM +0200, Thorsten Blum wrote:
> Thanks for reporting this.
> 
> Changing
> 
>  memset(&mk->mp->attrs[mk->mp->num - 1], 0, sizeof(mk->mp->attrs[0]));
> 
> to
> 
>  memset(mk->mp->attrs + mk->mp->num - 1, 0, sizeof(mk->mp->attrs[0]));
> 
> fixes the false-positive warning
> 
>  memset: detected buffer overflow: 32 byte write of buffer size 0
> 
> even though the pointers have the same value. Does anyone know why?

Might be a good question for Bill? The full context is available
starting at:

  https://lore.kernel.org/all/20240913164630.GA4091534@thelio-3990X/

I wonder if the krealloc() has something to do with it? I should try GCC
but I don't have a tip of tree copy handy at the moment and I am also
rushing at the end of my day to pack for my travels to LPC :)

Cheers,
Nathan
