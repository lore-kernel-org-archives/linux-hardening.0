Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC643B42EF;
	Wed, 26 Aug 2026 21:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779285; cv=none; b=BdQJFpLb7GvSXjzDqoYWwHeXKJug9nx/WIIA81ER67XsCENo51uGY5AI38EEJGDFwDB4V9tU6Hk1xFzWb3Na/0fwnkK/NTWz5GaAO5NrXTdj+qRy1518M83rz690GMZyyXfm256a2MGOya39Paay7YZhRGiXb5dPgv/wi1ZWxeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779285; c=relaxed/simple;
	bh=9O1SzvtacpfmXi5NaIYG4m6PymUAhyDHkxQX8rfAr00=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WP+g/lhDMW9NxbbnksJnGnWkos7aP/HE2riLpINcx5LoegVskrSJl0QKFWF9UzBludv2H5/sl5btdRgcCFy0ptxiMp0CEkzSNrdN+oAOUvuzbgSquQL755r5qvabDncp/h+0BmBR8ZqIIzVjosvMCHFVWfkbo8byguiV7Z97O0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=BGnkMr/W; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=bRyTx2O9; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="BGnkMr/W";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="bRyTx2O9"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787779281; bh=p//9/VE0+qjCaFLgnSL5ypF
	LlJDetYf3uZB6tHLfay0=; b=BGnkMr/Ww91ob8uwvcVQS1JzYsVLgfBmWjwMjgdd9eZFJwEDkV
	o1ivgsRORTRk3Uv4/gOlHldibvedUH58iW+Aab3vfgAaDd1o2vdHHwdbcV6MDM3YNC8WadchDXT
	EksCGvlpGccP5B4xGr9Jr8c/CO+UCGg9x1bMXBxjoGFYIRz9IBxeAtAMmGminT2j5QrhtexJHCz
	za8Di34PHdAgERQDyuKEQH+eLB7HUte/ctXsw0oxqY0/K3lgegGOTL0K6kQydHV5ZZlsaQTHRzQ
	e0jj+YxlymWXpHfqQ58GdgeNBar7OFgvrVl+Jk9c8hnysH8YOSiQdCCIVdSJ3iKRJkw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1787779281; bh=p//9/VE0+qjCaFLgnSL5ypF
	LlJDetYf3uZB6tHLfay0=; b=bRyTx2O97OSThAbrvebUg9i/VBmfEmuJNjEF0Nb6dyTG1qOrXH
	GduIlrmnnvmosvnnKRAx/da7H6Ny0wkTTXCA==;
Date: Wed, 26 Aug 2026 22:21:22 +0100
From: Bradley Morgan <brads@mainlining.org>
To: Bill Wendling <morbo@google.com>
CC: =?ISO-8859-1?Q?Thomas_Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Jan Kara <jack@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, Gary Guo <gary@garyguo.net>,
 Alice Ryhl <aliceryhl@google.com>, Douglas Anderson <dianders@chromium.org>,
 Anand Moon <linux.amoon@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 codemender-patching+linux@google.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 2/2] userns: Add KUnit test suite for uid_gid_map
In-Reply-To: <20260826204323.3974187-1-morbo@google.com>
References: <20260823125348.1138649-1-morbo@google.com> <20260826204323.3974187-1-morbo@google.com>
Message-ID: <E9656951-4A60-43BB-BCCD-4249F70BE10D@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

> + /* Insert more than UID_GID_MAP_MAX_BASE_EXTENTS (e.g., 10) elements */
> + for (i = 0; i < 10; i++) {
> +   extent.first = i * 10;
> +   extent.lower_first = i * 100;

Both .first and .lower_first increase monotonically with i. So
forward[] is already sorted by .first and reverse[] is already sorted
by .lower_first before sort_idmaps() runs. The sort is a no op on
this input.

> + /* Verify sorting is correct */
> + for (i = 0; i < map.nr_extents; i++) {
> +   KUNIT_EXPECT_EQ(test, map.forward[i].first, i * 10);
> +   KUNIT_EXPECT_EQ(test, map.reverse[i].lower_first, i * 100);

This passes even if sort_idmaps() did nothing. The test cannot tell
a working sort from a broken one.

To actually verify sorting, insert the extents out of order so that
sort_idmaps() has to rearrange them. For example:

    extent.first = (9 - i) * 10;
    extent.lower_first = (9 - i) * 100;

Then after sort_idmaps(), forward[0].first should be 0, forward[1]
should be 10, etc. That proves the sort moved things.

Nits:

> + KUNIT_ASSERT_NOT_ERR_OR_NULL(test, map.forward);

Redundant. insert_extent() just allocated it on the 6th call, and
the previous KUNIT_EXPECT_EQ(test, ret, 0) already confirmed success.
If you want to keep it, at least put it after the loop where it
protects the sort, not inside the insertion loop where it tests
something that just succeeded.

> + KUNIT_EXPECT_EQ(test, ret, 0);

Should be KUNIT_ASSERT_EQ. If insert_extent() fails the test
continues and the next assertions run on uninitialized data. Same
for the base test.

No tag yet, fix the test data and I'll tag v4.


--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
