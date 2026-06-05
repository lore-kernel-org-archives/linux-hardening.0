Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E9C28725B;
	Fri,  5 Jun 2026 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682927; cv=none; b=hGXlqCTq/NK0h0dJT5UYtWXEQJiEm74txjztwRrY0IsRbzogUTn8G5MjfYYrzI22303wdxi9P+dwJG2UCT3nd/dTErxLctZmrgXX2fmPKLCsAgw9prSOwo4B9dg/2qkCYoxtgjiR4288clM6tPZrkKJCyPuzoMTtoNm2y2nh/lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682927; c=relaxed/simple;
	bh=YV2uNbPaJBcjv8noE1gM8kONADTyRIz8xeumYPfVdU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnLBip8QrAqu0BUrNwl6KMKmd0u0AJujUiS6yBqYvch+vPAMzWOoW1S7+/m8+znUZ+Td5LSuJeU3qCyclvwJqaJc9qJTMKnW/qeHFKY2EjFVUnxCKK6loteIV4evO00MRkWGUJ0QMWtPgKhC1K1pdi8LZgeuD5XrB8S6btyYxD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4F8rhaE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4F8rhaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BF41F00893;
	Fri,  5 Jun 2026 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780682926;
	bh=9s3sWRVpgxchzDG7N1rvybpE1WGp1wCd44hSTHObGaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m4F8rhaEt+GK+VL7x3SnX9q2vkfvFX7ejGOsBF/4rIekkYBgP1rOzktFiKFJZnigX
	 RIV0a/pXmJJU/UWYsJX3BnonHa3WREq6pPkyxjLinD8A1jAb4yOOUKdWCe/lTsBghX
	 SYBdZEDDRER8q6UIV2kcQWkd5Ih9tVj3QkFBdzNY1t1jBPIZM4+BPMuPPNxoj0neSM
	 bZve4QQfFADDZ3UDYc9VmFqUpFDqy2z+ufwlsmUeaPqVx4I8wzQhhO2o5sTQ7HcEJW
	 Cyg9EaTRUxVBQlLY9HXHX1VsQPbIYgS9lOM8NLNTGFxdxRphEAydbSTBXYoXQiUjZP
	 98bKuTIEgcbLg==
Date: Fri, 5 Jun 2026 11:08:45 -0700
From: Kees Cook <kees@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH 1/2] mm/slab: add a node-track-caller variant for kmem
 buckets allocation
Message-ID: <202606051108.380FB49@keescook>
References: <20260602183122.747759-1-pfalcato@suse.de>
 <20260602183122.747759-2-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602183122.747759-2-pfalcato@suse.de>

On Tue, Jun 02, 2026 at 07:31:21PM +0100, Pedro Falcato wrote:
> This is required by users that want to use kmem buckets, but still
> desire specifying the NUMA node.
> 
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Nice!

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook
