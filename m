Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650801A314F
	for <linux-hardening@vger.kernel.org>; Sun, 13 Apr 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744548196; cv=none; b=p9TOrnAb3PwUoCsCfon6zMl+QNC5HmXWyB5dIt1SJYfg4b1HC2prkNm3wuYh4nnWict36WzDGLrrTLlLrNt5WIZk5rsg4F8yE6BafqztDm7mcKTe2isEaEEJTu52BXq5u9Uku8GOglmcUEmWAKqAPVttvZJOcKp++1l+ou+SWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744548196; c=relaxed/simple;
	bh=YBVrP0ioAfqFi7HGGInQPXg0PMtVOG28MGA1HhQi8zU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qT4+yUpZVMRp+fDo8izPms1LKsdAZe+cV2fxyRsdxHiNktqqaybaObKur3H+RMVf3iR1OVmoq1N7ADg3KFDO1jZvZk6t9MtoBuvTV8Jupz2Wngj29t6jpsTNzDUDqI8QkVLrKftkPw+6Pok2HBL6sNthuYmqBH+RmPJBkgXTfKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cpL7bDRa; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cpL7bDRa"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744548181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+g3tIT1J01F3PNxqjXfPswRzwcT32eu6uks0bITlMTA=;
	b=cpL7bDRajhjTosoM/A/fZJh05HWg4SwWQJXrUDdpyQJcFJsGx6U0DrUQz/CglF16Z2pEIy
	OcnHAUecAcd1vH7w5NRQW9GqqXSPOGhidBrIJwF/WuxptPTZGtPC6xTvqnOCXvNRQrYh64
	y7k/djtKeN+CJbTOXaMomUe0ajizRGY=
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.2\))
Subject: Re: [RESEND PATCH] mux: Convert mux_control_ops to a flex array
 member in mux_chip
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <202504071119.DB9497A510@keescook>
Date: Sun, 13 Apr 2025 14:42:49 +0200
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A6D52C12-29BF-4A51-B677-584EFC4F3823@linux.dev>
References: <20250302230220.245739-3-thorsten.blum@linux.dev>
 <202503031040.223DEF2781@keescook>
 <785391F0-C381-47FE-89E7-6265F7761208@linux.dev>
 <202504071119.DB9497A510@keescook>
To: Peter Rosin <peda@axentia.se>
X-Migadu-Flow: FLOW_OUT

Hi Peter,

On 7. Apr 2025, at 20:20, Kees Cook wrote:
> On Fri, Mar 07, 2025 at 12:32:07PM +0100, Thorsten Blum wrote:
>> On 3. Mar 2025, at 19:44, Kees Cook wrote:
>>> On Mon, Mar 03, 2025 at 12:02:22AM +0100, Thorsten Blum wrote:
>>>> Convert mux_control_ops to a flexible array member at the end of =
the
>>>> mux_chip struct and add the __counted_by() compiler attribute to
>>>> improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>>> CONFIG_FORTIFY_SOURCE.
>>>>=20
>>>> Use struct_size() to calculate the number of bytes to allocate for =
a new
>>>> mux chip and to remove the following Coccinelle/coccicheck warning:
>>>>=20
>>>> WARNING: Use struct_size
>>>>=20
>>>> Use size_add() to safely add any extra bytes.
>>>>=20
>>>> Compile-tested only.
>>>=20
>>> I believe this will fail at runtime. Note that sizeof_priv follows =
the
>>> allocation, so at the very least, you'd need to update:
>>>=20
>>> static inline void *mux_chip_priv(struct mux_chip *mux_chip)
>>> {
>>>       return &mux_chip->mux[mux_chip->controllers];
>>> }
>>>=20
>>> to not use the mux array itself as a location reference because it =
will
>>> be seen as out of bounds.
>>>=20
>>> To deal with this, the location will need to be calculated using
>>> mux_chip as the base, not mux_chip->mux as the base. For example, =
see
>>> commit 838ae9f45c4e ("nouveau/gsp: Avoid addressing beyond end of =
rpc->entries")
>>=20
>> Since this should work and is well-defined C code according to =
[1][2],
>> could you give this patch another look or should I still change it =
and
>> submit a v2?
>=20
> I think C is wrong here, but it seems it will continue to accidentally
> work. I personally would like a v3 that fixes this, but I leave it to
> Peter who is the MUX maintainer...

What's your take on this?

Thanks,
Thorsten

