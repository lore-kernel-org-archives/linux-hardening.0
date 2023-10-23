Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248AA20B29
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR4CDg9m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCFEC433C8;
	Mon, 23 Oct 2023 17:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698082173;
	bh=TFyddzODnA71wlttcWczDl2ULr/aiDXiJcRsmEttaXE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FR4CDg9m+SAmdKCzpr0yZ9kRTMHdtjdTtTLzAcWdAH2yo8eedoUNIFEorpJTshynG
	 +YIHrRJaVeB96pyOq7vW2AX/P/YINun0pPUCFpCCio2CmrzoPavpNxejtI70mgOJ/5
	 vVFQGjBFuDNHix5xbmPTuwhcJ5KoMpeX40B4+FlKw/nvvY+i2I6+rZyuWuMWPUi3pf
	 5GXWapp8Py6yGmz/5vSyzP5pBPr0jVD8vtoT9tMu3OtsIqDm927tLF0BaKBi82fKDc
	 c+IlEQDp6L/d55EOUO6VSwaas0pX/MYgeRVpkLcDJrjhH+MuHvT6gEKZRbmDORnX3O
	 DtF8zDpM4/ZXQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: wlcore: boot: replace deprecated strncpy with strscpy
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com>
References: 
 <20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808217070.695306.9829944196418700359.kvalo@kernel.org>
Date: Mon, 23 Oct 2023 17:29:32 +0000 (UTC)

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect wl->chip.fw_ver_str to be NUL-terminated based on its usage
> with DRIVER_STATE_PRINT_STR() in debugfs.c:
> 491 | DRIVER_STATE_PRINT_STR(chip.fw_ver_str);
> ... which uses DRIVER_STATE_PRINT():
> 444 | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
> ... which relies on scnprintf:
> 434 | #define DRIVER_STATE_PRINT(x, fmt)   \
> 435 | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
> 436 | 			  #x " = " fmt "\n", wl->x))
> 
> Moreover, NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Similar-to: https://lore.kernel.org/all/20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com/
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

75fdaa28f103 wifi: wlcore: boot: replace deprecated strncpy with strscpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231018-strncpy-drivers-net-wireless-ti-wlcore-boot-c-v1-1-d3c6cc6b80fe@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

