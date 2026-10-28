Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180983;
	b=TxToanAsbXRyrD/kuFngpo4Qltt0ENxjUsVv++srI4qYJNDLsP2MlFtxJWlm3mYDwCJp
	 19tVkFABlw0ChR+QhfYnDWMKcdhql28+J6i+dtuV0xBX0kE1lxmcZO0XxlEBFwphiP530
	 8uBAM5VamJdIAbAjIaFsX2Ekuxso9uOrZA8HvMTlFqonpQoUFd4zi+fKHz2MpuNKpiVlE
	 r9pdc8kaF/OVLV5NxrAn51G1XvqIzVA4PRs47c66zf/Vjz+VbpAoHKKviCzvq99T7KTOI
	 9k43W2cng8+NyP7dicBjmjSfsfXwu/6Tv2tBE2o8SjG+kBnPvmy8a+qCEbjFHEePayw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
	b=D+AX4O0DwX4sosD176P8avXd07GhhAvY+2wQ+b6dP6PH9RmwHZnjFNZPLfml6oO6EvrW
	 GErmHSPMK3BinUT2u9iey2lD5Z+GAGKQpd05DaUgg5kQYYyvv3XbjRIpZyfaaGErFz3oe
	 SdXXkt6YRjW+PV1St0NPImigN9kwnnX5Gzd8LcxN2AH28RkDxNGI798Hh63me5tJJdNQ+
	 G3g2bjPk4/N3zeLoRgg+BHyt+jCM9gyWRvMbeOhdAoZ/4uH78U+kTZsmDFod8f4dXS/z6
	 aVx675njpgtY90TIfEW3Yn20Q4ODmAVQa2kEZOSHGT93HCN87/m8OKWmBhibbSdh07w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDWonstv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE2606A320
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 09:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1DE2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDWonstv
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c43373ae89aso99469066b.3
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 02:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180981; cv=none;
        d=google.com; s=arc-20260327;
        b=BoqdEVIhm+BkZfNQNK0lRbBR1ue6GMbnJJsLgclViVuLQmILz6gxGy+0xgKCb9/eev
         1fJaIIBEPB9pvo2ToVqF8orRodBdrZYNK/dD5CmJ5yRxwYRIYidCMwjqAUukt5KJdy5f
         RrozvhTkFUTko6WQG9I6bA+6XwIOQj9OqTHlXNNM193Z253cKDF1KviYjLXIbsLQ5FTn
         KYXDpQcWb/LncvMx3vgfQup6TqIGAV3A7vvPZQACS/j1XMFp8nJJh/aOcQsd/Tut6+Lj
         8FWIlm8rg/WFZcvgcxq5QzrG0pykdL9rtjL5trVFMKPFzYY5S2PxtAVv0+jQPAv92Igb
         BmGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        fh=n/Dxw/jpuIIYRDb7tVPeRjsc6BIYZnSInnAqetjc9eU=;
        b=ovUJp1RP1fF4VKkCyUTh5yHgbmYINlPQvLVejld3c08M40x4/HumOhLB+8Vmg71w/3
         7f+FD9GO9yKFkzcrOj9P9cSrnkghs/aGbnX7/FD2ZZMArcwyIW74bMgLvYItfPDOgsKW
         HE9lzxikjkxUCWZ7Q2OLze6eNwgtdnMgV1NddkpkEF1CpZ0RLE/hyfgMA9UL5jHfSAFE
         G0D+ZXAhAIjRVCySxiMmQu/Cw9TEUe25tcyeDa/FrdFsJhkOT2OQg1bL02uY/NFgZVY/
         hgzqrkaK3w8xbDD3uJ/MhufoqR19vAmvWteI9DAGS45fycIzCy8mM2tZL3Z5lZySF9lc
         rXuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180981; x=1793785781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=HDWonstvPcPLttzddfVvr3FgZgIj3VTyvAyBQZO+i5zbi2rECmhSDB1AdWtfuODuhy
         zbThFOJ/JjrdUK/lT1BtY5Mp+LgVPMkR4Qmb04x1Avh2AVbEsATe5lvudS7x0SEorpMy
         ReQIkPvkTLZqXSyJPrV9ZolsJmrPn6NOA+iUBn1Z0OyokcF0SAk+CxO33y5zGnKio9Tv
         cuJUT4+A+kWSsZ5MWECBo71XMwQC85PCyclaPunzfOsIAqOKjt00RM2xS3RmVMACwQll
         Lmk0EP+6mdeww5gNkgsAXctSQmF9/qTytHXp9TBcuVFEHzvtb+Mji/sDVnTmpnhvMOOJ
         3Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180981; x=1793785781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=bu+UGkKFnEs7LlUyumEnTkgLGsK+1onB6QAVpTbMrUrdbkZeB2xFXiZ4kz5bfHXoL5
         DLkfrlQITfUUKmCwVhmfW0yC4GMGyLjJ/pRiXUyJUw0eGQkPpYy8gwF9WRRXBVUJwR2Q
         9+S2BfUziLGdNYzlcKa2xyeEuVBeKFqNgE1oobTJr9MMA2vqgoRqI4+WC1SiiHFsC9XI
         Sx6MhbPdmu5jWRSML3VEFMb0oQSdvLFf7okI4ZbN/vyVUYiWOQYW929s61++VYkMcCXk
         bU8zC6XSKA3ylCq0kralyhbQix3s6FV0kSp77ZZLI4m9ELIByQdLPOUfO68hrj+D4q/h
         6OoA==
