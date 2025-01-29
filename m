Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779261B423C;
	Wed, 29 Jan 2025 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738180810; cv=none; b=C4jVLxlrbLWyKBJpWMU9fFsPStPhZ03v8lymUCXeILUOsaEXtdbkVnHqQqNV7vhUonL6O9EvYIQyig9yl7hS8GjZEn54BvM7bwJAElA2+Tj3kfHaP3Fzmwfo2C2neRG5jjrYrLjUUkGyurF9cDVnc93yGflYZKiPxOXAE3EXUOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738180810; c=relaxed/simple;
	bh=sMmIhnqkNXVngAsBEqt4Z0JFvE9J1WFviDTRkxPthjk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=K/o9Q4zM2D+qzq6Erd52XOUWuleHUr4mavcI73aOAmRyrrSeQyH3OKtIdxohc6PwxcfuF0R1c0zfubvKmUGSx/ddR249lHBbU6dQPtWp9CINt4qmQF5Xp/g6sWJI1Hk5YULL1FRPTBF/jZcg7ZOzX6XaWav9M2iUrjPOs2kR/Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0C2bCvk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0C2bCvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D020BC4CEE0;
	Wed, 29 Jan 2025 20:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738180809;
	bh=sMmIhnqkNXVngAsBEqt4Z0JFvE9J1WFviDTRkxPthjk=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p0C2bCvkDgKPb873mjq4Lglziuj4nID0ThXJcXqN0bVpqYZbZDhHo5BIVB1TfYDXJ
	 evhK2UrMUeqfdUSC8qRpydZmA4rqNVPxMZ7j5d4IP+lrumpRc+q1+iQDKopYDb7Jif
	 inOIWGmLPJYM4eu/uRJKn5qrlkAguCKc9hC92eOfmza40r/hvKEC2QI3NxDOqGL4r+
	 sEwe4sBHmzUGofX06ukfM0KwwPLrBqhBg4KV4Xjo8p9oz5uVOvDQRjDbIKTpuwTPF6
	 Ty9zoT0kBxghN5z5vf4OLNiJU3BbY2t4nso3i9ZsHenuyw08q8tt83DtLmZtDbT+YA
	 /9eDCHN270bAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2686C380AA67;
	Wed, 29 Jan 2025 20:00:37 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl constification changes for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
References: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <kndlh7lx2gfmz5m3ilwzp7fcsmimsnjgh434hnaro2pmy7evl6@jfui76m22kig>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/constfy-sysctl-6.14-rc1
X-PR-Tracked-Commit-Id: 1751f872cc97f992ed5c4c72c55588db1f0021e1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: af13ff1c33e043b746cd96c83c7660ddf0272f73
Message-Id: <173818083591.411204.7885522737032067203.pr-tracker-bot@kernel.org>
Date: Wed, 29 Jan 2025 20:00:35 +0000
To: Joel Granados <joel.granados@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Anna Schumaker <anna.schumaker@oracle.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, Baoquan He <bhe@redhat.com>, Bill O'Donnell <bodonnel@redhat.com>, Corey Minyard <cminyard@mvista.com>, "Darrick J. Wong" <djwong@kernel.org>, Jani Nikula <jani.nikula@intel.com>, Joel Granados <joel.granados@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, Song Liu <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Wei Liu <wei.liu@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 29 Jan 2025 09:14:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/ tags/constfy-sysctl-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/af13ff1c33e043b746cd96c83c7660ddf0272f73

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
