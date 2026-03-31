Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B4B3D6692;
	Tue, 31 Mar 2026 21:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774994039; cv=none; b=EVA2iZGaG38A4gNEHPVL3JWi7zZSsVMIiGRlZe/yzzZsIaaKAPZHC5U2IMGB+7h+oyNMF7HfJ8c//LlpWlWMMW1b4UmzrBcGyl55g6KGNAf7gArHIESTCNQPXb2pmp9Lr7DbS5X2Hq8TPXthfxVJF8Jw0nwQTJVxsUMceLyEp68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774994039; c=relaxed/simple;
	bh=H2Fc6P8Zwf74Nlec4YK0EaWq/S+/5/koC6yQTjygwjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVRTqfy6UbVepCyH/w7UzFPZtLysfSu3RkdTHNh4sK3u4vbDNqT3xHmJCC6iHg27ITlfyuuxVs0R1X1hr0OY9eCOw/sYU/+OlYJ51atE4butqxsRkPjQjn5bjTNZtcFbVKn6ELil6Qu2/VfLxtyQlHCJpRPSEVtH7vUzD656uZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPiK6qbc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPiK6qbc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299C7C19423;
	Tue, 31 Mar 2026 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774994039;
	bh=H2Fc6P8Zwf74Nlec4YK0EaWq/S+/5/koC6yQTjygwjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lPiK6qbcTI7wEl5WUqCvvMtMqDyPbzFgr1jY4g+WAddTyV1+sdcKybNQAh5q9j2XU
	 LFclEzciQ+Elq9o6wRB4/LIMK6oAzDTsiOMaaXLJDOh7frP7Guryi5+le5yJh/wv5t
	 ZOGBtexNahsdU6Z1+3UfYIh5tRTkGO8EUdvudV5huEfaSz9+k2cQtD3f+3II7950Rn
	 Q94EU0SUat3u89aPWMyexJ79rkjir54aIQLQY0hnJXZL8LdxNmbrFqV7Q8iVRF9WYy
	 wReODc92ssIp1B54ireBYS51c8L7a/754x9NQaKKqlNkI5eNBYjyCjPsdmTqTWXHG9
	 eHyk7LiDRx9cg==
From: Kees Cook <kees@kernel.org>
To: linux-hardening@vger.kernel.org,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] pstore/ftrace: Keep ftrace module parameter and debugfs switch in sync
Date: Tue, 31 Mar 2026 14:53:56 -0700
Message-Id: <177499403395.2779844.5056031272669443915.b4-ty@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260301192704.1263589-1-gpiccoli@igalia.com>
References: <20260301192704.1263589-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 01 Mar 2026 16:26:36 -0300, Guilherme G. Piccoli wrote:
> Commit a5d05b07961a ("pstore/ftrace: Allow immediate recording")
> introduced a kernel parameter to enable early-boot collection for
> ftrace frontend. But then, if we enable the debugfs later, the
> parameter remains set as N. This is not a biggie, things work fine;
> but at the same time, why not have both in sync if possible, right?
> 
> 
> [...]

Applied to for-next/pstore, thanks!

[1/1] pstore/ftrace: Keep ftrace module parameter and debugfs switch in sync
      https://git.kernel.org/kees/c/421a41c485dd

Take care,

-- 
Kees Cook

