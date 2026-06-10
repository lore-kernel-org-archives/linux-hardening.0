Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207B87E0FF;
	Wed, 10 Jun 2026 01:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781054418; cv=none; b=N/CbTTTa5bVpTRTOsnidQgON1U5XvKlnOZZ9aWHQQIUw4oUVHKfb2dESlDqYqbP3ltnA3bgNkc+foZXnvVIN4gy8NXbluR4m+9teT0ikw/gQ/QCzVsYcxG1t+UHddxBX/aCsDzhIWzy/0s8ZlUgGCXL+K6AQ1Gu60sw4HwlOny8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781054418; c=relaxed/simple;
	bh=CHLiqPsKNMX5exPT742i0+3IE+Iy/k4VLewc72kYpw8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hb5zvjrvTiFzHyzWWc2lOmtJIz7yV1BqrQmJVjQDZjWxY7EUFpkVpv/NbuvYLL5J+kOhn86r12cC6wskZIbmbcOd7ypOHBHjWpOISrEY2DlamlnEw0mAiezzL4l1tADoKRB27uL1eyaAkI/tgLxja3iBZDU2Xp0+cbIx44UJoXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUtOg2mR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUtOg2mR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B051F1F00893;
	Wed, 10 Jun 2026 01:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781054414;
	bh=aKGhdlzuvfHlB4+p9iqkgQqduQF9ViQTH2yVd3SVtuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eUtOg2mR1lCcDK8GHRNBijPvBxSw0/KeFz0ihiof2G8EChKTtyN9VTuNEEzrPzHsH
	 +wJ6kG6bkglUnVdSedQRwvvdcD+KWhL4+Uyj/M3EeVXCKLhjzucWbId1uqr6nU4+x9
	 mjEVsZqO1uJLBdXxIJ3IHoYRO0WKYxtX38JPRyOj2dOGFEa20tkAeilGfLH+GbmTc1
	 Fn4O6coR4Wjm5t9oIIiAud2LQgks9rgWD/TmOfzJJh+7fEMvY2s0vE3h9XuAaYTniu
	 noPxj9tWbhoYDOYhcGfOJOsZRz9Nivy5AuSqSAltNWjvNgXrMGeZKNx5iPWikLOT3S
	 8renqt1l/1NQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197403930A12;
	Wed, 10 Jun 2026 01:20:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH next] drivers/usb/atm: Replace strcpy() + strlcat() with
 snprintf()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105441263.2779729.6672573959508250060.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:20:12 +0000
References: <20260608095523.2606-36-david.laight.linux@gmail.com>
In-Reply-To: <20260608095523.2606-36-david.laight.linux@gmail.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: kees@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, arnd@kernel.org, 3chas3@gmail.com,
 gregkh@linuxfoundation.org, castet.matthieu@free.fr, stf_xl@wp.pl

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jun 2026 10:55:20 +0100 you wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Avoid string function that are due to be deprecated.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
> 
> [...]

Here is the summary with links:
  - [next] drivers/usb/atm: Replace strcpy() + strlcat() with snprintf()
    https://git.kernel.org/netdev/net-next/c/41d3e102edc2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


