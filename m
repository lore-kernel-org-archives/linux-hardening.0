Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83794227BB5;
	Thu, 26 Feb 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100167; cv=none; b=oKzI0zjzBpwOlMA8OmHjGZODtF95SNZAG5eLaQm0AX9tUW925TXyRCrqpk7phFk01CxMeBye4fFl68tUWCSQ9OIDJjjymObVfS0t65CC9P6bv8opCZhWvwcTCIBD1Yt9Xm+SKjK5nEGcCPvB5OrPVs+QH5WFWFE/KL28B9xTjuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100167; c=relaxed/simple;
	bh=biKqRyvpWuguXFm/8QPIOZ5OjWV5g0hWS/d8h9nLg4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lzt3+Y5oE4j2NamuG/8AF8iFYjzsEg+o/nfExrluPchz8O4cVvVcTIsvaBEgXC7st7ZRaYbemFYsB06vHZoMmwPizn56/3gYCe+Bw3bKu+urHHl/qoW+TFTq07yR78LjQsB8hwAiSZGFwh6kaKIBUhicvSjKFSH2GFaD9NWz0Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5mcq+9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5mcq+9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2891FC19422;
	Thu, 26 Feb 2026 10:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100167;
	bh=biKqRyvpWuguXFm/8QPIOZ5OjWV5g0hWS/d8h9nLg4k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k5mcq+9jHOWQHwCsIwdPytzf22xUG1PXgxXrh1jZEGbut8FBQSnZffk41jdeNMa9r
	 RxCt/YDDTmSJfBMNY6FUuoxqEzsV7QIHEfzVdHXNlRZoxCZ9iZTNvJcTIiuYapadcv
	 FCwvSYs1yjkihMGxMaewrJBiKgzeM5TOMiwZBkYvF9ya+o8JPgNBRQ1J/rI/Tl6Kyy
	 2tjnysSQ1QaNQvG2ArYo5qapPY1hDURLbBSh0nHrPSahNAswY7MitJ5FZCJ9Xbcnr0
	 XlCkAbf+6rQCu5UnaqNY/wAVwTOCV0b+Cn0Bz85PBkzDuIf6alj1usL6I/dg6qN4mn
	 ofmO9koIbDOtA==
Message-ID: <751a94a7-d5b2-415e-9591-a7d97b452d81@kernel.org>
Date: Thu, 26 Feb 2026 11:02:43 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slab: Saturate to SIZE_MAX for allocation size overflows
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Matthew Wilcox <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter
 <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260225013954.work.319-kees@kernel.org>
 <aZ5zjIpYZYoc-LSX@casper.infradead.org> <202602242315.C9D5430C7@keescook>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <202602242315.C9D5430C7@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/25/26 08:15, Kees Cook wrote:
> On Wed, Feb 25, 2026 at 03:59:08AM +0000, Matthew Wilcox wrote:
>> On Tue, Feb 24, 2026 at 05:40:02PM -0800, Kees Cook wrote:
>> > +++ b/include/linux/slab.h
>> > @@ -1105,7 +1105,7 @@ static inline __alloc_size(1, 2) void *kmalloc_array_noprof(size_t n, size_t siz
>> >  	size_t bytes;
>> >  
>> >  	if (unlikely(check_mul_overflow(n, size, &bytes)))
>> > -		return NULL;
>> > +		bytes = SIZE_MAX;
>> >  	return kmalloc_noprof(bytes, flags);
>> 
>> Wouldn't this be better written as:
>> 
>> 	return kmalloc_noprof(size_mul(n, size), flags);
>> 
>> (etc)
> 
> Sure, I can convert them all that way if that's preferred?

Yeah I think it's better than effectively open-code the same thing?


