Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0785383CD9;
	Wed,  7 Aug 2024 16:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047504; cv=none; b=VcOm98/N1YVXDNUiJS31KywufSkmsHSpJn7nPKrMXag+l4NaO7eM8TNZXhaWL/7V5UxmmQzqbSt8UWW5f1dH83DyRApy/O8op/YdjsQl4aHb1wOZwutg5sAhiazAxGOOuY3DkxtVHfy1sZvd5gkKAfAN4DAx9HJ/l4QfmSvfUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047504; c=relaxed/simple;
	bh=ADvqYf2IAgJCxvm3IizYlbyKRZJMCiNMRngX7iDTyYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdXYktfBZhEOrr3qqZKPD8OersXLNbhuI9Jx9tN8OS2WThkPSHJu5eipxrpU4O46OygvwKDjbcMnI5vhir/51qwqUAWGsmGky5+whChueGUJCQUM25WqcU+LwX+EwHfkCRGcTpsmt9hleJNQZDpZqU95yCE6PJ9qu+dLsUsIm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ue2pIJz3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ue2pIJz3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9BEC4AF09;
	Wed,  7 Aug 2024 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723047503;
	bh=ADvqYf2IAgJCxvm3IizYlbyKRZJMCiNMRngX7iDTyYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ue2pIJz3gmbllMOBW8CqCREpLWkxsS8EDIwd/HaU4KNA31Ev52DOxOnmSGLE7MADC
	 mFwEQJjR4THVKhZZdzZidsIRykKt83xzMpwZE//guDTWa/hVg33+G7qhNsVIzoDPbT
	 TSTQtjl/QXBezsUZriHk3wErSefEpddqvTFGzvSR1Cv6tV+OnylLTFMdQ+o/bCo0kf
	 tXYx9jKkqrEieP0CNpLTnqpiVln5dwxup0B3IafWDla2xhw51Q+5bpfs5etc+XXgj5
	 y3sYUGnPIHuxeTQM2YZ6K1tsyfGvVrXTlxtms647Df9kt2fhiWak58QD7w9fh+7IVw
	 mFMpyd6v12frA==
Date: Wed, 7 Aug 2024 17:18:19 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] sched: act_ct: avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <20240807161819.GA3006561@kernel.org>
References: <ZrDxUhm5bqCKU9a9@cute>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrDxUhm5bqCKU9a9@cute>

On Mon, Aug 05, 2024 at 09:35:46AM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the structure. Notice
> that `struct zones_ht_key` is a flexible structure --a structure that
> contains a flexible-array member.
> 
> Fix the following warning:
> net/sched/act_ct.c:57:29: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>

