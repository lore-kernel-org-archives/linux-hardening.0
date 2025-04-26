Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6126C502BE;
	Sat, 26 Apr 2025 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745662653; cv=none; b=XqLx6b3lkd0//x8Wq3YcGhxCm865tlJiS1rfRnF0WKFaO4KrJNu6ph+xwah20MEgFBUiOLb1ALbCudtw8ehGoRNyjORYEyQFp/RQIDtfhG36ewCpg5MxD3rJtW9w0fMSzTUTT8BqzbzDRw9RGH+tgaRCe5NP0HQHR1hoGZVIvwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745662653; c=relaxed/simple;
	bh=7hs/1Nyf/ppXoz6xxamIkNtgAnWagu91IGMs3NCcD8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOMpAiKWLW3TWLZblI3MQyPnUYkKJXACKG6yjzUskc7JE+6zTyeluMnkyPKO7pZpACoku5+u/IQXNaeEGPnFyvei5hs6spcbJ+/ot+o2Fwq3cQoyDbCX/1xWAeMXFbLXDefjo0c4yZ56NnT9O5zWxEg+EhcJbdReWmWXZC6/eA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJHCRAHb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJHCRAHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7EEC4CEE2;
	Sat, 26 Apr 2025 10:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745662652;
	bh=7hs/1Nyf/ppXoz6xxamIkNtgAnWagu91IGMs3NCcD8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJHCRAHbd7906OgdZEl2tEX35vZIrp1huRIJkSYmLK1bGjVlJMvPRuB9NYrdiqgZL
	 NgzhDaHY8g/A1e6unJqjYHA83MM5+GKNYcI6/74/z3ivlgSCtfdBVuCr41JLx4Jv5H
	 Y8zoj6odA3cf75u28+J5alQgS5IOgwQS+V0520iGriWN/zJRKV3F6328R5thduZdWU
	 KA6461lxaGew9Ln5pB1J3CF170gcc41ExtIAp94c4gS2yL4C0avLJmYnhuk1CkqhSy
	 Xeqge+gOE4cXWgQ5jufatsTgjlJvcmQ5sL22Z+63/SQlRqALwIYZaFew+uMp8ofrGs
	 u5ds0w/HLnssw==
Date: Sat, 26 Apr 2025 12:17:28 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
	Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmalloc: Support more granular vrealloc() sizing
Message-ID: <aAyyuCz6Y1bliBbn@pollux>
References: <20250426001105.it.679-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426001105.it.679-kees@kernel.org>

On Fri, Apr 25, 2025 at 05:11:07PM -0700, Kees Cook wrote:
> Introduce struct vm_struct::requested_size so that the requested
> (re)allocation size is retained separately from the allocated area
> size. This means that KASAN will correctly poison the correct spans
> of requested bytes. This also means we can support growing the usable
> portion of an allocation that can already be supported by the existing
> area's existing allocation.
> 
> Reported-by: Erhard Furtner <erhard_f@mailbox.org>
> Closes: https://lore.kernel.org/all/20250408192503.6149a816@outsider.home/
> Fixes: 3ddc2fefe6f3 ("mm: vmalloc: implement vrealloc()")
> Signed-off-by: Kees Cook <kees@kernel.org>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
