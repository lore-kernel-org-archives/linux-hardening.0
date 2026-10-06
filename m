Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5163383982;
	Tue,  6 Oct 2026 21:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791323719; cv=none; b=bAmfHtekzWJWRQRbZYwWLc0ywiI+LpgMeWoTHyV3XvL3aR2y7ipSDyKE3NnehOutMy2sfLTZHnWy8Tj0ljuaNZ4DYEPy9L+awPy+OHY33K+08gzWqCUc2jIrCsR74v9WXjlZvEtAsr2vt61A/ZZnqKUyqN0R4osQ6uljkLAMw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791323719; c=relaxed/simple;
	bh=xHJ9hg4yHkDXfjW444BnDtWp5EuaiG7dT2iCEQzYgK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OjHcAbXGTiBmS9+bFEagEUkx/n0x93KJlbKLzQWf5HL7M+M/PStM6+EfaBRBlDNHqdoKOCaCuCSpa3Zg/GW52AtgN9CUFGACdszsMpv04KiC12Gy033JMdOYUCmfTJSOnj0Nq5/kMm0rZIrU/LnhvqNIVzZShQMPbcmRa+hxXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNM4U+Ff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNM4U+Ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D69B1F0089B;
	Tue,  6 Oct 2026 21:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791323718;
	bh=p6cFzmPVwnvLGajBYkemFKtr5g0mwddLRoGytSZpBcQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JNM4U+FfrDsXu5990fwPYm6E29Rkx4Z2Jnv2SwaQHObk/terRWHB1dyEp0e6TARv3
	 he5XCigWKBrVTsXRj+vBYmp+MOTpS18pIF/4QCPC8Oryq9OvaZvGZg/g3GgYXuIuhf
	 J6Vr14biXn3SW9Igv5wQFFKarNudhjYVJ3TlNzsi3UV3+oYdOt5Zlvzx72+chr+lJA
	 iTglIHE9dfWIxKGmIYtihtacHmp9QMlTBfYOKNbHXQbBIXJE0ZTypKLL6hNYRElVvp
	 gWyctowbQSA+0XTQdJTU3vxFX9iVd4i/dcICnRKPyU6QCx2aYE+Kicch5b1UhOq3V6
	 LWZgF1xyJm80A==
Message-ID: <007d40e9-221f-4dcc-ab74-e2f1ff706dec@kernel.org>
Date: Tue, 6 Oct 2026 23:55:11 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for
 devm_kmalloc
To: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, driver-core@lists.linux.dev,
 linux-hardening@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20260914223212.i.829-kees@kernel.org>
 <20260914223219.901347-2-kees@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20260914223219.901347-2-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15.09.26 00:32, Kees Cook wrote:
> Mirroring the type-based allocation now in use for the kmalloc family of
> APIs, provide the same for the devm_kmalloc family of APIs. This will
> allow for future plumbing of type information (e.g. alignment) into the
> underlying allocations. This immediately gains type check on return
> values (instead of the prior "void *" return type).
> 
> Signed-off-by: Kees Cook <kees@kernel.org>
Reviewed-by: Danilo Krummrich <dakr@kernel.org>
