Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9944A23;
	Tue, 13 Aug 2024 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723510529; cv=none; b=HV13tuDLlS0iYJ1znTNwXVDSDAuZi4El0pyy//jc7tPkqikmB/dJ6Ph9TF10vR8d2RCSKnvCFWm9gb1kJxnwZK21Aq0fhJ+ZySepTN4yNsTbAeHIp/MC6F9GuYYL+getXAKsCCoDYWlLwSslDI18IE7LdBHwJyAqsooDyUXRB+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723510529; c=relaxed/simple;
	bh=DFzDUmeCC9VBR/ZhGIFh0y3jhD9i74BxNimb9cHC8fY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RlX1L1pHefdj4+NL7RlsjnOOsQji+pjQuDwMyfZeZ90qoQRIqwI/pQccm/bTdYeUdzdj1Jfy+uQB68ZKaZBVshCwFxc4I/iohdJnDyzcdpvtI6gs9T7tpVjVxMkXkw3MGlkAW51F/900bgggsxiiRZzC2b6CQ5RwKKXYNXiXlUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQ3IAiAj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQ3IAiAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1B7C4AF11;
	Tue, 13 Aug 2024 00:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723510529;
	bh=DFzDUmeCC9VBR/ZhGIFh0y3jhD9i74BxNimb9cHC8fY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nQ3IAiAjglMzUKDNp3y/Lq8dSIFV92aZbs4JgD5DZQIHbtdLatV8YOnSIBRvX38rs
	 arJDdQpB+RP2nbFSl+Z+W2rD4UwPZBF8v08nfIxm6SHt9u7gfSk0abvUEgsHjFLU8U
	 q95p+EL85xRXy9JEh7q3t9XoND2mjiKItz6AZqYsSL0v6YUGWLrJF2YUlwJnZEO/Y2
	 8sxWjEJQHcUkHX5Ygq5wLvaOdo2bdBwwc8qIFTXmt+75jiIfUYJRUx0XnVODQVQ1tv
	 iDHNISXMePk68rfiGYCGnX81rrp7hs/QIJRv0CTx9d/l1nQGcHQ+PSCR5wvnOPm5aK
	 qk1nf1dHN1Zvg==
Date: Mon, 12 Aug 2024 17:55:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Potnuri Bharat Teja
 <bharat@chelsio.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] UAPI: net/sched: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20240812175528.32a18bee@kernel.org>
In-Reply-To: <20240809094203.378b5224@hermes.local>
References: <ZrY1d01+JrX/SwqB@cute>
	<20240809094203.378b5224@hermes.local>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 09:42:03 -0700 Stephen Hemminger wrote:
> Tested this with iproute2-next and clang and no problem.
> 
> The patch might be better split into two parts?

Fair point, a small two-patch series would be ideal.
-- 
pw-bot: cr
