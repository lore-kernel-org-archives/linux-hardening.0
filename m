Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B1325483
	for <linux-hardening@vger.kernel.org>; Mon, 24 Nov 2025 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764018388; cv=none; b=KO8i3XwskNnpjJmlzjRX2YWsVwb4Al9si5JPV9ykZhmVHhboLw1y/JeB6cZU2q+2f1iRIC0a/EVps/cAcfjQuuoA3VtWnaPXH4h/hA3XjLbRqW+tOauLzO8RizjCa3WSM7JtRs/QzoPcPBujnpQfKISPZwFPwRyJxgVK5xgKWW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764018388; c=relaxed/simple;
	bh=5ZpbdBOEme5Ef7yD8vxuIFpt/rRhKUZ4HY8PVU4Fpo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW2qFDseyhytgimD1jTRqHRJ7dbnVBpYvF501Eeefw9OmmplqQl3gJBjyQqkn/2ywhRmYMyu36ISx7qP9C0odRTUB1z6kEo5ubIuSpJ5YSeMxemeugF7KjrI/2ERLx9vDv5LTzCAv+XjX8ekZAl9kCj8AT2Y4t14QzMaieVBVws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MneGRE5Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MneGRE5Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44062C4CEF1;
	Mon, 24 Nov 2025 21:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764018388;
	bh=5ZpbdBOEme5Ef7yD8vxuIFpt/rRhKUZ4HY8PVU4Fpo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MneGRE5YfqloYRWYJ2L43A3dMy6bQMkj7pqpMXSmicTWkMJ5kfBym8XFudRcYX1TZ
	 dfrifPk9s8kNFw5Gz+tHGOuonOz6/ok9phUhrrW4aOY9LlVHuHTkSRSxH9HHWVDUvy
	 9tBZPzDEnDB6d3cw3eCiCnxe67B43BAZK+x18CiXY+ZojbNPy6IMp5sWISMjryaT1Y
	 i8SqeV+0wTyFb8ZLi5IMMmwCdScm7Yr7qFPSC6LjomBpY7Tyw3YY5ViZ1RtS42UwEC
	 Rk9nmqQVVWF95lepBqNkbk0GAwPSgELQmPrUUxbH2ixDwrJbbn1lfxAo6L4L2nL8xR
	 yivTaa1MknR8w==
Date: Mon, 24 Nov 2025 13:06:27 -0800
From: Kees Cook <kees@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-mm@kvack.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 13/16] usercopy: Remove folio references from
 check_heap_object()
Message-ID: <202511241306.525D3248@keescook>
References: <20251113000932.1589073-1-willy@infradead.org>
 <20251113000932.1589073-14-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113000932.1589073-14-willy@infradead.org>

On Thu, Nov 13, 2025 at 12:09:27AM +0000, Matthew Wilcox (Oracle) wrote:
> Use page_slab() instead of virt_to_folio() followed by folio_slab().
> We do end up calling compound_head() twice for non-slab copies, but that
> will not be a problem once we allocate memdescs separately.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
