Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B4C1D5ABA;
	Tue,  7 Oct 2025 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759859250; cv=none; b=DrSIdUjUu1d9nUhHpP3I0UadCBar1TxpWIWPIQdutJ2WIbhTOAPOWC8DteAOWvJ3zSyO4mYzCMNbQuaX/UblLuWXGBZlzC6IYb1HKEylIAzWb5ZrqbxgVQwktASjDJTxFlGdRbab5DBvgRu+qeSWpioKcWnkHuOJfIsx4wt4K34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759859250; c=relaxed/simple;
	bh=dczTTPELd8aHcA9RSrajs/WbIkYGypdtTEu3wfq5fUQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aRrwfp+VJrNzNiHHIyw5vT5w1yJUzoMPG+fz/fYGROuSPi/IkTJeEyXY27+0H1MDVYg9d59HY2dk+8hfYMAkOODhyclg4oTK3vTT/RmbtSDkTBPTJWwr/LTgCTGhPBppR1/nEc1EPDUb6rQ41LivHuy2Ip5+j1C5nY72B7DSe5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=n5D4QAEh; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="n5D4QAEh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1759859241;
	bh=dczTTPELd8aHcA9RSrajs/WbIkYGypdtTEu3wfq5fUQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=n5D4QAEh+NHMP475F4Zs7wCio0vFockETYLBCIlOjQw07Jzu92NvOJBktfUjab58P
	 MXM8y7kZPMjzTxBUTSteyrjZfm/MxJ4mUH0uDFSCSMwJaeNhFUNbqxedlXSIq49qe9
	 82wsfsYmmZ79ttSTWfatcEQ8eelMFaVS6QLnWFpQ=
Received: by gentwo.org (Postfix, from userid 1003)
	id C3DF4402AF; Tue, 07 Oct 2025 10:47:21 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id C219140137;
	Tue, 07 Oct 2025 10:47:21 -0700 (PDT)
Date: Tue, 7 Oct 2025 10:47:21 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Kees Cook <kees@kernel.org>
cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Jann Horn <jannh@google.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Marco Elver <elver@google.com>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
    Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
    Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, 
    Yafang Shao <laoar.shao@gmail.com>, 
    Tony Ambardar <tony.ambardar@gmail.com>, 
    Alexander Lobakin <aleksander.lobakin@intel.com>, 
    Jan Hendrik Farr <kernel@jfarr.cc>, 
    Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
    llvm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] slab: Introduce kmalloc_obj() and family
In-Reply-To: <202510071001.11497F6708@keescook>
Message-ID: <e019c59a-ba8b-ec04-dc5b-923cf9dd9d9c@gentwo.org>
References: <20250315025852.it.568-kees@kernel.org> <20250315031550.473587-2-kees@kernel.org> <aOR15Xb6DfolYM0z@casper.infradead.org> <202510071001.11497F6708@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Oct 2025, Kees Cook wrote:

> But all of that is orthogonal to just _having_ the type info available.

iOS did go the path of creating basically one slab cache for each
"type" of kmalloc for security reasons.

See https://security.apple.com/blog/towards-the-next-generation-of-xnu-memory-safety/

