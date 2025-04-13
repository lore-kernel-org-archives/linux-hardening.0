Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8551E195;
	Sun, 13 Apr 2025 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744588634; cv=none; b=uqjLIyC2Nn5pO0pCrDdAzYF6aenMsVWCcPdyfLWSe3YuuzaqGrGN3WoaQoDfxDd0nI1rAqe1pqAFA5m9YKvARgaa6l4/1S0/iIGlYKgIlksvLrlnk0V6WbmJvLTso3ggFr6Wov9M2w+9glGGSQZSP+pcCCD87n2WzSOGSWFkWmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744588634; c=relaxed/simple;
	bh=mqumJ15ez3wlIfPBsytJxO3ZoBxXr6fTeIISa8OKpBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifPCsPKiI5MSl58ZeQXJbMOC67t3kRlQ6B0aDjDi252pqa+vPD5z9jQIDwoxX3WgJVTUk4HRtrYjA9Z0wtBCvLp3WlcIvGGwL+omY5ANgnL43zNNiBX9C5KcGrJEpH/xGs7qjOczRRyay3bfygGzjrj1MP/48qgQWNUV5LbRdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/Yl1Jds; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/Yl1Jds"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225477548e1so34487745ad.0;
        Sun, 13 Apr 2025 16:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744588632; x=1745193432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ggdOzOafcZWg0a2ABvywxy3qu5ohHwEM4Ncju7HTLCY=;
        b=k/Yl1JdsQxsHkznUQPItpFh9lD9IephaURGUEfVVU+zjU4+X8/Kbsk4H1JSld+xq9q
         srO+kLEBTFjyH91QNYVSNZiZH4L4cdZqSUeUtifcuZeHticiChpuuS9k7hX/EW7beDG/
         9SvEF4cYSoIPrD+y38M6tzizEJk9HQIfMcSxiH6zKV3F+3fEdoSt1VTFCTm/wsv7oEGk
         53wACX0WFYsXgUsTKKfyqgq7/EGxW/OskxNN6vXa/rMhspOdfIpoRaCSbbmwYFxHeYYj
         mYqJ2bI4hamhMDh3tj2BR1M41N3QxZpB5fjWIQttJjv+2mxw0VchRrmhnGkiqg8dm5Lq
         KgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744588632; x=1745193432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggdOzOafcZWg0a2ABvywxy3qu5ohHwEM4Ncju7HTLCY=;
        b=wkbt2sskqc9jjbG1Sn0XWIPUmQDwuNOCWpoGChab/3CeDiuMhRVd5ftqMF4XMyED80
         U97SCF1HrttTjZVoI3KtQ58AwenQUcsB3dsy0802YfJKAr4HOrGfCh9GHDH9cgQW4oxU
         UmuGx4p8ZwtuBux9l7rt0aKOnmWHbpTDpkn9XIcBTSThT1CH+S4k1beEW76OSgkTwd2P
         On6KW282GhcBIBJ0Fug1YlOIA7SlFcEWgsPNlHQWtP+z0HI41QEPK6i1D/SEQAvemUZ/
         n0z7r7r2SiHHKJ5wXOgiD2haseNpw5FnOmapg8u/D1N9+9NV4/h0SsHMslIiGXsYoh5E
         QrVw==
X-Forwarded-Encrypted: i=1; AJvYcCU03SfAfJO61JWAM2jdoT1o5QqmpROREP3a4JmwPjdORYqVUHUsjy6qv+HDkUhfUePOigJgJ7ButvWn0/2F@vger.kernel.org, AJvYcCWdFcAK2aJQhJ0MUmR9WmXHJH0XLbKCNwJk+NrwvARKV045LwIGTMlE+TD/XnMe43oqz6/S9z74aMo=@vger.kernel.org, AJvYcCX4onoY9UBvlzx698IGmBqtgvMEULPu7lb8wNS9wYka92szbu8BUeET9rdGr+P9qAsWuHoZcF5kmSLE6CEm+5Z+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Erfk2TdhVWDe6licYE7ln0ukizPoaNtQ+UxPD2j6Bv5Hsvll
	hrepEWrvAGI0mBURsz3mG2X/N97suUSMwngtDHLEEz9ukhBrMhM/
X-Gm-Gg: ASbGncuHJf/K6LdqJvj6swRiwEWFPQQiYMQCYn9l9DlmXbf4ZtGWru5GPlgT4Ht/K/m
	JGjIuMaunp4lDwFm8lV1r7Negbv3/j71jxDq250GBbgr11f/doOLc0XapqtDcw89G9bFjHhorg3
	nIsQn23y/ti2UctHJc7Vhjma8ywRNBAn8e8N+4DxlpGLTF643YexYUshD/CsOjZFC8aZoY6zJCl
	BSm0CehtmebXKywJsC7oQmQXjjCD6FoA9VT/w3BKE4/wONVfHfGCrAKvO5O79Czv/0M3cGQ4FA8
	6DqMxp1xD+5CvQVqv2mbGMrBn93lMRSBfLaBs5Oy
