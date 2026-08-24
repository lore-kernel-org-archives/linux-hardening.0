Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E34D3DEAC1;
	Mon, 24 Aug 2026 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787552015; cv=none; b=DSoKSHCL6hK5sePfycggcVxqHeHit0XQvsJwVh/z7dBgbNTT5a4Ile+o02mh4G2Cqr+wce00wCiO6SBaRPU9Py2Yi1PNU3CeX3ymShEbSf6VrsEh4woViQ+KwQzIYpUPPGGWRDRYP7fr0nFgOrBelhWdfcRrKcz32xBeqhrnUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787552015; c=relaxed/simple;
	bh=1L9tMSCy0wrBAPwBYeqZ+nw0ZDjewG/CnhHdnRXZ25w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8tGYjSuU6avcG16elrNb36/VT088Uybd7rg6K1azF1Q2FvpPxqPDHDQcaQa+CzTSD+kehtiQ8FXY2y1UPUG7idDzse3yymgTuREcDgmeL3JSDQZQcPP741JqDkOpvZAyTtpNAUEIwyj5Oli1zmPmsZcOEO97I2nCEZ0c2LcM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P763sNUY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sKL8eZrf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P763sNUY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sKL8eZrf"
Date: Mon, 24 Aug 2026 08:13:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787552005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Esxg00+zdR1OijSa8nmQQ2akLFoa3u5p9vLQFPPi/4=;
	b=P763sNUYKjbFVNoHv9yyAfdkEg9XvoDrdHSz/Ab0YEI/mT3BwiSGzY11G1tSiWrjE3I4Z+
	Y/Gv3BfbIdLPiBWfoNUcsL83dGvtbNhit9LUsxA2krUTh/+ex/NjeUIgwvzoAjzfwR7xyf
	UJHopBG2Pa38z/XdoiHVnEH7vUnHsveNSAxpW/71pGzcjF0QZ7+43eSYDma/tIsoXHJBgQ
	E3DkrzfhA5hjJA/JlvBFjIfwVoBfjUsXb8ISzeHLs4brYgpYJZhd4rUBS56ViNcJhE3t//
	DMnvNm0sOeJ7A8B9hFZufuksQ84ZRgVQ8SQ6GCk2XLYlfR31yr6hZb5fdnhxMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787552005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Esxg00+zdR1OijSa8nmQQ2akLFoa3u5p9vLQFPPi/4=;
	b=sKL8eZrfF17mDG5fNF+0CaDWhx/W8a5nlsGhNIHtYXt26h+GH21QcfykQvhLlk7FjfbLpY
	sbGLzD9LvCuk0pBA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl <aliceryhl@google.com>, 
	Douglas Anderson <dianders@chromium.org>, Anand Moon <linux.amoon@gmail.com>, 
	Oleg Nesterov <oleg@redhat.com>, codemender-patching+linux@google.com, 
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] userns: Add KUnit test suite for uid_gid_map
Message-ID: <20260824080214-8b12767a-8b04-4344-b48a-cd2966ad36de@linutronix.de>
References: <20260823125155.1136740-1-morbo@google.com>
 <20260823125155.1136740-3-morbo@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260823125155.1136740-3-morbo@google.com>

On Sun, Aug 23, 2026 at 12:51:48PM +0000, Bill Wendling wrote:
> Add a KUnit test suite to verify the insertion and sorting of mappings
> in struct uid_gid_map. This test suite validates both base extent
> insertion (<= 5 mappings) and extended extent insertion (> 5 mappings,
> which triggers the allocation of the forward and reverse pointers).
> 
> This is especially useful for verifying that the __counted_by_ptr
> attribute added to 'forward' and 'reverse' pointers works correctly
> without causing any runtime bounds-checking panics or traps.

AFAIU patch 1 is supposed to not change any behavior.
You could move the unit test to the front to make that clearer
and also validate it.

> Assisted-by: Gemini Next
> Change-Id: If0c2c197a35cd7429cf0d2d6e3b33f0d9f0be66c

Change-Id should not be used upstream.
See Documentation/dev-tools/checkpatch.rst.

> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Thomas Gleixner <tglx@kernel.org>
> Cc: Nicolas Schier <nsc@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: "Thomas Weiﬂschuh" <thomas.weissschuh@linutronix.de>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Anand Moon <linux.amoon@gmail.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: codemender-patching+linux@google.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> ---
>  init/Kconfig                  | 10 ++++
>  kernel/.kunitconfig           |  3 ++
>  kernel/user_namespace.c       |  4 ++
>  kernel/user_namespace_kunit.c | 87 +++++++++++++++++++++++++++++++++++
>  4 files changed, 104 insertions(+)
>  create mode 100644 kernel/.kunitconfig
>  create mode 100644 kernel/user_namespace_kunit.c

(...)

> +static void test_user_ns_map_insert_extended(struct kunit *test)
> +{
> +	struct uid_gid_map map;
> +	struct uid_gid_extent extent;
> +	int i, ret;

(...)

> +	/* Now sort the map to set up reverse mapping */
> +	ret = sort_idmaps(&map);
> +	KUNIT_EXPECT_EQ(test, ret, 0);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, map.reverse);

KUNIT_EXPECT_*() will *not* abort the test when the assertion fails ...

> +
> +	/* Verify sorting is correct */
> +	for (i = 0; i < map.nr_extents; i++) {
> +		KUNIT_EXPECT_EQ(test, map.forward[i].count, 5);
> +		KUNIT_EXPECT_EQ(test, map.reverse[i].count, 5);

... leading to a crash here if map.reverse is invalid.

To also abort the test on assertion failure use KUNIT_ASSERT_*().

> +	}
> +
> +	/* Clean up allocations to avoid leaks */

Pointless comment. This is true for every single call of kfree().

> +	kfree(map.forward);
> +	kfree(map.reverse);
> +}

(...)
