Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9415F2DCBE3;
	Tue, 10 Mar 2026 14:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154128; cv=none; b=YujFuJGqJeXpJmPwDpQVsXWFw+tdQqshiqZGTtTYJN7FFEasXr6wSZjh0rzjVcd+psagJwT03omBD9Re46D/H79q73aCeRmsd6FyDBZfI8jDhcrYJnR8UmYFIDJa4mlcydrGhaeVgigVEYdcUm1rmV7Nh9+D3cmmcT62VotygRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154128; c=relaxed/simple;
	bh=GOP/hOYafpu6PlKBqAfnruTjFGMJLr2fvFuUOLKXkX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFHoxMKqG1sg3bCznKvZ8bK40rPeDx4uVH5mOjrJOov0U86t0guS/9qnwmP/o9+Ep1pAZJzYvnj7My1lj8YqOO66hAHpJj75KV0DxLTF8IK6GNpdlP5Gs6GvkEtUF5GJ5mkQc4i6dIWmcfjQV7coDE2jhVJEt1s0qlfhD58raz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPgiybm7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPgiybm7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5A7C19423;
	Tue, 10 Mar 2026 14:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773154128;
	bh=GOP/hOYafpu6PlKBqAfnruTjFGMJLr2fvFuUOLKXkX4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GPgiybm7vPguv1pxX5lCJU+ZRCMHMgM4rW8BCePv+jZ1xDgVi/iqjFv57C4bQdb4I
	 jKfqH04Ny50GrbCEcIjbkIzgFyUiqtv5Xm8DqM2zGtF6hDT3hT0BfwGwAY9XzK+ASA
	 uIAUcMtGIhJ44BfTV2qe/x2Hqy2FrmZoVnpOeCZ7IZpmfRd6QfHNAlW6Yu0uE2QG/5
	 v/Wt91pil/WX4vf0UjYvXn5uTtRUQCSS5fhl0qBfB1K2x30gX9QQdi3qirZTzQ2+/i
	 XYgQAoj7DOVifnzOImgKO8U0KbuAZ8JdZu5pckk4gPNv3kf5UggDsuNNMtQ2+t0WLN
	 le70mo+DUB17A==
Date: Tue, 10 Mar 2026 08:48:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] nvme: Annotate struct nvme_dhchap_key with __counted_by
Message-ID: <abAvTZ-PC8zE6Tbj@kbusch-mbp>
References: <20260303213102.86585-1-thorsten.blum@linux.dev>
 <20260310142049.GA10134@lst.de>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310142049.GA10134@lst.de>

On Tue, Mar 10, 2026 at 03:20:49PM +0100, Christoph Hellwig wrote:
> On Tue, Mar 03, 2026 at 10:31:01PM +0100, Thorsten Blum wrote:
> > Add the __counted_by() compiler attribute to the flexible array member
> > 'key' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.

Thanks, applied.
