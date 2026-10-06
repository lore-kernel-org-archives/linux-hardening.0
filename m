Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B825A655;
	Tue,  6 Oct 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301377; cv=none; b=WO7Nr0yYZshIbQ5MadJjmX9FE6HI5Dt3edzz5LBKJB446jUx/RL+6PEr3FfuArrVSY5w8HS8pg+qvmFQZbZ04XHnFpoDfqgaOjZHNZZ8FIDbTOMGc5RUGfMTGp4b/GhJd9s//kW7Sq0tTQfEXbIphZRpxqhOGuYHI6VCKgcn7+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301377; c=relaxed/simple;
	bh=roU9coQfRxaaeiOH/ZEkXx1JahWrXVJ8XSe6JADNSnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ig4vQomnP8kYZvNs+jP5HdQHIsCtpbOCh0NdNRVHPLbOfQr2jkh+5r1adCuOlas5IBfoYh3RmUB0v6y/dAHCm+kD9pSzyYG1GWoe7nhoWuwZM81z30s34MdYnc1EAEUwQgYeaJfxsvj+BAWDaDw5ECZqEDDGMNl0q9Q2hpCQcWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtFXPpLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtFXPpLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02CC1F0089D;
	Tue,  6 Oct 2026 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301375;
	bh=roU9coQfRxaaeiOH/ZEkXx1JahWrXVJ8XSe6JADNSnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dtFXPpLCJewLAk5Ox0npsd0Mgz53kla9loWdf5Eeh2AXLLA9D8I6jICAQRkQT5R/X
	 /wiIowQCQ7f04XKwQWgJTf8+dQJSq/0K/1JWFjklQ4+ThJMfY8OIO0s+TlvpL/q4Pl
	 mTzVROl+C7LzpKFVCGguqBuViszzQYS8Qe28I1g2sd5/eIel/dJjcdTIpAvBelWBMr
	 wRVtPNaFVD0lVvtbWshaLWQF5/Lx03FCGpo6t4pmQT7+CgSklhjuwa3WhOVYdgrVQW
	 O8o2ZaOvKX7SyvUUpkC6tIRc0vc37f2eeWRLdv8klxit8OCFZfInya8svTX5h2U5Z1
	 Wb7ms5cUKZPEg==
Date: Tue, 6 Oct 2026 17:42:48 +0200
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Move default_gfp() into gfp_types.h
Message-ID: <asUW5dkEronQezrU@gremlin>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914223219.901347-1-kees@kernel.org>

On Mon, Sep 14, 2026 at 03:32:16PM -0700, Kees Cook wrote:
> Using default_gfp() only depends on the GFP_KERNEL value. Move
> default_gfp() into gfp_types.h so that future use in devres.h doesn't
> require pulling in all of gfp.h.
>
> Signed-off-by: Kees Cook <kees@kernel.org>

LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

--
Cheers, Lorenzo
