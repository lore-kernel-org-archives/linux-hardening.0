Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180935;
	b=NIOpmRIHhNYWMnp1RnBCyoNW5BDQAKoCoJutuhVZbPhiHMYxcdNxwD9gjpf4QhYilNnr
	 O2S2s1r/IJzOrrOVfnWo78LD/k1F1meG2yfZAIRhqM/kSYBnDELTX/HZU9rwyoTE1oWnV
	 P+Gbeed5Qg4y5IIfz0mpTVDea3molpwsZDdLgoQCBY1J4kmQ54H0OnESjJ1KHJNBUCjiX
	 Se7iwnS98bG65aeD08gMPIFOyMGfGIBdfV+ufFiqcnUTMWd/igy14pFT+YXyhKuHU3wr6
	 2OhmXwGBEANnk0CywoP5iutwrT+2HjkEqjJE6d7U1+Ltoh4Y435I4Qkz/j2oS8rF9Lg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180935;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
	b=MAAMu6/WvWDSajBq7Wo0CAgIdj1u/G7WcBfoHqiIHGf8fhGOWJ8O/ta5WoZBk/QU+0MM
	 jkXuXzyaMy5p2Glqn4G5V/wrWebyB8IFep864Kk8TlBsTgIa8fGwQd8dIJdcc/A211CvK
	 Dw8ZKQDmJ5gIqaEa1rh1YwGohGh5t7LX3/eop8efQQVbCuxlu5VrhfA7Key3gf3gfK0mf
	 W5by+JNnfg3Th1b0LqkqTHTBnMtLXD1wHZ50Gtp9tORIJwH3d0pO3+5iMq3ZN/MARRFTl
	 i31e1IA4T7m/TdoPG7/xcyuHcgcszsCcWRl5/8vWX/id1/C1ZOieyrIlEFryfKCwX7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vui6KWrO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA337606A327
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 09:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA337606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Vui6KWrO
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4677aad67bso80653166b.0
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 02:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180933; cv=none;
        d=google.com; s=arc-20260327;
        b=jVt8pS7Tc5mFmxpXG/9XFWDOeEPGJ77W8zRev7e5n/KDSFnPl2Ds87m67E4ZBR2vzs
         eYBfCFZN5sw9diP4ZshcW7CKEUSmAxCbgK9TwH3xPtaWYGh9ti0Gfqwml0rvf5h26SWy
         cCfDGSqQoUi6SnWxr1eMZMBI4CJXFM8CogMQXdvKSpgnrb5kqEcZY3BkXDdvYTQGc7JD
         gJMliGapQfAYHyLlCjgQNlveNME3tvdGgmMJSNCpJnrgtwdK85vnzP/WLeMOkkEe3XvS
         AN0R8W7LRnH35yp2VEwffOZkUxs3R98780AGyH9syq9DPZDKBn9MEsqGIxYlm6a3jiWW
         mBzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        fh=hZMTuRNcjgHXmYsrK5xeqqz5L0gHBawt6qRrVMrC6o0=;
        b=AYd/4IzZ7L+l4XCJMFGwscOyTsmvzTAGqbt+9Njfi+ih4Bqj43A+waq4PEahBckCnH
         sLpwSHrU+8GTjrVJQp91zBXNZjFdXx7guc1znbAKCntMWbJy6Fd7vGe5cD4MPHhD4zTh
         JeI36C6uwOIfZp8bUv2Kr0nGYn938loIp5mJc+bsyAo10ar7xVdxAQ5dRpBtz4+J/SGh
         ghtH3W4weEpiAzg/TgTudKl0GgYsLTSUhcbwMmjORisMrMQJUgzEHNA4U2wyn9YbtyH6
         dsLgOb46FboMfj1wZXOLQFiEAeR8Ado7v2txWOAezkJ96JGBz7DRhxiih9AJpRASujD/
         LuRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180933; x=1793785733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        b=Vui6KWrO4M0VRNK72Uu/n41uCoswnoTt+s/4QwFSHl7/x7Wwr/LrY3N3cJToCeeoXM
         gjMWLp2yO7pfatfowW3ZvCHPPtkx/53S/09OAgySOYQqlj1GHNRXmPOsjzGdOwkPRw08
         1/E93mARaaQYA60m0E0r3++wEApoTDg4hisWLVZFMzjrGhx6r5bLTJP/d/9noXhRolUh
         YG+kLrJQW9QXS0gd34x62/dM+7wa+NmCevHYC/qS7YEKyxS+fAE1T4fKnUnN/erff9tG
         OvbCtkvj0vDFGT0GdrFXaN8Mc+wQG9Gu3QDE89h3/4MLK25Lx6K4CEO1axqBDwDqaSmX
         AW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180933; x=1793785733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcY0Gi4dcvyxZkHDA78yGLoz9GDb1HPFjbtFx6GpqEs=;
        b=N4W7XaluVBfvnCkghpO6a1MyD4t2zfcOZK1zftj768cimUUxkjMgnsH2fKoHnFH54l
         aZEb511nAFcVTv1GU/wTuCVyjTIzSXVIY/WEYt2mkczx5a0qRSdnykcIAapzYqLGFLJl
         vFQ03hX5fqdRB8VfB/ZTdM0eCwYK5jri08Xn3hHg5hfSLQIVElluiAaiu8ghqGAU8ptt
         0Z+PBpJ13G+i4atWeJTMDjr3DhJQheyeWg50N5GcaoQcNuNUwAyPRFhlORdwyhAGqjCp
         In+9TkCdiBlqH4J80ZrycmQXz+1dews8B/GpXUA1FfvWOMNfI4fdWtWfIjFsc/1KqlPF
         H1wQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8qkEPfP+/lyVpnTJzotfZTjum+hiyD/o7mejgqGMyeloKbnCKsV/FYkzd8DFd75hNO6iUBWDcQaFSc0zTx7c=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8cP2yHETjXkLZ5eIyf38ATmsIU1KuYbsGqWvJ7IWofykpPeVK
	KQE/Zi2jcGKNJyQbDcQq0LI/y5l9Y/knS14dg498xz8Rt7yB1d4QdW6ooV/mlqoMNa+muvwzkIB
	FerpdoCV9D5fofx57G25fcPgAreQ+6ts=
