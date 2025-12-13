Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A88C3B8D68
	for <linux-hardening@vger.kernel.org>; Sat, 13 Dec 2025 01:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765589072; cv=none; b=EKTgdZndWwJFYoHA72au+7oab7Ewtr4+AGIZPF7InuxELe8peJKHkIj8J7x9lD8LWKcZaXoM9KjZjVD6Qa+FWYMUcU5d31dbdDY7KasdLiCtCE67RPG8Onfc8mXuESBaXjYiCZKQSUAbXuI+TWwHOAXTXQW8GhR+E9NW70PJLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765589072; c=relaxed/simple;
	bh=EfrRLbN7siAIW5Lk2yum2xDuvB6AvSX/kywDeMY0f84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQXdALo0Em36zefgI+vB+Ytzhv28OwsCzqmD0+3vAeTlOpVXMmCBZm/G3zZBWdgCUNkhuIdVpdqYT2Q9sBCbw2EN2AYLnCKraRtLC7LlwA3xYqbmQ+SJzVLN2c/vW9FwMx1w8eoUcoNo1CjiwO3Ns1nfCPO+DmcEcrKWmSoTQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul02A4xb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul02A4xb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C202C4CEF1;
	Sat, 13 Dec 2025 01:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765589071;
	bh=EfrRLbN7siAIW5Lk2yum2xDuvB6AvSX/kywDeMY0f84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ul02A4xbWtH/1Vbe3HHLVi6kk4ZnCcM8E6NBilvIMKoOwKjGOUWbCNFP/gdlMCXKL
	 /oFv1n6dQIdvETjyfrGxhsvZq2a9Poxs/ZwQVA+qjSR5ix09v2RpPz6FUw4BdIDJkG
	 ZBHtLJlXMyhFT4RWHbUr2YkH31M91IaxeYfURxbHLIz1g/KyhTFQl+v9UwrihmIz2X
	 4TkqJGM5jxuBoyGbV/+1h9YZB4b+EDRWBH6xoGigus5cLk6+DcyAA30YankfK4zMQ3
	 W9VF2AL0o7IjFq+ZWzdhszfuTeONkcqtfdcwBmx2gJ8wx3BURwY7HOHcojO8CiaA2U
	 VrEQT+j3WTlKQ==
Date: Fri, 12 Dec 2025 17:24:31 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
	"Constable, Scott D" <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v9 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <202512121709.F5617B17D@keescook>
References: <20251210022025.harder.803-kees@kernel.org>
 <20251210022035.331892-1-kees@kernel.org>
 <CALvbMcCNEf_r5kAQXAihxwMcSWC5msVcSBfBax78N2CZc6k9Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcCNEf_r5kAQXAihxwMcSWC5msVcSBfBax78N2CZc6k9Kw@mail.gmail.com>

On Fri, Dec 12, 2025 at 03:07:51PM -0800, Andrew Pinski wrote:
> On Tue, Dec 9, 2025 at 6:27 PM Kees Cook <kees@kernel.org> wrote:
> [...]
> > +uint32_t
> > +typeinfo_get_hash (tree type)
> > +{
> > +  gcc_assert (type != NULL_TREE);
> > +  uint32_t hash_state = 2166136261U; /* FNV-1a 32-bit offset basis.  */
> > +
> > +  mangle_type (type, nullptr, &hash_state);
> > +  return hash_state;
> > +}
> 
> It might make sense to do a few self_test here instead of (in addition
> to) having a testcase.
> This way the testing is done earlier.

I tried to do this back in v2 and could not make it work. See [1] for
more details on what I found, but basically I don't have access to the
parser itself in the selftests, so I couldn't build end-to-end testing
of arbitrary C (testing node types isn't really a sufficient test in my
view). I could to basic type tests, but it would be redundant to what
I ended up with in dg, and I didn't want to split up the testing.

If I'm missing some other way to do this, I'd be happy to give it a shot!

-Kees

[1] https://lore.kernel.org/linux-hardening/20250905002418.464643-1-kees@kernel.org/

-- 
Kees Cook
