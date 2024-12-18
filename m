Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F935949;
	Wed, 18 Dec 2024 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734558165; cv=none; b=jZQ1uFnSwqxebLDmoicc+pU+QmO0NvpBMYuP9zZsRgz6/UrNSUwRKI7TinYYy2q/3qCWmjwf9wc/9SlzJ0rgCKTFqkakhAjJW23y6qkPRENJR/HFSxlst2PhRjg5QH+udV2IBuI8fY+ZC13BfoBjummI0E2CYE9QxkI6ZDSlg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734558165; c=relaxed/simple;
	bh=tG+OwXLGs4Juvcakf8f9GoHdPtkxCqi8l6C/CaWOqvc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Jtyk5fBV084oLC+HF/YrW4xUkOGu0rL4NT4+vwCQCBVf79cb3cP5TQdW7TiCvZaHnrHZO7VHWxLTiUKwVUMfrUbiNBjH8cHIGt6MM0SIYCUyxSUCVUnq/fT9WXlAp4ypwDw5c06nOvKH+b2jTMY39mJu7FSyO+9cZAL17/OF+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGqDhxmn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGqDhxmn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8A9C4CECD;
	Wed, 18 Dec 2024 21:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734558165;
	bh=tG+OwXLGs4Juvcakf8f9GoHdPtkxCqi8l6C/CaWOqvc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=UGqDhxmnyaWJFC6g9Y++gM77vyQu//3+EWKU0S123ZDhyNi4GTIdM7x9NmBvHp3/m
	 5/rQg5pfF8ad2yek6xVLFrCxdokynTArW3/Xk/NI1F0XBa0nuy3mif/93ss3t4D3Xc
	 1/1yp/ye08r1sOlzYgC6buEqfDfFJJGw9b69yHnLyuVt8EOHYvQlWlcYA9Cx+h+JNk
	 nEScB30HqfJhtGNwHV027S2cKTFs2gwfAXMLTqEM6T+PEGih5WCeNj4o56AxBMG0oj
	 dmIusRhJzYSsOutmFVccz9erGx2mX5clfNjkv7U6eIkv6JemI6Bq7pa14DvYMMph5r
	 BzX2A1ZKKvDPQ==
