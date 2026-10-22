Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696885;
	b=MVdgUQsqjg/5hANy/wMl1D66cJXed7uar++h1wr+I2NEDsThSgqV/S0zqrOgfn9QFC0s
	 8WwFciWLQ0qd1rPJE8Z9hmv3ZEdVfyIam6kANYJa440KItVZPCy5gMiLkU0CZcZjo27Ce
	 +dFgau5x6AYf85s6F0Cvs5nDduzxbUlwcUJhBH3cDAIFqaKAYZ52LRWMlyBtUH40GVli6
	 9FC2mTU6LLhz6Revggwh3VAZdhZdboiLzArpoI0cKDdQQFqamvdnfuvPS5Ta0+TzqBRbO
	 b8G6wP8SApraGytMrqFo8jpNHqNZTIVbSdVAKllqLm0ULTL2csyKtYqrWzTOOHQvmlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696885;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=a5kvei9+h9xuqpAHrFUWGBCIdiVPEQGO6A2NrFREInE=;
	b=GybX+zT2nnllSfsAlj9zNIsiufT3b3DtybGC7Kq8dznM/xxnYrkNKOMc8iVoCDtaMgbW
	 dZqXIonyiODvc+fx3ZHrskcTm0NqCbtw8tvfdZDw9S1fLffBKpaRwZEHLAYHmZCj04wtd
	 uLNXA7rXv+3aWla8mrbCTozjeryz+DEkKFpNJFkz+8e3oX40AmlGaq7FNf4iMb0UM4E2t
	 bDLrgkeCzE2AInGx5XFKDBB8IhDQa/5n866clvVBAVuF8vd44uYDllhu0tYjkykMYWFjg
	 OjD6Gf8tC3S7igXPmKQYIaVN0lPduINmdu/VdqfUHsFdN3kezxRiFqkJkuIkRKvQGSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X78HNf15;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B3606A31A
	for <linux-hardening@vger.kernel.org>; Thu, 22 Oct 2026 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X78HNf15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89BE1F01825;
	Thu, 22 Oct 2026 19:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792696884;
	bh=a5kvei9+h9xuqpAHrFUWGBCIdiVPEQGO6A2NrFREInE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X78HNf15Y49IzbAsKJWoDqfYg2+dQVdgB/bUKc4N1kG36v4CBvGOVXYuiK5ngG7Z2
	 2S2J1eCD5zKtmI1GsGplDiiPTUSsbgZS3CNSpYhIJI5TrWVctxgKmlvOoQlVVTXik+
	 /V6It7wlI+mFAzD3Iie6QTevmqoQ4I/gOaxvkHTJHo+1dskCOdSDlyLmQmHQfGysDN
	 XiTlm9cHaUikekNddKlwZ73BFNFPu7sO1CdBfUlOoDCEIRRyxJTPgnWOw246N/dVMY
	 lpLNsPbsgvIln/X+1MZEJBm0IG9JIyq7GPI7N1q9LuuhzsXP405qa9sXDnwdrsIkLc
	 bKWXGa6voXwAg==
Date: Thu, 22 Oct 2026 12:21:24 -0700
From: Kees Cook <kees@kernel.org>
To: Richard Biener <rguenther@suse.de>
Cc: Richard Biener <richard.guenther@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>, Martin Jambor <mjambor@suse.cz>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ipa-icf: Compare access path type sizes without TBAA
 [PR105438]
Message-ID: <202610221219.BECB805C6D@keescook>
References: <20261010050537.i.784-kees@kernel.org>
 <CAFiYyc2gYAjiKDi+TeC9_qEX+LHa7fSxj42JjRtM6Dbi6Yfidw@mail.gmail.com>
 <20261015052441.7d2b3c-kees@kernel.org>
 <39r25275-0488-rq01-55nq-28rs192rp368@fhfr.qr>
 <76op6r8p-n2p7-r6p8-s541-rs310035q364@fhfr.qr>
 <21s7p869-5267-7nq1-701q-p35771ss56qp@fhfr.qr>
 <20261015215136.adec8b-kees@kernel.org>
 <o3sqnnq2-0osr-p0oq-0544-o8npp92808n4@fhfr.qr>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o3sqnnq2-0osr-p0oq-0544-o8npp92808n4@fhfr.qr>

On Mon, Oct 19, 2026 at 02:17:47PM +0200, Richard Biener wrote:
> ## 3. Recommended Structural Solutions
> 
> Rather than maintaining deferred state across five intermediate IPA passes, PR ipa/105438 should be solved through one of the following architectural approaches:
> 
> ### Approach A: Differentiate Incompatible Layouts at ICF Time
> If inlining a merged function will cause invalid memory references, diagnostic warnings, or TBAA violations due to mismatched pointer types or array bounds, ICF's equivalence checks (`func_checker::compatible_types_p` and `func_checker::compare_operand`) should not declare the functions identical when:
> - Parameter types differ in array bounds or struct sizes.
> - Memory access offsets or base types are not strictly identical across types.

Heh. I think this is describing the original patch I sent that started
this thread? :P

-Kees

-- 
Kees Cook
