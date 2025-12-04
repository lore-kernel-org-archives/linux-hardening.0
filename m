Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3D275111;
	Thu,  4 Dec 2025 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764828456; cv=none; b=kOiMfifjZDbYV4wRMN77Y517axKQilXcQu/ndGy/kYrzDRM7oQ9VaI6lNXXi7CXcej4XV9AoHA/Pk4mkDHz2s0kXJPn9qV6y9w3CL5s+g9BH72w4QyuVn5T7kJtnrW7KRnhM2XP3JH3fFPfkWtvy0piG5DDaj4QO3HqozpvDowM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764828456; c=relaxed/simple;
	bh=oW9YKnJzWB2+6bhflZNJrm7g/KPV070xkxno6gjgYUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvgvVGuKZ9Sa6S79+QJ42wOaz1CA2nClnshF8dYDOTnvhAUh+V+eZeVZpu1dXnW0foQ+pcQN0ebpaHkPyrWiEjnWs3mmw0C/CFxyknKSs0htsgspLLaRxPSOM/wJF1b6smJYjFqGAo5gTNJUE5zDQjy6038qahdrps2CWaUNuU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlPO1jE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlPO1jE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A065BC113D0;
	Thu,  4 Dec 2025 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764828455;
	bh=oW9YKnJzWB2+6bhflZNJrm7g/KPV070xkxno6gjgYUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZlPO1jE4+cXIEbXbrYgmI1LOZn4FWTmffO/oZULe8KxYnUHl9HGcFtfewnOWg1sVT
	 sIYh97Lk+BAF8ZjuTTQar07UmTVtc5kBka1ROibQScS+3lduJMkBNTecSDfHtz4Qm/
	 h61HX/Ed1WyJW6H9QfSasuIDq/T+Ci4L7jEYYosAqSkoulfvkurQeFjk3IU60wWk/e
	 AMbRg/allsp9drBAGnL7GFJbtcge2ygnVUrC6+lXUrGBbqhpbrD/kUR1PjzE8xNQM9
	 NzINl3oGv/K0tdXi8zWMEA2e+mHrNDJkQ9vV7GrN6E59gaux4HmKLK3Vs9soHxn4pe
	 z/wrdO7FIhuUg==
Date: Wed, 3 Dec 2025 22:07:35 -0800
From: Kees Cook <kees@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>, Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org,
	Nathan Chancellor <nathan@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jan Hendrik Farr <kernel@jfarr.cc>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v6 0/5] asdf
Message-ID: <202512032205.BCA3A5B1@keescook>
References: <20251203233029.it.641-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203233029.it.641-kees@kernel.org>

> Subject: Re: [PATCH v6 0/5] asdf

*sigh* Should have been:

[PATCH v6 0/5] slab: Introduce kmalloc_obj() and family

-- 
Kees Cook
