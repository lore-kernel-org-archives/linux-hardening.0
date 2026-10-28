Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181021;
	b=ZAfCbDXNQtVDeZh9LCg+3X5PX7c6gspFOwOXKS4yXmPw2LkcGwVSzqWz1MCqEIob6DRr
	 nhHRUiIjHSHvZJmYMqX/JfAB1PBSXqMo4F3YpOisASO8pOTsjCrqroSYzJ43vpd1Q5/TU
	 8vN2D4uwreZKe4C2VO0Qfmr/vF7w62QtZSkrYWhltTWXefH7rzK+SjvlTPZ03VyROyAWR
	 xREBOshBwECV/jCAUA8pxRtfA08CK64VuaseTJzoLuKHwcaXb7Hr0UR9psfeYfWUWbWVe
	 nMfXxmRfS3TnI89uPbAxfhkrpBzoJZTOVjJo4Z+BKbzZJoq12Qh9r0EbS0p6rXT+nug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
	b=bJ2cul08LnikgFRddj49JjwK0tiir97h8fOXuViUxYR+U8nugI51LrBV7EAljJPNpmyA
	 fRD1GuUaiHyPFu1XfLjBlD3PdGqdnicC4nE8avHjBqJI+m3ETSCiLdfv5evyjm67YsdSx
	 S9UvI3BktEFCB4KMDWXw3Z/uFtfDHvrsnVU2UXS1yDWj9CgPlQBXkXwM2u4q/snapr4Bs
	 VjxvFoPKpq94tIr0JZbPb9Z3t6dqWB1jHSMuv5LBVyVglHNOFQ2vAoxA/YUfneMRbe6ah
	 cyaGSvyhN3kUOfkkpCazPAADobC/1ZfGT1xVs/WBB0/tptudKCZ5J+K1R/e4ynUxVCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Po+tkBhH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC01F606A330
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 09:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC01F606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Po+tkBhH
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c40e30c26a4so297337166b.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 02:50:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793181019; cv=none;
        d=google.com; s=arc-20260327;
        b=bmHKXsaMVuQrQA2nVQD9l/PiiERmPjZDdNnByEs2RYwSAfO3DyvU09SoXDmGUCsHP+
         bpy37ien+EzfpQ51fcQS1srm9gvYeP6YcftusCGN3eOsCNNr5u8ItuqvGrMvE5Umz1nG
         R441cYhULPpZdGvRgTLw4Rrz6QgaU3FbO9QnyICfvkjDN7qDYdTqBrlPES5uyxq/oWQy
         BE5j6dnEkUKdY6YZh7jSP8l0MDKYutsXf59yvAxQtNVgkJNV2URuzyL4pQF5filiOvHl
         Z351HSPBl2oLzb/tVMKjbA86s8/gHTS7Ex5boQo1KnvzlZJD95Q3i9Az0AyYZpEcNOfN
         ZzrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        fh=TQOlcMakaOc7hxm+mOU4Iqd9Lcn+Om4MI+gkQ2rQxRI=;
        b=XuUR50b4qV7r56Q5CrgHzsLYWqMU/FIi+JaBty1zSi3BrjsTKc4K3RyJDBIeTswmeX
         wqG2XvaXsZmifo0HmDoCcyHDuPQisusiTAk6OxV+L3bUqPJQQEAM7GOqMSA/LFNfmH1Z
         9Aa1GUPeU4x+b9BO4rGegieltsSFyqqyEt6hzVxRc7BF5kAiyYuMUHMDEDDFFyjbodlP
         JZwYdk0Cb7gOIt/o8eXR6A7IUU0oKsAgL2UWIaPvV2x0W2MR5QSi6rzljaX5ErEs9qba
         EC2kAl19oKU0RIk6WR4ixCm9JQXvSmnujW7uMTq0hq+Sa4NQKGUixS+v8CEDXzmYv2e3
         kzeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793181019; x=1793785819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=Po+tkBhHSAxqEHwLFlZ/dUO+MJX4kBmJcMJ72/CBTwKDm72BzNBiMEteALPgfbyNoP
         EzBjYCRyohCnJfUhTv7oF1MACYHopGGCSjOQ6AazrqyebZD9uRI6Ayr5dej4TDUM4dlt
         SXymOqJpD4azna2aSzuZrbEp4Lwg6lVAvMmnKhE8Jgl/LQsXxfn1L3AWnI0S+lFXopYE
         GOgNNvE45nthasHpbdgbf74OgLbSrrfaJWK7r2jXh+PEfaeIx1GrmaA8Q6XsabUHVALV
         5xyPXXcFo+JPCjrfzKLTnwjN4I5ZzTw08NB2P3kl8K8jQ2pAiA05GHlZledigQ/6uRPm
         L8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793181019; x=1793785819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=0H34wxrP50ax+b1CUYuCHSgWCeIN+K08y7JasaoIKBiowpGU/rMf4hwopVcoGXJ7dG
         p6Mmo+Zq3Rp/BqaW78vRcta4+0sdlUqIg8YnnkJb3B0Z8dYgke60yoQTSTf6UZDa3vp8
         ckmjwQN5UDQpTKiUm50iyVsC++NxZIAXVvjCNW8+3CEej5bU8K2F7HbbAWAaZKDTus06
         XVRPtWcezhX05p/0/SUYeUsJWFMxixIR6xVyJTNx5SCbYTPad/+EgHnnuOFDr+gOTs6J
         BHno/LQziyvKLXqIxGZMlT2ctOf3BlgLBLrcg/1C2hv5PianN9EYY8h9B7LdFG3nDXTe
         sJHA==
