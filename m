Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE6829993D;
	Mon, 12 Jan 2026 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257016; cv=none; b=gfNlNjJjxzjdjoJT7zhkRSakqjbOeicZvOS7rbv/Pm1+dra1PjQyvP6t9MJJrtc2X3XjWPgI/9heYGo9aVz9fELSTLIu6HyZFK7S2naIsiVRy59x/cC8Rg1cA1pd+NW2dhTbIloj7JTqXUykIdKJQfFQj6YwsFX/ZGWXsgRvLmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257016; c=relaxed/simple;
	bh=2j3Vx+M4g9Jusk7+k8aENlOdAkyxuzprxevvyMNHoSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RIxjuzoxYbkCH40NIUgGS6unORFlb3Pa4CmMqmm6pQeW4XhvHGaHoB8ZUq2Kp2OLuYNlqxIdGsHjQtg9SPAQZvNv5NY4YlZr6ZcwXV+sbbJCfLYmv9non8huceSLkzCNl3gmz7G3R+hNlXK6M90JKg6kwUKGHkxgHmTn1bmbBpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp7Do5Za; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp7Do5Za"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42591C19421;
	Mon, 12 Jan 2026 22:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768257016;
	bh=2j3Vx+M4g9Jusk7+k8aENlOdAkyxuzprxevvyMNHoSw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jp7Do5ZaX6f/yV8Y3cJTXT9hlHclylbo/QSdlBu5vUULW8VtDvmkHEIky8E/KNXJw
	 UYdZIohtbEdRqw8yhYGynVy6lm5IbTlV1/92oVr8xpTxaVQBD3gmrXKlqgmj3ZPEE9
	 n4ZRAqK8jl9pQEhgs2Nw95A70VJuTMdkyZwbYNAI5pq2Ajy3bNbgs5rZauJgB3xsIl
	 h4j1CW/laZCN7Trh8YA1b/QrfWABoqmCsy+GxbiQIgKvZoU+Qmb5X+9qwsM1+nwg48
	 FFsoaReWLnXdZjs4IeKjwj2cy5SpQfRtA/I/acC3Hp0mJJ1NvDObkVKBP2yPtHcFSg
	 4LnEtqJ9UNcgw==
From: Kees Cook <kees@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Thorsten Blum <thorsten.blum@linux.dev>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND] fs/xattr: Annotate struct simple_xattr with __counted_by
Date: Mon, 12 Jan 2026 14:30:15 -0800
Message-Id: <176825701425.1928864.9814229430448280195.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105122057.2347-2-thorsten.blum@linux.dev>
References: <20260105122057.2347-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 05 Jan 2026 13:20:53 +0100, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'value' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] fs/xattr: Annotate struct simple_xattr with __counted_by
      https://git.kernel.org/kees/c/f2c5457dadec

Take care,

-- 
Kees Cook