Date: Wed, 18 Dec 2024 13:42:40 -0800
From: Kees Cook <kees@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Christopher Ferris <cferris@google.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>, Keith Packard <keithp@keithp.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stddef: make __struct_group() UAPI C++-friendly
User-Agent: K-9 Mail for Android
In-Reply-To: <20241218145758.701008-1-aleksander.lobakin@intel.com>
References: <20241218145758.701008-1-aleksander.lobakin@intel.com>
Message-ID: <57A07BD9-8EAD-4AC9-91B5-7F6D3850BB9C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 18, 2024 6:57:58 AM PST, Alexander Lobakin <aleksander=2Elobak=
in@intel=2Ecom> wrote:
>For the most part of C++ history, it couldn't have type declarations
>inside anonymous unions for different reasons=2E At the same time,
>__struct_group() relies on the latters, so when the @TAG argument
>is not empty, C++ code doesn't want to build (even under
>`extern "C"`):
>
>=2E=2E/linux/include/uapi/linux/pkt_cls=2Eh:25:24: error:
>'struct tc_u32_sel::<unnamed union>::tc_u32_sel_hdr,' invalid;
>an anonymous union may only have public non-static data members
>[-fpermissive]
>
>The safest way to fix this without trying to switch standards (which
>is impossible in UAPI anyway) etc=2E, is to disable tag declaration
>for that language=2E This won't break anything since for now it's not
>buildable at all=2E
>Use a separate definition for __struct_group() when __cplusplus is
>defined to mitigate the error, including the version from tools/=2E
>
>Fixes: 50d7bd38c3aa ("stddef: Introduce struct_group() helper macro")
>Reported-by: Christopher Ferris <cferris@google=2Ecom>
>Closes: https://lore=2Ekernel=2Eorg/linux-hardening/Z1HZpe3WE5As8UAz@goog=
le=2Ecom
>Signed-off-by: Alexander Lobakin <aleksander=2Elobakin@intel=2Ecom>
>---
> include/uapi/linux/stddef=2Eh       | 12 ++++++++++--
> tools/include/uapi/linux/stddef=2Eh | 14 +++++++++++---
> 2 files changed, 21 insertions(+), 5 deletions(-)
>
>diff --git a/include/uapi/linux/stddef=2Eh b/include/uapi/linux/stddef=2E=
h
>index 58154117d9b0=2E=2Ead51b1362bbb 100644
>--- a/include/uapi/linux/stddef=2Eh
>+++ b/include/uapi/linux/stddef=2Eh
>@@ -20,14 +20,22 @@
>  * and size: one anonymous and one named=2E The former's members can be =
used
>  * normally without sub-struct naming, and the latter can be used to
>  * reason about the start, end, and size of the group of struct members=
=2E
>- * The named struct can also be explicitly tagged for layer reuse, as we=
ll
>- * as both having struct attributes appended=2E
>+ * The named struct can also be explicitly tagged for layer reuse (C onl=
y),
>+ * as well as both having struct attributes appended=2E
>  */
>+#ifndef __cplusplus
> #define __struct_group(TAG, NAME, ATTRS, MEMBERS=2E=2E=2E) \
> 	union { \
> 		struct { MEMBERS } ATTRS; \
> 		struct TAG { MEMBERS } ATTRS NAME; \
> 	} ATTRS
>+#else
>+#define __struct_group(__IGNORED, NAME, ATTRS, MEMBERS=2E=2E=2E) \
>+	union { \
>+		struct { MEMBERS } ATTRS; \
>+		struct { MEMBERS } ATTRS NAME; \
>+	} ATTRS
>+#endif

Instead of copying the entire define, what about just wrapping the tag?

#ifdef __cplusplus
#define __struct_group_tag(TAG)
#else
#define __struct_group_tag(TAG) TAG
#endif

#define __struct_group(TAG, NAME, ATTRS, MEMBERS=2E=2E=2E) \
 	union { \
 		struct { MEMBERS } ATTRS; \
 		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS

-Kees

>=20
> #ifdef __cplusplus
> /* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro=
=2E */
>diff --git a/tools/include/uapi/linux/stddef=2Eh b/tools/include/uapi/lin=
ux/stddef=2Eh
>index bb6ea517efb5=2E=2E12b854ecc215 100644
>--- a/tools/include/uapi/linux/stddef=2Eh
>+++ b/tools/include/uapi/linux/stddef=2Eh
>@@ -20,14 +20,22 @@
>  * and size: one anonymous and one named=2E The former's members can be =
used
>  * normally without sub-struct naming, and the latter can be used to
>  * reason about the start, end, and size of the group of struct members=
=2E
>- * The named struct can also be explicitly tagged for layer reuse, as we=
ll
>- * as both having struct attributes appended=2E
>+ * The named struct can also be explicitly tagged for layer reuse (C onl=
y),
>+ * as well as both having struct attributes appended=2E
>  */
>+#ifndef __cplusplus
> #define __struct_group(TAG, NAME, ATTRS, MEMBERS=2E=2E=2E) \
> 	union { \
> 		struct { MEMBERS } ATTRS; \
> 		struct TAG { MEMBERS } ATTRS NAME; \
>-	}
>+	} ATTRS
>+#else
>+#define __struct_group(__IGNORED, NAME, ATTRS, MEMBERS=2E=2E=2E) \
>+	union { \
>+		struct { MEMBERS } ATTRS; \
>+		struct { MEMBERS } ATTRS NAME; \
>+	} ATTRS
>+#endif
>=20
> /**
>  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union

--=20
Kees Cook
