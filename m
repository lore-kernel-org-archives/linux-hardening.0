Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8F1311946;
	Sat,  5 Sep 2026 19:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788636491; cv=none; b=DGjL0HpJ5OUh84shzwgwIyFArD+u89XSIdP/+3O9w56q7a2K8GH4e01QLgTbejS/jegGqvQzSFnRI5LWEHmCUBtnGhNKQ/9bwm9WD5og44DtnPL7xK3Z8vqoO+u8U+oxY3gGTJ4GZDkI9xcor9JOpnawGgz+rm3mI/cCc+qFzbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788636491; c=relaxed/simple;
	bh=hEUsTF5GsFKcqMBmQH8mKQaHpxTLacLHdVBI/gVB42c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCj7BUr86N5NUPKkgGVjdyt4Cbb1hrNNV3rZ8Onw63svgNFkLoDfIjSLaENkH27XMqFtLBbJfmpb+DKQWA6fKyxWCQ+tEre7m1T7h0N6S2AEqaXjX9f8KAQVUt9RhOehn2Xl+Xmj2PUG2n5D0etwuWB0Ayoc6+XjIRLS+1CmRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhVKUknS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhVKUknS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3411B1F00A3D;
	Sat,  5 Sep 2026 19:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788636489;
	bh=vcuOJLKUWaTWcD3DSDMUl/fMtUKkAUu9OzN8KRhhrPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jhVKUknSh4flKM4r2BrWzOv+R/QLB/0mBYxFnYnChER7C2bVM8fjXHyvQVjIvfFwh
	 tSCUnXSTAFWLfNcfDTUPQGDXx0VD2FEnpSCYi1d4GHkS3b6CBH2cGU5/1dCgYgRfW6
	 oe7iOLeh93MrcsT4cIp8Mu69rP0VLRNgoNJyoy0p95FDnMkQoPEjUz69Q1SZe8ewKd
	 qtrc4i2pWBjc8B8wUzg8/uP19EEat4bBxGYq57cCvAnPIJrOiQ/UUbIt//CirEtJEL
	 L+E8zoX567Ok4RAKw3fpxPbwlzn1b2rIdYyWI0ImpfZ+TFrFjQtdDGP2Yk/g0AQ/Jg
	 EjZliHjz2V0Pw==
Date: Sat, 5 Sep 2026 12:28:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Xuanqiang Luo
 <luoxuanqiang@kylinos.cn>, Tim Bird <tim.bird@sony.com>, Zihan Xi
 <zihanx@nebusec.ai>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] llc: do not run the state machine on out
 of service connections
Message-ID: <20260905122808.1696a959@kernel.org>
In-Reply-To: <20260901210308.1173180-1-kees@kernel.org>
References: <20260901210300.i.590-kees@kernel.org>
	<20260901210308.1173180-1-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 14:03:03 -0700 Kees Cook wrote:
> +	/*
> +	 * An out of service connection has no row in llc_conn_state_table[],
> +	 * so it cannot be driven by any event.

Networking comment format, assuming the comment is indeed necessary and
not pure slop.

> +	 */
> +	if (unlikely(!llc_conn_state_in_service(llc->state))) {
-- 
pw-bot: cr
