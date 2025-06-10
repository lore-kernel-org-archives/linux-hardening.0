Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDD0747F
	for <linux-hardening@vger.kernel.org>; Tue, 10 Jun 2025 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749528950; cv=none; b=OXyuR58TqTad/oHZW+tYvc6NTDAVcPIy0HVnaFEUEnTWEsgR45wqYoXvhQgmZbWLu81nzGAz0u0uSMeNEH5SKF+t8mGJi9XlGwtsxajkc1jdZsgi80kyhzwvCKkewO3eeERb559oCfkmmgC48wx2MkyzDUmqyZSr7IIWmUXjT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749528950; c=relaxed/simple;
	bh=SNmQMfX8br1v3m6Ue7itdaBLQ/yx3M1lD48sr4R/J6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmqJlAQrewIN/TBjzmmcyor3z/2mBkqQCO1aQxwhPiir3Ju+OHHbjcA7Rj5oZhuEdLUZc9y6fhCd/YKKIzPm9EZtPp0degfKyMGq5LHWJBcQ8k1aWD4AOYYra0ITrRN/O+dm0dIKC/q/s+5M7rPrE0rao5F1sDjPoK97gIoS8pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+F7F0yE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+F7F0yE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46203C4CEEF;
	Tue, 10 Jun 2025 04:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749528950;
	bh=SNmQMfX8br1v3m6Ue7itdaBLQ/yx3M1lD48sr4R/J6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F+F7F0yEzPfqKL0TrqfMXXeklqTlnsG4CCmP4dKNRl9Cq90xxhD++itUyDG4aQGUs
	 oMbMIa8lR319QFWQKJFF+Ff5cvovzUnFjl2kxxRtcR14kY0ErFarqzjAtr2YysrCgP
	 lDsQIIcbIbTiA4L7sxUlfocSSMzsqE5CRdl7HcCrGcAUXCo9iSSzE+cxIy7jhu7Fbk
	 ksCbzd40NJDyFVpreicZuu8brXYtANRUAmwmV5ijt+pgR1fEP+/urR6o/TSUHsPUWL
	 gJgoDIX2tx0W4Jv+hUU4YdTejM2RWGtokspGoH7CuE020K2pV/K+jUDjsegEaoBFjg
	 q96OYf+YxJJyA==
Date: Mon, 9 Jun 2025 21:15:49 -0700
From: Kees Cook <kees@kernel.org>
To: Brahmajit Das <listout@listout.xyz>
Cc: linux-hardening@vger.kernel.org, justinstitt@google.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	linux-um@lists.infradead.org
Subject: Re: [RFC PATCH] um: replace deprecated strncpy with strscpy
Message-ID: <202506092114.01147457A5@keescook>
References: <20250607213006.7858-1-listout@listout.xyz>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250607213006.7858-1-listout@listout.xyz>

On Sun, Jun 08, 2025 at 03:00:06AM +0530, Brahmajit Das wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> This modification is mainly due to the concerns on
> https://github.com/KSPP/linux/issues/336, where it was mentioned that
> strncpy_from_user is confusingly named as it does not NUL-pad the
> destination, but it does NOT guarantee NUL-termination.
> With this approach/patch we can always ensure that the dst buffer is NUL
> terminated.

I think we need wholesale fix the kernel's usage of
strncpy_from_user()... first, how is it being used? Are things being
manually terminated? Are something destinations not actually C Strings?
We may want two APIs (like strtomem vs strscpy). And then since we're
dealing with user data, I would think padding should be included?

-- 
Kees Cook
