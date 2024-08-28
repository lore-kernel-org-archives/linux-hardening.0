Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D961A38D5;
	Wed, 28 Aug 2024 15:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860181; cv=none; b=s5cqwuNXhpIIm1uOnjW/ewEFtqPUsHG8UhabhTOrcxvTFqSr/6qaCynx4xNLG0a7NYCgBKALlssoPHKcU2EiyA6QcFGuotjZOFMTAcytNNM+qYX2ReGAfVA351Aq59715dIMqh6CvOS4dg9NrB6G6GinXs+hyV0i9roYv8Tz7Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860181; c=relaxed/simple;
	bh=6jKtNo+KDR/piWngR9TIg2HXPVoyQjTr0NtoJ9E7HQA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XIOQC6sPl/m2q3tdgLyVasb+D+C1Tn19MlT/UEi/NnqT9BsAZXjIAWH9H6jgu6HTPnFAs4EcVhIp4HHhU2nmSnHzctbXYy6VMHUfPpxsxpeR28tDrfAEDjyCpN/xn9yP23u1tAq5pTc9dxGam1/DYyCSQ9BPyCp/v4Xtciheb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=jM0oZuwD; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="jM0oZuwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1724859449;
	bh=6jKtNo+KDR/piWngR9TIg2HXPVoyQjTr0NtoJ9E7HQA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=jM0oZuwDkTxthXgKyO7cbAbfFUAMVTPEMIDrbW6z7k43krUuQIO6vAPQvanQpqBpj
	 zQi83aKD8IMEtL216eIG3JEK9l7krTmA/nqD35zzRayC/C3ERjIPwq3bI9m/pYiJSI
	 LQbmM9i28oRhinMZ6ii34Wc9nOcK4v24ZgRBBwuk=
Received: by gentwo.org (Postfix, from userid 1003)
	id 06701404BB; Wed, 28 Aug 2024 08:37:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 05102404BA;
	Wed, 28 Aug 2024 08:37:29 -0700 (PDT)
Date: Wed, 28 Aug 2024 08:37:28 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Kees Cook <kees@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    "Gustavo A . R . Silva" <gustavoars@kernel.org>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
    Jann Horn <jannh@google.com>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    Marco Elver <elver@google.com>, linux-mm@kvack.org, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, linux-kernel@vger.kernel.org, 
    llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] slab: Introduce kmalloc_obj() and family
In-Reply-To: <202408271709.31D322019@keescook>
Message-ID: <81a4ed8c-7758-b295-e68b-ecc0372cc956@gentwo.org>
References: <20240822231324.make.666-kees@kernel.org> <5c3852e6-4a6a-42d8-85ff-8c1605939454@suse.cz> <202408271709.31D322019@keescook>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Aug 2024, Kees Cook wrote:

> > Since that could be feasible to apply only if Linus ran that directly
> > himself, including him now. Because doing it any other way would leave us
> > semi-converted forever and not bring the full benefits?
>
> Right -- I'd want to do a mass conversion and follow it up with any
> remaining ones. There are a lot in the style of "return k*alloc(...)"
> for example.

I believe Andrew has dealt with these issues in the past?
