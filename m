Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF98D38DF9;
	Sat, 13 Jun 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781375585; cv=none; b=MXsNqtxsIvVkiNfx+P8czArHT3HYdQqea98S53MmAta/7sN0ho0QXry2slNF2h3EJrnd+5zpXkPUUFeoqE8q75S9fAc4Rqi+8XRHneUEwDPcDpp5jP0YkkNoMg50zhHUPtmRwIwdr0gZkD4UEcNQBhQ0jEd5xoHdqWdRlJdJNpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781375585; c=relaxed/simple;
	bh=yOW1T1jI9R3lcErTj0NvMwYkX0MWbRLw3YOmNJRO3O0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3CvVQvpXo4VEPGKgp3AfVcnOKTIqHwIjKxocNc5FbaiCdGxLQWpQ+2puPqytshBmlwmzMcKXq8olasxdZUVaMdxtj3Y6ntB9RHWqSVcm1jgAWp60bgHaVxJJffun6Ndv+Mzu0TePBb19zy3KpHzdD0TxVtD88kz2gQNaWGoxYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWH5j2Ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWH5j2Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE021F000E9;
	Sat, 13 Jun 2026 18:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781375584;
	bh=mp30tNqRfK4Zo9AUlCqB1todNLWmHa6GmIIRAZsl2kA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WWH5j2IeOfr7qkLo+wELTxTqWnL9XBQV/ZrhkUpio9pYgrHeVMOXgu/2lhTzU6jYN
	 gZ9VIR0CklvtNogLK7+5eEZjkSPV132GIc+/gDP6J60EgfWtGBrCPwuOXrXfSiohm1
	 pvx1148fro5ST4PnJe7JjPl19lTYUEzqmWilRDEy54nVg6Y26huMM6HH6K5Ck0I9Ki
	 dNUbEyEVW155apszFZ5nOVerqJ9cwozTC+C0T2GPbr8dHBv/Knqf4/SdIsy9hjojSf
	 sm5pyyxho878EZYEL8pdRr7GPRVuofDdOs2+UjaqzZ2iQXE2rJr0sMoBjB+oLev3xP
	 A1EVBArekuPxg==
Date: Sat, 13 Jun 2026 11:33:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Hao Li
 <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes
 <rientjes@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, Simon
 Horman <horms@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH net-next v2 0/2] net: isolate SKB data area allocations
Message-ID: <20260613113303.7562bc59@kernel.org>
In-Reply-To: <20260611124642.345400-1-pfalcato@suse.de>
References: <20260611124642.345400-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 13:46:40 +0100 Pedro Falcato wrote:
> Subject: [PATCH net-next v2 0/2] net: isolate SKB data area allocations

This doesn't apply to net-next, does patch 2 not apply to mm?
If neither tree can take both - maybe MM can take the first patch by
itself and we will queue patch 2 after the changes propagate during 
the merge window?
