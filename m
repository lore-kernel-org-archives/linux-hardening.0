Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF80E2AD2D;
	Wed,  5 Mar 2025 04:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741150642; cv=none; b=gOZJnGwS4BCp6kG0YWvjKBVZT52gosAhZ4Vna99/m/hEfBN5Dm/pT5u+SvMjoFVlgLWy9wFlqGD2u/RQWaQI9Ct9yXNigS3ztazU4rIM3pUV2pjmJ9tf7A/sf5xz25b1yVWQU/bVNh8ce8Zx7w/QsZpHkl9CC/mAwRsAIlaEqhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741150642; c=relaxed/simple;
	bh=QL7FR8XfXuKE/HaEdkkItoNfp3tRJjrQsT++UDGTAFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijpp4ou7Ylq7HusU3dJqllSsGj221xBXwrWikPsW/4xYIg572ns/VL3XYcJkFjOjsOOSLV3SNO7mgSt4yhqUk1evLvx6JbIFRKE9fhgNa9YPXUUDe2ivrC2iR404fsJ3C3LeT2GuvbHgBS+VJLc8qYofURX/bLwGwLhWFxG4BMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtFMdnVB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtFMdnVB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D858C4CEE2;
	Wed,  5 Mar 2025 04:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741150641;
	bh=QL7FR8XfXuKE/HaEdkkItoNfp3tRJjrQsT++UDGTAFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BtFMdnVBZWuel0MXl4Dxo7sHRQbj4edNcK8Lkrs9hVdYUl/h46m0UCsRrBFuvngGa
	 5zoL9CHnI+PeJnfEdTwQ3yBUA646+EMFO53+pXtoAM8N2pwtLNKbGMOHv4e5B4Y1pw
	 AZhT23wUvayMkSbzbxAL1/7MJ3ThxeLBMrpgSvx+ryM+JDjewzU/2vlx0fca9B72TC
	 IzxAidVxF84CLX9TKhzCISKAF3yWqf8elSbErt8nn4FlS8E5ZMtVV02avjCqxFVFHW
	 mkaaI0hFXAMHjkWkfhJvFBl2SHJ54ItWpYxYUwsYDTAdYVBF7Mfm/BvJT/fLmQxhaG
	 9KQFDuQIzkTVw==
Date: Tue, 4 Mar 2025 20:57:16 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>,
	Qing Zhao <qing.zhao@oracle.com>, Bill Wendling <morbo@google.com>
Cc: Peter Rosin <peda@axentia.se>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
Message-ID: <202503041935.AE2093CFFA@keescook>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
 <20A47316-D274-45DD-BA15-F66139654D44@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20A47316-D274-45DD-BA15-F66139654D44@linux.dev>

On Tue, Mar 04, 2025 at 09:58:21AM +0100, Thorsten Blum wrote:
> On 3. Mar 2025, at 19:44, Kees Cook wrote:
> > On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
> >> Convert mux_control_ops to a flexible array member at the end of the
> >> mux_chip struct and add the __counted_by() compiler attribute to
> >> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> >> CONFIG_FORTIFY_SOURCE.
> >> 
> >> Use struct_size() to calculate the number of bytes to allocate for a new
> >> mux chip and to remove the following Coccinelle/coccicheck warning:
> >> 
> >> WARNING: Use struct_size
> >> 
> >> Use size_add() to safely add any extra bytes.
> >> 
> >> Compile-tested only.
> > 
> > I believe this will fail at runtime. Note that sizeof_priv follows the
> > allocation, so at the very least, you'd need to update:
> > 
> > static inline void *mux_chip_priv(struct mux_chip *mux_chip)
> > {
> >       return &mux_chip->mux[mux_chip->controllers];
> > }
> > 
> > to not use the mux array itself as a location reference because it will
> > be seen as out of bounds.
> 
> Getting the address doesn't fail at runtime, does it? For this example
> it works, but maybe I'm missing some compiler flag?
> 
> https://godbolt.org/z/qTEdqn9WW

Uhn. I can't explain that. :( We've seen this calculation get tripped
in the real world, though:

https://git.kernel.org/linus/a26a5107bc52

But yeah, when I build local test cases, grabbing an integral trips it,
but taking an address does not, as your godbolt shows. This makes no
sense to me at all.

Here's my version, doing a direct comparison of int to *(int *) ...
https://godbolt.org/z/e1bKGz739

#include <stdlib.h>
#include <stdio.h>

struct foo {
    int count;
    int array[] __attribute__((__counted_by__(count)));
};

int main(int argc, char *argv[]) {
    int num_elems = 2 + argc;

    struct foo *p = malloc(sizeof(*p) + num_elems * sizeof(*p->array) + sizeof(int));
    p->count = num_elems;

    // this correctly trips sanitizer:
    int val = p->array[num_elems];
    printf("%d\n", val);

    // this does not?!
    int *valp = &p->array[num_elems];
    printf("%p %d\n", valp, *valp);

    return 0;
}

Qing and Bill, are you able to explain this? If I set p->count = 0, 1, or
2, this trips. Is this somehow an off-by-one error in both GCC and Clang?

-- 
Kees Cook
