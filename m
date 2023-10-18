Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A8B156D6
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjNGqGSW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D0C433C7;
	Wed, 18 Oct 2023 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697617975;
	bh=+prAov5OlbashqVGxd23DwmWrUyjOJwX2ICX0AH4eVk=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=CjNGqGSWvHrtKbQ8zCQwdIxW0T3ZUh4VZ0mPhRZeGATCcL2Ix/xxbr5jmNFcLAnkh
	 2QR2tCY99zo5BP6mUMV8iFdkZOr7vQypBc6Bjfn1nHce/YLNSSu2bGa5KLxygL6lpd
	 AoZW9A0owRuwaKaikjkw5mVdS4sR5r2sudCe77sVPPpmlFXz4AMKRV611Ldb4Nq3L1
	 eOS6aFHzYuL2MayCdF5RsHwrzVIoY2Z5URWo1sJDcWMby+MM+Q1zgVIeCK+450zs04
	 cz/rfPAoX1BSRhm92C1OlpLXXNFUJjgZLzWvMMRG4bMmFVjUTLBFyFc7c5MiiKHIcz
	 M/f4ABa127O2Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath6kl: replace deprecated strncpy with memcpy
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-v1-1-d69c599b49a9@google.com>
References: 
 <20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-v1-1-d69c599b49a9@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169761797261.48072.1075267340140520177.kvalo@kernel.org>
Date: Wed, 18 Oct 2023 08:32:54 +0000 (UTC)

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous
> interfaces.
> 
> The affected code's purpose is to truncate strings that are too long
> with "..." like:
> foobar -> fo...
> 
> The lengths have been carefully calculated and as such this has decayed
> to a simple byte copy from one buffer to another -- let's use memcpy().
> 
> Note: build-tested only.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

40990961d983 wifi: ath6kl: replace deprecated strncpy with memcpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013-strncpy-drivers-net-wireless-ath-ath6kl-init-c-v1-1-d69c599b49a9@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

