Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A548CD7F
	for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781874; cv=pass; b=soG9mjB8hW7D3Lu1ednj9TGOLaE1QIUx+eqCULxxT58L2YZwH2/WsF9XZDOW+rKGW6LUIn/Ff3dCrchKn4Ntx3ndv4Bl/FQVYUfSFDGw1n2N3KeKjVkN52O7EhJvYwxJN1GkJNKMiAcSIYeWdaQBsut6Et2FWFvXT0aOX9TVk0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781874; c=relaxed/simple;
	bh=h6jhuvTWqLaqruIgi1i5TAYcvTriQCGzhZebRCsuWN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ch2cREO7F9BkM3iQrouovTmymDRlNNZjO1iXtApu91jRF54OOz8q33M6WQJ77K6Kee3K1h7uWNPG9U8K7GiNb2CDU8ToU+i9jOR8LH1slXw5ekfOI6V1Vu0wHVSCfJFJIM7G4G5GNbxhQulBTR8q7ySJrCX+kBXgIMHW07Jg6XM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bz1jkVgo; arc=pass smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bz1jkVgo"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-782af6c753cso1169751137.3
        for <linux-hardening@vger.kernel.org>; Wed, 26 Aug 2026 15:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787781866; cv=none;
        d=google.com; s=arc-20260327;
        b=JJLaDZsNdV5e/lkpp0fWwoGYcurUXT+6t6lTBIsuKQhmH3dFiI+7fXFcKBP2yHaAbj
         7tZQC+0STbJ6q7H9hHs1NFVGZeo14m32bQrZ2O5+82xU8trN3F1x8un5elGLDtdMmboX
         oJEQ2FHBpsJXz3R9kgR4bqP1FDHb1tcnWbOeI7i4szkJANebQc60buW2BzHE+x/UXY4K
         eTLBfnd/7kMk0grwKkCOjZe3xVWh+vMJDR+GNN0z7daLHb0WgrVZV4m6IuMAzUn5l7TH
         LUsevxuh4ZfiWDLfWLXEvF5Tf1CRCGIzEg1LY8odwEPiPNbBrQCLde+/NcpUvUunqi0B
         YD4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KE+jiRIP75MXtXBIyBa6Bn84xQJeL42gUj2ODi3jyzY=;
        fh=vsGZ0osAtmiZeqhsIcQArjW61ao7/BjekFinwj8BbF8=;
        b=jVddEBhwUhpsADGp89CfB7d09Cx4VRAn2VNrwg06wm2amaXBUAZrMz0Az8GTx4VOKw
         /is4By36fFI6taXP6TexELMAg0l+Atz6OtlBob5Drz73Ykfn3wXZGawb87I2XzVAGNVA
         X5bXPLr1yw8huRCz7nWPiWdHD/Rf5136JIdHFg9aUKwuna0FterUmSVmKlnvM5bEuB1Y
         MmDDMQ53eLBPJhmyhkUsTw2PYnSG3fTdrdecDjjQstm8ILSnp52wdRvs2bTezwF438BQ
         nuvgZbtGr5p13pjOU+LClK7M05enmNwuCdxhy6CBYjlWe/xgTyu8ytuOwc/Wphfcpy3S
         AAkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787781866; x=1788386666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KE+jiRIP75MXtXBIyBa6Bn84xQJeL42gUj2ODi3jyzY=;
        b=Bz1jkVgoc0Oj6fxoSKtmGZ+j2jSsK25Fy6dIkN1VqFv7gyD+Vt9Jeo8giThH83VrBl
         o7tlYwl6B9q8hmeuCL/J4ri6EJJFxhgfO5MmWhSFNGFJvflnrpQpP80hpWNK1SwDX4h5
         9pIwUnQrEb4z/yI9bI04BnpXoNZsoZWIHUYyc3DeHJjbDHkFziVa1Fryhqg2AvP8tZ48
         gTWPpFt/QrEZYCgyKp9zN02ClJighD6OSfNyrn76IOxqvxWfAtZVfa4VYyKuQuLmKOhy
         twzzfqdeIuqY8cuPbHqo2EVnpU3m2sl9mom+l+lk4uoSRDZHqM1kLapW5eHFzOXY6d9/
         4Qkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787781866; x=1788386666;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KE+jiRIP75MXtXBIyBa6Bn84xQJeL42gUj2ODi3jyzY=;
        b=B5GtJ4a0NeUiDPw3GT/wbdAtNd9yIe+qKonAtGJofEIEyxhNJloac5/IM1auyNvj7i
         UhVOyNyBKWaYx2VvnLSHVMxr3+RxoI3zocUVv7tajVqPErI4SNHNCkv48G4hK9qedJae
         nBTViLdJxdzliN1rWJ6Aq18h9RvxzP0Kr4rghtjvOlkwQOxKHNoe8Qv/O54+ntEV9tY4
         NwbnB+jNyKSLBbm+tZ8HqZGf5TM0TnREkMjcQnHsBL7+xAls7VoIr4lvloAJUUQCVxo7
         XueXIjXeQxgPz9m2CX8YgQ2Gl9U753avkY+C66jZTJ8yqPlR0IRnpyLxy27kk8EPnpGV
         smwg==
