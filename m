Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054A119C54F;
	Thu, 11 Dec 2025 22:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765490551; cv=none; b=pjtLz2orF+hIn+83itr/w9V5xNQkQwGxNjF6WKCB/hGwsjsuaBwIBy8rBEjbMXmbRPB2oVuboA3kPOhQHm3p7G0uk3I2EhD2o/GcbhNVgHV239pzCyuTG44Q0anHAzSpeIeeE0stN/a8tzy6h2qReJa1HNL8ICTFFWSHMaZm4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765490551; c=relaxed/simple;
	bh=1jUgFRDwVLlPWU+cRYkz5ms19z7NWJCY23qeUoAcv8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awwFXFKyUIQwB1dVHhcwYJw0r91E8JYZHrG6+H7W9f/Q/8DmnK22oZnD2UxoUOtAa8dh9Z7aP6gVm/whzNdYoJR8LrCxaIEzEMiiV+kS4wZwcq9qkTBkHpdnk1fdJzzC+lgUjjgXz2Gg03jbAjhA/i3VOCJV+AYsYolbPoJLTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P765zWgb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P765zWgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00344C4CEF7;
	Thu, 11 Dec 2025 22:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765490550;
	bh=1jUgFRDwVLlPWU+cRYkz5ms19z7NWJCY23qeUoAcv8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P765zWgbp4XZhTszJMCeeDUVNp10Rd3K8KYKkwkNcXitSFm5Wh3gK2hkGiYR/ZVsB
	 FmAa2JgHELGwNTiEre/bcZF9ZAGyj/ycg7TK1LwCcU6yZfgJhGDYBQg/fqTqZZlnfu
	 QWprdOkdYHOQBhSAK/PqaLXJ9wfCJr5mJ77yqxB5plHt8nb/lBctR+ymX2osMGBDDs
	 J6+sbTCUPcxDE01wOymOruBEgfAHfi8zW4v0+u9m5cAqGOM0PbSGFtCcId1PC9nOxu
	 +GSqoovogCnNL+zXwsi+73UATSs8J+b0f9+SK5YiGb1TW7wNZz1/bNqIPphNOHKkSv
	 zCJMLNUHPW3VQ==
Date: Thu, 11 Dec 2025 14:02:29 -0800
From: Kees Cook <kees@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: cocci@inria.fr, linux-hardening@vger.kernel.org, linux-mm@kvack.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Vlastimil Babka <vbabka@suse.cz>,
	LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Potapenko <glider@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bill Wendling <morbo@google.com>, Christoph Lameter <cl@linux.com>,
	David Rientjes <rientjes@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Harry Yoo <harry.yoo@oracle.com>, Jakub Kicinski <kuba@kernel.org>,
	Jan Hendrik Farr <kernel@jfarr.cc>, Jann Horn <jannh@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Justin Stitt <justinstitt@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Pekka Enberg <penberg@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion script
Message-ID: <202512111400.135295C20@keescook>
References: <20251203233036.3212363-5-kees@kernel.org>
 <22e31f45-55fc-43c6-bede-fee1c829aefc@web.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e31f45-55fc-43c6-bede-fee1c829aefc@web.de>

On Thu, Dec 11, 2025 at 03:15:08PM +0100, Markus Elfring wrote:
> > Finds and converts sized kmalloc-family of allocations into the
> > typed kmalloc_obj-family of allocations.
> 
> Can previous patch review concerns get more development attention anyhow?
> https://lore.kernel.org/cocci/71d406fb-9fb1-44a9-912a-7a0d270b9577@web.de/
> https://sympa.inria.fr/sympa/arc/cocci/2025-11/msg00066.html

I've replied there now. tl;dr: I already dropped the empty Comments line
for this v5, and didn't want to make other changes to the .cocci without
a better rationale. I'm open to suggestions, though!

-Kees

-- 
Kees Cook