X-Forwarded-Encrypted: i=1; AKwUvBzXnp3WM2vfl/ZcLEx/8czuxvYzgDZfxk8QOkLDeHzx3H97y7kLW6CueqKnI6HUkhMa7LbIHoPs49FTJSUGdpM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwLnN7ZYuCNxTanO7foz2q3sAvUdvk3bYIeObk2HOR6fBn64xy
	0KemZFYue/bmAHmfEa1Lghz19t4Hkmc5YsvkDFwFptCXAVuvPWSS7Yi4S6E0bMPzpnDIFeViTz5
	k6qDtEgwHJhXY7ZP26a67R3x8RYP+1Rc=
X-Gm-Gg: AYBFou2/IyO/UuZ5UlXMjQZDZE0E2GkdrMWcK+v4/YB9jM3Ez2T/N5/od1kbRJMCSpY
	KBn+RBCq0PmJhslUJnPMTf6K7R25jo5fBdwMGNd5snTdh0xTpE+T+KHeknSA+5c7h/JUHXkA5yZ
	STFk+xGm4SYgHhhLhOk+Hb6O7ww/rVYm0Fou8wW6jQb0whqPPmpMOC3bkZe4kDAAs4YJqfcpc8l
	NtgLqZYJyS32pdTZulzTvpvOUhyR+sInnAyT0NX3gJUhh98sp3ndyy1zx1j6m5IOAs34LVo8KZA
	fyRTr/asjowzg2TQDWSqhwyZ8cAr53VgRY4BjzqelwW0fg6oQ3b3qqL2AQ5WcGlcf1XQ8IA59Mi
	kezpv2T0YaqdkuuHqWnZH6ee1Cfu5bSpB5cW/zVuQAWNxT6LBxWtRj5fp8HeTbwAuilqymv+lsD
	1VdBB3qeax39gdbZNplV08n+g+HNV2/e52iOzMe70Xhb/sjjjEvpMivz07/Ul9XxQXZEhRec4Hr
	xPSUvkxcjl4VgmTDEYGFsikjHI=
X-Received: by 2002:a17:907:d48d:b0:c42:82ac:b6a9 with SMTP id
 a640c23a62f3a-c49bdf7de97mr167322666b.29.1793180980909; Wed, 28 Oct 2026
 02:49:40 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:04 +0200
X-Gm-Features: AclHuK-kwXGKz5n7QFXQ4iO49tQbUX582-rj9xJLuSYR3NDY9XFvg2hsu7UGHjc
Message-ID: <CAHp75Ve71BfcWr++PfQPiOc=OURNn1-cdJey=M1xBVCb0HhHQw@mail.gmail.com>
Subject: Re: [PATCH 08/10] leds: pwm: Switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
