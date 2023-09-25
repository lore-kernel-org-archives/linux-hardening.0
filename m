Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B815AC;
	Mon, 25 Sep 2023 02:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96557C433CA;
	Mon, 25 Sep 2023 02:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695609023;
	bh=0jDwZ96nyJhTF4nmVXocUav9QlceaTK+fsd1hTcuQrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=prDohBtJO9880AllSqZPuVLeO5pSLOAWQukM68p11IT6YUwQ9CkWU7RniZFdEFV7E
	 Nt/v/hT+u3N4BN4a0HbN4afaVVz+Wc5rqHEi8AhyONnIqQ4G0nXT6y0xNvF566IWnG
	 rfNM2owzp6jW9j2ZlkeRCvm0MNWrfEw4q2VPV5JDiRKDhLicr1ku4TYyrxGMNNHB6T
	 HRHZafrHXNYBnNfuUbVYJFPHQ8G/R3TUHXZOj2TUg8d8ySkXAVDvKoWDwvTB0kOiCM
	 sadS1mh56zJBBPi9/Burjre+j9G0lOzNU0kuK5rWRGq0wqcGjBvGHUG63nollnp/U9
	 SUfr5gi1x70/A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79FA6E29AFD;
	Mon, 25 Sep 2023 02:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: wilco_ec: Annotate struct ec_event_queue
 with __counted_by
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <169560902349.21032.13563278253669519579.git-patchwork-notify@kernel.org>
Date: Mon, 25 Sep 2023 02:30:23 +0000
References: <20230922175146.work.219-kees@kernel.org>
In-Reply-To: <20230922175146.work.219-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: bleung@chromium.org, tzungbi@kernel.org, set_pte_at@outlook.com,
 dmitry.torokhov@gmail.com, luzmaximilian@gmail.com,
 u.kleine-koenig@pengutronix.de, gregkh@linuxfoundation.org,
 jiangjian@cdjrlc.com, chrome-platform@lists.linux.dev, nathan@kernel.org,
 ndesaulniers@google.com, trix@redhat.com, hdegoede@redhat.com,
 lee@kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Fri, 22 Sep 2023 10:51:47 -0700 you wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct ec_event_queue.
> 
> [...]

Here is the summary with links:
  - platform/chrome: wilco_ec: Annotate struct ec_event_queue with __counted_by
    https://git.kernel.org/chrome-platform/c/1aa8df90f456

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


