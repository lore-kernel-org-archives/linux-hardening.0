Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CE836AF5;
	Tue,  7 Jan 2025 01:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212633; cv=none; b=QfvFw/V0AUAZAvanOahre3xoKkIAdhUmyhV/eWw+OSIsLtYkVL3W7KmRKHeXxVroK6N1CQ7n5FdRXwv+YddtnaYsmJk/d01DbN91V8xrYt/ZsQjPBx+sU3hj+eYd5C6p4io1MRIJ7BGHFY3PF09vmnmb7u2PU6mLUDY04zcmBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212633; c=relaxed/simple;
	bh=kAVrCQjzZghGx/Mh/TnXhecmI2ef0AhPGBvN/Aj8emc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB4obopmq3BbtryVfpww9eIbbGS/OD4C5G2q03EMOGE3PNVGfGHSIGRo/PbGHcIGubf1MGLPGx+XpYxqlahPCS9Y1Q2lagbkEFHlyX8+i04sB7W1tf14P7Oa2eE07cw5oHGuJhSKgdJDiQzXSTEolYzMu0s6Lu5efBFe/8NXaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpk+LaIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpk+LaIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06360C4CED2;
	Tue,  7 Jan 2025 01:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736212633;
	bh=kAVrCQjzZghGx/Mh/TnXhecmI2ef0AhPGBvN/Aj8emc=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=dpk+LaIMK1A26bZlbRyuwn8ixb/Il4rYdg9BPZKr+WqFHmKjCt/rXJ+T4CbdMT+P8
	 eXzNTGgu3STjCmzu+4POglK+Uq/mZPr57XZl7bi3IAHy4qB8O/+HvsGt1vgbBHn8Vz
	 m6xN1oK+YJ4ZhknXWuE6ui1fuABxFC+YFlezOjDLBshBGhd8bX59qfC03Vu03iz3Vi
	 /XUAJiFgOL+bmIZHZvPzsdz5HdaX1zPxR+e2SmmOPNj5no7M1B4+lEkJxLX8wucN3t
	 Z/c0h5GGHRtU9pryz7ailccg7DjIM2y6NFXWW1iOeEzinRwJ7vlz2g4yUsPL1MHVfV
	 va1n5a+DihdAA==
Date: Mon, 6 Jan 2025 17:17:10 -0800
From: Kees Cook <kees@kernel.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, jeffxu@chromium.org,
	akpm@linux-foundation.org, jannh@google.com,
	torvalds@linux-foundation.org, adhemerval.zanella@linaro.org,
	oleg@redhat.com, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	jorgelo@chromium.org, sroettger@google.com, ojeda@kernel.org,
	adobriyan@gmail.com, anna-maria@linutronix.de, mark.rutland@arm.com,
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de,
	rdunlap@infradead.org, davem@davemloft.net, hch@lst.de,
	peterx@redhat.com, hca@linux.ibm.com, f.fainelli@gmail.com,
	gerg@kernel.org, dave.hansen@linux.intel.com, mingo@kernel.org,
	ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com,
	peterz@infradead.org, ardb@google.com, enh@google.com,
	rientjes@google.com, groeck@chromium.org, mpe@ellerman.id.au,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Andrei Vagin <avagin@gmail.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Mike Rapoport <mike.rapoport@gmail.com>,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: Re: [PATCH v4 1/1] exec: seal system mappings
Message-ID: <202501061713.823E772F@keescook>
References: <20241125202021.3684919-1-jeffxu@google.com>
 <20241125202021.3684919-2-jeffxu@google.com>
 <202412171248.409B10D@keescook>
 <htdv44tqzi4jl2b7dwutsdwnh4tgrxq6xdvumi5wwu3hnh7sgw@tfwlal74ukx6>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <htdv44tqzi4jl2b7dwutsdwnh4tgrxq6xdvumi5wwu3hnh7sgw@tfwlal74ukx6>

On Fri, Jan 03, 2025 at 03:48:23PM -0500, Liam R. Howlett wrote:
> So we have at least two userspace uses that this will breaks: checkpoint
> restore and now gVisor, but who knows what else?  How many config
> options before we decide this can't be just on by default?

See my reply to Lorenzo, but I'm not arguing for it to be enabled by
default. I was trying to show how we traditionally handle these kinds
of features: putting their enablement behind a Kconfig and boot param
that work together. That way distro kernels have it _available_ without
making it _enabled_, and specialty kernels can have in enabled by default
(and can disable it at boot if needed too).

-- 
Kees Cook
