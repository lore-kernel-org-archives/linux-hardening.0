Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F54D29A
	for <linux-hardening@vger.kernel.org>; Tue, 31 Oct 2023 05:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amK94fn4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B5160C433B7;
	Tue, 31 Oct 2023 05:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698730953;
	bh=wMKsm2bxFfPf2c84oJ8HXZxSOsEDlsYQdrnM1+U1hMc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=amK94fn4j0ZOv2Yavumfg4ti6AcnEv0N1NURZOe0JeEWe6/vLPghWFE8LADexbKyx
	 n6jazaflWARNAQIJojMdDWQVm/apb+euB3Ozr8YQkpBy+H8sz1TD0Es9E7NG2S4BXy
	 mVsAsDrEkYYFULQC9b8Xt/6Tg9EmsUqEgCfHxCifDxDkeLBsR4bQZol1fszBOuRyfe
	 aXMOSQI9xsab8gsaiho2Tip9emO2lFZ0UMxJOuetkMDe3uW2Muuu8RRwDVBb1dDcYV
	 F+/orplP+Ve1jbfiVu1xtZo7wku412DG+MNkvDkWfib8VuVhG+ZSexrJRjRDJa5ZWr
	 W9z+Sb/oOj0HQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F411C4316B;
	Tue, 31 Oct 2023 05:42:33 +0000 (UTC)
Subject: Re: [GIT PULL] hardening updates for v6.7-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202310300946.C0E11C5@keescook>
References: <202310300946.C0E11C5@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202310300946.C0E11C5@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc1
X-PR-Tracked-Commit-Id: 9cca73d7b4bfec75b2fcef751015f31691afa792
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: befaa609f4c784f505c02ea3ff036adf4f4aa814
Message-Id: <169873095364.17204.11806766104260276539.pr-tracker-bot@kernel.org>
Date: Tue, 31 Oct 2023 05:42:33 +0000
To: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Elena Reshetova <elena.reshetova@intel.com>, Ricardo =?iso-8859-1?Q?Ca=F1uelo?= <ricardo.canuelo@collabora.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Justin Stitt <justinstitt@google.com>, Azeem Shaikh <azeemshaikh38@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>, David Windsor <dwindsor@gmail.com>, Douglas Anderson <dianders@chromium.org>, Hans Liljestrand <ishkamiel@gmail.com>, Joseph Qi <joseph.qi@linux.alibaba.com>, Lukas Loidolt <e1634039@student.tuwien.ac.at>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <michal.simek@amd.com>, Mimi Zohar <zohar@linux.ibm.com>, Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>, Stephen Boyd <swboyd@chromium.org>, Vasant Hegde <vasant.hegde@amd.com>, Viresh Kumar <viresh.kumar@linaro.org>, Xiubo Li <xiubli@redhat.co
 m>, linux-hardening@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 30 Oct 2023 10:02:53 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/hardening-v6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/befaa609f4c784f505c02ea3ff036adf4f4aa814

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
