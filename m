Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794336144;
	b=zIAhlQzm+Xwzo5iDgBaC3U66H3JyfC12mh2Nu9GWarDsg84LnSNKCoY3pK1txJvsbBYz
	 iEqC8vTHobziRypkzj/IVhaTGeXxS0oUDjGNAOSXYWmcub6k1boNW2ZyzNADxVgvGaTUf
	 v+x2iVFpt3sS0WtikkYGQeN+TqRgH8RX811UsWSGmf+MJW5G+wTZyVVEjVf5I7cDFb7kr
	 nfj24QPWkLEPu2ZyOb1fRnMXdICs607z1ve0uZ89PJrSeDAJ4pW7PU/zHd+EacyqhrPh0
	 FzIqdytl0O/P6JSTJ//f51aA9eeF674d/LbMS6n+AE2Y5g1RF5N6EFKf29OdW7n1kjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794336144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=IJxn3qo9bR1YiWbsVjx6fmfUIW8eyV5FFrf9nDql2TM=;
	b=s5iqgeTVDtUCd8WBydjkqpiD0XfGr0z8I6xnqpNLhXCklcl6wSPj1A0231dwaPukhflS
	 TSei0YipKbgccjeKRJL1cF5QKdCEhFPlZC4oHRul2Alh+oWCNkZp6N8rwHiWkWm7WESvl
	 fuXwsQhUhMi3Ivlz8eKeaS+YcugZKR84rD+Vf2cfunP0tuartmMvxI661UDOs46lsetYh
	 Yuu2UicSf8qIuJxf38V9dhHbylZYEsQr9zgPU5sVvJZ3b4ng1BCQR9CnHwYgahZLYovq6
	 5h0dpl/J+Y2PqGEWeYTpcxOZ94RmMKEqc//sGKgjCCIFpOkEI35wbvl7eiod60QXmEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOzPl1L8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.41
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803CC606A910
	for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 18:42:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 803CC606A910
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GOzPl1L8
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6de1fd5f572so948728eaf.3
        for <linux-hardening@vger.kernel.org>; Tue, 10 Nov 2026 10:42:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794336143; cv=none;
        d=google.com; s=arc-20260327;
        b=imgM054IELl6Idp8e0PGB2a6yjGEg9ZNc8qNheIov1yHIQkb5rigCHgGjnxfRHEuZS
         kad13dIyDWDU3dDS8RAtF2ItuIgvChxRvNrsi0hHS7dq6FaovQZOeHSk5k+N90X8E8MW
         6No6dz/Vdd+Gqzs9WVghTdDYZyckLYv90/jUvIywoeycGwOWnbVIrIrxcJ4NylTl9vMx
         w18btNz3lRtr11caqkmnEyDNQy6CkEvxmWrNzbKY0ja/0+QRUXMtOKjXqWiTwClFy889
         Dp9yT8j/xeJ9JqljKU4eT+aWz4uoLA5/0Sw/L3q7QtK85zctP1WD/+nJK7BQJhxwEtsL
         B+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IJxn3qo9bR1YiWbsVjx6fmfUIW8eyV5FFrf9nDql2TM=;
        fh=Y2NjReMclf8YUuYdl7s+ccKQD2kM+j1QE6FRNgMjRCw=;
        b=jKQDpKCk58b+IrTcaJRILuSwtwpRLIkJfNbtxTqbBPKukpoPR7dEZEQxjnzJ8wuf+K
         nkHGStTcOh6G20N4h/l+rKFnsdJFQ7wTMSqmJeSekOKFg8ZyeNV/kqPJxUoLkXVqx/2G
         3gt8J9q9TtakIPHSUZJhoV3exZK+BMgCPbZS9ofnPfKDmVEVW/fzZDi7SLEn+Ix3lnw0
         MjI9s1rGJDoKY1ofl+K/Koy8Cb5d5mRNPekc8O3zXlJ0rn+aF+GBUJZ7CUMZUOxj+dH1
         YVYOrKPOrcrIom8V5wi83fvWuZUIGDbI8Niw+YjoX4+0ce5LtR36DfGTzo572lu39ykD
         lIBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794336143; x=1794940943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IJxn3qo9bR1YiWbsVjx6fmfUIW8eyV5FFrf9nDql2TM=;
        b=GOzPl1L8hRVjkffAQOxToM40LGbUN6J+NDsUfwKw2whmCy12nlhxMqTZrIffhYz6c5
         82raO4rO5Z/Nnur8vQxYLPRuFWegRL9LQna+/16U/qixg+cCYrO84k3opaOnz/z9f//g
         OvMmuW1l82/aqZBPhPkF/MRWD7wEOpc///gPqgv0Z63wprZeqEw9aafEjqB/YLKAkFAu
         uEyg1Gh3mrFddj2nVel68LgHczYj88PuhW38WnVMmW3rfQkBPIuaO2p/1W3LAYjQmuEX
         edsXx3DSwbwWpPfNXsmEt6yUl2iQfN9PXb6PoQkNB767Ud9sIdMaXNoOmZXinAaskBPI
         dGTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794336143; x=1794940943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IJxn3qo9bR1YiWbsVjx6fmfUIW8eyV5FFrf9nDql2TM=;
        b=RgyGsHqoIq3NfoveWOzHuGGaX44/UJO2iQApRyyitIqMGcWhunmSUI2K8yJL8qheRK
         mdgIg1PZWBr6Lg+CMlReoqzj/2Wxs+vzm5KFvwOE/9Y2dq+WhDbLv1kaFMKuX+DG4I/Q
         CkZ/QNghtWQQUCRc93s6z/1jj6r/ACTI7erfSW++z034L2lgH59i/Rr3hUHUcbDYIkCh
         zzoMPviEdhOyn8Q/LsSNKQUz4l35QT7PQo+Rr0GqyPkcFTHAmYc+fZ1UxbyIFvWWiI3x
         SjhMhd822q8iX6bvLh8XEla2cFl1xaaNsp7KWQzVmY5pEJKhDLRCId0bDflKRFdYxiw+
         NnQw==
