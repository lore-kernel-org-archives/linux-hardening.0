Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5B834BA35
	for <linux-hardening@vger.kernel.org>; Fri, 26 Sep 2025 00:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758845008; cv=none; b=rcvDTkREuh6JrO8DahuurRz0XmEGFP0MF20VQHy8qD/JJbF6pe24fufYBGzC+7tKwGp84Zm7WKzFDxuKC4AGexHnrvQGInWCyT/jUogHFQnH3EqpPGVaUXbcEigkDMez13tB7NjjQ/dVUL2Oso95k43DuR1CkW8XJnR9rNoVF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758845008; c=relaxed/simple;
	bh=dIp//LwVCbYYymqTBM3qS8qb2jP/eg0Jf9aiSto0fc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUzU4n4drAY/+/hzZ8UPsTpOqwTYv/vcKi2J6yb946nGZ9uukGg8q9hB+2mCEnUcGyr56VpIYmDErwLEvpamiPzT0sappYXZmlCP+eznICzSnAXTXW0/Je/lgoNjnUZHI8X8icxlvmpLzS8Q3d9jyAoLmH2CrlYy4n6B7AV7stU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU4HQhb8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU4HQhb8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78531C4CEF0;
	Fri, 26 Sep 2025 00:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758845007;
	bh=dIp//LwVCbYYymqTBM3qS8qb2jP/eg0Jf9aiSto0fc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DU4HQhb8sdQyEfF/dpL4osDMBgVOjnrRjg0i73ARw8Y/vL3AXKOgMFkd/nM1A9ZYo
	 09+SrWe0/B2UTD26q96jv82st4jaUtNPTXiSBlevCLRNjJuyj4/SgTLeffQGNGtcA0
	 hWLV6kviZk70UEES6ehhsMXOnXO6OnWE3CBB2UsAyiaoKDnXpe9EhDYWhnbuyvCOBA
	 17cbdDiYwVLgohxkzA4DvD7X034N+GBCgE/YNkfDxRFVfNK8JGJYjJGhbV9UCTwTuf
	 jmvChVsQlAroQBOEHXq7yNYjCsowqW6pw5+dsnmL0xabElQCRQgg71h9OS6o8E/+Dr
	 FQPUoox6/ZYeQ==
Date: Thu, 25 Sep 2025 17:03:27 -0700
From: Kees Cook <kees@kernel.org>
To: "Hill, Steven " <steven.hill@collins.com>
Cc: "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RFC] gcc-plugins patch for compiler versioning.
Message-ID: <202509251701.0CC2424@keescook>
References: <BN0P110MB2020D78705BB39062BF8D107FD1FA@BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN0P110MB2020D78705BB39062BF8D107FD1FA@BN0P110MB2020.NAMP110.PROD.OUTLOOK.COM>

On Thu, Sep 25, 2025 at 05:00:35PM +0000, Hill, Steven  wrote:
> Hello.
> 
> Would like to have comments on the attached patch. There could be another
> option for checking both gcc and glibc versions. Just wanted comments before
> doing anything further. I am not on the mailing list, so please CC: on any
> replies. Thank you.
> 
> -Steve
> 
> 
> From b1ac0805d70aaa2e1500a071f63c88bcaa76754e Mon Sep 17 00:00:00 2001
> From: "Steven J. Hill" <steven.hill@collins.com>
> Date: Tue, 23 Sep 2025 18:21:09 -0500
> Subject: [PATCH] gcc-plugins: Relax constraints on plugin compatibility.
> 
> The compatibility check for gcc plugins is too inflexible,
> and a lot of times wrong. Add ability to let the user choose
> how stringent compatibility is.

Why is it wrong a lot? I'm not sure I understand what problem is being
solved here?

-Kees

-- 
Kees Cook
