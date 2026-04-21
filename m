Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D35D3D668F;
	Tue, 21 Apr 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777047; cv=none; b=mK8I/NUMukCtZEhIAfcl/KB40s3/0gzTa61e+zD2nIiXo4ALfL57S+oqLITzNMskkbHNzavgGBk4/k8djDw8m+wDq++FLWcpCFcbspJwAbs3RKdkYWIAlg9pwJYBQTrqX3vhbkpO37Os2O1Af4vCSr5JH3UfteW6JNuFOqGfwS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777047; c=relaxed/simple;
	bh=cmQ/TzlmunIJhADdEoHVA7NvJufKIU0doXpfCB934LE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D0MpDFJLpdIV9VPtdnstjFuplkHRA5pmk9iMsDyx86VsTCWZ4QTfx9iAg/GOV8hB1ZRfeJ8Aga4Lbi9hnIvqNI4GFwDoSXYWee7g/Jc9w9vN9gzpDVO6H9W/5QvZj3MTEI4ijkxe2SSzlIw9uLWJ7V+izSVQBof4ayGLUlsyyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJwB5YWq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJwB5YWq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2405C2BCB0;
	Tue, 21 Apr 2026 13:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776777046;
	bh=cmQ/TzlmunIJhADdEoHVA7NvJufKIU0doXpfCB934LE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BJwB5YWqZ6nImZWY3Dro4ZiVJuuxDqYWRE0tKOuzXj4GLWDTwfiPgfsWvq5OfPJ/L
	 pSk0GOooZF+2syT2gnFhoLozN7K1BZXtkC2MzG0lPkymbp4uRhbOX7pYELglFSH8BN
	 Fc5p1r1fOCJjHY8+NP03ErwXWc91K5vBpaJpIpUnhEqf0PV6YGpybttprpo1JcvawB
	 Yh0SegXzv2Yl6/yubibg51yCYSa3ulJx2hmh62t+XlYR31052XfNXKhryq+B0yfZVq
	 lZZkn/ODc3q1y/TDzuPPpovl7I7tZG8ktlH9AFPlUlKL0Y1/92IyJqaAgGprdknRng
	 3Ch0rQGE/2mkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F57393019A;
	Tue, 21 Apr 2026 13:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net 1/1] net/sched: sch_dualpi2: drain both C-queue and
 L-queue in dualpi2_change()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177677701024.2399510.3164974567553256757.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 13:10:10 +0000
References: <20260417152551.71648-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260417152551.71648-1-chia-yu.chang@nokia-bell-labs.com>
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
Cc: victor@mojatatu.com, hxzene@gmail.com, linux-hardening@vger.kernel.org,
 kees@kernel.org, gustavoars@kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, horms@kernel.org,
 ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 17 Apr 2026 17:25:51 +0200 you wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Fix dualpi2_change() to correctly enforce updated limit and memlimit
> values after a configuration change of the dualpi2 qdisc.
> 
> Before this patch, dualpi2_change() always attempted to dequeue packets
> via the root qdisc (C-queue) when reducing backlog or memory usage, and
> unconditionally assumed that a valid skb will be returned. When traffic
> classification results in packets being queued in the L-queue while the
> C-queue is empty, this leads to a NULL skb dereference during limit or
> memlimit enforcement.
> 
> [...]

Here is the summary with links:
  - [v3,net,1/1] net/sched: sch_dualpi2: drain both C-queue and L-queue in dualpi2_change()
    https://git.kernel.org/netdev/net/c/478ed6b7d257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


