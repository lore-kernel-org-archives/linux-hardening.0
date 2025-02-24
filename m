Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71A2661B7;
	Mon, 24 Feb 2025 18:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423330; cv=none; b=XzVUYEFwR99dq3lNhIrrIQ020HBNwrW0s3eX7/emndHkENE56iDLHGSY2VtaPwOBAek8B1SjppI7drSLe7r7AwCXKOhETwcIZOuxj2z9TLw28EtTLS1vTsBSfH9pQ7d9IrK7h6ou7PoQlJQTgLa7eMNA68E70w8wAFgc22jbp1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423330; c=relaxed/simple;
	bh=alwm7H0/BWdTHX+puhJNS61pewetUWsMlLy/AAC4VRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGp/5ExeheRcMXxHBqEQwDcteA//2DEDhSTZoQdK931CrTNx4RxXKNzX74DR+IX8SU30SqcJv+oGo4T5+e7Dh16JZg4c2+kt50hFCif0HVPRp9ndO58p/zyzn8FLOdn0I6fd49kjCQeSyGbc0zQewfItV4OlpfN4tfOEd8ATq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjEhGyGK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjEhGyGK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18827C4CED6;
	Mon, 24 Feb 2025 18:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740423330;
	bh=alwm7H0/BWdTHX+puhJNS61pewetUWsMlLy/AAC4VRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GjEhGyGK3NikUXJvD6X3msh6CJMLkJ+zXObx3D6+LvMSYvDXrrX/on8/Vb2ccqDCJ
	 c0liPvhk4ohuyS2mUOdZQ1LlEuWZLR6K4n2dDnbFfckcUlA29ijBTBpHIwFW+B75+s
	 4bFyGOmueXYBkU/PLMlerOVQbtqbYpEwSNiDUYw0wVDe8fiY/VXEL4pKrFvc0w2ycR
	 aFT9SNfHF6mK17AVYL41HSlGg0a/KLxDtZakreGghtLRk/IF/0yb2pFMjzk7yPta/J
	 eGoSGGZoAC8rbY7aeHBGLpilC+cX+Wf0q9m1wkbr6bZ73BWGwb1X8eciJ0liDZCf6D
	 NfQzy0r9pDMjA==
Date: Mon, 24 Feb 2025 10:55:26 -0800
From: Kees Cook <kees@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Jeff Xu <jeffxu@chromium.org>, akpm@linux-foundation.org,
	jannh@google.com, torvalds@linux-foundation.org, vbabka@suse.cz,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com,
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, hch@lst.de,
	ojeda@kernel.org, thomas.weissschuh@linutronix.de,
	adobriyan@gmail.com, johannes@sipsolutions.net,
	pedro.falcato@gmail.com, hca@linux.ibm.com, willy@infradead.org,
	anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com,
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com,
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com,
	42.hyeyoo@gmail.com, peterz@infradead.org, ardb@google.com,
	enh@google.com, rientjes@google.com, groeck@chromium.org,
	mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com,
	mike.rapoport@gmail.com
Subject: Re: [PATCH v6 1/7] mseal, system mappings: kernel config and header
 change
Message-ID: <202502241053.1FF33D5B0@keescook>
References: <20250224174513.3600914-1-jeffxu@google.com>
 <20250224174513.3600914-2-jeffxu@google.com>
 <443992d7-f694-4e46-b120-545350a5d598@intel.com>
 <CABi2SkVKhjShryG0K-NSjjBvGs0UOVsY-6MQVOuQCkfuph5K8Q@mail.gmail.com>
 <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <385e1498-2444-4a7a-a1b0-0013b0b8fd68@intel.com>

On Mon, Feb 24, 2025 at 10:52:13AM -0800, Dave Hansen wrote:
> On 2/24/25 10:44, Jeff Xu wrote:
> > For example:
> > Consider the case below in src/third_party/kernel/v6.6/fs/proc/task_mmu.c,
> > 
> > #ifdef CONFIG_64BIT
> > [ilog2(VM_SEALED)] = "sl",
> > #endif
> > 
> > Redefining VM_SEALED  to VM_NONE for 32 bit won't detect the problem
> > in case that  "#ifdef CONFIG_64BIT" line is missing.
> > 
> > Please note, this has been like this since the first version of
> > mseal() RFC patch, and I prefer to keep it this way.
> 
> That logic is reasonable. But it's different from the _vast_ majority of
> other flags.
> 
> So what justifies VM_SEALED being so different? It's leading to pretty
> objectively ugly code in this series.

Note that VM_SEALED is the "is this VMA sealed?" bit itself. The define
for "should we perform system mapping sealing?" is intentionally separate
here, so that it can be Kconfig and per-arch toggled, etc.

As for the name, I have no strong opinion. Perhaps VM_SEALED_SYSTEM_MAPPING ?

-Kees

-- 
Kees Cook
