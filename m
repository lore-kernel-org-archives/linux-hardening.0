Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DC5486BAE;
	Thu,  6 Aug 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786038978; cv=none; b=LlljHQjU7kIQKZI8xWyTvxqWZuz4gFWbXVY0iSKIImgCicNkkRfzytfmyYh8C2r37z2QDGgRSBOe0TVK0m2TeIZK3UQWPH7MsJkXDSOADlyFbh2cZjvFjcjzxUgRoF6WsuzHy29oSkuhywZRE66MLEOMFXuBe4EqGRKC0G6PYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786038978; c=relaxed/simple;
	bh=wVGgCsO637m3QybdNrh7969r6LJhw5kjVsuPjs/xhmY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C28Y6IfD3s3Fa8QwcXgvYDtn+xQSnPwv1Vn4AA33hOLJ57W+AJPCaSVXrQ87bhhblhlqLtkv2VpIzSRZQn6nFI2aQ2jquP+eBLnIg+PQLK3/7n7EHmqGRmE0tLEcngXm919SYAkzvTQbw7+tUoFQXi3YTXCk5SHy3k15x9Cig5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI0vijPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI0vijPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34B21F000E9;
	Thu,  6 Aug 2026 17:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786038975;
	bh=pP8/+IPjApPrhg92srmtesvabW4LFYQXAJXR3pd5Fbw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=EI0vijPY5rBvJdiBHvxF5mK9Tlgu4Gjn/wB6Mn/YEegWUoCgEorGfIPIfvu3yps1P
	 xWLpq6a8hcqiQYB61qQDCIwvQWtUNbXgXL7ZJA8PO3B/q7iaQ3HRmSsQmeNtkg5WFk
	 qWQYvlMtvwLsWh2IJ+I3HcrnSku+5WAaX1uEM6zQXZ9z50dYxCMRKkchVFjMVbEs6B
	 VkpiRlTKtoX+Ndy1tzHCPfMVXYfXC9o2lU3xSeDJiMhER+Ytey+SYiQdkOM91WNvrq
	 rP7DBJcdNLuNovQLLMEP9lE2lhiSTLxOB2VR2URDOeOX86kobIHy5W5QRcg3bcgHTF
	 jrQ9ueHPseWAg==
Date: Thu, 6 Aug 2026 11:56:14 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Milan Tripkovic <milant2002@gmail.com>
cc: pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, kees@kernel.org, 
    alex@ghiti.fr, andy@kernel.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
    Dusan.Stojkovic@rt-rk.com, Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
Subject: Re: [PATCH v6 2/2] lib/string_kunit: extend benchmarks and unit test
 to memcmp()
In-Reply-To: <20260520123954.379630-3-milant2002@gmail.com>
Message-ID: <94d47e77-3cec-158f-c214-248d00e41529@kernel.org>
References: <20260520123954.379630-1-milant2002@gmail.com> <20260520123954.379630-3-milant2002@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 20 May 2026, Milan Tripkovic wrote:

> From: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>
> 
> Extend the string benchmarking suite to include memcmp().
> Extend the string unit test to include memcmp().
> 
> Signed-off-by: Milan Tripkovic <Milan.Tripkovic@rt-rk.com>

Same comments on this patch as were posted here:

  https://lore.kernel.org/linux-riscv/81c7c1b0-2906-96f6-6f7e-c859a7578c8c@kernel.org/T/#u


- Paul
