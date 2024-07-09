Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E21B86EF;
	Tue,  9 Jul 2024 17:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720547807; cv=none; b=QXuytOQAXAVvYnws95xVym+gUsreMKOWiSrm93ywgddAPwUFnyGvHappXY8fCvJEMpl2ZakzfLr/iE907TGKo7/bKsLXxDYkQMPnfiOT+jZhE+nHcuBpUQ/CEYkGXcOiwCWaKLdEghOrGA+Vcms6yLYdQ8i6EokNk70MCtJQaHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720547807; c=relaxed/simple;
	bh=lqIfszPJjpiNasWfZrcbbg6gcB3GlCMI5AiZWnuHdVI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JYE87bm9J+zD/8eO7ohKdPxd7Exe9WuMe0+rZpfSbVCJRtsbz8tkP6RH6k2BBtyq9WEtzgnRtCzp93eCwhDCOuKxw1bVCnlw91oD9Tk0a7Y9MK+gIHsO5NxXsEgLhvP0Uxasbmsk4ex4iGAOgL0rA8aOWFQgxOst+YgIxUE2bzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=rF65cSGn; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="rF65cSGn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1720545992;
	bh=lqIfszPJjpiNasWfZrcbbg6gcB3GlCMI5AiZWnuHdVI=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=rF65cSGn0PVhYU0/wM2M+ak/jAdLosvZRg3k1Jg9d+Q+1Rpl9XvxKWkthpKTPuAc8
	 eWXR17uJx32gbd8Lvn6C9WmqQGzyuOoiO8H8mwfx6wl1vPhnstMI6F/AnNkg/GOMCG
	 mNwC7D9i2ywQLMTc5HRwR/cDkj/eZTIjst3od5c4=
Received: by gentwo.org (Postfix, from userid 1003)
	id B98A540364; Tue,  9 Jul 2024 10:26:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id B6A4640253;
	Tue,  9 Jul 2024 10:26:32 -0700 (PDT)
Date: Tue, 9 Jul 2024 10:26:32 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Kees Cook <kees@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, 
    Tony Luck <tony.luck@intel.com>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Miguel Ojeda <ojeda@kernel.org>, Marco Elver <elver@google.com>, 
    Nathan Chancellor <nathan@kernel.org>, Hao Luo <haoluo@google.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
    Mark Rutland <mark.rutland@arm.com>, Jakub Kicinski <kuba@kernel.org>, 
    Petr Pavlu <petr.pavlu@suse.com>, 
    Alexander Lobakin <aleksander.lobakin@intel.com>, 
    Tony Ambardar <tony.ambardar@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org, linux-hardening@vger.kernel.org
Subject: Re: [RFC][PATCH 0/4] slab: Allow for type introspection during
 allocation
In-Reply-To: <20240708190924.work.846-kees@kernel.org>
Message-ID: <a1fd42b5-50b7-1360-4fd0-8f590dc08e02@gentwo.org>
References: <20240708190924.work.846-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 8 Jul 2024, Kees Cook wrote:

>
>            obj = kmalloc(obj, gfp);

Could we avoid repeating "obj" in this pattern?

F.e.

 	KMALLOC(obj, gfp);

instead?
