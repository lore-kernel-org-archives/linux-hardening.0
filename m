Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C4390CA9;
	Thu,  9 Jul 2026 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614902; cv=none; b=q17L+qo2vLB8IBeiyhVM1OPnk9KL9cQo9mw+9O318EOhHIrB9bfKtKMZYMNo+iLJNga4EHmA5AEYtj81cwgtOr4v7acB8o1R0w2Jw7nA3mUmbWJ4/MbjfAUzeAPQTGISsfPlEWAE+nOMfBBQE6fYRzIEbHu+NgAZTJl4GWQo8bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614902; c=relaxed/simple;
	bh=aLu7u+oABB980v2Byj7fzcb9TmJLpvMJFDKWcrfgS28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2emTja8BdbPrxzguV7fmZzItmkrfo8PECO5oaxrdk/XHuAlr5XzvF0lghsRVRHuZb+2PYZvtLyyjWM3I+6szOebzCstog757WVkSsX18cywCMcnmVSshNvKGYlweYbW30zvUjv7hC3NkIfWkx55waxx3Xugua8M+TkeRjKf0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgEPUdxR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgEPUdxR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98E91F000E9;
	Thu,  9 Jul 2026 16:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614900;
	bh=en2jQU3RKZOxl8VHFH3AosXhXYEPlXT/YANUMo2uz7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IgEPUdxR4kV+JPNgLaiHh+FLgy+REXBSjTv5KcLc/zcYy4RxGFYOKEOS2T5QUYeJy
	 RKuA+GVhiNiypsqBdQV2V11gjMSK35Oh28mZymWq4zfbi5pmoFo1dEPZYSB7CFR4S+
	 ZmzxMeS9dSxVwN+k97bTARIhh246bi/PpGpCggULXrTFZ4wLgHGsphG6a9etvd2irT
	 USnuXRDk1ZoLFIleP26WPTNZK/4hKmZ+j/1OrwJXcZWNj7EXQDhXuQWTk+Soq5lDUT
	 /1OhRDs+as0NYWverC45vAbGL3e0b92q1mLGUp6JPzvya7dI8FI8s4VN1EbrJJQeY9
	 sidEUj/lHJAHQ==
Date: Thu, 9 Jul 2026 17:34:56 +0100
From: Simon Horman <horms@kernel.org>
To: Ian Bridges <icb@fastmail.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: Replace strlcat() with seq_buf
Message-ID: <20260709163456.GT1364329@horms.kernel.org>
References: <akiCtALVjd9TF8Xl@dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akiCtALVjd9TF8Xl@dev>

On Fri, Jul 03, 2026 at 10:49:08PM -0500, Ian Bridges wrote:
> In preparation for removing the strlcat() API[1], replace its uses in
> __devlink_compat_running_version().
> 
> The function accumulates a variable number of version strings into a
> fixed buffer, which is what seq_buf is for. The seq_buf is anchored at
> the end of any existing string in the buffer and each version string
> is appended with a single seq_buf_printf(). The output is unchanged,
> including under truncation.
> 
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Ian Bridges <icb@fastmail.org>
> ---
> The patch was tested as follows, on top of net-next:
>  - x86_64 allmodconfig and allyesconfig builds of net/devlink/dev.o at
>    W=1 produce no warnings.
>  - A userspace comparison of the old and new construction ran with
>    randomized version lists and buffer contents across all buffer
>    fill levels. The outputs are byte-identical in every case,
>    including on overflow.
>  - The changed path was exercised in a QEMU guest through the ethtool
>    GDRVINFO ioctl against a netdevsim device, before and after the
>    change, with identical fw_version output.

Reviewed-by: Simon Horman <horms@kernel.org>

