Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB1E2ECD3A
	for <linux-hardening@vger.kernel.org>; Fri,  6 Feb 2026 18:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770401795; cv=none; b=bs8/ysWPc/laogYH1mel8rfp6nVec013MDxnfBV8lhSAsOGNrPxnWUKJEET3ehYD+MIhT2dYMCI+gInrA2iqoKGzCQr0ZqCv0iGjDVdY8jDb9TVniEGFhIpwIMF5KEA4Z6u1V22fMmuxSED4gPzkkOlgic9tzG7M7YpO3W3SrkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770401795; c=relaxed/simple;
	bh=PZwINrWAuS1wQHYArI/H9HLcqcKzUHI2zFqZ6NVXZd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ/l1y4qvNGoTSpWWk7r5C/P/CbQ7F1KikSfxHNYFWn4Y+57BqP8yUC4fN1d95hMW9Wsiygk8T7PlVfaD1UAU+JwHVF0PheTwLpwLIu4L8LGRJhTxI/2ZXqbVJ9wWWF1QLHqZcckDpVN0k4k1eyTvfvwDGXWfLfilt72wcjR09E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQxBXv0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQxBXv0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CB3C116C6;
	Fri,  6 Feb 2026 18:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770401794;
	bh=PZwINrWAuS1wQHYArI/H9HLcqcKzUHI2zFqZ6NVXZd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQxBXv0MM3bY7K8XWMh28vPegX/o6ja8a4NEPexqSjXZcld+5XfhJFua1McwuZzmn
	 Mqo5se8cHeKF0p+whVw8PEAxjajtJ/KRVVaRj3lb4cYxY4swP4XhGc0BQXqmB/DgNA
	 gxq2k99vqngbz9uoGXaI5Xh7dWHu2sWseg1Z3fR30wXXaPHsY7vsdprJM59YmuWw6/
	 YFhTKhBgfe9pC4Zw5cQh0B9TQ79PbhUmc0Gb3V8qLrnZnKp9tSzDD7nbywf0+eFI+0
	 tgIWODZ6dta6wl7Ma9auTWGSZApciwyrusxWIwxkDChhv+RQKDMn2khEgvofnZRiwp
	 BUqJv+g9/+K+g==
Date: Fri, 6 Feb 2026 10:16:34 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
Cc: Indu Bhagat <indu.bhagat@oracle.com>,
	Claudiu Zissulescu <claudiu.zissulescu-ianculescu@oracle.com>,
	Qing Zhao <qing.zhao@oracle.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4] Fix sanitizer attribute infrastructure to use
 standard TREE_LIST format [PR113264]
Message-ID: <202602061016.DD543146B8@keescook>
References: <20250904174325.it.487-kees@kernel.org>
 <CALvbMcAMWW1ewkszu9nYEaY0iA=CsUh+JFm1pzpnkXvzp9dP5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvbMcAMWW1ewkszu9nYEaY0iA=CsUh+JFm1pzpnkXvzp9dP5Q@mail.gmail.com>

On Fri, Feb 06, 2026 at 12:05:04AM -0800, Andrew Pinski wrote:
> On Thu, Sep 4, 2025 at 10:43 AM Kees Cook <kees@kernel.org> wrote:
> >
> > The __attribute__((__copy__)) functionality was crashing when copying
> > sanitizer-related attributes because these attributes violated the standard
> > GCC attribute infrastructure by storing INTEGER_CST values directly instead
> > of wrapping them in TREE_LIST like all other attributes.
> 
> I am going to review this over the weekend. I see it was not reviewed yet.

Thanks! I'd love to get this landed (I don't have commit access).

-- 
Kees Cook
