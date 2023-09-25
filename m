Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA9F10A3D;
	Mon, 25 Sep 2023 10:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC835C433C7;
	Mon, 25 Sep 2023 10:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695636990;
	bh=KVvlpa4bYGBggQD4XcK3KvcDv12hAr51NXqGZaUuzMg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ibImPGBafs9tjLpDiOv/cHZ68mLPdBE6XI97Mr/1zsVjV5c3jqm5nowXINFXMSoeX
	 UmGH72RSAmBb9yizxk3KXUgcv8PYRYXU4wkNmO7O9uyZA/rDU0f3VVpAqXCn86ebWO
	 QdZtg5AjADSsHU95ondSQWLU0AbEBQqVDP8ecFcxEFw3hkfOEW/ED5sLAtxiSkmZCR
	 ue8dOudRyk9ivqfLIMvc6l11ZIIpEd1p7hfXQgskDb8/8dqHngVWD5IWGZlkG3Hsfu
	 8dTMFz0dmzw0wHhbhklJWvZKfC8rnnO+RvgKowFEBg3GWz6pIBUAZOJDp8Pe6tm0Ex
	 DzzLz8qoIGLjQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCD46E29B00;
	Mon, 25 Sep 2023 10:16:30 +0000 (UTC)
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
 <169563699076.31071.3693415146979727291.git-patchwork-notify@kernel.org>
Date: Mon, 25 Sep 2023 10:16:30 +0000
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

This patch was applied to chrome-platform/linux.git (for-next)
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