X-Forwarded-Encrypted: i=1; AHgh+RqKqmwhTD+f0A9yEKOHHkVmXUgJKEExJcp8xaLYcdnR5jLtriZhU5hflGnhz8mqrw/gHIJttiteSEJv9lLzYTo=@vger.kernel.org
X-Gm-Message-State: AFuF++ljtbPxraGfEMWJnpP7Sb+cdXzRbuECtznj4rzz7vQo7yo02RlY
	RDFS+CTkAPPpw2au9ZxQhYKOWatnfeMLyf0IgGCsRE0wHjeXw9sQ3BUtj0XH5khiKS2LuDlYhg6
	SEMpMxBR76R0xpa6btzaLteOon20lLElB0GVvdgw=
X-Gm-Gg: AR+sD13jR7zwAgW7Gwink1Rh/cHN1LxaQl6R7vHDTZbxrCiwDLAS0nbBbnJbsyrWZFx
	SRenE4zFoctGZKCDxOWQvn3dLmvdwAjrzG4GJMb4VCye2IMbvtnwimE0/cvtMWT/imNKG7krQjJ
	pd4ruOTIDFDfsycvDcg7UbQdyj0pHf92DMICkgrDyOc//YFum6Al+hIK8XgvMtnG6o9EWHZfdz9
	5KpizWizhfNFklKq0PfLuPRtDu1qeGXO9F4ok08+gfPRoQlSrRbNwWwPhZZYWPy3wBpvRMuxFhF
	iTSOULEgax+9PArijtSdZwd5Hb6Pw238FV01lnHrlHpLh8RUmSPrw9gBUMGSRYn3ItqiI7a9h40
	XxBQecgPKYaW/kbmQfkGJ8aCmlQUIqOicdwx4aEwNaA==
X-Received: by 2002:a05:6102:162a:b0:77b:28c1:210e with SMTP id
 ada2fe7eead31-782bf9bca7cmr4121526137.1.1787781864359; Wed, 26 Aug 2026
 15:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823125348.1138649-1-morbo@google.com> <20260826204323.3974187-1-morbo@google.com>
 <E9656951-4A60-43BB-BCCD-4249F70BE10D@mainlining.org>
In-Reply-To: <E9656951-4A60-43BB-BCCD-4249F70BE10D@mainlining.org>
From: Bill Wendling <morbo@google.com>
Date: Wed, 26 Aug 2026 15:04:08 -0700
X-Gm-Features: AcwNN1XZAcHYyOacS71CcIqgQvcI1d_XlJVHYav1sZyJBbPppwjsV6YVzHnhu5A
Message-ID: <CAGG=3QWoRk8AVkuir4Ooa7ghZX9QpCU42M15F2J4SYN+zENouA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] userns: Add KUnit test suite for uid_gid_map
To: Bradley Morgan <brads@mainlining.org>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 2:21=E2=80=AFPM Bradley Morgan <brads@mainlining.or=
g> wrote:
>
> > + /* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS (e.g., 10) elements =
*/
> > + for (i =3D 0; i < 10; i++) {
> > +   extent.first =3D i * 10;
> > +   extent.lower_first =3D i * 100;
>
> Both .first and .lower_first increase monotonically with i. So
> forward[] is already sorted by .first and reverse[] is already sorted
> by .lower_first before sort_idmaps() runs. The sort is a no op on
> this input.
>
> > + /* Verify sorting is correct */
> > + for (i =3D 0; i < map.nr_extents; i++) {
> > +   KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
> > +   KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100);
>
> This passes even if sort_idmaps() did nothing. The test cannot tell
> a working sort from a broken one.
>
> To actually verify sorting, insert the extents out of order so that
> sort_idmaps() has to rearrange them. For example:
>
>     extent.first =3D (9 - i) * 10;
>     extent.lower_first =3D (9 - i) * 100;
>
> Then after sort_idmaps(), forward[0].first should be 0, forward[1]
> should be 10, etc. That proves the sort moved things.
>
> Nits:
>
> > + KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.forward);
>
> Redundant. insert_extent() just allocated it on the 6th call, and
> the previous KUNIT_EXPECT_EQ(test, ret, 0) already confirmed success.
> If you want to keep it, at least put it after the loop where it
> protects the sort, not inside the insertion loop where it tests
> something that just succeeded.
>
> > + KUNIT_EXPECT_EQ(test, ret, 0);
>
> Should be KUNIT_ASSERT_EQ. If insert_extent() fails the test
> continues and the next assertions run on uninitialized data. Same
> for the base test.
>
Billionth times the charm!

I hope I've addressed everyone's concerns. Obviously let me know if I
didn't. :-)

> No tag yet, fix the test data and I'll tag v4.

I added your "Reviewed-by" on "PATCH 1/2", but not this one.

-bw

>
> --- Thanks!
> https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.ne=
t/
