Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA402F12CE;
	Tue, 10 Mar 2026 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773108024; cv=none; b=QScOOLmnWLEWH9C08qg5/HwhMJb+pzwQIljU+9Ild9LRrFCnqWvQG6BniqcqoEMvUvXv4DxmG1IIj03ktovLi/2MXG+tc53UX/RB32LyjWARoeBrYo9JLySNYLFdZb3GJJzFdSQ5JQ4KgmUX/fW+VZ4ZPBtJgpn7s+Y6OoNWV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773108024; c=relaxed/simple;
	bh=vuv2ofYk2ZYEuyhZFbh1O/E/DkqfQvV8IcNt51pgGXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GmNr6HMb6GG26zObKxOMez1eIB6b7hKJKQi/Rb24hWG7/CKIl1ISP40TJpLo3a1aDVBQPUhI75wbRCI7vCn1dlP1zCMD2jLogNx2fHVCRxtQmNCYoeHasExHjLfJWd+Ff4W1Gf2sc4mO4ht8ppFpoV0DowBL6fRi7UftIXSwcI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MivJw4u/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MivJw4u/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7DFC4CEF7;
	Tue, 10 Mar 2026 02:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773108023;
	bh=vuv2ofYk2ZYEuyhZFbh1O/E/DkqfQvV8IcNt51pgGXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MivJw4u/JDT86zCzrE6GqHppXRWJF7j81cofL1QdNzmRdz8Jq5baozhdhURXF8bLZ
	 HTneE66ldeGi+rLqwpIRIXyvjTfH20U98O++6kAL+Hib9x6TiMOzp7b1tq7wxe1QOh
	 7lY650w1PtB0EDtQ9JC92lwWAUqUlI5HrbDPRcmGsEppSk6IR83Wf35git94YUaO3x
	 KWs7UN5GY8AZyCSUx4VbVUaTTOLzl3Dqz4hU4+xPX3GaHujVCBxHwYG98Rgrjn5j8z
	 MvuD8G4Or1PvWHts2lM4/qhI6N8X56jvBe/K3F/Z0PTIZn9xLANvODbSj4GXaUcTn5
	 l7JK0o7Pb78QA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E98CC3808200;
	Tue, 10 Mar 2026 02:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: rocker: kzalloc + kcalloc to kzalloc_flex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177310802072.2022132.2512105974511017986.git-patchwork-notify@kernel.org>
Date: Tue, 10 Mar 2026 02:00:20 +0000
References: <20260306025449.12333-1-rosenp@gmail.com>
In-Reply-To: <20260306025449.12333-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kees@kernel.org, gustavoars@kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Mar 2026 18:54:49 -0800 you wrote:
> Combining the allocations simplifies things, especially the free path.
> 
> Remove ofdpa_group_tbl_entry_free as a result. kfree is shorter.
> 
> Add __counted_by for extra runtime analysis.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: rocker: kzalloc + kcalloc to kzalloc_flex
    https://git.kernel.org/netdev/net-next/c/692743073580

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


