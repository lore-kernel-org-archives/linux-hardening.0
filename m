Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42B0470429;
	Mon, 28 Sep 2026 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638957; cv=none; b=Dh5UtlUTUjuycHIqsahcpIfPzpycGRkg0bl5GDkCjl8hGJCLacjYLFpID8DsGGOPMb2RG6zNOZSCBQW4vgQBzpYcPLn0+Jq5w0oppu0Byf2gxIIJPqFwMrWXD9E1VwrXFcFF7ll9XKt4beGcig0oXmm7X3Pjez682cXrl0LO6G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638957; c=relaxed/simple;
	bh=4fQ7m1rBQOG0dUwfEqM77N5KuKo+0XFQF7cuNwDUcJA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jBchyzfnhj44cKDOifueCEhK3qlEY7WDMSX1g03oYBuag/XYgnOY6uHQvZminWpZoE4FuWPjaPCBpInFaFyBOIbKQCyfax7Bul9Jik5mVhFbtlVay2eqwhLOx/oGcJ574pHdogOdpzdbkfHbAgzJT2N0x+G6duhURJKoIpnxDek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dm6fYjvm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dm6fYjvm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272BE1F000FF;
	Mon, 28 Sep 2026 23:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790638956;
	bh=N/uTPNqgSmBF9rh1jEmI/ycOHBrfDvicp4X6U1S9Cy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Dm6fYjvmUaayF6/hcSdccsykXlMd90HLFeAOg7Bm+rRrwkFmeMOFFEPqVhzx1V2eA
	 Gw77w8KXsEHK1EjYWxFNJWHulUSbmLi66gSohUj7CyisqeSnvkBq7/d5AP7ogp4Fd2
	 r/6N2ErCbxyj7fkzPOqSc45jLW1qT5bo/T6Ynq24=
Date: Mon, 28 Sep 2026 16:42:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Bill Wendling <morbo@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Alexander Potapenko
 <glider@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov
 <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 kasan-dev@googlegroups.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 thomas.weissschuh@linutronix.de
Subject: Re: [PATCH] kasan: add KUnit tests for __counted_by and
 __counted_by_ptr
Message-Id: <20260928164235.041803152d3f340d4c59e59e@linux-foundation.org>
In-Reply-To: <20260928231737.2092716-1-morbo@google.com>
References: <20260928231737.2092716-1-morbo@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 23:17:37 +0000 Bill Wendling <morbo@google.com> wrote:

> The '__counted_by' and '__counted_by_ptr' attributes associate a
> flexible array member or pointer member with a struct field that holds
> its element count. Supporting compilers use these annotations to
> compute dynamic object sizes via '__builtin_dynamic_object_size()' and
> perform runtime bounds checking with KASAN.
> 
> Add KUnit tests ('counted_by_flex_oob_access' and
> 'counted_by_ptr_oob_access', guarded by CONFIG_CC_HAS_COUNTED_BY and
> CONFIG_CC_HAS_COUNTED_BY_PTR respectively) to verify that:
> 
>  - '__builtin_dynamic_object_size()' returns the expected byte size for
>    annotated flexible array and pointer members.
>  - KASAN detects out-of-bounds read and write accesses beyond the
>    annotated count.
> 
> Allocate the test structures in 'noinline' helpers and hide the
> returned pointers with OPTIMIZER_HIDE_VAR() so allocation-size
> attributes and compiler optimizations do not mask the '__counted_by'
> and '__counted_by_ptr' checks.

Thanks.  Are any of Sashiko's comments pertinent?
	https://sashiko.dev/#/patchset/20260928231737.2092716-1-morbo@google.com