X-Google-Smtp-Source: AGHT+IGVZ+0a/vLI9CpMaxmhmyTJwFlvT9K8EhgW+IsLK9YQ1RtByNSmdGfCcHtVNPXEuotdPoXlmg==
X-Received: by 2002:a17:902:c944:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-22bea4bc931mr125730795ad.23.1744588631379;
        Sun, 13 Apr 2025 16:57:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f830esm5636051b3a.95.2025.04.13.16.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 16:57:10 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D52954208F49; Mon, 14 Apr 2025 06:57:07 +0700 (WIB)
Date: Mon, 14 Apr 2025 06:57:07 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
	linux-doc@vger.kernel.org, linux-mm@kvack.org,
	Thomas Huth <thuth@redhat.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ard Biesheuvel <ardb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] slab: Decouple slab_debug and no_hash_pointers
Message-ID: <Z_xPU9wjyFw2h_Vy@archie.me>
References: <20250410174428.work.488-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FtEU1UtlnSMohtZk"
Content-Disposition: inline
In-Reply-To: <20250410174428.work.488-kees@kernel.org>


--FtEU1UtlnSMohtZk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 10:44:31AM -0700, Kees Cook wrote:
> Some system owners use slab_debug=3DFPZ (or similar) as a hardening optio=
n,
> but do not want to be forced into having kernel addresses exposed due
> to the implicit "no_hash_pointers" boot param setting.[1]
>=20
> Introduce the "hash_pointers" boot param, which defaults to "auto"
> (the current behavior), but also includes "always" (forcing on hashing
> even when "slab_debug=3D..." is defined), and "never". The existing
> "no_hash_pointers" boot param becomes an alias for "hash_pointers=3Dnever=
".
>=20
> This makes it possible to boot with "slab_debug=3DFPZ hash_pointers=3Dalw=
ays".
>=20
> Link: https://github.com/KSPP/linux/issues/368 [1]
> Fixes: 792702911f58 ("slub: force on no_hash_pointers when slub_debug is =
enabled")
> Co-developed-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Harry Yoo <harry.yoo@oracle.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Tamir Duberstein <tamird@gmail.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-mm@kvack.org
> ---
>  .../admin-guide/kernel-parameters.txt         | 34 ++++++++-----
>  include/linux/sprintf.h                       |  2 +-
>  lib/vsprintf.c                                | 51 +++++++++++++++++--
>  mm/slub.c                                     |  5 +-
>  4 files changed, 72 insertions(+), 20 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 76e538c77e31..d0fd9c745db9 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1798,6 +1798,27 @@
>  			backtraces on all cpus.
>  			Format: 0 | 1
> =20
> +	hash_pointers=3D
> +			[KNL,EARLY]
> +			By default, when pointers are printed to the console
> +			or buffers via the %p format string, that pointer is
> +			"hashed", i.e. obscured by hashing the pointer value.
> +			This is a security feature that hides actual kernel
> +			addresses from unprivileged users, but it also makes
> +			debugging the kernel more difficult since unequal
> +			pointers can no longer be compared. The choices are:
> +			Format: { auto | always | never }
> +			Default: auto
> +
> +			auto   - Hash pointers unless slab_debug is enabled.
> +			always - Always hash pointers (even if slab_debug is
> +				 enabled).
> +			never  - Never hash pointers. This option should only
> +				 be specified when debugging the kernel. Do
> +				 not use on production kernels. The boot
> +				 param "no_hash_pointers" is an alias for
> +				 this mode.

So on production one would want hash pointers (i.e. auto/always), right?

Anyway, the wording LGTM.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

PS: I'm confused on unspoken convention that anything but otherwise specifi=
ed
is suitable for production, as I'm expecting explicit version deployment
(e.g. use <insert something> version instead of don't use <otherwise>).
=20
--=20
An old man doll... just what I always wanted! - Clara

--FtEU1UtlnSMohtZk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ/xPTwAKCRD2uYlJVVFO
o+w7AQCt25XM3TCWr6b02MEEkGSxqcN3+FaPyBczq+zpxtJkVQD9FuXjspH6lIrK
F1kF1a8dz6O0m3yt0padcRMeM6j+sQ0=
=g3x1
-----END PGP SIGNATURE-----

--FtEU1UtlnSMohtZk--
