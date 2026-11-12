Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794506145;
	b=Uo5cjfhfwvqjtyBwtpoB6R778n/Aw49G/wPEVkNoKGfSunp1Zkz8m86zQzgIA4NrCnb7
	 rVOYsYIyy6PuKISpLBteHSfAyLCoySA7yt3nzTx6Eg455r2gmqPrgiqdaGLbL0j9fKxPv
	 dUafDYz61z6Wus+dydUCuR5pTnKkRqlyZ+ZDKjQfm0mBDRtD6uG8PeELl20oyBnfSHsIF
	 me6Zwpu/XYEQ3kA//qU5lEuVC9X093VCv3zVgXsXd/UHWboNuZu7ZV/DT0SwZdChzbCNb
	 DzLXmxcYih4M7zuOdaQeYiFH3v/7wpYHc7DsgSAhbVRMF+Sa3XIPZTupvfGXy8UqD5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nLM7EJdjaO037/pI6q4xA/LTKNh0utgwqJExJ58n90k=;
	b=QJEKCvuCPD9lsJh/gBPy4Sn9tpQ9XPaaDN9cWhgnqfgrA9PNQbJNx7pLzwyvb2v5yEPy
	 72yneqhpI+Y8egKWPhmF5EVXyAhxF+vcAxj+gHsXzIiAB+pcJW1N/FoP90+gkLOzuoeJQ
	 RacXEB2xACibI1vIB3RDQjwKL2JRKm4RMk2I05AC1Dr3OVbbZRRS43FJrc4mfOYwpawY0
	 f859Yq0raV7f9ilpWB8N0lJ7FokqFtRvTvKW0k9WMvZxnDCUa/74Gbi55gxsKR9DIMabh
	 avOLyz3BeyIAF1hIDazXwbCSlyjRQY8PSdGfgbNpkKIleRe/ht6jZZRQEsiDCcf+D1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linuxfoundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=B1um2Zbo;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CBC606A323
	for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 17:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94CBC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=google header.b=B1um2Zbo
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c126fa1e3aso48281e87.2
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 09:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1794506143; x=1795110943; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLM7EJdjaO037/pI6q4xA/LTKNh0utgwqJExJ58n90k=;
        b=B1um2Zbob2QVyTjs4PeYKrHrs08r7xKE9fdC7CDVgKFPcoo11nNQZeMnDFwLhWT4j0
         N7oMp9W7A6N3/eN8Uxi06kKCRUwQlskBB9oyBZi18GgrFvOc0E5PbipfcVlX/kJQyZq1
         uMaZ0LkiJuIoJYQdASjNuWLuxDEv9/v2fwcAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794506143; x=1795110943;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nLM7EJdjaO037/pI6q4xA/LTKNh0utgwqJExJ58n90k=;
        b=yfVoSo8Wq/YeXPcuyOsZ/+vGzyIF/3WCl+0h9tETa95mnR8CndUS/T8YEWJKMfNXgl
         msld3eTyZiApvDbJu6JmWh7xa2GbzrqnbdduCLiVG6ID/2rmS0vSMvGet4pCTTm8r44S
         urc6oTqglWqKWSVzZklTAAmszB5KlnMEjv85VVbSBFCh28Si3GqymHn1bU9uVicaBrR+
         QfQX2sYHW2RBuXoqqvWErkZvO1mlKRd8CQrQiU/8fCUSjB+uVbhX7WQr/CdL6Xl4cgxo
         8gY9bV0VQoVHbwYaDT/H8xsfiIGERbELkmZqAY6LL8vBvufdPbFAlCtGH0FAudsKS1UB
         w7qA==
X-Forwarded-Encrypted: i=1; AL+hErECS1jkfRVbbcVeyuSv+wXrTDjy78jj/F23NfqlV87niN5MRo20Fv8vyeGTmNZX5YMScy/1BQZLY4rrNqJPIoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/e/XVzWBA5DAcMDj2ngUeO4jV8oQzOJNuzMoHNLUryEguMh8mT
	UOp+cWfdu9t9toitL5PYj1xVqcoKnfcWpwN14IpirUIqo6vaTvnVBijocPOgZS4lZZs+sDrOgON
	NxXeMTSagVg==
