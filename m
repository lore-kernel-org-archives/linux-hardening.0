Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E5A209F43;
	Mon,  7 Apr 2025 18:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744050048; cv=none; b=CODbgJ5GKXSrd/XHCahkDbwLofdwHuDFD4MGeh67qXheKd4I7Nuvk7jLbn9aa1VRbaeQ3FIA/0Za0mwsS3WttYVkX1sZBYbUuMi7M5OXyJcmvqg7EMG0ewbZW1ljx991uQlUuzqIyQBqBPiajaKgqKqKajMYw0/93R8Zyt3HB78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744050048; c=relaxed/simple;
	bh=zDaZbMAAg7xACniRnltf6MFVSca2BVZk0xG37WbN1nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKJeyQRIl/6jpFaUYEXiBY5q2BCy81SmSgYVXbd/tOYxmc257I14HmFjL41P62pMqxPufZRCA32+vii2qvgoXcwKf6ScHiZx/DXHSzjbum8p31CwUANx7A23tTQFXq+1lRbwvBZPpOM2UpYtoEcudrAtnh9+upY3G9YPHICkYW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVdoNG9T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVdoNG9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BB6C4CEDD;
	Mon,  7 Apr 2025 18:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744050047;
	bh=zDaZbMAAg7xACniRnltf6MFVSca2BVZk0xG37WbN1nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVdoNG9T1vHhy5eiI5HN2DEdCrcT5PSI9+78x09euy5F35DTZ0zXb7GO9vkMTzNy0
	 jBc2b4t4Bq4B0iTf4PWOTplxWLFbFfZuAnhhQHtGmtDac2QrhznS7Q5mCumXOD8+nv
	 hTJJahFC6Pqq7uXIp2HA+DBccGmd8UIsUCcsXxaC0yS5w4BpF9L8pwWsTrPW3OlqrC
	 zOywcCoIg18+Ap/kleSyWB2itTETxu1sqNJks53HhHx4nOI8Ep+jKRlSY4TnO2/qqs
	 br6bzTaXtnvnkkX566KksyaB+n6yJHGJt/5+Us+uWgLqL8GOQzcCTmG+6BNu/3yOM4
	 gE7+vuCb3RtiA==
Date: Mon, 7 Apr 2025 11:20:44 -0700
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Peter Rosin <peda@axentia.se>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
Message-ID: <202504071119.DB9497A510@keescook>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
 <785391F0-C381-47FE-89E7-6265F7761208@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785391F0-C381-47FE-89E7-6265F7761208@linux.dev>

On Fri, Mar 07, 2025 at 12:32:07PM +0100, Thorsten Blum wrote:
> On 3. Mar 2025, at 19:44, Kees Cook wrote:
> > On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
> >> Convert mux_control_ops to a flexible array member at the end of the
> >> mux_chip struct and add the __counted_by() compiler attribute to
> >> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >> CONFIG_FORTIFY_SOURCE.
> >> 
> >> Use struct_size() to calculate the number of bytes to allocate for a new
> >> mux chip and to remove the following Coccinelle/coccicheck warning:
> >> 
> >>  WARNING: Use struct_size
> >> 
> >> Use size_add() to safely add any extra bytes.
> >> 
> >> Compile-tested only.
> > 
> > I believe this will fail at runtime. Note that sizeof_priv follows the
> > allocation, so at the very least, you'd need to update:
> > 
> > static inline void *mux_chip_priv(struct mux_chip *mux_chip)
> > {
> >        return &mux_chip->mux[mux_chip->controllers];
> > }
> > 
> > to not use the mux array itself as a location reference because it will
> > be seen as out of bounds.
> > 
> > To deal with this, the location will need to be calculated using
> > mux_chip as the base, not mux_chip->mux as the base. For example, see
> > commit 838ae9f45c4e ("nouveau/gsp: Avoid addressing beyond end of rpc->entries")
> 
> Since this should work and is well-defined C code according to [1][2],
> could you give this patch another look or should I still change it and
> submit a v2?

I think C is wrong here, but it seems it will continue to accidentally
work. I personally would like a v3 that fixes this, but I leave it to
Peter who is the MUX maintainer...

-Kees

-- 
Kees Cook
