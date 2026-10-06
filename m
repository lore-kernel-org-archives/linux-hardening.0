Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD97244694;
	Tue,  6 Oct 2026 00:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791247964; cv=none; b=O+nhx1095F/rkgOzoueCJ7z6+SXvwJJ8a8FKy1jBwX/YMHdvDpkCsP3ubavQ95EwNvdh/uQvUCXpiTXyp5bLFUDpI1AQ8W57c/uoO630kbfehmT5thKkk9Wg3b98wA6n7WxRuUU9YCVwqI8lsfN09Z5GBxuC/gb7hsXkfpDYcM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791247964; c=relaxed/simple;
	bh=N/gfL2dmPRy+8qNrwzpUEw8CfKnOH8yxOpuxlLZrbSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFjvJ+OkvWNYYiPOr5qZUzARXXhkwbm6p0MMLimUmahv5Qt9ilujdywcQ565Zeg2dAikCUZ4c9mtci1C1XaeiV63UiD0DCUmydKVrxbOlt39KylDbZ248tbAAmD6lFLipf7uz/k+FEQw5Co8AV7KwFp8hQJWK3cbXHjXMC2ka70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLnHL2gb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLnHL2gb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6BB1F000FF;
	Tue,  6 Oct 2026 00:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791247962;
	bh=a6yHyvxgSFAtHWCFCMd4s/EWnCMi2wyyPVO4ODcFr4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bLnHL2gbeCWNkbpH9td+jOYWcisFag1WKNYRonRKZsQjeSs/vv73vLl7fIEhngC/u
	 kr8+q7aBapijn3MEgS1UCicKD1luURaAL5imAaRwbllzE3JS9B9HWzk0YhB8Cx9XIf
	 /7dv1YJE4Ig+4eASQDDy90UFaMx1grxitiainL0BkT8jrvLdsz8/DUz2kGSepbrxfN
	 tZPdsKNC8QDKq8VC5rw4vOUtsltue1ZzpehpSm5P5kGNKlWBlQGa2/Hb3IpG6qKb4Z
	 CIj2dkgElxLscz2EgeZFK1HMxMkVca6J+MexZZRIaVh6zwuSz4BNxh1D6h7I29HyPK
	 +Pc8utcOPJqHA==
Date: Mon, 5 Oct 2026 17:52:42 -0700
From: Kees Cook <kees@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	driver-core@lists.linux.dev, linux-hardening@vger.kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
Message-ID: <202610051752.4516E8CF4@keescook>
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
 <2026100532-stench-enrage-0b81@gregkh>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026100532-stench-enrage-0b81@gregkh>

On Mon, Oct 05, 2026 at 11:35:16PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 14, 2026 at 03:32:17PM -0700, Kees Cook wrote:
> > Mirroring the type-based allocation now in use for the kmalloc family of
> > APIs, provide the same for the devm_kmalloc family of APIs. This will
> > allow for future plumbing of type information (e.g. alignment) into the
> > underlying allocations. This immediately gains type check on return
> > values (instead of the prior "void *" return type).
> > 
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: <driver-core@lists.linux.dev>
> > Cc: <linux-hardening@vger.kernel.org>
> > ---
> >  include/linux/device/devres.h | 102 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 102 insertions(+)
> 
> 
> I'm guessing you want this to go through your tree?  If so, that's
> great:
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Awesome; thank you! I'll get it into -next via the hardening tree.

-- 
Kees Cook
