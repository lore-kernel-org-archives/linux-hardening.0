Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554E208D7
	for <linux-hardening@vger.kernel.org>; Mon, 23 Oct 2023 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVgWfTu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C05C433BF;
	Mon, 23 Oct 2023 17:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698082144;
	bh=QHFYOWlkGzWzBm8/TDgaH/NxaV2cslJrLINWwlJQA/s=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=FVgWfTu2X8tsb3prDb290Ls4nIJjC2E6e+STuJrtghR8sn4A7zuJHXf7ReOr7uRv9
	 X3vbQv5lLeOSahlR7Q0Uj6EQiFbDa7hbehu/4xm7jPh8xDXnKVgbO8Sbu5voHC9keB
	 EdxUfDnK9RwbuZ/OmB0SSicqHWPu/CiDyPCWTd1pknVzWmra/gjOAW9JZ9B09Q9EgS
	 PGJIpp9kqg5jS6OYM6k1RcRBTHhxtxrrWmEPo/DZ8SFeBrL7+3g2cVTmTXJ4LGRF4G
	 FFpCqxIKSgvx6YfwS8Fy0h0HoG5xSVkkLb3Fx8Tbj1J8hx4kvIlHDBu6PJNW7cMbj9
	 uYIcOimdXRO/Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: wl18xx: replace deprecated strncpy with strscpy
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
References: 
 <20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169808214096.695306.16867371927362677555.kvalo@kernel.org>
Date: Mon, 23 Oct 2023 17:29:02 +0000 (UTC)

Justin Stitt <justinstitt@google.com> wrote:

> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> wl->chip.phy_fw_ver_str is obviously intended to be NUL-terminated by
> the deliberate comment telling us as much. Furthermore, its only use is
> drivers/net/wireless/ti/wlcore/debugfs.c shows us it should be
> NUL-terminated since its used in scnprintf:
> 492 | DRIVER_STATE_PRINT_STR(chip.phy_fw_ver_str);
> which is defined as:
> | #define DRIVER_STATE_PRINT_STR(x)  DRIVER_STATE_PRINT(x, "%s")
> ...
> | #define DRIVER_STATE_PRINT(x, fmt)   \
> | 	(res += scnprintf(buf + res, DRIVER_STATE_BUF_LEN - res,\
> | 			  #x " = " fmt "\n", wl->x))
> 
> We can also see that NUL-padding is not required.
> 
> Considering the above, a suitable replacement is `strscpy` [2] due to
> the fact that it guarantees NUL-termination on the destination buffer
> without unnecessarily NUL-padding.
> 
> The very fact that a plain-english comment had to be made alongside a
> manual NUL-byte assignment for such a simple purpose shows why strncpy
> is faulty. It has non-obvious behavior that has to be clarified every
> time it is used (and if it isn't then the reader suffers).
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
> Link: https://github.com/KSPP/linux/issues/90
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Patch applied to wireless-next.git, thanks.

fb329e8b1d88 wifi: wl18xx: replace deprecated strncpy with strscpy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231018-strncpy-drivers-net-wireless-ti-wl18xx-main-c-v2-1-ab828a491ce5@google.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