X-Gm-Gg: AYBFou3tOre822uSX8v8mSM+Pp290vEzy+UN1umjozZXEuTXNsw0JpUz6bmgrrsbrJ/
	VmVdbjdB38YsGFe2TNty3Oq1DaHVBhuXCY39T3EtHq06YOJjL9cqmOREWkdxRstHmXalwhwr4sp
	hPmX6qW70PccVE8HzYBqRU4TgH8oGivWxvEclgGgURwwxK3a6xL6s8dU24RYLl1WG5ZmEaij6xB
	PH7U7l1TTHcQy93/Ykr/4At+HRgz9oQjzMHBS1T3sAwA7vwtJSrkeGerdki8cyFKK0+6pxKyHGz
	669DMFk2fom5jK3hb0vQpmET+i+E+XWoFtfx7K8U6sAXjYNUnyf++5P4lRhy9HY50s6yq0XlYhD
	jz8G2gRCQJ6OSYwhi3uGUR1ILI2BbYwuCY6L+CC61I7enCwbNoJcMTLvPEGI71k2pbH/IwckFOY
	wgs7NIE2TZrmuGMgmDQ1czOeHYlt07EtBPzCh/wHxr+4FuKtlA4+m6zDleEDAWnd/9Ky9LaZDDi
	StQpmC9cUC6y73K9+2vdEj4mw==
X-Received: by 2002:a17:907:a893:b0:c46:8b51:c17c with SMTP id
 a640c23a62f3a-c49bdf394e6mr156034066b.17.1793180933042; Wed, 28 Oct 2026
 02:48:53 -0700 (PDT)
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
In-Reply-To: <f0d7b2f0dce916f4cde3dd466a5b51a4b88fbdd8.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:48:16 +0200
X-Gm-Features: AclHuK9bqVSr5ebQZT2ja4gGk1wmv0GUJ0T7y7aJfJNVsg1OI_1bv2lVUKDS3Hk
Message-ID: <CAHp75VfJ-L5ELAttN+Fz_Co2E1KHumwLZAEMXFMhRubzgVLqug@mail.gmail.com>
Subject: Re: [PATCH 02/10] string: Switch to __nonnull_args() macro
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
> Replace __attribute__((nonnull)) with __nonnull_args() to
> standardize nonnull attribute usage across the tree and keep the
> attribute's quirks in one place rather than open-coded at every call
> site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
