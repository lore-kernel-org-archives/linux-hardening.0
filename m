Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B19307AE9;
	Fri, 16 Jan 2026 00:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768524226; cv=none; b=KJAkpYcobn1K1pbpBMKs1lspjssBM/bmruGEDQ1GClShnXNfuW18P8QGY6hexIv4GshdUz7IsPN19r47ighL6D+kzL7jemIYjrhigbLElF2TMRCM0WNCzjIPBioZ2sn2AutN8ADhRmYEGhqDPlTFN92NNquz+TnxftWxo9eRveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768524226; c=relaxed/simple;
	bh=WgoVEt3XjcqdkgY52KH+uOERdgttmKm3Bau8OK/fRgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRobQe7u5rC1EB8Ih/2ZD9sbxB1YupMKIO7q8kk9LrVXMTN2o5E6+HF82mn3D2EkbnUPVjWCGCSSj7KDbE+o1ykB4ie9j9paoBiVUDbUuOF1d5zxZu1GI0N+XWniyhI0Y3Ut3IRNoXIce2xdS1+uaLYUF9xLTLbnWHqtTRoeg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRRWhTGV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRRWhTGV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EACC116D0;
	Fri, 16 Jan 2026 00:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768524226;
	bh=WgoVEt3XjcqdkgY52KH+uOERdgttmKm3Bau8OK/fRgM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DRRWhTGVEYSeAWzOVPk824YhRGL9siGopxdRikDeh3BB7hNp3LIhjAziJqQLYvA8G
	 r7o8FodItIQQoMf6QBdfAIG/bpzO8hFyj0VAGLevCb/tE4VAJaZ95Wveg2V5JIBEja
	 /9d3hiVa7/aN41SNSWsxFHurSVJLBkoU2+t5MNsvYmp6GJqCtRWUQghNmW+FaQFVQ5
	 cvwXfjXNhpq/DqCJkxMDllSd0T3iVDf3NXOoTBeJ2v3TYIXXqxQPkwD8YddnLz9Hf0
	 B2XS1MP+SdPfovZ08Kbr66+Xpzq/cF906oA5gzMQN5QckjUsJZVN8ZmQ4KjvtajUeg
	 uutaZ/1w8Wdqw==
Date: Thu, 15 Jan 2026 16:43:46 -0800
From: Kees Cook <kees@kernel.org>
To: "Rafael V. Volkmer" <rafael.v.volkmer@gmail.com>
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] overflow: extend shift helpers and add size_shl()
Message-ID: <202601151635.9C323403@keescook>
References: <20251128033830.331426-1-rafael.v.volkmer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128033830.331426-1-rafael.v.volkmer@gmail.com>

On Fri, Nov 28, 2025 at 12:38:28AM -0300, Rafael V. Volkmer wrote:
> while experimenting with check_shl_overflow() on an architecture with
> native __int128 support, I noticed that the helper always reports
> overflow as soon as the promoted type of @a/@d is wider than 64 bits,
> even when *@d is actually able to represent the shifted value.

Ah, whoops. Yeah. Can you add some tests for int128 to
lib/tests/overflow_kunit.c (see how check_one_op() uses:
	check_ ## op ## _overflow

there's a bunch of type checking in there but nothing uses int128, so
there might be more than just shl?

> On a toolchain and architecture that support __int128, this reports

What's the right way to attempt such testing?

-- 
Kees Cook