X-Forwarded-Encrypted: i=1; AL+hErHi838JrJg4iGlZGexdGbt8imA4MnqZVBNlSBpoo5sqWxosXGmHTJZhlw4pGleTHhEOz+zfrgOQNMY/Fxc2CUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zQiPo/6R15LyldzXUtztQ62s6U4BgrKiIkEM4C0t4FZJSHtcP
	sbKPNg6aPa2bEP1afqhaMVIy6533GnKFfEEKeyJkbP1C/NCXLVdUAHbMPMKMbRvW1Bq/jBfDKJh
	ET/fg7NnIybtKMtlEGA2pkNbzAn/k4Ss=
X-Gm-Gg: AYBFou0iEWKxIHZryPeN4QRJcVH0XISF7U3s2EWKehw0kYUxBoKv/CgnyxgacLN+70z
	UdSnn58LlX2vRxCiUsyKjX4WmghrM6gRYiv0jRLQ+hfZlCsMWE7R8pOmzuT4+bs9CwO5uMAZJfK
	mweuFqEaiV05TxJOY58Bjw++6KMTgubWf0tPoGoeZ6Pt+ZdLb3ZgNDfWutkIr1VnqoSIjqnCZLL
	8zqUGfRGw0mJeMfmWD76ZvZRBHrG58W61wajBzy7IdO+zJoFk6rRuVJUWQOD6ZffG0gcawCrA9e
	P5dzcOuvnHkWUyI6nF0viCaZCNyx7K94qSr2SsGan0/zL8xFTkuaafVC5hbim4WUYlkViPXsg5v
	0WKAH3GOuVTHZTdkHNUwY/UYfRIs+OTO638jGkKmUQ7xPq1Ro/ykjdtuBAiRLGYIT
X-Received: by 2002:a05:6808:2212:b0:4f3:e133:c574 with SMTP id
 5614622812f47-5683cc0efcemr2798420b6e.19.1794336143447; Tue, 10 Nov 2026
 10:42:23 -0800 (PST)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110164222.698745-1-andriy.shevchenko@linux.intel.com>
 <avNb_7QmpPkxa8xq@yury> <df77dcec-08ea-b307-53bc-d52078fce7a2@linux.intel.com>
In-Reply-To: <df77dcec-08ea-b307-53bc-d52078fce7a2@linux.intel.com>
From: Yury Norov <yury.norov@gmail.com>
Date: Tue, 10 Nov 2026 13:42:12 -0500
X-Gm-Features: AclHuK9zAzIBs3yl4x2cgqpMXprPRNOqAyrkGsucmnU2n3m4faNlmxAM7HKEc8g
Message-ID: <CAAH8bW9ZT-D6boyM6qWLj9DpYwi1CgFXcfJk3Q9mtnNGqSYQDA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] string: Export strnchrnul()
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Yury Norov <ynorov@nvidia.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-hardening@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, jorge.lopez2@hp.com, 
	Hans de Goede <hansg@kernel.org>, Muhammad Bilal <meatuni001@gmail.com>, 
	platform-driver-x86@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 1:39=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Tue, 10 Nov 2026, Yury Norov wrote:
>
> > On Tue, Nov 10, 2026 at 05:41:50PM +0100, Andy Shevchenko wrote:
> > > Export strnchrnul() for users that may be compiled as modules.
> > >
> > > Reported-by: Armin Wolf <W_Armin@gmx.de>
> > > Closes: https://lore.kernel.org/r/1969fb5a-38ef-4b4b-9d2f-cb9a4348b96=
8@gmx.de
> > > Fixes: 0bee0cece2a6 ("lib/string: add strnchrnul()")
> >
> > Not sure that exporting a symbol is actually a fix. It rather looks
> > like a normal development. Also, I'd like to have this patch attached
> > to the PDx86 or whatever series that uses it.
>
> I did put it now before the change that broke because of the missing
> export.
>
> I dropped Closes and Fixes tags as the issue should be non-problem after
> the history rewrite.

OK, then

Reviewed-by: Yury Norov <ynorov@nvidia.com>
