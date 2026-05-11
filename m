Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166537B018;
	Mon, 11 May 2026 12:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501951; cv=none; b=aFieJp4kLWtiLtXSk4HwwbndXFxbxEE34MxhGDkgoksYrF4p9XalFOMJmmDTr5pxX8YShguWePig/Cly+zriPM3EInLUCYTlQBks5lpeOyXGhfzwWJkOM94kUBz/++Yb8Fcl563zEMdUK/lFrF6kzXk3NrRdUac1np9+gzqfEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501951; c=relaxed/simple;
	bh=tLmLnG7NtRDvNzoHFnnr7G7EPjQ98zaD83MXtS3QGaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D4H1DYQk8FAUBgwz3ni5PdCGGNThRTy6p9EUhZfmjbqo04TslhvAT87PAKRgC5qrWOlMhxWXaISKoQwKO+ULr9Eezw/wXaTQ7ianrIB0/+YhTCM2vQ2rau6kibNcDLx8bUCH/MthI/Ug0kpVP/APJ1NWH1djVOTEYiPpqG7hnlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=NE8Iccbh; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="NE8Iccbh"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B1B3C410B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1778501949; bh=Zd6JYObStql70QlOFbbXZc/nE8PPz1FUhOYeRsnw8R0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=NE8Iccbhlop5kx/SHt52Rf/geOduMGW0s25QzxYTEUHbOkhdbPL75cGB5nCBgnUio
	 1pSNbwEElvVuv2NeKLxoVtFifIe4xEigRVkh48eplDHFyEsqhWGLAKSd1uQsFnnlWk
	 hWMnXO1LkRUlwCipZJeOAMpBuWCtuwX/eVO/7We249wxaKgEsrDn+VsCrzq3Zt/BJi
	 YfslED0S1ywKWCAqGSGB+63OAvyGLWcK4ttKvxUJ1uXeHan8VURu5zqR8s5MtHpuhQ
	 vkWlLjWBWQ4m/IYIg3bPaOcYEatIgwvk/RaLkbxDF8DLgll1PeFdXk4yjxFYTbZeDE
	 V8grkQeZtgilw==
Received: from localhost (unknown [IPv6:2601:280:4600:27b:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B1B3C410B5;
	Mon, 11 May 2026 12:19:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Marco Elver <elver@google.com>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
 David Rientjes <rientjes@google.com>, Roman Gushchin
 <roman.gushchin@linux.dev>, Kees Cook <kees@kernel.org>, "Gustavo A. R.
 Silva" <gustavoars@kernel.org>, David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Mike Rapoport <rppt@kernel.org>, Suren
 Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov
 <dvyukov@google.com>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-hardening@vger.kernel.org, kasan-dev@googlegroups.com,
 llvm@lists.linux.dev, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] slab: fix kernel-docs for mm-api
In-Reply-To: <afi0nQ84k1oz5RyH@elver.google.com>
References: <20260424132427.2703076-1-elver@google.com>
 <20260424132427.2703076-2-elver@google.com>
 <9c321184-9080-4d5c-bd1a-a16cd0bbaed3@kernel.org>
 <CANpmjNN_=g31Eoa+w1NrFALfp1dDBi5oHEZdr_bA_48-tS2M=Q@mail.gmail.com>
 <afi0nQ84k1oz5RyH@elver.google.com>
Date: Mon, 11 May 2026 06:19:08 -0600
Message-ID: <871pfiw343.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Marco Elver <elver@google.com> writes:

> How about the below, i.e. adding type decls that only the kernel-doc
> parser sees? One complication is also DECL_KMALLOC_PARAMS, and adding
> kernel-doc parser hacks for that looks pretty awful, so this is a lot
> cleaner.

I'm going to be a while catching up with things, so this is just a first
take.  I strongly suspect that the people who object so strongly to
documentation markup in general would be less than fully thrilled by the
addition of this kind of workaround.  I'd like to ponder a bit and see
if I can some up with something better...but again, it won't happen
right away.

Thanks,

jon
