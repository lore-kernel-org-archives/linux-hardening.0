Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA8639855
	for <linux-hardening@vger.kernel.org>; Thu, 20 Jun 2024 18:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909954; cv=none; b=g1urPEVZaxKT1aOVuPz9OrBSZ9QcRs/LcESh34Grh53RY4wUPT2NQ/33v0A8uSWAhsxip05eQDtMJL6SGoeyXwctGRz8DwNmqD6kWQW7J2PBhYcCmkTKL9BzHr5Q9LF3MtfT1MsnDjH4k0EuwdHdoQotP+bREza4QYRI8tvleRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909954; c=relaxed/simple;
	bh=lTzTVp1u2ZY/33DSacWsJpPfGL854+EENYkyrza6jNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgPmIeBppwIbsdkTA3DWpvmK4UfD+mosOh5MSRwKI45/ZHz+euGjkQfn1W9S1X4sZnggjLQpAGC+II/LciG8SvuX3c0fxVyMoj1aPeHoU9GRqK7GjteKXZ0Pz34B9kr0ab6hBFv5M00RjJUdMGC6TgvmoiEqUa04qgkYk2QR54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRLORXOR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRLORXOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED3CC32786;
	Thu, 20 Jun 2024 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718909953;
	bh=lTzTVp1u2ZY/33DSacWsJpPfGL854+EENYkyrza6jNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FRLORXORdq/O8QdBB4WAPYndyKmuQN7QQ/aE1zBULz0N3fEN4Hk2AS7nQFW+QhXt4
	 7fxb9W+b0cZZBdFN+9GcX+JBtmR7dwjdWVkyQhEcMHmV5UgdveVAu7lZ9qHcqIxGhX
	 Sc4oQnzFtiJO8TZHSOgQ5WERuFhIowIslGEAQJsIquu4YHhBMzh6RuahbC7L5zb+mP
	 LvZMu4K/5ZoTB2QHzW2+jvHlldi4htSWNGf6t9HWoaDAMKChs1Sa5nogV/xnxoLxav
	 Wz1FJRMoMDe4XxhlcjdFGBVgmzyOuJTv+y+EClujBeDfyXatRqY2zYjPPlMbWCStf8
	 QVfewK1IOGvGQ==
Date: Thu, 20 Jun 2024 11:59:12 -0700
From: Kees Cook <kees@kernel.org>
To: Anjali K <anjalik@linux.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
	naveen@kernel.org, christophe.leroy@csgroup.eu,
	gustavoars@kernel.org, linux-hardening@vger.kernel.org,
	vishalc@linux.ibm.com
Subject: Re: [PATCH] powerpc/pseries: Whitelist dtl slub object for copying
 to userspace
Message-ID: <202406201158.346A2BE@keescook>
References: <20240614173844.746818-1-anjalik@linux.ibm.com>
 <202406171053.F72BF013@keescook>
 <499f5305-eb54-43a7-9864-d032f29c445d@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <499f5305-eb54-43a7-9864-d032f29c445d@linux.ibm.com>

On Thu, Jun 20, 2024 at 10:58:49PM +0530, Anjali K wrote:
> However given that:                                                        
> (i) The dtl buffer is read-only. The dtl trace is a set of metrics which   
> are collected to be read by privileged users.                              
> (ii) Users usually reads all the dtl entries, not a subset.                                             
> (iii) Read overflows are unlikely to expose anything useful to attackers        
> since we are whitelisting the complete slub object and there are no        
> contiguous memory locations which need to be hidden.                       
> Can we go ahead with the whitelisting using kmem_cache_create_usercopy()   
> approach?                                                                  
> Or are there other reasons to prefer the bounce buffer approach?

Yeah, based on this and what mpe said, I have no objection to just
allowing it in kmem_cache_create_usercopy(). I was mainly just curious
what the threat model was. :)

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