X-Forwarded-Encrypted: i=1; AKwUvByu1yrRDrpxe1rMXikPZoIQpMPK3KI2+Gg5DZ+iZDHlIi8Kj86jHT92Idg01xzwrWExIKnI0gNlBRI3ntM3wP0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCUGniCVsQiHaMWTs71U88msVTqBj2Z9JohP7AUCONGXiZIE2q
	klDHJFr6mMoIoHCyC4mS1CSx5kcz2+IZOcDnhWiItAKZEK8JotJVC7NdTCXq9qgV5UJCE/VeqMO
	ZJI3Ecl+Qg9Un9LnM6hiRkaudi0G6evY=
X-Gm-Gg: AYBFou2Bv8RRHfyuqBZEA3M16kL+XHzTMshz9iusg8AR2+mjwfwVXGrS18hSOyn4Ykd
	2FtIeulYmqvhPdWXYOhw3WnZZ0xrtlr8xRogQI/O/OzVVdKlO41lJVUenQnovf+ULUHC8mUI2FA
	36s2+UizuRCZbPnKCRCv3G1GwZYSBUvlfEI/RMuWMF6XjQ1GbxCWI6sWhTWEVfX5NqKD3brn0F7
	12H8q6TMFXw1q8QZYqJgrIOushkuNaKArwEzdHbA/L+JVDrCV2ws4WeS7XG4x35GvtQrZinri9x
	/ZNsnbdK2+ZQwM6ZECe5CLGg08QgMrnt+68TWoaBEsTovWFo4dFkyQNwe+2i0fbaUMxRlELyyPl
	ensHzi8y3dK9aePpRp1lCRHql77h32bwtvyFCDlsm0xCfNFCWSUvaRyZIZe2vhRUiKpl2+/rRxm
	RYCpN0z7CHQ9FkpvW6Y/pMbvIodrC+OK6nwpZMHvNpNbCZqtGf6OFjP+e+tE+b5VE716bYP0p5D
	Xiy0u1RPGEtPf5SmVzALL6t2fjZOeRZmPt7j0k0lm0+QyU=
X-Received: by 2002:a17:907:86a9:b0:c48:a838:c17e with SMTP id
 a640c23a62f3a-c49a739f8dfmr484567766b.14.1793181019107; Wed, 28 Oct 2026
 02:50:19 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
In-Reply-To: <33ec8080594f9f4ef1d50e36497339c9a6897393.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:43 +0200
X-Gm-Features: AclHuK92we6zl1A1tCfKfYVeuXltUG4Bsfa-fRzr4orRkDVhJuYkTUAxt0MOtcM
Message-ID: <CAHp75VfR2i_PPZwSG2UPaxShU5L=FsSdEAT+0iUMDKAfugbRsQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] drm/i915: switch to __nonnull_args() macro
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
