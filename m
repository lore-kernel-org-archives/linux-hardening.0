Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6392C21F4;
	Wed,  5 Nov 2025 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762348757; cv=none; b=bqIExXeIa1Eb0r1rlvwr+7FxaMWBIAds563wh+KF9caX8IK5DG0yoBd/RNxuWCcNiUZcNqyMtRtYFIztm4NiCkmuHRiKsbV9NhxPNI+BNcNEgFHKdPcyp3Qy5mZv9trVLI/nImilDzi33Zn+/1KCDhskK+D4edkmZuoMi/r1u/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762348757; c=relaxed/simple;
	bh=6KUe+jJWbRnSON46jSCDp6lAvrbXJpLVfZLY1Qy5h0o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=W+a8HII4C1Gf4aZl9FKEOw0KX8Ze/aGz6QNzwoFL8KeiwIwlP+3cH3SxT4/2rWwFvwh7sHnSuNYbCetsIK8qbiQWO7hhPEPcVsxMRwEDsvaBoozzkin5nkv/6XTnLxewP1kFovAptOF3uxkBIGPKRFALWITwkvqMxScl6Ka6wUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E69C4CEF8;
	Wed,  5 Nov 2025 13:19:13 +0000 (UTC)
From: Daniel Gomez <da.gomez@samsung.com>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>, 
 Malcolm Priestley <tvboxspy@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
 Rusty Russell <rusty@rustcorp.com.au>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20251010030348.it.784-kees@kernel.org>
References: <20251010030348.it.784-kees@kernel.org>
Subject: Re: [PATCH v2 0/3] module: Add compile-time check for embedded NUL
 characters
Message-Id: <176234875339.527809.2169922211039196526.b4-ty@samsung.com>
Date: Wed, 05 Nov 2025 14:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 09 Oct 2025 20:06:06 -0700, Kees Cook wrote:
>  v2:
>  - use static_assert instead of _Static_assert
>  - add Hans's Reviewed-by's
>  v1: https://lore.kernel.org/lkml/20251008033844.work.801-kees@kernel.org/
> 
> Hi!
> 
> [...]

Applied, thanks!

[1/3] media: dvb-usb-v2: lmedm04: Fix firmware macro definitions
      (no commit info)
[2/3] media: radio: si470x: Fix DRIVER_AUTHOR macro definition
      (no commit info)
[3/3] module: Add compile-time check for embedded NUL characters
      (no commit info)

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>

