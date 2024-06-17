Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCE919922D;
	Mon, 17 Jun 2024 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718662411; cv=none; b=lHZDNgP1GcN7QXxPxdfhePngjulZLDWFMQr6M8XYTQV3XE2VhoZSvPdWEQw/GCoJxnDbBXyaPfXGg9BsPhn6WsECk8IM9z9+aPOEg9NJTOd1Y7hlXrHDrzFFhMKXVTsizhbuN5DlQq884NNGNwi4OFXfjhMAsI2ChYH85weIzRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718662411; c=relaxed/simple;
	bh=kuzsz5JZS13v4vcaYF1tNIj3xc0VM+SCvs1aD9mr8Vw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+kuLZ7nPW6Ur0c42h5Gx4zGoYEyI5gNSsVpDPVWEXV6ZtE+kxy361oRRzgBOgD54d/0P3WGNQZqDLYMVKNs248azbMi1OPbKxXhbJImmYT1E/THkTeSmbwlaLNc/X6qDwwj5CLHD79bLC9Ri5EgN8+8QFrDLGqflra5vqycSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBZMNq+r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2UxhRcXQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBZMNq+r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2UxhRcXQ"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718662408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CIRabLYRMR5NpCpWntKKTO4pVGlHUQzV4X+BxKrofPU=;
	b=cBZMNq+rLdNAn5IRjLyoCXi6xdquxSBJZ1EctOLzaWPNxsfB3B5HQyGdq6U8g9tdpoKTwH
	dch+/pHUzsZ0FNDf1/0Rc+3g9c+NXc7o6vwPEXfEXYOeO2Io9f1ysUKY0boIvv/HuM/e81
	3EDzFop5rrU08KBb2Z5Aa941Tm8rve/0Eqsx2NFZkfn3rsvD2qzt7A/bGYmBedlP7e2bwd
	idmIoc2OtLMQAS8x8VU6BnGLoAjimAywDPhtAs9ZwL/JgsN7MGFsHsYZt318iKiC34VZ/T
	8U8+AW35dZm7SqZf5mW02uQKsm/RLeEwxtk/qV+wcwSvX96neICasqpie6kBpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718662408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CIRabLYRMR5NpCpWntKKTO4pVGlHUQzV4X+BxKrofPU=;
	b=2UxhRcXQRRGMFDhxw9LUXsNC8tEks65FJEHH13hNBtjB/I8tnuWs6bsWO0i5ZNe1HnBokI
	y3DC+IgSJ942+XAw==
To: Kees Cook <kees@kernel.org>
Cc: Gatlin Newhouse <gatlin.newhouse@gmail.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Marco Elver <elver@google.com>, Andrey Konovalov
 <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Andrew Morton <akpm@linux-foundation.org>, Rick
 Edgecombe <rick.p.edgecombe@intel.com>, Baoquan He <bhe@redhat.com>,
 Changbin Du <changbin.du@huawei.com>, Pengfei Xu <pengfei.xu@intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Xin Li <xin3.li@intel.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Tina Zhang <tina.zhang@intel.com>, Uros Bizjak
 <ubizjak@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, linux-kernel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH v2] x86/traps: Enable UBSAN traps on x86
In-Reply-To: <202406121139.5E793B4F3E@keescook>
References: <20240601031019.3708758-1-gatlin.newhouse@gmail.com>
 <878qzm6m2m.ffs@tglx>
 <7bthvkp3kitmmxwdywyeyexajedlxxf6rqx4zxwco6bzuyx5eq@ihpax3jffuz6>
 <202406121139.5E793B4F3E@keescook>
Date: Tue, 18 Jun 2024 00:13:27 +0200
Message-ID: <875xu7rzeg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jun 12 2024 at 11:42, Kees Cook wrote:
> On Tue, Jun 11, 2024 at 01:26:09PM -0700, Gatlin Newhouse wrote:
>> It seems that is_valid_bugaddr() needs to be implemented on all architectures
>> and the function get_ud_type() replaces it here. So how should the patch handle
>> is_valid_bugaddr()? Should the function remain as-is in traps.c despite no
>> longer being used?
>
> Yeah, this is why I'd suggested to Gatlin in early designs to reuse
> is_valid_bugaddr()'s int value. It's a required function, so it seemed
> sensible to just repurpose it from yes/no to no/type1/type2/type3/etc.

It's not sensible, it's just tasteless.

If is_valid_bugaddr() is globaly required in it's boolean form then it
should just stay that way and not be abused just because it can be
abused.

What's wrong with doing:

__always_inline u16 get_ud_type(unsigned long addr)
{
        ....
}

int is_valid_bugaddr(unsigned long addr)
{
	return get_ud_type() != BUG_UD_NONE;
}

Hmm?

In fact is_valid_bugaddr() should be globally fixed up to return bool to
match what the function name suggests.

The UD type information is x86 specific and has zero business in a
generic architecture agnostic function return value.

It's a sad state of affairs that I have to explain this to people who
care about code correctness. Readability and consistency are substantial
parts of correctness, really.

Thanks,

        tglx