X-Gm-Gg: AYBFou12k66aNU3w+uaTyqaTAab8cngGQKm4bNgSLOYq4Z4GQAnRK42kOtb/8kChc7B
	HGDuQ8TImYnkNRgcoJDumAPysFTxKWKzsJhfeXA4s8JnQLK/HFoGOVN1EQf8lMRYJo1TN3gyA7s
	o1j+MNKEZWv/kp5oLM+aR2uumApLHAO1L2yV2sBqmMlk/eCpzlQcaXo5CNsn/ci9v83zch5M+Rq
	BjVnrMA14xDggon68WBbVapoyDXDuqqA8KtlGkb6spm7CdMikINv5+tbU6vizECRmSXuTgQlPLf
	PU5yd+v/bzv5RBzDk/KJHuwZ4u4B0pj88nk5U1VUOyroTfpbxhxluduCNt9CDsyfq6o2WX5v0Ml
	17s9mcNbucwjG2pIPSKzQXgfGbRJHIAo66QASQXqkppQpWE8rLHKmgfgXJBYlZZZlvQLYW8dtAP
	LSLl9Ry/h6B1yX39O1JwqQZsYE561yX4/wiJkgmP2+vb36T5O9I04DKe/QAhgA5HSot38GIIrOC
	UyFsYh1a7NNBTA3aKtEB+0Z2IaaqUeZP5LNXddx/y4TpGpPvGF6s3smPoZhfHLw2wIMiWSFpPLB
	KnpoTPTLr2YLGLpMPjusBvxMjkGG1AUki+xqztu1kGF9j3ouI4H3+kaH5LPAO8LjIcWabFO5Gry
	Spz6Tc/WUxsR1zKm/YY/eRp4=
X-Received: by 2002:a05:6512:3a8a:b0:5bf:a172:db47 with SMTP id 2adb3069b0e04-5c17077e434mr56032e87.16.1794506142725;
        Thu, 12 Nov 2026 09:55:42 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c157ba55d8sm1905414e87.18.2026.11.12.09.55.42
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:55:42 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c1479be604so67558e87.1
        for <linux-hardening@vger.kernel.org>; Thu, 12 Nov 2026 09:55:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEzULElzLs+J94z88oah6g0sWfaWpVoUTlBhTdjcYajTy9ahN/tHQPgFvFIRYuI19ADT9npavMtUhXOZRcvSXI=@vger.kernel.org
X-Received: by 2002:a17:907:d86:b0:c50:62ff:efe2 with SMTP id
 a640c23a62f3a-c5066b2da47mr541451166b.21.1794505688483; Thu, 12 Nov 2026
 09:48:08 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260914223212.i.829-kees@kernel.org> <20260914223219.901347-2-kees@kernel.org>
 <20261112004039.GA523044@killaraus.ideasonboard.com> <avWNCC3_Ff0knO6J@devuan>
 <CAHk-=wgYBrhvo2NAG_Ja-0ovPf=xO20Gcopv9Yrr1u=QVxECZw@mail.gmail.com> <avX3Y08tF8Z0C4LH@devuan>
In-Reply-To: <avX3Y08tF8Z0C4LH@devuan>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 12 Nov 2026 09:47:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi1U9ry+MmK2_z7E=0KPpNG9zF212t-YmB8gc-qsUvp0A@mail.gmail.com>
X-Gm-Features: AclHuK8TqtfSnV8lmNLmK3LZjOEY1Z81GA-4LECZ876wsZ5FbRi5al1rfBz408g
Message-ID: <CAHk-=wi1U9ry+MmK2_z7E=0KPpNG9zF212t-YmB8gc-qsUvp0A@mail.gmail.com>
Subject: Re: [PATCH 2/2] devres: Provide kmalloc_obj*-style API for devm_kmalloc
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kees Cook <kees@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, driver-core@lists.linux.dev, 
	linux-hardening@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 09:33, Alejandro Colomar
<alx+linux-hardening@kernel.org> wrote:
>
> I don't agree that the code is worse.  It's _different_, just like Rust
> forces one to write different code

different *is* worse. We do not want to have random strange syntax
that differs from all normal rules for some little unimportant detail
when I already outlined something that has standard C syntax and is
superior from a technical angle.

Code needs to be legible, and that means that it should follow a
pattern that people are used to, not have random single-byte markers.

The goal is to be readable to *HUMANS*. And no, removing the (more
common) function to allocate just a single object in favor of using a
"1" is not human-friendly. And adding a pointless "," to make a
compiler think it's not a missing argument is not human-friendly.

And honestly, I don't think Rust is a great example of human-friendly either.

              Linus
