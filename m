Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663EE8626C;
	Mon, 13 May 2024 21:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715636018; cv=none; b=H25lDyOHxpGy+v6AKLNyGG7L9HwELzBKRNnQVPobNYK/m4gnaNea2xwLjIu7W9xw9uWQXeqx3Kbb9HYPckWMdkcFjOdLGD/Z8X8giq+6ETB0U4jqQ5J7XElB/f/PaESXWdOoyRxckEhiLp3cnecBYM1pFUEDzUQyWcEMh/nxfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715636018; c=relaxed/simple;
	bh=LZQyVa6HbF5aFesfL5KBEJjWp6Uo08VsW0BunuSRUB4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=MXhQAuYapx0nqxMmiGTBRqvI4+q9pRTO16VvI4YRnRMHCEFyNNDJiPMmh7GUk/TKbjCq6/epGhmvwhNZsmMjRyewPciq8irIu5DNqVqaB0wsrwaB3EZjQ6KnriyjeGYUIdgdfJgtTCs2QA67vVWfL+eY+WHp7UDZoQeolEKCfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pj8pPLzU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pj8pPLzU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44F49C4AF08;
	Mon, 13 May 2024 21:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715636018;
	bh=LZQyVa6HbF5aFesfL5KBEJjWp6Uo08VsW0BunuSRUB4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=pj8pPLzUq1LIYJUWGpB1MXCBwTRVvXrkcejqqLCp1hn35ObS7tWtqkZnFmR2LRC3t
	 fr+LjsVFW7qMMV35kpfO7SHy4Lj1Qq6fgaL8//vfKnqK5lQ4IGIED/yRm5ZsD63zBi
	 E6vxUc2rOh4mC9RTHOtiD4BYGLxhBC3nD2Sl48ZXF12yS58YCD+SKCOHeV5XEewYo1
	 C9tNYwDpHpQardSvgUn9JwqRyO8ibTnG52Xk8JhLbb1OFZEVzEEKXZ/lCZ3saatwLZ
	 VQ5Y6M4OPpq0cjxSJbQuYBpJ00XB6NslP3DZi7yVNtHAhlmlqiV3CIRwUJU2jB5p42
	 ESdp3YDuWRP9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 321DCC433F2;
	Mon, 13 May 2024 21:33:38 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for 6.10-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202405111234.6F2AB1F@keescook>
References: <202405111234.6F2AB1F@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202405111234.6F2AB1F@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-6.10-rc1
X-PR-Tracked-Commit-Id: 6d305cbef1aa01b9714e01e35f3d5c28544cf04d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 87caef42200cd44f8b808ec2f8ac2257f3e0a8c1
Message-Id: <171563601819.15304.1622750092646698226.pr-tracker-bot@kernel.org>
Date: Mon, 13 May 2024 21:33:38 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Charles Bertsch <cbertsch@cox.net>, Erhard Furtner <erhard_f@mailbox.org>, Erick Archer <erick.archer@outlook.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Ivan Orlov <ivan.orlov0322@gmail.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>, kernel test robot <oliver.sang@intel.com>, linux-hardening@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Marco Elver <elver@google.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Nathan Chancellor <nathan@kernel.org>, Sven Eckelmann <sven@narfation.org>, Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>, Tycho Andersen <tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 11 May 2024 12:42:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-6.10-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/87caef42200cd44f8b808ec2f8ac2257f3e0a8c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
