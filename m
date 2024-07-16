Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A573478;
	Tue, 16 Jul 2024 21:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166216; cv=none; b=lQn4Nezil9MLmYmeNu8ArNXpawpUC8rttq9diyVyIOV5uKcr33zqf/p8gtUX/5H+75eE5WjRFDV/xM8bmaPmhaXbD31ZuP88Jw1sOq6J2YfWWqIF+jcEDySFw754AuIg/yajBpBq+tS//yOt3jtU7o+1epIAWjXhEWZOXH03/S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166216; c=relaxed/simple;
	bh=/gP1d8Ynww6awa/zUsHTh9a+QkvgeBsP7vZTtNq8TnM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Jvry+N7U7wBw/TN0WfAtTwGYDEy7XLEh5VFO2Ydnz7K3L3d3jRbI0FhalaqCdCZPMwtMm1TGLYPnPo0/p4QHAREHF9TCJ4yNWnj9ZFnxJSbn6vhseXz6JnuMjpslizF7JmnxO5wv4GJEFEavdI7ow0j11B0q8bwYjOtDXMtg+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkS7ztxc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkS7ztxc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE039C116B1;
	Tue, 16 Jul 2024 21:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721166215;
	bh=/gP1d8Ynww6awa/zUsHTh9a+QkvgeBsP7vZTtNq8TnM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dkS7ztxceO2PmVSXD5C2Ajwjxi+7BK/uYAUzLtVwBiTDviXOnzXa6p9hyuHpe5Rgq
	 58LQvn3x5M5tChmOazReZVdA0QKtrqxT6Ck530o5zICHpjMC/y0pfE3UFC+kjIj7dN
	 Mm2pYYdn59hMHjg47PZGar41RuMKQAFq/JAcoUXKLUdokfrjewxfFs4KBiJPmhdL0C
	 6p7Ax3q10GlGpntMG+3w65e4MFcqFc0Z4UgBef51s2NeKzUeyNJTQ5x78k+u8nL/+3
	 G6nwh+APzIx2u6YhviNArvXBuaPofL6PX7fxQ4nYId4xnibI0582TwgVkzV00OIT8O
	 qFZNaV8u1N8Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B461AC43443;
	Tue, 16 Jul 2024 21:43:35 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.11-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <202407150926.4864BCABD8@keescook>
References: <202407150926.4864BCABD8@keescook>
X-PR-Tracked-List-Id: <linux-hardening.vger.kernel.org>
X-PR-Tracked-Message-Id: <202407150926.4864BCABD8@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.11-rc1
X-PR-Tracked-Commit-Id: 9b3c13c9ea4ecb2b95948f666560b8df8f358b40
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8050258bd1eed0f77dd7e3fa15feb23bbcc38e63
Message-Id: <172116621572.23491.12812023645156996571.pr-tracker-bot@kernel.org>
Date: Tue, 16 Jul 2024 21:43:35 +0000
To: Kees Cook <kees@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, Jeff Johnson <quic_jjohnson@quicinc.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>, Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jul 2024 09:29:29 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.11-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8050258bd1eed0f77dd7e3fa15feb23bbcc38e63

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
