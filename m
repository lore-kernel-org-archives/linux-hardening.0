Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A9C347DE
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s1UMVl3c"
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cc])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B4111
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 15:04:14 -0700 (PDT)
Date: Wed, 18 Oct 2023 18:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1697666651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2s3U1yAkM0di0yOCxQzp2ytWG3Emh1ypqTY1EYO4mxw=;
	b=s1UMVl3cbdUUtkb57UUvuFyq4GhP0cIIbcrHXN/hjQSZ2ymQwfVvzpXbJQZ2G90Ex+DldY
	TT4ybtNZhgETfTVatkwg6v/+EhdN1E0i1zmDhyWdg5Y46EHh0KpwMwFpDXINvBF7qTsnF0
	6yNmfX0ieuecgs8Po7tHkg9dWk4NVGU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Brian Foster <bfoster@redhat.com>, linux-bcachefs@vger.kernel.org,
	kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] bcachefs: Refactor bkey_i to use a flexible array
Message-ID: <20231018220407.b5dvm2ehibcqvhzq@moria.home.lan>
References: <20231010235609.work.594-kees@kernel.org>
 <ZSkpU0vdrCTfTxuZ@bfoster>
 <202310131637.D0C66BFBA@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310131637.D0C66BFBA@keescook>
X-Migadu-Flow: FLOW_OUT

On Fri, Oct 13, 2023 at 04:44:21PM -0700, Kees Cook wrote:
> On Fri, Oct 13, 2023 at 07:26:11AM -0400, Brian Foster wrote:
> > Hi Kees,
> > 
> > I'm curious if this is something that could be buried in bch_val given
> > it's already kind of a fake structure..? If not, my only nitty comment
> 
> I was thinking it would be best to keep the flexible array has "high" in
> the struct as possible, as in the future more refactoring will be needed
> to avoid having flex arrays overlap with other members in composite
> structures. So instead of pushing into bch_val, I left it at the highest
> level possible, bch_i, as that's the struct being used by the memcpy().

I agree with Brian here - I'd like this buried in bch_val, if possible.

I also went with unsafe_memcpy() for now - that's now in my for-next
tree. I'm not seeing any advantage of DECLARE_FLEX_ARRAY over that -
perhaps later if we could use __counted_by that would make more sense.
