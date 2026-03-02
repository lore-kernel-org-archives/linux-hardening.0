Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F88338D006;
	Mon,  2 Mar 2026 09:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772443681; cv=none; b=XFQVYNfxYUZlgJL4lW1Ieb2F7VFbEpXN9ACpKfxAklh13omK9v9IFO5j3L1REsvChaAxbPcp1Io8G8ULLpFzI1mFerMzTworHUhSySOXQxZ+m6WbAphOO3kk/Rfrghfg1u3jpiCuo9AJDdBENNJTqi1gkKDJoNxTezbRgIFclvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772443681; c=relaxed/simple;
	bh=XDqqJpO6KvaRP2y+HP6XP+sqGzk+KS+e/tXhKDCvw04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cpNfu8/dQqr2iwaM7xxYBVHWoUlE3RJfQxT8TvjYL6MuJRwkFh93jMSdgcVEAYygBstg4N2dSbnq462Yj7njV3ihgEj+0BhWINiEG0irxraj4pw7oDxEXsxo9Kj4CCB1dzPsKCMVW1ZryEm2WEXY3ILB3J4GPN804UxeIc/Xvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 290C314BF;
	Mon,  2 Mar 2026 01:27:53 -0800 (PST)
Received: from [10.57.13.119] (unknown [10.57.13.119])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B60D3F73B;
	Mon,  2 Mar 2026 01:27:50 -0800 (PST)
Message-ID: <a5967fbf-7be7-44aa-aaae-f374ea7ea61c@arm.com>
Date: Mon, 2 Mar 2026 10:27:47 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/30] pkeys-based page table hardening
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Andy Lutomirski <luto@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
 Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>,
 Joey Gouly <joey.gouly@arm.com>, Kees Cook <kees@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Marc Zyngier <maz@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Maxwell Bland <mbland@motorola.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Pierre Langlois <pierre.langlois@arm.com>,
 Quentin Perret <qperret@google.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, x86@kernel.org
References: <20260227175518.3728055-1-kevin.brodsky@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260227175518.3728055-1-kevin.brodsky@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/02/2026 18:54, Kevin Brodsky wrote:
> NEW in v6: support for large block mappings through a dedicated page table
> allocator (patch 14-17)

To be clear, v6 is still very much an RFC - I just forgot to pass --rfc
to git format-patch...

- Kevin
