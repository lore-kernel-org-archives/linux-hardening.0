Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB327E
	for <linux-hardening@vger.kernel.org>; Wed, 15 Nov 2023 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkanIWO1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5705C433C7;
	Wed, 15 Nov 2023 04:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700023957;
	bh=TOROuUKbGVkHbqlD7MOJvSa09ZuXX1ZO3Dc3MLy4wXg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EkanIWO1xNGbYLSyBRxsdEFy1OTXQ1MqIcjIulwd2b06DoLIvJ+G9sPYBCw4JZMPf
	 LQ7TgreU7NUvSExvM1df1lPD/qP9h+jAsmswYvDQb8tS2ISE7tMuok8/TTvSpofCQ1
	 OF0lyxqfR2jDavvUNkBVy6v0AxX5v+XTMvBZh4p0WN53GCaHLwKxMdaqwNlKvJNUpe
	 MV9+H75jpz6I9GS5uc/l+Xqna0Bv/eGZyp/NNXUXaz1qsrWDWfWxFR0Ah5fn87keej
	 tkgutuM+tk5ICX+oorgouQRsKua16cSwlRyvCcRPDNipkbvMH7A1ztTFXKkxvlrFzg
	 S66tarN/tsx4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A0B79E1F670;
	Wed, 15 Nov 2023 04:52:37 +0000 (UTC)
Subject: Re: [GIT PULL] hardening fixes for v6.7-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <202311140940.5D358293F0@keescook>
References: <202311140940.5D358293F0@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202311140940.5D358293F0@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc2
X-PR-Tracked-Commit-Id: 782ce431613cf08c3a00dca42ad925c3b1108d09
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
Message-Id: <170002395764.9863.2294945632318566793.pr-tracker-bot@kernel.org>
Date: Wed, 15 Nov 2023 04:52:37 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bill Wendling <morbo@google.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Kees Cook <keescook@chromium.org>, kernel test robot <lkp@intel.com>, Konstantin Runov <runebone1@gmail.com>, KP Singh <kpsingh@kernel.org>, linux-hardening@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 14 Nov 2023 09:41:28 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
