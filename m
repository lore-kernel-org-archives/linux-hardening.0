Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89E1E991B;
	Wed,  7 Jan 2026 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767748418; cv=none; b=cwSWZ56mTWmpeycBtHT5bB9l1ozUkXHvW3ZMrf0AZwJhf061wh4J1Rr4mjrkvpkwC8hRZa91YpR2pMzkyxovJtMZu5JW8xsswUlUsngBm1tnW7MmyBl2wRsbvwoAHBivZZiPs3F+Xsco4M1FIh5LTfEk5k72TL0CLH3Abhh73Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767748418; c=relaxed/simple;
	bh=c6DhjuAYjJ60Y/2VxKFi8AXoje6Vb5o4elpRPJtXr3s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IucLN+o5ZGQmddclzlvhnQXsj/CWFQBk/EwoxlfvLygwHRQYakVjApR93jZPXQk/RtRc4pk68LwfcC8Z5V5rdAeYQdGDsKer39j/EpphXi7xtq+bKi8ronY2POTYU+NDEYakgovFBlONPlz2SI+u5eeQXbWttZ4dAdHk+9Uotf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ekv8RwGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ekv8RwGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCF3C116C6;
	Wed,  7 Jan 2026 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767748418;
	bh=c6DhjuAYjJ60Y/2VxKFi8AXoje6Vb5o4elpRPJtXr3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ekv8RwGNvnrQXDDqSJ3298GXsIX7yHUzdcm8nRXe+XrnqVSJin4yjn+dhDlGCYKTb
	 IKcLiGz2oJQMfUty//y+YSpp+LVigFCh0viwB7L5svBN/1ypldvQoln8aifD6Pw/oY
	 LqCkAaEshYAE4G00UpiGYLYnBBGj9LeziSytMTOz2ul5HCj8+gIRv7dGr2TZIF/A2A
	 soImn0E6ztRA1SZhltpKLqc67QBMzJyWPqyyO3Mkj4eEM9LiOs1KTvpH+zD71F8W5p
	 SawRqmKnO57c7D2o6EF65uHrFNZAOL1xyu5UFHh1aRyz2s54LmjFVA8Qy+C3s2UHDq
	 nMFwMo1tLSBtg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59BD380CEF5;
	Wed,  7 Jan 2026 01:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2][next] ipv4/inet_sock.h: Avoid thousands of
 -Wflex-array-member-not-at-end warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176774821527.2186142.1995050269976667394.git-patchwork-notify@kernel.org>
Date: Wed, 07 Jan 2026 01:10:15 +0000
References: <aVteBadWA6AbTp7X@kspp>
In-Reply-To: <aVteBadWA6AbTp7X@kspp>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 kees@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 5 Jan 2026 15:45:25 +0900 you wrote:
> Use DEFINE_RAW_FLEX() to avoid thousands of -Wflex-array-member-not-at-end
> warnings.
> 
> Remove struct ip_options_data, and adjust the rest of the code so that
> flexible-array member struct ip_options_rcu::opt.__data[] ends last
> in struct icmp_bxm.
> 
> [...]

Here is the summary with links:
  - [v2,next] ipv4/inet_sock.h: Avoid thousands of -Wflex-array-member-not-at-end warnings
    https://git.kernel.org/netdev/net-next/c/c86af46b9c7a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


